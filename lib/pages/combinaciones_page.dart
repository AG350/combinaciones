import 'package:flutter/material.dart';
import 'package:formas_colores/models/models.dart';
import 'package:formas_colores/provider/data_provider.dart';

class CombinacionesPage extends StatelessWidget {
  static String routeName = 'combinaciones';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Combinaciones'),
        actions: [
          Sincronizar(),
        ],
      ),
      body: SafeArea(
        child: Body(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
        child: Icon(Icons.home),
      ),
    );
  }
}

class Sincronizar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 25,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 0,
            title: Text('Sincronizar Registros'),
            content: Text(
              'Confirma la accion? no se puede deshacer.',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text('Si'),
                onPressed: () {
                  CombinacionesProvider().sincronizarCombinaciones();
                  CombinacionesProvider().cargarCombinaciones();
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
          useSafeArea: true,
        );
      },
      icon: Icon(
        Icons.sync_rounded,
        color: Colors.white,
      ),
    );
  }
}

class Body extends StatelessWidget {
  final cp = CombinacionesProvider();

  @override
  Widget build(BuildContext context) {
    cp.cargarCombinaciones();
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: CombinacionesProvider.combinacionesStreamController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final List<CombinacionModel> lista = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: lista.length,
              itemBuilder: (BuildContext context, int index) {
                CombinacionModel item = lista[index];
                return ItemsCombinaciones(item: item);
              },
            );
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}

class ItemsCombinaciones extends StatelessWidget {
  const ItemsCombinaciones({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CombinacionModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(item.color.descripcionColor),
          SizedBox(width: 5),
          Text(item.forma.descripcion),
          SizedBox(width: 5),
          Text(item.descripcion),
        ],
      ),
      trailing: item.idFirebase == null || item.idFirebase == ''
          ? Icon(Icons.sync_disabled, color: Colors.red)
          : Icon(Icons.sync_alt, color: Colors.green),
    );
  }
}

