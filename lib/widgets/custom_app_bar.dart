import 'package:flutter/material.dart';
import 'package:news_app/Themes/theme_manager.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  ThemeManager themeManager = ThemeManager();
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10,left:10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.circle, color: Colors.blue,size: 50,),
                    Text("News\nApp",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.add_box_outlined,color: Colors.black,),
                    Switch(value: false, onChanged: (value){},activeThumbImage: const AssetImage(""),),
                    const Icon(Icons.menu)
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return  Container(
                      padding: EdgeInsets.all(1),
                      child: ClipRRect(
                       borderRadius: BorderRadius.circular(200),
                        child: Image.asset("assets/images/${index+1}.png",fit: BoxFit.cover,),
                      ),
                    );
                  }),
            ),
          )
        ],
      );
  }
}
