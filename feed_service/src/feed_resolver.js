const { MongoClient } = require('mongodb');
const uri = MONGODB_DATABASE_URI;
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });


module.exports = {

 Query: {

   async getuserFeed(parents,args,context,info){
      if(!context.user){
                    console.log(" Not Authenticated as user");
                    }

               await client.connect();
               console.log("Connected correctly to server");
               const db = client.db("fmongoDb");

               const col = db.collection("ufeed");
               const query = {user_id:context.user};
               var ucon=" ";
               var uphto =" ";

               const qr = await col.find(query).project({_id:0, contents:1, 'photo.photo_id':1}).toArray();


                   console.log("Record Read successfully");
                   console.log(qr);
                   console.log(qr[0].contents);
                   console.log(qr[0].photo.photo_id);
                   ucon = qr[0].contents;
                   uphto = qr[0].photo.photo_id;
                   console.log("uphto: "+uphto);

              const mfeed = {
                  contents: ucon,
                  photo_id: uphto
              }

               console.log(mfeed);

          return mfeed;
          await client.close();




   }

 },

 Feed: {
       photo(getuserFeed) {
       //referencing photo_id to photo_id of Photo entity in post_service
         return { __typename:"Photo", photo_id: getuserFeed.photo_id };
       }
     }







};