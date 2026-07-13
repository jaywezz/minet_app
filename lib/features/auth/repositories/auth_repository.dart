import 'dart:async';
import '../models/user_model.dart';
import '../models/login_request.dart';
import '../models/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(LoginRequest request);
  Future<UserModel> getCurrentUser();
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<void> saveAuthData(AuthResponse authResponse);
  Future<void> clearAuthData();
}

class MockAuthRepository implements AuthRepository {
  // Mock data
  static const String _mockEmail = 'user@minet.com';
  static const String _mockPassword = 'password123';
  static const String _mockAccessToken = 'mock_access_token_12345';
  static const String _mockRefreshToken = 'mock_refresh_token_67890';

  // Simulate network delay
  static const Duration _networkDelay = Duration(seconds: 2);
  
  // Mock storage for auth state
  bool _isLoggedIn = false;
  String? _storedToken;

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    // Simulate network delay
    await Future.delayed(_networkDelay);

    // Validate credentials
    if (request.email != _mockEmail || request.password != _mockPassword) {
      throw Exception('Invalid email or password');
    }

    // Return mock auth response
    final user = UserModel(
      id: '1',
      name: 'John Doe',
      email: request.email,
      phoneNumber: '+1234567890',
      profilePicture: null,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );

    return AuthResponse(
      user: user,
      accessToken: _mockAccessToken,
      refreshToken: _mockRefreshToken,
      expiresAt: DateTime.now().add(const Duration(hours: 24)),
    );
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if user is logged in (in real app, this would check stored token)
    final isLoggedIn = await this.isLoggedIn();
    if (!isLoggedIn) {
      throw Exception('User not logged in');
    }

    // Return mock user data
    return UserModel(
      id: '1',
      name: 'John Doe',
      email: 'user@minet.com',
      phoneNumber: '+1234567890',
      profilePicture: null,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In real app, this would call logout API and clear local storage
    await clearAuthData();
  }

  @override
  Future<bool> isLoggedIn() async {
    // Simulate checking stored token
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Return the stored login state
    return _isLoggedIn && _storedToken != null;
  }

  @override
  Future<void> saveAuthData(AuthResponse authResponse) async {
    // Simulate saving to local storage
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Store auth data
    _storedToken = authResponse.accessToken;
    _isLoggedIn = true;
    
    // In real app, this would save tokens to secure storage
    print('Auth data saved: ${authResponse.user.name}');
  }

  @override
  Future<void> clearAuthData() async {
    // Simulate clearing local storage
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Clear auth data
    _storedToken = null;
    _isLoggedIn = false;
    
    // In real app, this would clear tokens from secure storage
    print('Auth data cleared');
  }
}
