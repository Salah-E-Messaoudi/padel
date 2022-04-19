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
        admin.firestore().collection('userInfo').doc(friend.uid)
        .collection('notifications').doc().create(
            {
                'key': 'friend_added',
                'displayName': user.displayName,
                'photoURL': user.photoURL,
                'seen': false,
                'createdAt': admin.firestore.FieldValue.serverTimestamp(),
            }
        );
        const payload = {
            notification: {
              title: 'You have a new friend!',
              body: 'added you to his friends list, now you can invite each other to matches to complete your team.',
            //   body: 'Expand your friends list to invite each other to matchs.',
              sound: 'default',
            },
            data: {
              click_action: 'friend_added',
              sound: 'default',
            },
          };
        admin.messaging()
        .sendToDevice(friendDoc.data().token, payload)
        .then((response) => {
            console.log('Notification successfully sent');
        });
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