const { ApolloServer} = require('apollo-server');
const { buildSubgraphSchema } = require('@apollo/federation');
const typeDefs = require('./post_schema');
const resolvers = require('./p_resolver.js');



const server = new ApolloServer({
     schema: buildSubgraphSchema([{typeDefs, resolvers}]),
     context: ({req}) => {
              // Get the user token from the headers.

                const user = req.headers.user?req.headers.user:null;
                console.log('got userid from decoded token : '+ user);

                if (!user) throw new AuthenticationError('you must be logged in');


                // add the user to the context
               return {user};
               }


   });

server.listen(4002).then(({ url }) => {
    console.log(`🚀 Server ready at ${url}`);
}).catch(err => {console.error(err)});

