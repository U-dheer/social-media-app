class Loginparams {
  final String email;
  final String password;

  Loginparams({required this.email, required this.password}) {
    if (email.trim().isEmpty || !email.contains('@')) {
      throw Exception('Invalid email format');
    }
    if (password.trim().length < 4) {
      throw Exception('Password must be at least 4 characters long');
    }
  }
}
