# Apollo_fed_example

This application is an example of apollo federation which uses multiple different types of databases(polyglot persistence).

## Getting Started
Frontend - is a flutter application which uses firebase authentication for users.
&
Backened has an apollo federated gateway which consists of 3 subgraphs for 3 different microservices:
1) Accounts :- For maintaining user's personal details. This service uses Neo4j database .
2) Posts :- This service is used when users want to upload photos and videos , so the record will contain photo-location, creation date, photo id etc. This service uses Google                 Firestore.
3) Feeds :- This service is used when users want to see their uploaded posts or other's uploaded posts. This service uses MongoDB database. 










