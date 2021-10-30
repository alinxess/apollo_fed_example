const { gql } = require('apollo-server');

const typeDefs = gql`

type Feed @key(fields:"feed_id"){
     feed_id:ID!,
     contents:String,
     creation_date:String!,
     user_id:ID!,
     photo:Photo,
}
extend type Photo @key(fields: "photo_id") {
  photo_id: ID! @external
}


type Query{
     getuserFeed: Feed
}

`;

module.exports= typeDefs;