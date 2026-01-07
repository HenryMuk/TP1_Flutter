import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('produits');

  // Ajouter un produit
  Future<void> addProduct(String nom, String description, double prix) async {
    await _productsRef.add({
      'nom': nom,
      'description': description,
      'prix': prix,
      'dateCreation': FieldValue.serverTimestamp(),
    });
  }

  // Récupérer tous les produits
  Stream<QuerySnapshot> getProducts() {
    return _productsRef.orderBy('dateCreation', descending: true).snapshots();
  }
}
