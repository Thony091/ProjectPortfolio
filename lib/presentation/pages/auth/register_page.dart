import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../presentation_container.dart';

class RegisterPage extends StatelessWidget {

  static const name = 'RegisterPage';
  
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {

    final color = AppTheme().getTheme().colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear cuenta'),
          backgroundColor: color.primary,
        ),
        body:  const BackgroundImageWidget(
          opacity: 0.1,
          child: _RegisterForm()
        ),
      ),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  void showSnackBar( BuildContext context, String message ){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final registerForm = ref.watch(( registerFormProvider ));
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    ref.listen(authProvider, (previous, next) { 
      if ( next.errorMessage.isEmpty )  return;
      showSnackBar( context, next.errorMessage );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox( height: 30 ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ingresar Datos',
                  style: 
                    textStyles.titleLarge,
                ),
              ],
            ),
            const SizedBox( height: 20 ),
        
            CustomTextFormField(
              label: 'Nombre(*) ',
              keyboardType: TextInputType.name,
              onChanged: ref.read( registerFormProvider.notifier ).onNameChange,
              errorMessage: registerForm.isFormPosted
                ? registerForm.name.errorMessage
                : null,
            ),
            const SizedBox( height: 20 ),
        
            CustomTextFormField(
              label: 'Rut(*)',
              keyboardType: TextInputType.text,
              onChanged: ref.read( registerFormProvider.notifier ).onRutChange,
              errorMessage: registerForm.isFormPosted
                ? registerForm.rut.errorMessage
                : null,
            ),
            const SizedBox( height: 20 ),
            
            CustomTextFormField(
              label: 'Fecha de Nacimiento',
              keyboardType: TextInputType.text,
              onChanged: ref.read( registerFormProvider.notifier ).onBirthayChange,
              errorMessage: registerForm.isFormPosted
                ? registerForm.birthday.errorMessage
                : null,
            ),
            const SizedBox( height: 20 ),
        
            CustomTextFormField(
              label: 'Correo(*)',
              keyboardType: TextInputType.emailAddress,
              onChanged: ref.read( registerFormProvider.notifier ).onEmailChange,
              errorMessage: registerForm.isFormPosted
                ? registerForm.email.errorMessage
                : null,
            ),
            const SizedBox( height: 20 ),
        
            CustomTextFormField(
              label: 'Numero de Telefono(*)',
              keyboardType: TextInputType.emailAddress,
              onChanged: ref.read( registerFormProvider.notifier ).onPhoneChange,
              errorMessage: registerForm.isFormPosted
                ? registerForm.phone.errorMessage
                : null,
            ),
            const SizedBox( height: 20 ),
        
            CustomTextFormField(
              label: 'Contraseña(*)',
              obscureText: true,
              onChanged: ref.read( registerFormProvider.notifier ).onPasswordChanged,
              errorMessage: registerForm.isFormPosted
                ? registerForm.password.errorMessage
                : null,
            ),
            const SizedBox( height: 30 ),        
            CustomFilledButton(
              height: 60,
              width: size.width * 0.70,
              radius: const Radius.circular(25),
              shadowColor: Colors.white,
              spreadRadius: 4,
              blurRadius: 3,
              icon: Icons.person_add,
              text: 'Crear',
              iconSeparatorWidth: 65,
              fontSize: 22,
              buttonColor: Colors.blueAccent.shade400,
              mainAxisAlignment: MainAxisAlignment.start,
              onPressed: (){ registerForm.isPosting
                ? null
                : ref.read( registerFormProvider.notifier ).onFormSubmit().then((value) {
                    if( registerForm.isValid && value == true ) {
                      context.push('/login');
                      showDialog(
                        context: context, 
                        builder: (context) => const PopUpMensajeFinalWidget(text: 'Se ha Registrado Exitosamente!'),
                      );
                    }
                });
              }, 
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿Ya tienes cuenta?'),
                TextButton(
                  onPressed: (){
                    context.push('/login');
                  }, 
                  child: const Text('Ingresa aquí')
                )
              ],
            ),
            const SizedBox( height: 20)
          ],
        ),
      ),
    );
  }
}