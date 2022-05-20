import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GenericPage extends StatelessWidget {
  final IconData iconData;
  final String nameModule;
  const GenericPage({
    Key? key,
    required this.iconData,
    required this.nameModule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.2),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(50),
          width: 600,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green.withOpacity(.8),
              width: 5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                size: 100,
                color: Colors.green,
              ),
              Text(
                "Módulo de $nameModule",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
                color: Colors.green.withOpacity(.2),
              ),
              Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Parameter: ${textParams ?? "Nenhum paramêtro encontrado"}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Query Parameters passados: ${querys.length}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...querys
                        .map((q) => Text(
                              "    $q",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                        .toList()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? get textParams {
    final param = Modular.args.params["param"];
    if (param != null && param == "") return null;
    return param;
  }

  List<String> get querys {
    return Modular.args.queryParams.entries
        .map((key) => "${key.key}: ${key.value}")
        .toList();
  }
}
