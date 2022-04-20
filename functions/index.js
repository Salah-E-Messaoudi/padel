const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
admin.firestore().settings({ignoreUndefinedProperties: true});

exports.addFriend = functions.https.onRequest( async (request, response) => {
    let body;
    try {
        body = JSON.parse(request.body);
    } catch (_) {
        response.send({
            'result': false,
            'code': 'invalid-body',
            'message': 'Invalid body',
        });
    }
    // console.log(body);
    if (body.friendPhoneNumber == undefined) {
        response.send({
            'result': false,
            'code': 'invalid-phone-number',
            'message': 'Invalid phone number',
        });
    }
    if (
        body.uid == undefined ||
        body.displayName == undefined ||
        body.phoneNumber == undefined ||
        body.token == undefined ||
        body.photoURL == undefined
    ) {
        response.send({
            'result': false,
            'code': 'invalid-owner-data',
            'message': 'Invalid owner data',
        });
    }
    let user = body;
    let friend = await admin.auth().getUserByPhoneNumber(body.friendPhoneNumber)
    .catch((err) => {
        response.send({
            'result': false,
            'code': 'user-not-found',
            'message': 'User not found',
        });
    });
    let friendDoc = await admin.firestore().collection('userInfo').doc(friend.uid).get()
    .catch((_) => {
        response.send({
            'result': false,
            'code': 'user-not-found',
            'message': 'User not found',
        });
    });
    try {
        await admin.firestore().collection('userInfo').doc(friend.uid)
        .collection('friends').doc(user.uid)
        .create(
            getUserDataMin(user),
        );
        await admin.firestore().collection('userInfo').doc(user.uid)
        .collection('friends').doc(friend.uid)
        .create(
            getUserDataMin(friendDoc.data()),
        );
        let body = user.displayName+' added you to his friends list, now you can invite each other to matches to complete your team.';
        createNotification(
            friend.uid,
            user.displayName,
            user.photoURL,
            friendDoc.data().token,
            'friend_added',
            'You have a new friend!',
            body,
        );
    } catch (err) {
        console.log(err);
        response.send({
            'result': false,
            'code': 'already-friends',
            'message': 'Already friends',
        });
    }
    response.send({
        'result': true,
    });
});

exports.onUpdateBooking = functions
    .firestore
    .document("bookings/{id}")
    .onUpdate( async (change, context) => {
        if (change.after.data().owner == undefined) return;
        if (!arraysEqual(change.before.data().list_invited, change.after.data().list_invited)) {
            //find elements that have been deleted from after
            // let before = difference(change.before.data().list_invited, change.after.data().list_invited);
            // console.log('list_invited: elements deleted:',before);
            //find elements that have been inserted to after
            let after = difference(change.after.data().list_invited, change.before.data().list_invited);
            console.log('list_invited: elements inserted:',after);
            for (const i in after) {
                console.log('starting with element N°',i,'=',after[i]);
                let user = await admin.auth().getUser(after[i])
                .catch((err) => {
                    console.log('user with uid:', after[i], ' not found');
                });
                if (user == undefined) return;
                console.log('user found');
                let userDoc = await admin.firestore().collection('userInfo').doc(user.uid).get()
                .catch((_) => {
                    console.log('userInfo document not found for user with uid:', user.uid);
                });
                if (userDoc == undefined || userDoc.data() == undefined) return;
                let body = 'You have received a new invitation from '+change.after.data().owner.displayName+' to join a match';
                await createNotification(
                    user.uid,
                    change.after.data().owner.displayName,
                    change.after.data().owner.photoURL,
                    userDoc.data().token,
                    'new_invitation',
                    'New invitation!',
                    body,
                );
            }
        }
        if (!arraysEqual(change.before.data().list_added, change.after.data().list_added)) {
            //find elements that have been deleted from after
            // let before = difference(change.before.data().list_added, change.after.data().list_added);
            // console.log('list_added: elements deleted:',before);
            //find elements that have been inserted to after
            let after = difference(change.after.data().list_added, change.before.data().list_added);
            console.log('list_added: elements inserted:',after);
            for (const i in after) {
                console.log('starting with element N°',i,'=',after[i]);
                let user = await admin.auth().getUser(after[i])
                .catch((err) => {
                    console.log('user with uid:', after[i], ' not found');
                });
                if (user == undefined || user.displayName == undefined || user.photoURL == undefined) return;
                let body = user.displayName+' has accepted your invitation and joined your team.';
                await createNotification(
                    change.after.data().owner.uid,
                    user.displayName,
                    user.photoURL,
                    change.after.data().owner.token,
                    'invitation_accepted',
                    'Invitation accepted',
                    body,
                );
            }
        }
    });

/**
 * Adds two numbers together.
 * @param {FirebaseFirestore.DocumentData} data
*/
function getUserDataMin(data) {
    return {
        'uid': data.uid,
        'displayName': data.displayName,
        'phoneNumber': data.phoneNumber,
        'photoURL': data.photoURL,
        'token': data.token
    };
}

/**
 * Adds two numbers together.
 * @param {[]} a
 * @param {[]} b
 */
 function arraysEqual(a, b) {
    if (a === b) return true;
    if (a == null || b == null) return false;
    if (a.length !== b.length) return false;
  
    // If you don't care about the order of the elements inside
    // the array, you should sort both arrays here.
    // Please note that calling sort on an array will modify that array.
    // you might want to clone your array first.
  
    for (var i = 0; i < a.length; ++i) {
      if (a[i] !== b[i]) return false;
    }
    return true;
  }

/**
 * returns the difference between two lists. 
 * eleminates all commun elements that exists in before and in after
 * @param {[]} before
 * @param {[]} after
 */
 function difference(before, after) {
    if (before == undefined) {
      before = [];
    }
    return before.filter(function(value, index, arr) {
        return !after.includes(value);
    });
  }

  /**
   * create a notification in notifications sub collection, and send a notification to device
   * @param {String} uid
   * @param {String} displayName
   * @param {String} photoURL
   * @param {String} token
   * @param {String} key
   * @param {String} title
   * @param {String} body
   */
  async function createNotification(
    uid,
    displayName,
    photoURL,
    token,
    key,
    title,
    body,
  ) {
      if (uid == undefined ||
        token == undefined ||
        key == undefined ||
        displayName == undefined ||
        photoURL == undefined ||
        title == undefined ||
        body == undefined
        ) {
            console.log('unable to create and send notification to user with uid:', uid);
            return;
        }
    await admin.firestore().collection('userInfo').doc(uid)
    .collection('notifications').doc().create(
        {
            'key': key,
            'displayName': displayName,
            'photoURL': photoURL,
            'seen': false,
            'createdAt': admin.firestore.FieldValue.serverTimestamp(),
        }
    );
    const payload = {
        notification: {
          title: title,
          body: body,
          sound: 'default',
        },
        data: {
          click_action: key,
          sound: 'default',
        },
      };
    await admin.messaging()
    .sendToDevice(token, payload)
    .then((response) => {
        console.log('Notification successfully sent to user with uid:', uid);
    });
  }