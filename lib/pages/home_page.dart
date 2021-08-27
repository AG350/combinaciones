import 'package:flutter/material.dart';
import 'package:formas_colores/models/color_model.dart';
import 'package:formas_colores/pages/combinaciones_page.dart';
import 'package:formas_colores/provider/data_provider.dart';
import 'package:formas_colores/widgets/form_button_widget.dart';
import 'package:formas_colores/widgets/painter_triangulos_widget.dart';
import 'package:formas_colores/widgets/textfield_widget.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PainterRedondoWidget(),
              FormularioSeleccion(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormularioSeleccion extends StatelessWidget {
  final nombreController = new TextEditingController();
  final colores = <ColorModel>[
    ColorModel(color: 'FFFF00', descripcionColor: 'Amarillo', id: '003'),
    ColorModel(color: '0000FF', descripcionColor: 'Azul', id: '002'),
    ColorModel(color: 'FF0000', descripcionColor: 'Rojo', id: '001'),
  ];

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
              onPressed: (value) {
                print(value);
              },
            ),
            SizedBox(height: 20),
            SelectionItem(
              colores: colores,
              hint: 'Seleccione Forma',
              icon: Icons.colorize_outlined,
              onPressed: (value) {
                print(value);
                if (value != null) {
                CombinacionesProvider.combinacionSeleccionada?.color.color = value!;
                }
              },
            ),
            TextfieldWidget(labelText: 'Descripcion', controller: this.nombreController),
            SizedBox(height: 20),
            FormButton(
              text: 'Combinar',
              onPress: () {
                Navigator.pushReplacementNamed(context, 'combinaciones');
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
    required this.colores,
    required this.hint,
    required this.icon,
    required this.onPressed,
  });

  final List<ColorModel> colores;
  final String hint;
  final IconData icon;
  final Function(String?)? onPressed;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(hint),
      elevation: 3,
      icon: Icon(icon),
      items: colores
          .map((e) => DropdownMenuItem(
                child: Container(child: Text(e.descripcionColor)),
                value: e.color,
              ))
          .toList(),
      onChanged: onPressed,
    );
  }
}
