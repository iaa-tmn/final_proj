class usersLogin{
  String login ='';
  String pass = '';

  usersLogin(String login, String pass){
    this.login=login;
    this.pass=pass;
  }

}
List <usersLogin> generateList(){
  List <usersLogin> users=[];
  users.add(usersLogin("123", "1111"));
  users.add(usersLogin("1234", "1111"));
  users.add(usersLogin("12345", "1111"));
  return users;
}

bool validateUserPass(login, pass) {
  List <usersLogin> userList = generateList();
  bool _valid=false;
  userList.forEach((element) {
    if (element.pass==pass && element.login==login){
      _valid=true;
    }
  });
  // int index = userList.indexOf(usersLogin(login, pass));
  if (_valid) {
    return true;
  }
  return false;
}
