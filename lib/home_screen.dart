// ignore_for_file: avoid_print

import 'package:comida_rotatoria/food_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/const.dart';
import 'models/food_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late PageController _pageController;

  late AnimationController _animationController;
  double? lastAnimatedValue;
  Curve animationType = Curves.easeOutBack;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animationController =
        AnimationController(vsync: this, upperBound: 1, lowerBound: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 198, 1, 1),
                Color(0xffFF0000),
                Color.fromARGB(255, 255, 111, 0),
                Color(0xffFFA500),
              ],
            ),
            borderRadius: BorderRadius.circular(6),
            //gradiente
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder<void>(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return AnimatedBuilder(
                        animation: animation,
                        builder: (BuildContext context, Widget? child) {
                          return Opacity(
                            opacity: animation.value,
                            child: FoodDetailsScreen(
                              foodDetail: foodList[currentIndex],
                            ),
                          );
                        });
                  },
                  transitionDuration: const Duration(milliseconds: 800),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            color: Colors.white,
            iconSize: 30,
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Stack(
              children: [

                //Page Buildes para manejar el fondo y el contenido de la pantalla segun el item de la lista

                PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      color: foodList[index].colorScheme!.background,
                    );
                  },
                  itemCount: foodList.length,
                ),


//informacion de la comida 
                Positioned(
                    top: size.width * 0.5,
                    child: SizedBox(
                      width: size.width * 0.6,
                      height: size.height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InfoFood(
                            icon:
                                //icono de tamaño,
                                Icons.timer_outlined,
                            text: '${foodList[currentIndex].time} min',
                          ),
                          InfoFood(
                            icon: Icons.wb_iridescent_sharp,
                            text: foodList[currentIndex].size.toString(),
                          ),
                          InfoFood(
                            icon: Icons.person_2_outlined,
                            text: '${foodList[currentIndex].cantidad} people',
                          ),
                          InfoFood(
                            icon: Icons.star_border_outlined,
                            text: '${foodList[currentIndex].rating} stars',
                          ),
                          InfoFood(
                            icon: Icons.restaurant_outlined,
                            text: foodList[currentIndex].category.toString(),
                          )
                        ],
                      ),
                    )),


//nombre de la comida
                Positioned(
                    top: size.height * 0.16,
                    child: Hero(
                      tag: 'name',
                      child: Container(
                        alignment: Alignment.center,
                        // color: Colors.amber,
                        width: size.width ,
                        height: 70,
                        child: Text(
                          //comida rapida
                          foodList[currentIndex].name.toString(),
                          style: GoogleFonts.ubuntu(
                            fontSize: 27,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                Positioned(
                    top: size.height * 0.26,
                    right: -size.width * 0.3,
                    child: GestureDetector(
                            onTap: () => navigateToDetail(foodList[currentIndex], context),
                            onVerticalDragUpdate: ((details) {
                              print('current index $currentIndex');

                              if (details.delta.dy <= 0) {
                                if (!_animationController.isAnimating) {
                                  if (currentIndex < foodList.length - 1) {
                                    setState(() {
                                      animationType = Curves.easeOutBack;
                                    });
                                    _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                    _animationController.loop(count: 1, max: 1);
                                    lastAnimatedValue = 1;
                                  }
                                }
                              } else {
                                if (!_animationController.isAnimating) {
                                  if (currentIndex > 0) {
                                    setState(() {
                                      animationType = Curves.easeInBack;
                                    });

                                    _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        curve: Curves.easeInOut);
                                    if (currentIndex > 0) {
                                      lastAnimatedValue = 1;
                                    }
                                    _animationController.reverse(
                                        from: lastAnimatedValue);
                                    lastAnimatedValue = 0;
                                  }
                                }
                              }
                            }),
                            child: Hero(
                              tag: 'plate1',
                              flightShuttleBuilder: (flightContext, animation,
                                  direction, fromContext, toContext) {
                                // final Hero toHero = toContext.widget as Hero;
                                return Image.asset(
                                  direction.name == 'push'
                                      ? foodList[currentIndex].img1.toString()
                                      : foodList[currentIndex].img2.toString(),
                                  width: 300,
                                ).animate().rotate(
                                      duration: const Duration(seconds: 1),
                                      alignment: Alignment.center,
                                      curve: animationType,
                                      begin: 6,
                                      end: 0,
                                    );
                              },
                              child: Image.asset(
                                foodList[currentIndex].img1.toString(),
                                // 'assets/plate1a.png',
                                width: 300,
                              )
                                  .animate(
                                    controller: _animationController,
                                    autoPlay: false,
                                  )
                                  .rotate(
                                      duration:
                                          const Duration(milliseconds: 1200),
                                      alignment: Alignment.center,
                                      curve: animationType,
                                      begin: lastAnimatedValue ==
                                              _animationController.upperBound
                                          ? -_animationController.upperBound
                                          : _animationController.lowerBound,
                                      end: lastAnimatedValue ==
                                              _animationController.upperBound
                                          ? 0
                                          : _animationController.upperBound),
                            ))
                        .animate()
                        .rotate(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOutBack,
                            begin: 0,
                            end: 0.2)
                        .then()
                        .rotate(
                            begin: 0,
                            end: -0.2,
                            curve: Curves.easeOutBack,
                            duration: const Duration(milliseconds: 500))),
                Positioned(
                  top: 0,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      //bordes en la parte inferior
                      
                      //gradiente de rojo, naranja y amarillo
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 198, 1, 1),
                          Color(0xffFF0000),
                          Color.fromARGB(255, 255, 111, 0),
                          Color(0xffFFA500),
                        ],
                      ),

                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    width: size.width,
                    height: 100,
                    child: Text(
                      //comida rapida
                      'Fast Food',
                      style: GoogleFonts.pacifico(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  top: size.width * 1.3,
                  left: 10,
                  child: Hero(
                         tag: 'description',
                    child: SizedBox(
                        width: size.width * 0.75,
                        height: size.height * 0.2,
                        child: Text(
                          foodList[currentIndex].description.toString(),
                          style: GoogleFonts.pacifico(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.justify,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class InfoFood extends StatelessWidget {
  const InfoFood({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      // color: Colors.red,
      height: 40,
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: GoogleFonts.pacifico(
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}



navigateToDetail(FoodDetail food, BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder<void>(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Opacity(
                opacity: animation.value,
                child: FoodDetailsScreen(
                  foodDetail: food,
                ),
              );
            });
      },
      transitionDuration: const Duration(milliseconds: 800),
      reverseTransitionDuration: const Duration(milliseconds: 500),
    ),
  );
}
