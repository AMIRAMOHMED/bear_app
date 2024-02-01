import 'package:bear/consts/animation_enum.dart';
import 'package:bear/consts/app_color.dart';
import 'package:bear/widget/button.dart';
import 'package:bear/widget/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    AudioPlayer player = AudioPlayer();

  Artboard? riveArtBoard;
  late RiveAnimationController controllerLookIdle;
  late RiveAnimationController controllerHandsUp;

  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerFail;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerLookDownLeft;
  late RiveAnimationController controllerLookDownRight;

  void removeAllControllers() {
    riveArtBoard?.artboard.removeController(controllerFail);
    riveArtBoard?.artboard.removeController(controllerHandsDown);
    riveArtBoard?.artboard.removeController(controllerHandsUp);
    riveArtBoard?.artboard.removeController(controllerLookDownLeft);
    riveArtBoard?.artboard.removeController(controllerLookDownRight);
    riveArtBoard?.artboard.removeController(controllerSuccess);
    riveArtBoard?.artboard.removeController(controllerLookIdle);
  }

  void addLookLeftController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerLookDownLeft);
                player.play(AssetSource("sounds/Left pronunciation.m4a"));

    debugPrint("left");
  }

  void lookIdeal() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerLookIdle);
            player.play(AssetSource("sounds/Reset sound-1.m4a"));

    debugPrint("restart");
  }

  void addLookRightController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerLookDownRight);
        player.play(AssetSource("sounds/Right pronounction.m4a"));

    debugPrint("right");
  }

  void beNormalController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerHandsDown);
    player.play(AssetSource('sounds/Normal pronunciation.m4a'));
    debugPrint("normal");
  }

  void beAngryController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerFail);
    player.play(AssetSource('sounds/Angry pronunciation.m4a'));

    debugPrint("angry");
  }

  void beHappyController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerSuccess);
player.play(AssetSource('sounds/Cheerful  pronunciation.m4a'));

    debugPrint("success");
  }

  void beShyVController() {
    removeAllControllers();
    riveArtBoard?.artboard.addController(controllerHandsUp);
 
player.play(AssetSource('sounds/Shy pronunciation.m4a'));

  }

  @override
  void initState() {
    super.initState();

    controllerLookIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.Hands_up.name);

    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);

    controllerFail = SimpleAnimation(AnimationEnum.fail.name);

    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);

    controllerLookDownLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);

    controllerLookDownRight =
        SimpleAnimation(AnimationEnum.Look_down_right.name);

    rootBundle.load("assets/bear.riv").then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      artboard.addController(controllerLookIdle);
      setState(() {
        riveArtBoard = artboard;
      });
    });
  }

  @override
  void dispose() {
    controllerLookIdle.dispose();
    controllerHandsUp.dispose();
    controllerHandsDown.dispose();
    controllerFail.dispose();
    controllerSuccess.dispose();
    controllerLookDownLeft.dispose();
    controllerLookDownRight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20),
        child: FadeInAnimation(
          delay: 6,
          child: Column(children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: riveArtBoard == null
                    ? const SizedBox.shrink()
                    : Rive(artboard: riveArtBoard!)),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  fuc: beShyVController,
                  text: 'shy 🙈',
                ),
                CustomButton(
                  fuc: beNormalController,
                  text: 'normal 😊',
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  fuc: addLookLeftController,
                  text: 'look left ⬅',
                ),
                CustomButton(
                  fuc: addLookRightController,
                  text: 'look right ➡',
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  fuc: beAngryController,
                  text: 'Angry 😠',
                ),
                CustomButton(
                  fuc: beHappyController,
                  text: 'Cheerful ☺️' ,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            CustomButton(
              fuc: lookIdeal,
              text: 'Restart 🔁',
            ),
            
          ]),
        ),
      ),
    );
  }
}
