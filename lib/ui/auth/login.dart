import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/model/user_model.dart';
import 'package:parawisata_mutakin/network/services.dart';
import 'package:parawisata_mutakin/ui/auth/register.dart';
import 'package:parawisata_mutakin/ui/main_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum statusLogin { signIn, notSignIn }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keyForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginRequest loginData;
  ApiServices _services = ApiServices();

  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    loginData = LoginRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: Form(
                  key: _keyForm,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Login",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Colors.green)),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          validator: (value) => value.isEmpty
                              ? "Silahkan masukan username!"
                              : null,
                          onSaved: (username) => loginData.username = username,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Username"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          validator: (value) => value.isEmpty
                              ? 'Silahkan masukan password!'
                              : value.length < 6
                                  ? "Password kurang dari 6 digit"
                                  : null,
                          onSaved: (password) => loginData.password = password,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "password"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            SharedPreferences sharedPref =
                                await SharedPreferences.getInstance();
                            if (_keyForm.currentState.validate()) {
                              _keyForm.currentState.save();
                              showMessage("Loading....");
                              final response = await _services.login(loginData);

                              if (response.value == 1) {
                                showMessage("Login Berhasil");

                                sharedPref.setInt("value", response.value);
                                sharedPref.setString(
                                    "username", response.username);
                                sharedPref.setString(
                                    "fullname", response.fullname);
                                sharedPref.setString("email", response.email);
                                sharedPref.setString(
                                    "address", response.address);
                                sharedPref.setString("sex", response.sex);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainApp()));
                              } else {
                                showMessage(response.message);
                              }
                            }
                          },
                          child: Text("Submit"),
                          color: Colors.green,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text("Belum punya akun ? "),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                child: Text(
                                  "Daftar",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showMessage(String message) {
    return _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.pink.shade300,
      duration: Duration(seconds: 1),
      margin: EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
