import 'package:flutter/material.dart';
import 'package:seminario_6/models/product.dart';

class Productcard extends StatelessWidget {
  final Product product;
  const Productcard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: _cardBorders(),
        width: double.infinity,
        height: 400,
        margin: EdgeInsets.only(top: 30, bottom: 50),
        child: Stack(alignment: Alignment.bottomLeft, children: [
          _BackgroundImage(product.picture),
          _ProductDetails(product.name, product.id!),
          Positioned(top: 0, right: 0, child: _priceTag(product.price)),
          if (!product.available)
            Positioned(top: 0, left: 0, child: _notAvailable())
        ]),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _notAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            child: Text(
              'Not available',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}

class _priceTag extends StatelessWidget {
  final double price;

  const _priceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            child: Text(
              price.toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const _ProductDetails(this.titulo, this.subtitulo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        decoration: _buildBoxDexoration(),
        child: Padding(
          padding: EdgeInsets.only(right: 160),
          child: Column(
            children: [
              Text(titulo,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis),
              Text(subtitulo,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        height: 70,
        width: double.infinity,
      ),
    );
  }

  BoxDecoration _buildBoxDexoration() => BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), topRight: Radius.circular(25)),
      );
}

class _BackgroundImage extends StatelessWidget {
  final String? url;
  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: url == null
            ? Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover)
            : FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url!),
                fit: BoxFit.cover),
      ),
    );
  }
}
