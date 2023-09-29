// import 'package:flutter/material.dart';

// class EditProduct extends StatefulWidget {
//   late int productId;
//   late String productName;
//   late int categoryId;
//   late String price;
//   late String supplierInfo;
//   late String productPhoto;

//   String? _mySelection;

//   EditProduct({
//     required this.productId,
//     required this.productName,
//     required this.categoryId,
//     required this.price,
//     required this.supplierInfo,
//     required this.productPhoto,
//   });

//   @override
//   State<EditProduct> createState() => _EditProductState(
//         productId1: productId,
//         productName1: productName,
//         categoryId1: categoryId,
//         price1: price,
//         supplierInfo1: supplierInfo,
//         productPhoto1: productPhoto,
//       );
// }

// class _EditProductState extends State<EditProduct> {
//   late int productId1;
//   late String productName1;
//   late int categoryId1;
//   late String price1;
//   late String supplierInfo1;
//   late String productPhoto1;

//   var productNameController = TextEditingController();
//   var priceController = TextEditingController();
//   var supplierInfoController = TextEditingController();

//   _EditProductState({
//     required this.productId1,
//     required this.productName1,
//     required this.categoryId1,
//     required this.price1,
//     required this.supplierInfo1,
//     required this.productPhoto1,
//   });

//   @override
//   void initState() {
//     productNameController.text = productName1;
//     priceController.text = price1;
//     supplierInfoController.text = supplierInfo1;

//     supplierInfoController = supplierInfoController;

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 40, bottom: 5),
//               child: Text(
//                 "Add New Product",
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5),
//                       child: TextField(
//                         controller: productNameController,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     color: Colors.black,
//                                     style: BorderStyle.solid)),
//                             hintText: "Product Name"),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5),
//                       child: DropdownButton<String>(
//                         value: _mySelection,
//                         iconSize: 30,
//                         icon: (null),
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 16,
//                         ),
//                         hint: Text('Select a Category...'),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _mySelection = newValue!;
//                           });
//                         },
//                         items: _categories.map((item) {
//                           return DropdownMenuItem(
//                             value: item['category_id'].toString(),
//                             child: Text(item["category_name"]),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5.0),
//                       child: Text(
//                         "Price",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                     TextField(
//                       controller: priceController,
//                       decoration: InputDecoration(
//                         prefixText: "Rs.",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                                 color: Colors.black, style: BorderStyle.solid)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "Suppliers Info",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5.0),
//                       child: TextField(
//                         keyboardType: TextInputType.multiline,
//                         maxLines: 5,
//                         controller: supplierInfoController,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(
//                                   color: Colors.black,
//                                   style: BorderStyle.solid)),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5),
//                       child: GestureDetector(
//                         onTap: _openGallery,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(),
//                               borderRadius: BorderRadius.circular(8)),
//                           height: 150,
//                           width: double.infinity,
//                           child: pickedFile != null
//                               ? Image.file(
//                                   File(pickedFile!.path),
//                                   height: 20,
//                                   width: 20,
//                                 )
//                               : Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                       Icon(Icons.cloud_upload_outlined),
//                                       Text("Click here to choose an image")
//                                     ]),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: SizedBox(
//                         height: 50,
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(),
//                           onPressed: () {
//                             addproducts();
//                           },
//                           child: Text('Add'),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5),
//                       child: SizedBox(
//                         height: 50,
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white),
//                           onPressed: () {
//                             Navigator.pop(context);
//                             setState(() {
//                               productNameController.text = '';
//                               pickedFile = null;
//                             });
//                           },
//                           child: Text(
//                             'Cancel',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
