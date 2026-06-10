import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme.dart';
import 'prov_auth.dart';
import '../domain/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

// Limpia los controladores para evitar fugas de memoria
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
// Maneja el proceso de login llamando al método del notifier
  Future<void> _handleLogin() async {
    if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: AppColors.surface,
          content: Text('Por favor, completa todos los campos.', style: AppTextStyles.bodyMedium()),
        ),
      );
      return;
    }
    await ref.read(authNotifierProvider.notifier).signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
  }
// Construye la interfaz de usuario y escucha cambios en el estado de autenticación para mostrar mensajes de error
  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authNotifierProvider);

    ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (_, next) {
      next.whenData((state) {
        state.maybeWhen(
          error: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.surface,
              content: Text(message, style: AppTextStyles.bodyMedium()),
            ),
          ),
          orElse: () {},
        );
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              Text('CONVIVENCIA\nAUDIOVISUAL',
                  style: AppTextStyles.displayMedium()),
              const SizedBox(height: 8),
              Text('Accede a tu cuenta', style: AppTextStyles.bodyLarge()),

              const SizedBox(height: 48),

              _buildInput(
                controller: _emailController,
                label: 'CORREO',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _buildInput(
                controller: _passwordController,
                label: 'CONTRASEÑA',
                obscureText: true,
              ),

              const SizedBox(height: 40),

              // Botón
              SizedBox(
                width: double.infinity,
                child: authAsync.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.gold,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _handleLogin,
                        child: Text(
                          'INGRESAR',
                          style: AppTextStyles.labelLarge().copyWith(
                            letterSpacing: 4,
                            fontSize: 12,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMedium()),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: AppTextStyles.bodyLarge().copyWith(
            fontStyle: FontStyle.normal,
            color: AppColors.gold,
            fontSize: 18,
          ),
          cursorColor: AppColors.gold,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.goldLine),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.gold),
            ),
          ),
        ),
      ],
    );
  }
}