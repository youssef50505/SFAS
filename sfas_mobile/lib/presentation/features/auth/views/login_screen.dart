import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthEvent.loginRequested(
              _emailController.text,
              _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) {
              if (user.role == 'ROLE_ADMIN') {
                context.go('/admin-dashboard');
              } else {
                context.go('/finance-officer-dashboard');
              }
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Row(
            children: [
              if (isDesktop)
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Remix.bank_fill, size: 80, color: Colors.white)
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .scale(delay: 200.ms),
                          const SizedBox(height: 24),
                          Text(
                            'SFAS',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(color: Colors.white, fontSize: 48),
                          )
                              .animate()
                              .fadeIn(delay: 400.ms, duration: 600.ms)
                              .slideY(begin: 0.5),
                          const SizedBox(height: 16),
                          Text(
                            'School Finance Administration System',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.white70),
                          ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                        ],
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32.0),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (!isDesktop) ...[
                              Icon(Remix.bank_fill,
                                      size: 64,
                                      color: Theme.of(context).colorScheme.primary)
                                  .animate()
                                  .fadeIn(duration: 800.ms)
                                  .scale(delay: 200.ms),
                              const SizedBox(height: 24),
                              Text(
                                'SFAS Login',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displayMedium,
                              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.5),
                              const SizedBox(height: 48),
                            ] else ...[
                              Text(
                                'Welcome Back',
                                style: Theme.of(context).textTheme.displayMedium,
                              ).animate().fadeIn().slideY(begin: 0.2),
                              const SizedBox(height: 8),
                              Text(
                                'Sign in to access your administrative dashboard.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.grey[600]),
                              ).animate().fadeIn(delay: 200.ms),
                              const SizedBox(height: 48),
                            ],
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Corporate Email',
                                prefixIcon: const Icon(Remix.mail_line),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Remix.lock_password_line),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1),
                            const SizedBox(height: 32),
                            state.maybeWhen(
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              orElse: () => ElevatedButton(
                                onPressed: _submit,
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ).animate().fadeIn(delay: 500.ms).scale(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
