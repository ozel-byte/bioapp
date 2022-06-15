import 'package:bioapp/model/Paciente.dart';
import 'package:bioapp/services/ConexionApi.dart';
import 'package:flutter/material.dart';

class SearchPaciente extends StatefulWidget {
  SearchPaciente({Key? key}) : super(key: key);

  @override
  State<SearchPaciente> createState() => _SearchPacienteState();
}

class _SearchPacienteState extends State<SearchPaciente> {
  ConexionApi capi = ConexionApi();
  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Buscar Paciente"),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.1,
                  color: Colors.white,
                  child: Center(
                    child: TextField(
                      controller: _controller,
                      onChanged: (v) {
                        capi.busqueda(v);
                        setState(() {});
                      },
                      decoration: InputDecoration(hintText: "Buscar Paciente"),
                    ),
                  ),
                ),
                Container(
                    width: size.width * 0.8,
                    height: size.height * 0.75,
                    color: Colors.white,
                    child: _controller.text.length > 0
                        ? FutureBuilder(
                            future: capi.busqueda(_controller.text),
                            builder: ((context,
                                AsyncSnapshot<List<Paciente>> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      selectedColor: Colors.amber[200],
                                      leading: Icon(Icons.person),
                                      title: Text(
                                          snapshot.data![index].nombreMascota),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Peso: " +
                                              snapshot.data![index].peso),
                                          Text("Edad Mascota: " +
                                              snapshot.data![index].edad),
                                          Text("Estado: " +
                                              snapshot.data![index].estado),
                                          Text("Razon: " +
                                              snapshot.data![index].razon),
                                          Text("Sexo: " +
                                              snapshot.data![index].sexo),
                                          Text("Nombre del dueño: " +
                                              snapshot
                                                  .data![index].nombreDueno),
                                          Text("Direcion: " +
                                              snapshot.data![index].direccion),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                          )
                        : Center(child: Text("Buscar")))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
