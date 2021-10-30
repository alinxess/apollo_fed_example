const { gql } = require('apollo-server');

const typeDefs = gql`

type User {
     user_id:ID!,
     username:String!,
     fullname:String,

}

type Query{
     getuserData: User

}


`;

module.exports= typeDefs;