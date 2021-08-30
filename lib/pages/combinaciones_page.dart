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
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.sync_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final cp = CombinacionesProvider();

  @override
  Widget build(BuildContext context) {
    cp.cargarCombinaciones();
    return Center(
      child: SingleChildScrollView(
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


void syncItems()async{
  
}