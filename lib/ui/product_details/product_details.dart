import 'package:ecommerce/cubits/local_cart_cubit.dart';
import 'package:ecommerce/cubits/local_cart_cubit_state.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/ui/components/add_to_cart_btn.dart';
import 'package:ecommerce/ui/components/color_card.dart';
import 'package:ecommerce/ui/components/quantity_card.dart';
import 'package:ecommerce/ui/components/size_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/product_details';
  ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSizeIndex = -1;
  int selectedColorIndex = -1;
  List<String> sizes = [
    "XS",
    "S",
    "M",
    "L",
  ];
  List<Color> colors = [
    Color.fromRGBO(47, 41, 41, 1),
    Color.fromRGBO(188, 48, 24, 1),
    Color.fromRGBO(9, 115, 221, 1),
    Color.fromRGBO(2, 185, 53, 1),
    Color.fromRGBO(255, 100, 90, 1),
  ];
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductsDataDto;
    var product = args;
    var productImages = args.images!
        .map((image) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ))
        .toList();
    print("product: $product");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actionsPadding: EdgeInsets.only(right: 20, top: 5),
        actions: [
          Badge(
            label: BlocBuilder<LocalCartCubit, LocalCartCubitState>(
              builder: (context, state) {
                if (state is AddToCartSuccessState) {
                  return Text(
                    state.products != null
                        ? state.products!.length.toString()
                        : "0",
                    style: TextStyle(fontSize: 15),
                  );
                } else {
                  return Text(
                    "0",
                    style: TextStyle(fontSize: 15),
                  );
                }
              },
            ),
            largeSize: 20,
            offset: Offset(5, -15),
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: ImageIcon(
                size: 26,
                const AssetImage('assets/images/shopping_cart.png'),
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "Product Details",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: const Color.fromRGBO(0, 65, 130, 0.3))),
              child: ImageSlideshow(
                // width: 200,
                height: MediaQuery.of(context).size.height * .3,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorBackgroundColor: Colors.white,
                children: productImages,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 220,
                    child: Text(
                      product.title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Text(
                    "EGP${product.price}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              // color: Colors.black,
              margin: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 35,
                        margin: EdgeInsets.only(right: 15),
                        // padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: const Color.fromRGBO(0, 65, 130, 0.3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${product.sold} Sold",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        child: Image.asset(
                          'assets/images/star.png',
                          width: 16,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 3),
                        child: Text(
                          "${product.ratingsAverage}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "(${product.ratingsQuantity})",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  QuantityCard(),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Description",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                product.description!.replaceAll("\n", ""),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Size",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 40,
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () => setState(() {
                          selectedSizeIndex = index;
                        }),
                        child: SizeCard(
                          size: sizes[index],
                          isSelected: selectedSizeIndex == index,
                        ),
                      ),
                    );
                  },
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Color",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 40,
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () => setState(() {
                          selectedColorIndex = index;
                        }),
                        child: ColorCard(
                          color: colors[index],
                          isSelected: selectedColorIndex == index,
                        ),
                      ),
                    );
                  },
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Total Price",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "EGP ${product.price}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                  AddToCartBtn(
                    productId: product.id,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
