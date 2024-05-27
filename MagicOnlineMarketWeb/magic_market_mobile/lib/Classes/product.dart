class Product {
  final String usuario;
  final String nombreProducto;
  final double precio;

  Product(
      {required this.usuario,
      required this.nombreProducto,
      required this.precio});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      usuario: json['usuario'],
      nombreProducto: json['nombreProducto'],
      precio: json['precio'].toDouble(),
    );
  }
}
