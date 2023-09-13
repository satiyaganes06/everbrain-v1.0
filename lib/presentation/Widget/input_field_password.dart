import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFieldPassword extends StatefulWidget {

  TextEditingController passwordController;
  bool passwordToggle;

  InputFieldPassword(this.passwordController, this.passwordToggle);

  @override
  State<InputFieldPassword> createState() => _InputFieldPasswordState();
}

class _InputFieldPasswordState extends State<InputFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
            controller: widget.passwordController,
            keyboardType: widget.passwordToggle == false?
              TextInputType.visiblePassword : TextInputType.emailAddress,
            obscureText: widget.passwordToggle,
            cursorColor: Colors.redAccent,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Enter Password',
              hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              contentPadding: const EdgeInsets.only(left: 20),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: (){
                  funPasswordToggle();
                },
                icon: widget.passwordToggle== false ?
                const Icon(Icons.visibility_off_outlined) :
                const Icon(Icons.visibility_outlined),
                iconSize: 20,
                color: widget.passwordToggle == false ?
                Colors.redAccent :
                Colors.green,
              ),
              suffixIconColor: Colors.grey,
            ),
          )
      );
  }

  void funPasswordToggle(){
    setState(() {
      widget.passwordToggle = !widget.passwordToggle;
    });
  }
}

