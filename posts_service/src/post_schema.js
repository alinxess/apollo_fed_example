const { gql } = require('apollo-server');

const typeDefs = gql`

type Photo @key(fields:"photo_id") {
     photo_id:ID!,
     photo_location:String!,
     creation_date:String!,
     user_id:ID!,
}

type Query{
     getuserPhoto: Photo
}
`;

module.exports= typeDefs;