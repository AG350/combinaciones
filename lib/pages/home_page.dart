import 'package:flutter/material.dart';
import 'package:formas_colores/models/models.dart';
import 'package:formas_colores/provider/data_provider.dart';
import 'package:formas_colores/widgets/widgets.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  static final routeName = 'home';

  @override
  Widget build(BuildContext context) {
    CombinacionesProvider.formulario();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            child: Center(
              child: Container(
                width: double.infinity,
                height: 600,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormularioSeleccion(),
                    AnimatedSelection(),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class FormularioSeleccion extends StatelessWidget {
  final dp = CombinacionesProvider();
  @override
  Widget build(BuildContext context) {
    CombinacionesProvider().cargarFormaColor();
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorSelect(),
            SizedBox(height: 20),
            FormaSelect(),
            TextfieldWidget(
                labelText: 'Descripcion',
                onChanged: (value) {
                  CombinacionesProvider.combinacionSeleccionada.descripcion = value;
                  print(CombinacionesProvider.combinacionSeleccionada.descripcion);
                }),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FormButton(
                  text: 'Combinar',
                  onPress: () {
                    if (CombinacionesProvider.combinacionSeleccionada.descripcion != '') {
                      dp.combinar();
                      CombinacionesProvider().cargarCombinaciones();
                      Navigator.pushReplacementNamed(context, 'combinaciones');
                    }
                  },
                ),
                FormButton(
                  text: 'Ver Combinaciones',
                  onPress: () {
                    CombinacionesProvider().limpiarSeleccion();
                    Navigator.pushReplacementNamed(context, 'combinaciones');
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FormaSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CombinacionesProvider.formaStreamController,
      initialData: CombinacionesProvider.listadoformas,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Container(
          child: SelectionItem(
            formas: snapshot.data,
            hint: 'Seleccione Forma',
            icon: Icons.colorize_outlined,
          ),
        );
      },
    );
  }
}

class ColorSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CombinacionesProvider.colorStreamController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Container(
          child: SelectionItem(
            colores: snapshot.data,
            hint: 'Seleccione color',
            icon: Icons.colorize_outlined,
          ),
        );
      },
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
                  onTap: () {
                    CombinacionesProvider.combinacionSeleccionada.color = e;
                  },
                ))
            .toList(),
        onChanged: (_) {
          CombinacionesProvider.formulario();
        },
      );
    } else {
      return DropdownButtonFormField(
        hint: Text(hint),
        elevation: 3,
        icon: Icon(icon),
        items: formas!
            .map(
              (e) => DropdownMenuItem(
                child: Container(child: Text(e.descripcion)),
                value: e,
                onTap: () {
                  
                  CombinacionesProvider.combinacionSeleccionada.forma = e;
                },
              ),
            )
            .toList(),
        onChanged: (_) {
          CombinacionesProvider.formulario();
        },
      );
    }
  }
}
