import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/inner_screens/add_prod.dart';
import 'package:grocery_admin_panel/responsive.dart';
import 'package:grocery_admin_panel/services/global_method.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/buttons.dart';
import 'package:grocery_admin_panel/widgets/grid_products.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:grocery_admin_panel/widgets/orders_list.dart';
import 'package:grocery_admin_panel/widgets/products_widget.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../controllers/MenuController.dart'  as myMenuController;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var utils = Utils(context);
    Size size = utils.getScreenSize;
    Color color = utils.color;
    return SafeArea(
      child: SingleChildScrollView(
        controller: ScrollController(),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<myMenuController.MenuController>().controlDashboarkMenu();
              },
              title: "Dashboard",
            ),
            const SizedBox(
              height: 15,
            ),
            TextWidget(text: 'Latest products', color: color),
            const SizedBox(
              height: 15,
            ),
            Row(children: [
              ButtonsWidget(onPressed: (){}, text: 'View all', icon: Icons.store, backgroundColor: Colors.blue),
              Spacer(),
               ButtonsWidget(onPressed: (){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const UploadProductForm()));
               }, text: 'Add product', icon: Icons.add, backgroundColor: Colors.blue)
            ],),

            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // flex: 5,
                  child: Column(
                    children: [
                      Responsive(
                        mobile: ProductGridWidget(
                          crossAxisCount: size.width < 650 ? 2 : 4,
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                        ),
                        desktop: ProductGridWidget(
                          childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        ),
                      ),
                    OrdersList()
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}