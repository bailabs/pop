import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pop/models/quiz.dart';
import 'package:provider/provider.dart';

class GameStatLogin extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin facebookSignIn = new FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignGoogleIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }

  Future<FirebaseUser> _handleSignFacebookIn() async {
    FacebookLoginResult result =
        await facebookSignIn.logInWithReadPermissions(['email']);

    final FacebookAccessToken accessToken = result.accessToken;

    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: accessToken.token);

    FirebaseUser user = await _auth.signInWithCredential(credential);

    return user;
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Error logging in'),
        action: SnackBarAction(
            label: 'Error', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<Quiz>(context);
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Login to know  and save your rank',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'PaytoneOne',
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    FirebaseUser user = await _handleSignFacebookIn();
                    if (user == null) {
                      _showToast(context);
                    } else {
                      quiz.setCurrentUser(user);
                      quiz.saveData();
                      quiz.processRank();
                    }
                  },
                  child: Icon(
                    FontAwesomeIcons.facebookSquare,
                    size: 100,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    FirebaseUser user = await _handleSignGoogleIn();
                    if (user == null) {
                      _showToast(context);
                    } else {
                      quiz.setCurrentUser(user);
                      quiz.saveData();
                      quiz.processRank();
                    }
                  },
                  child: Icon(
                    FontAwesomeIcons.googlePlusSquare,
                    size: 100,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
