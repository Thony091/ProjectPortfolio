import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../providers/providers.dart';
import '../../shared/shared.dart';

class LoginPage extends StatelessWidget {

  static const name = 'LoginPage';
  
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final color   = AppTheme().getTheme().colorScheme;
    // final size    = MediaQuery.of(context).size;
    
    return  Scaffold(
      
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: color.primary,
      ),
      body: const BackgroundImageWidget(
        opacity: 0.1,
        child: _LoginForm()
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackBar( BuildContext context, String message ){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginForm = ref.watch(( loginFormProvider )); //para obtener el valor del state

    ref.listen(authProvider, (previous, next) { 
      if ( next.errorMessage.isEmpty )  return;
      showSnackBar( context, next.errorMessage );
    });

    final size = MediaQuery.of(context).size;
    // final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox( height: 50 ),
          
              Image.asset(
                'assets/icons/AR_2.png',
                width: 230, 
                height: 230, 
                fit: BoxFit.contain,
              ),
          
              const SizedBox( height: 40 ),
          
              CustomTextFormField(
                label: 'Correo',
                keyboardType: TextInputType.emailAddress,
                onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
                errorMessage: loginForm.isFormPosted 
                ? loginForm.email.errorMessage
                : null,
              ),
              const SizedBox( height: 30 ),
          
              CustomTextFormField(
                label: 'Contraseña',
                obscureText: true,
                onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
                errorMessage: loginForm.isFormPosted
                ? loginForm.password.errorMessage
                : null,
              ),
              
              const SizedBox( height: 30 ),
          
              CustomFilledButton(
                height: 60,
                width: size.width * 0.72,
                radius: const Radius.circular(25),
                shadowColor: Colors.white,
                spreadRadius: 4,
                blurRadius: 3,
                icon: Icons.person_2_rounded,
                iconSeparatorWidth: 50,
                text: 'Ingresar',
                fontSize: 22,
                buttonColor: Colors.blueAccent.shade400,
                mainAxisAlignment: MainAxisAlignment.start,
                onPressed: loginForm.isPosting
                  ? null
                  : ref.read(loginFormProvider.notifier).onFormSubmit
                  // if ( loginForm.isPosting ) context.push('/')
                
              ),
          
              // const Spacer(  ),
              const SizedBox( height: 20),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () => context.push('/register'), 
                    child: const Text('Crea una aquí')
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}