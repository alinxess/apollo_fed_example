
const admin = require("firebase-admin");


const serviceAccount = require('../service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: FIREBASE_DATABASE_URI
});



const db = admin.firestore();


module.exports={

Photo: {
      __resolveReference(reference) {

        //resolving referenced made by feed_service

        const userRef=  db.collection('uposts');
        return userRef.where('photo_id', '==', reference.photo_id).get().then(
            snapshot => {
                 console.log("data: ");
                 console.log(snapshot.docs[0].data());
                 return snapshot.docs[0].data();
            }
        ).catch(err => {
             console.log('Error getting documents', err);
           });
      }
    },


Query: {

  async getuserPhoto(parent, args, context,info){



        if(!context.user){
        console.log(" Not Authenticated as user")
        }
        const currentuser = context.user;

        const userRef=  db.collection('uposts').doc(currentuser);
        const udata = await userRef.get();
        console.log("post data:")
        console.log(udata.data());

        return udata.data();
    }

}


};