import 'package:flutter/material.dart';
import 'package:parawisata_mutakin/model/user_model.dart';
import 'package:parawisata_mutakin/network/services.dart';
import 'package:parawisata_mutakin/ui/auth/login.dart';
import 'package:parawisata_mutakin/utils.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  RegisterRequest registerData = RegisterRequest();

  ApiServices _services = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Register",
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
                          onSaved: (username) =>
                              registerData.username = username,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Username"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Silahkan masukan email!" : null,
                          onSaved: (email) => registerData.email = email,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Email"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          validator: (value) => value.isEmpty
                              ? "Silahkan masukan nama lengkap!"
                              : null,
                          onSaved: (fullname) =>
                              registerData.fullname = fullname,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Full Name"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Silahkan masukan alamat!" : null,
                          onSaved: (address) => registerData.address = address,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Address"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          validator: (value) => value.isEmpty
                              ? "Silahkan masukan jenis kelamin!"
                              : null,
                          onSaved: (gender) => registerData.sex = gender,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Gender"),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          validator: (value) => value.isEmpty
                              ? 'Silahkan masukan password!'
                              : value.length < 6
                                  ? "Password kurang dari 6 digit"
                                  : null,
                          onSaved: (password) =>
                              registerData.password = password,
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
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              try {
                                showSnackbarMessage(context, "Loading....");
                                final response =
                                    await _services.register(registerData);

                                if (response.value == 1) {
                                  showSnackbarMessage(
                                      context, response.message);

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                } else {
                                  showSnackbarMessage(
                                      context, response.message);
                                }
                              } catch (e) {
                                showSnackbarMessage(context, e.toString());
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
                            Text("Sudah punya akun ? "),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
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
}
