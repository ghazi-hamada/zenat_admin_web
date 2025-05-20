import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/core/functions/extensions.dart';
import 'package:zenat_admin_web/core/routing/routes.dart';
import 'package:zenat_admin_web/features/login/logic/login_cubit.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context)!;
    const primaryColor = Color(0xFFFB962B);
    var cubit = context.read<LoginCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Left side - Admin Info
              if (constraints.maxWidth > 800)
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    color: const Color(0xFFF5F5F5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo.png', width: 250),
                        const SizedBox(height: 170),
                        Text(
                          localizations.adminPanelTitle,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          localizations.adminPanelDescription,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),

              // Right side - Login Form
              Expanded(
                flex: 3,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            localizations.loginTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Form(
                            key: cubit.formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: cubit.usernameController,
                                  decoration: InputDecoration(
                                    labelText: localizations.usernameOrEmail,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return localizations.enterUsername;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<LoginCubit, LoginState>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      controller: cubit.passwordController,
                                      obscureText: cubit.isPasswordVisible,

                                      decoration: InputDecoration(
                                        suffixIcon:
                                            !cubit.isPasswordVisible
                                                ? IconButton(
                                                  icon: const Icon(
                                                    Icons.visibility,
                                                  ),
                                                  onPressed: () {
                                                    cubit
                                                        .togglePasswordVisibility();
                                                  },
                                                )
                                                : IconButton(
                                                  icon: const Icon(
                                                    Icons.visibility_off,
                                                  ),
                                                  onPressed: () {
                                                    cubit
                                                        .togglePasswordVisibility();
                                                  },
                                                ),
                                        labelText: localizations.password,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return localizations.enterPassword;
                                        }
                                        return null;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          ElevatedButton(
                            onPressed: () {
                              // Handle login action
                              cubit.login();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: BlocConsumer<LoginCubit, LoginState>(
                              listener: (context, state) {
                                if (state is LoginSuccess) {
                                  context.pushReplacementNamed(
                                    Routes.dashboard,
                                  );
                                } else if (state is LoginFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.error),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is LoginLoading) {
                                  return const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }
                                return Text(
                                  localizations.loginButton,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          const SizedBox(height: 32),
                          Center(
                            child: Text(
                              localizations.copyright,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
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
