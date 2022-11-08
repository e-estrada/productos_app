import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProductModel product;

  ProductFormProvider(this.product);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
