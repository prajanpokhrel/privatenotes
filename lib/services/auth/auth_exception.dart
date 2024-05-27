// Defining auth exception
// exception class

//login exceptionauth
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// register exceptionauth
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//generic auth exception
class GenericAuthException implements Exception {}

//userNotLoggedInauth exception
class UserNotLoggedInAuthException implements Exception {}
