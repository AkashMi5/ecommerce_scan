
 class UserLogin {

   String username ;
   String userid ;
   String email ;

  UserLogin({this.username, this.userid, this.email});

  factory UserLogin.fromJson(Map<String, dynamic> jsonData) {
    return UserLogin(
        username : jsonData['name'],
        userid :  jsonData['id'],
        email : jsonData['email']
    ) ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name' : username,
      'id' : userid,
      'email' : email
   } ;
 }

 }