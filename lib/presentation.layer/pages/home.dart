import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_flutter/presentation.layer/ui.util/ui.helpers.dart';
import '../../domain.layer/entities/recipe.dart';
import '../bloc/home/home_bloc.dart';
import '../widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.add(GetRecipeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 8.0),
            Text('Food App'),
          ],
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const CenteredLoading();
          } else if (state is HomeError) {
            return CenteredMessage(message: state.message);
          } else if (state is HomeLoaded) {
            return HomeMenu(recipes: state.recipes);
          } else {
            return const CenteredMessage(message: 'Something Went Wrong');
          }
        },
        listener: (context, state) {
          if (state is ShowSnackBar) {
            context.showSnackBarView(state.message);
          }
        },
      ),
    );
  }
}

class CenteredMessage extends StatelessWidget {
  final String message;
  const CenteredMessage({
    super.key, required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}

class CenteredLoading extends StatelessWidget {
  const CenteredLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class HomeMenu extends StatelessWidget {
  final List<Recipe> recipes;
  const HomeMenu({
    super.key, required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: GuidedRecipes(recipes: recipes),
      ),
    );
  }
}

class GuidedRecipes extends StatelessWidget {
  final List<Recipe> recipes;
  const GuidedRecipes({
    super.key, required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Guided Recipes',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: GridView.builder(
            itemCount: recipes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (BuildContext context, int index) {
              Recipe recipe = recipes[index];
              return RecipeCard(
                imageUrl: recipe.image,
                name: recipe.name,
                rating: recipe.rating,
                totalTime: recipe.totalTime,
              );
            },
          ),
        ),
      ],
    );
  }
}
