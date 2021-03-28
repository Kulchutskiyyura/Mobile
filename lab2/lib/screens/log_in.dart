import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab2/services/auth.dart';

// ignore: camel_case_types
class logIn extends StatefulWidget {
  @override
  _logInState createState() => _logInState();
}

// ignore: camel_case_types
class _logInState extends State<logIn>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showLogin = true;

  AuthService service = AuthService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Color.fromRGBO(194,194,194,1)),
          decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color.fromRGBO(194,194,194,1)),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(194,194,194,1), width: 3)
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(194,194,194,1), width: 1)
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: IconThemeData(color: Color.fromRGBO(194,194,194,1)),
                child: icon
              )
            )
          ),
        ),
      );
    }

  Widget _logo()
  {
    return Padding(
      padding: EdgeInsets.only(top:100),
      child: Container(
        child: Align(
          child: Text(
            "Find", style: TextStyle(fontSize: 48, color: Color.fromRGBO(0, 0, 0, 1)),
          ),
        )),
      );
  }
   Widget _button(String text, void func()){
      // ignore: deprecated_member_use
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Color.fromRGBO(108,63,204,1),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 20)          
        ),
        onPressed: (){
          func();
        },
      );
    }

    Widget _form(String label, void func()){
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: _input(Icon(Icons.email), "EMAIL", _emailController, false)
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _input(Icon(Icons.lock), "PASSWORD", _passwordController, true)
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func)
              )
            )
          ],
        ),
      );

      
    }

   void _signInButtonAction() async{      
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;
      dynamic user = await service.signInWithEmailAndPassword(_email.trim(), _password.trim());
      if(user == null)
        Fluttertoast.showToast(
          msg: "Can't SignIn you! Please check your email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
        else{
           _emailController.clear();
          _passwordController.clear();
        }
    }

    void _registerButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;
      
      if(_email.isEmpty || _password.isEmpty) return;

      dynamic user = await service.registerWithEmailAndPassword(_email.trim(), _password.trim());
      if(user == null)
        Fluttertoast.showToast(
          msg: "Can't Register you! Please check your email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
        else{
          _emailController.clear();
          _passwordController.clear();
        }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Column(
        children: <Widget>[
          _logo(),      
          SizedBox(height: 100,),    
          (
            showLogin
            ? Column(
              children: <Widget>[
                _form('LOGIN', _signInButtonAction),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Text('Don’t hava acount? Sign up', style: TextStyle(fontSize: 20, color: Color.fromRGBO(110,110,110,1))),
                    onTap:() {
                      setState((){
                        showLogin = false;
                      });
                    }                   
                  ),
                )
              ],
            )
            : Column(
              children: <Widget>[
                _form('REGISTER', _registerButtonAction),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Text('Already registered? Login!', style: TextStyle(fontSize: 20, color: Color.fromRGBO(110,110,110,1))),
                    onTap:() {
                      setState((){
                        showLogin = true;
                      });
                    }                   
                  ),
                )
              ],
            )
          ),
         

        ],
      )
    );
  }
}