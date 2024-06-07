import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

import '../../presentation_container.dart';
import 'components/custom_profile_field.dart';

class EditUserProfilePage extends StatelessWidget {

  static const name = 'EditUserProfilePage';

  const EditUserProfilePage({super.key});
  // final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        title: const Text('Edición de Datos'),
      ),
      body: const BackgroundImageWidget(
        opacity: 0.1,
        child: _EditProfileBodyPage()
      ),
    );
  }
}

class _EditProfileBodyPage extends ConsumerWidget {
  const _EditProfileBodyPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //TODO: Implementar provider de edición de datos del usuario
    // Aqui
    final textStyles = Theme.of(context).textTheme;
    final authState = ref.watch( authProvider ).userData!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
        
            CustomProfileField( 
              hint: authState.nombre,
              isTopField: true,
              isBottomField: true,
              label: 'Nombre',
              // keyboardType: const TextInputType.numberWithOptions(decimal: true),
              // initialValue: authState.nombre,
            ),
            const SizedBox( height: 20 ),
            
            CustomProfileField( 
              hint: authState.email,
              isTopField: true,
              isBottomField: true,
              label: 'Correo',
              // keyboardType: const TextInputType.numberWithOptions(decimal: true),
              // initialValue: authState.nombre,
            ),
            const SizedBox( height: 20 ),
        
            CustomProfileField( 
              hint: authState.telefono,
              isTopField: true,
              isBottomField: true,
              label: 'Numero de Telefono',
              // keyboardType: const TextInputType.numberWithOptions(decimal: true),
              // initialValue: authState.nombre,
            ),
            const SizedBox( height: 20 ),
        
            const CustomProfileField( 
              hint: 'Escribir contraseña',
              obscureText: true,
              isTopField: true,
              isBottomField: true,
              label: 'Contraseña',
              // keyboardType: const TextInputType.numberWithOptions(decimal: true),
              // initialValue: authState.nombre,
            ),
            const SizedBox( height: 20 ),

            const CustomProfileField(
              hint: 'Escribir biografia',
              maxLines: 4,
              isTopField: true,
              isBottomField: true,
              label: 'Biografia',
              // keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            
            // CustomTextFormField(
            //   label: 'Biografia',
            //   obscureText: true,
            //   onChanged: ref.read( registerFormProvider.notifier ).onPasswordChanged,
            //   errorMessage: registerForm.isFormPosted
            //     ? registerForm.password.errorMessage
            //     : null,
            // ),
            const SizedBox( height: 40 ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Editar',
                buttonColor: Colors.blueAccent.shade400,
                onPressed: (){ 
                  // registerForm.isPosting
                  // ? null
                  // : ref.read( registerFormProvider.notifier ).onFormSubmit().then((value) {
                  //     if( registerForm.isValid && value == true ) context.push('/profile-user');
                  // });
                }, 
              )
            ),
            const SizedBox( height: 20)
          ],
        ),
      ),
    );
  }
}