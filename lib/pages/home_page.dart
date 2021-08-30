import 'package:flutter/material.dart';
import 'package:formas_colores/models/models.dart';
import 'package:formas_colores/provider/data_provider.dart';
import 'package:formas_colores/widgets/widgets.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  static final routeName = 'home';
  late CombinacionModel combinacionStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: CombinacionesProvider.seleccionStreamController,
            initialData: CombinacionesProvider.combinacionSeleccionada,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                combinacionStream = snapshot.data;
              }
              return Container(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 600,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FormularioSeleccion(),
                        FormasSelector(
                          forma: combinacionStream.forma.descripcion,
                          color: combinacionStream.color.color,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class FormularioSeleccion extends StatefulWidget {
  @override
  _FormularioSeleccionState createState() => _FormularioSeleccionState();
}

class _FormularioSeleccionState extends State<FormularioSeleccion> {
  final nombreController = new TextEditingController();
  final dp = CombinacionesProvider();
  final colores = new CombinacionesProvider().colores;
  final formas = new CombinacionesProvider().formas;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectionItem(
              colores: colores,
              hint: 'Seleccione color',
              icon: Icons.colorize_outlined,
              onPressedColor: (value) {
                if (value != null) {
                  CombinacionesProvider.combinacionSeleccionada.color = value;
                  CombinacionesProvider.formulario();
                  setState(() {});
                }
              },
            ),
            SizedBox(height: 20),
            SelectionItem(
              formas: formas,
              hint: 'Seleccione Forma',
              icon: Icons.colorize_outlined,
              onPressedForma: (value) {
                if (value != null) {
                  CombinacionesProvider.combinacionSeleccionada.forma = value;
                  CombinacionesProvider.formulario();
                  setState(() {});
                }
              },
            ),
            TextfieldWidget(
              labelText: 'Descripcion',
              controller: this.nombreController,
              onChanged: (value) {
                CombinacionesProvider.combinacionSeleccionada.descripcion = value;
              },
            ),
            SizedBox(height: 20),
            FormButton(
              text: 'Combinar',
              onPress: () {
                if (this.nombreController.text != '') {
                  CombinacionesProvider.combinacionSeleccionada!.descripcion = this.nombreController.text;
                  print('${CombinacionesProvider.combinacionSeleccionada.color} + ${this.nombreController.text}');
                  dp.combinar();
                }
                Navigator.pushReplacementNamed(context, 'combinaciones');
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}

class SelectionItem extends StatelessWidget {
  const SelectionItem({
    this.colores,
    this.formas,
    required this.hint,
    required this.icon,
    this.onPressedForma,
    this.onPressedColor,
  });

  final List<ColorModel>? colores;
  final List<FormaModel>? formas;
  final String hint;
  final IconData icon;
  final Function(FormaModel?)? onPressedForma;
  final Function(ColorModel?)? onPressedColor;

  @override
  Widget build(BuildContext context) {
    if (colores != null) {
      return DropdownButtonFormField(
        hint: Text(hint),
        elevation: 3,
        icon: Icon(icon),
        items: colores!
            .map((e) => DropdownMenuItem(
                  child: Container(child: Text(e.descripcionColor)),
                  value: e,
                ))
            .toList(),
        onChanged: onPressedColor,
      );
    } else {
      return DropdownButtonFormField(
        hint: Text(hint),
        elevation: 3,
        icon: Icon(icon),
        items: formas!
            .map((e) => DropdownMenuItem(
                  child: Container(child: Text(e.descripcion)),
                  value: e,
                ))
            .toList(),
        onChanged: onPressedForma,
      );
    }
  }
}
