import 'package:flutter/material.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({Key? key}) : super(key: key);

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contasenaController = TextEditingController();
  final TextEditingController _confirmarcntrasenaController =
      TextEditingController();
  bool isVisibleObsecure = false;

  void _submittedForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Cuenta creada"),
      ));
    }
  }

  String? validateNombre(String? value) {
    if (value!.isEmpty) {
      return "Ingresa Nombre";
    } else if (RegExp(r"^[a-z A-Z]+$").hasMatch(value)) {
      return "Por favor ingresa un nombre valido con numero y caracteres especiales";
    }
    return null;
  }

  String? validateCorreo(String? value) {
    if (value!.isEmpty) {
      return "Ingresa tu Correo";
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return "Por favor ingresa un correo valido ";
    }
    return null;
  }

  String? validateContrasena(String? value, String? text) {
    if (value!.isEmpty) {
      return "Ingresa tu Contraseña";
    } else if (value.length < 6) {
      return "Porfavor ingresa una contraseña con al menos 6 caracteres";
    } else if (!RegExp(r"^[a-z A-Z0-9]").hasMatch(value)) {
      return "La contraseña debe contener olo letras y numeros";
    }
    return null;
  }

  String? validateConfirmarContrasena(String? value, String? text) {
    if (value!.isEmpty) {
      return "Confirma tu contraseña";
    } else if (value != text) {
      return " La contraseña no coincide";
    }
    return validateContrasena(value, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(image: AssetImage("assets/sweetcandy.png")),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Crear nueva cuenta",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffec60a6),
                              height: 1),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) => validateNombre(value),
                          controller: _nameController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "Nombre"),
                        ),
                        TextFormField(
                          validator: (value) => validateCorreo(value),
                          controller: _correoController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Correo"),
                        ),
                        TextFormField(
                          validator: (value) => validateContrasena(
                              value, _confirmarcntrasenaController.text),
                          controller: _contasenaController,
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: isVisibleObsecure,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisibleObsecure = !isVisibleObsecure;
                                    });
                                  },
                                  icon: isVisibleObsecure
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                              prefixIcon: Icon(Icons.password),
                              hintText: "Contraseña"),
                        ),
                        TextFormField(
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: isVisibleObsecure,
                          validator: (value) => validateConfirmarContrasena(
                              value, _contasenaController.text),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: "Confirmar contraseña"),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffec60a6),
                              minimumSize: Size(300, 50)),
                          onPressed: () {
                            _submittedForm();
                          },
                          child: Text("Crear Cuenta",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xfff6f6f6))),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
