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
                                      title: Text(
                                          snapshot.data![index].nombreMascota),
                                      subtitle: Text("Edad: " +
                                          snapshot.data![index].edad +
                                          " - "),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.search),
      ),
    );
  }
}
