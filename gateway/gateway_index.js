const { ApolloServer } = require('apollo-server');
const { ApolloGateway,RemoteGraphQLDataSource } = require('@apollo/gateway');
const admin = require('firebase-admin');
const waitOn = require('wait-on');
const { readFileSync } = require('fs');



const supergraphSdl = readFileSync('./supergraph.graphql').toString();

class AuthenticatedDataSource extends RemoteGraphQLDataSource {
  willSendRequest({ request, context }) {
      console.log("AD: "+context.user);
    // Pass the user's id from the context to each subgraph
    // as a header called user-id
    request.http.headers.set('user', context.user?context.user:null);
  }
}

const serviceAccount = require('./service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: FIREBASE_DATABASE_URI
});


const getMe = async (req) => {
// Get the user token from the headers.
  const idToken = req.headers.authorization || '';
  console.log('token from request : '+idToken);

 const token = idToken.split(' ');
 console.log('Without Bearer :'+token[1]);


 const validuid = await admin.auth().verifyIdToken(token[1])
         .then(function(decodedToken){
          console.log('decoded token : '+decodedToken);
           return decodedToken.uid;
         }).catch(function(error){
            console.log(error);
            return null;
         });

 console.log('valid uid : '+validuid);

 return validuid;
};


const gateway = new ApolloGateway({
  supergraphSdl,
  buildService({ name, url }) {
      return new AuthenticatedDataSource({ url });
    }
});


 const server = new ApolloServer({
      gateway,
      context: async({req}) => {

           // Get the user token from the headers
            const user = await getMe(req);

             console.log('got userid from decoded token : '+ user);


             if (!user) throw new AuthenticationError('you must be logged in');


             // add the user to the context
             return {user};},


    });

    server.listen(4000).then(({ url }) => {
      console.log(`🚀 Gateway ready at ${url}`);
    }).catch(err => {console.error(err)});



/*const server = new ApolloServer({
  gateway,
  context: async({req}) => {
       // Get the user token from the headers.
         const userId = await getMe(req);
         console.log('got userid from decoded token : '+ userId);

         if (!userId) throw new AuthenticationError('you must be logged in');

         // add the user to the context
         return {userId};
  },
  playground: true,
  introspection: true
});

server.listen(process.env.PORT).then(({ url }) => {
  console.log(`🚀 Gateway ready at ${url}`);
}).catch(err => {console.error(err)});*/
