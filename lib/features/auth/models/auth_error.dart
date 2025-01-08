/// Represents different types of authentication errors that can occur.
enum AuthError {
  userNotFound('User not found'),
  wrongPassword('Invalid password'),
  emailAlreadyInUse('Email is already registered'),
  invalidEmail('Invalid email format'),
  weakPassword('Password is too weak'),
  unknown('An unknown error occurred');

  final String message;
  const AuthError(this.message);
}
