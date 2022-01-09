import 'package:cinaddict/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/models/post.dart';
import 'package:cinaddict/routes/profile_view.dart';

class ZoomedImage extends StatefulWidget{
  const ZoomedImage({Key? key,  this.profilePicture}) : super(key: key);
  final ImageProvider? profilePicture;
  @override
  State<ZoomedImage> createState() => _ZoomedImage();
}
class _ZoomedImage extends State<ZoomedImage>with SingleTickerProviderStateMixin{

final double minScale = 1;
final double maxScale = 5;
late TransformationController controller;
late AnimationController animationController;
Animation<Matrix4>? animation;
OverlayEntry? entry;
@override
void initState(){

  super.initState();

  controller = TransformationController();
  animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200),)..addListener(() =>controller.value = animation!.value);
}

@override

void dispose(){
  controller.dispose();
  animationController.dispose();
  super.dispose();

}//incase we dont need them anymore
  @override
  Widget build(BuildContext context) =>Center(
      child:buildImage(),

  );

  Widget buildImage(){
  return Builder(
    builder: (context) =>InteractiveViewer(
        transformationController: controller,
        clipBehavior: Clip.none,
        panEnabled: false, //if you zoomed max you can not pan around
        minScale: minScale,
        maxScale: maxScale,
        onInteractionStart: (details){
          if(details.pointerCount < 2) return;
          showOverlay(context);
        },
        onInteractionEnd: (details){
          resetAnimation();
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CircleAvatar(
                backgroundColor: AppColors.lightGrey,
                backgroundImage: widget.profilePicture,
                radius: 50,

              ),
          ),
        )
    ),
  );
  }


//UI'in yukari ve asagisindaki barlarin ustune binebilsin diye
  void showOverlay(BuildContext context){
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;
    entry = OverlayEntry(
      builder:(context){
        width: size.width;
      return Positioned(
        left: offset.dx,
        top: offset.dy,
        width:size.width,
        child: buildImage(),);
      },
    );
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
        CurvedAnimation(parent: animationController, curve:Curves.bounceIn)
    );
  }
}


