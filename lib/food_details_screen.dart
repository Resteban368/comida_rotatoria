import 'package:animate_do/animate_do.dart';
import 'package:comida_rotatoria/home_screen.dart';
import 'package:comida_rotatoria/models/food_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailsScreen extends StatefulWidget {
  final FoodDetail foodDetail;
  const FoodDetailsScreen({Key? key, required this.foodDetail})
      : super(key: key);

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
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
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
              width: size.width,
              height: size.height * 0.4,
              child: Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      // color: Colors.red,
                      width: double.infinity,
                      // height: size.height * 0.3,
                      child: Hero(
                        tag: 'plate1',
                        child: Image.asset(
                          widget.foodDetail.img2.toString(),
                          width: 300,
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 5),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 198, 1, 1),
                            Color(0xffFF0000),
                            Color.fromARGB(255, 255, 111, 0),
                            Color(0xffFFA500),
                          ],
                        ),
                        // bordes redondeados
                        borderRadius: BorderRadius.circular(6)),
                    width: 50,
                    height: 50,
                    child: IconButton(
                      onPressed: () {
                        _animationController.reverse();
                        Future.delayed(const Duration(milliseconds: 200), () {
                          Navigator.pop(context);
                        });
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                  ),
                ],
              )),
          BounceInRight(
            delay: const Duration(milliseconds: 200),
            child: Container(
              alignment: Alignment.center,
              // color: Colors.amber,
              width: size.width,
              height: 70,
              child: Text(
                widget.foodDetail.name.toString(),
                style: GoogleFonts.pacifico(
                  fontSize: 27,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              InfoFood(
                icon:
                    //icono de tamaño,
                    Icons.timer_outlined,
                text: '${widget.foodDetail.time} min',
              ),
              InfoFood(
                icon: Icons.person_2_outlined,
                text: '${widget.foodDetail.cantidad} people',
              ),
              InfoFood(
                icon: Icons.star_border_outlined,
                text: '${widget.foodDetail.rating} stars',
              ),
            ],
          ),
          const SizedBox(height: 20),
          BounceInDown(
            delay: const Duration(milliseconds: 200),
            child: SizedBox(
                width: size.width * 0.75,
                height: size.height * 0.2,
                child: Text(
                  widget.foodDetail.description.toString(),
                  style: GoogleFonts.pacifico(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                )),
          ),
        ],
      ),
    ));
  }
}
