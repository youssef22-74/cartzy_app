import 'package:cartzy_app/core/common/widget/product_item_widget.dart';
import 'package:cartzy_app/feature/home/domain/entities/category_entities.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entities.dart';
import 'package:cartzy_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:cartzy_app/feature/home/widgets/tab_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              text: 'Hi !,\n',
              style: const TextStyle(
                color: Color(0xff212121),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: 'Let’s start your shopping',
                  style: const TextStyle(
                    color: Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Categories",
            style: TextStyle(
              color: Color(0xff212121),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),

          //! getCategories
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetCategoryLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: TabContainerWidget(
                    categories: dummyListOfCategory,
                  ),
                );
              }
              if (state is GetCategoryfailure) {
                return SizedBox.shrink();
              }
              return TabContainerWidget(
                categories: context.read<HomeCubit>().listOfCategory,
              );
            },
          ),

          const SizedBox(height: 16),

          //! getProducts
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetProductLoading) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: 163 / 288,
                    ),
                    itemBuilder: (context, index) => Skeletonizer(
                      enabled: true,
                      child: ProductItemWidget(product: dummyProduct),
                    ),
                  ),
                );
              }

              if (state is GetProductSuccess) {
                final products = context.read<HomeCubit>().listOfProduct;
                return Expanded(
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: 163 / 288,
                    ),
                    itemBuilder: (context, index) {
                      return ProductItemWidget(product: products[index]);
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

var dummyListOfCategory = <CategoryEntities>[
  CategoryEntities(name: "dumyyyyy"),
  CategoryEntities(name: "dumyyyyy"),
  CategoryEntities(name: "dumyyyyy"),
  CategoryEntities(name: "dumyyyyy"),
  CategoryEntities(name: "dumyyyyy"),
  CategoryEntities(name: "dumyyyyy"),
];
var dummyProduct = ProductEntities(
    title: "sdfsgs",
    price: 200,
    id: 12,
    images: ["assets/image/onboarding-2-screen.png"]);
