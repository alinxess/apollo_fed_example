
 const neo4j = require('neo4j-driver')

 const uri = NEO4J_DATABASE_URI;
 const user = "neo4j";
 const password = NEO4J_DATABASE_PWD;

 const driver = neo4j.driver(uri, neo4j.auth.basic(user, password))



module.exports = {

Query: {
 async getuserData(parents,args,context,info){

      if(!context.user){
              console.log(" Not Authenticated as user");
              }
        console.log("context in accounts resolver: "+context.user);

        const session = driver.session();
        console.log('connection established');

           const result = await session.readTransaction(tx =>
            tx.run('MATCH(u:User) WHERE u.user_id=$user_id RETURN u.username, u.fullname',
            {user_id: context.user})
            );

         const singleRecord = result.records[0]

         const user_name = singleRecord.get(0);
         const userfullname = singleRecord.get(1);
         console.log("user_name : "+user_name);
         console.log("userfullname : "+userfullname);

      const fuser= {
          username: user_name,
          fullname: userfullname
      }
      console.log(fuser);
      return fuser;
      await session.close();
      await driver.close();

}
}


};