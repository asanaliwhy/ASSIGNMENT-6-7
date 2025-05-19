import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:final_2/error_handler.dart';
import 'package:final_2/generated/l10n.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _isLoading = false;

  Future<void> _handleEmailAuth() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      if (_isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        await userCredential.user?.updateDisplayName(
            '${_nameController.text.trim()} ${_surnameController.text.trim()}'
        );
      }
    } catch (e) {
      ErrorHandler.showError(context, ErrorHandler.handleException(context, e));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      ErrorHandler.showError(context, ErrorHandler.handleException(context, e));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleFacebookSignIn() async {
    final localizations = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);
    try {
      final loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final accessToken = loginResult.accessToken;
        final credential = FacebookAuthProvider.credential(accessToken!.tokenString);
        await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        ErrorHandler.showError(context, localizations.errorFacebookCancel);
      }
    } catch (e) {
      ErrorHandler.showError(context, ErrorHandler.handleException(context, e));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLogin ? localizations.login : localizations.register,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 16),
                  if (!_isLogin) ...[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: localizations.name, border: const OutlineInputBorder()),
                      validator: (value) => value!.isEmpty ? localizations.errorEnterName : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _surnameController,
                      decoration: InputDecoration(labelText: localizations.surname, border: const OutlineInputBorder()),
                      validator: (value) => value!.isEmpty ? localizations.errorEnterSurname : null,
                    ),
                    const SizedBox(height: 8),
                  ],
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: localizations.email, border: const OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty ? localizations.errorEnterEmail : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: localizations.password, border: const OutlineInputBorder()),
                    obscureText: true,
                    validator: (value) => value!.length < 6 ? localizations.errorPasswordLength : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleEmailAuth,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                    child: Text(_isLogin ? localizations.login : localizations.register),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin ? localizations.createAccount : localizations.login,
                      style: const TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                  const Divider(),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
                    icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                    label: Text(localizations.signInWithGoogle),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _handleFacebookSignIn,
                    icon: const Icon(Icons.facebook, color: Colors.white),
                    label: Text(localizations.signInWithFacebook),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            AnimatedOpacity(
              opacity: _isLoading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const CircularProgressIndicator(color: Colors.deepPurple),
                ),
              ),
            ),
        ],
      ),
    );
  }
}