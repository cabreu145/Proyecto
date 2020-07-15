import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {
  final String _url = 'https://flutter-proyect-dc09a.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json'; //Post

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json'; //Put

    final resp = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json'; //Get

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      //listado de api flutter
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);

      //print(prod);
    });
    // print(productos[0].id);
    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1; //significa ya se hizo
  }
}

// File photo;

//   @override
//   Widget build(BuildContext context) {...}

//   _processImage(ImageSource origin) async {
//     final _picker = ImagePicker();

//     final pickedFile = await _picker.getImage(
//       source: origin,
//     );

//     photo = File(pickedFile.path);

//     if (photo != null) {
//       product.urlImg = null;
//     }

//     setState(() {});
//   }
