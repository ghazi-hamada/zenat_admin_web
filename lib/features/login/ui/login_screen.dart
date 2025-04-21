import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/core/functions/extensions.dart';
import 'package:zenat_admin_web/core/routing/routes.dart';
import 'package:zenat_admin_web/features/login/logic/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        Image.asset('images/logo.png', width: 250),
                        SizedBox(height: 170),
                        Text(
                          'لوحة التحكم - زينات',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'مرحباً بك في لوحة إدارة تطبيق زينات. من هنا يمكنك إدارة الحسابات، مراجعة البيانات، التحكم بالمحتوى، والإشراف على التجربة الكاملة للمستخدمين.\n\n'
                          'يرجى التأكد أنك تملك صلاحية الدخول إلى هذه اللوحة. أي استخدام غير مصرح به قد يؤدي إلى الملاحقة.\n\n'
                          'نسعى دائماً لتقديم منصة آمنة ومحترمة لجميع المستخدمين، ودورك في الإدارة جزء أساسي من ذلك.',
                          style: TextStyle(
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
                          const Text(
                            'تسجيل الدخول للوحة الإدارة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                                    labelText:
                                        'اسم المستخدم أو البريد الإلكتروني',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى ادخال اسم المستخدم';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: cubit.passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'كلمة المرور',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى ادخال كلمة المرور';
                                    }
                                    return null;
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
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'هل نسيت كلمة المرور؟',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'إنشاء حساب جديد',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Center(
                            child: Text(
                              '© 2025 Zinat',
                              style: TextStyle(
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
