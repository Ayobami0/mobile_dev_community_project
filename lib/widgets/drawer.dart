import 'package:flutter/material.dart';
import 'package:mobile_dev_com_dashboard/colors.dart';
import 'package:mobile_dev_com_dashboard/widgets/widows_data.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late bool _onHome;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(ModalRoute.of(context)!.settings.name == '/'){
      _onHome = true;
    }else{
      _onHome = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 70,),
            GestureDetector(
              onTap: () => Navigator.of(context).popAndPushNamed('/'),
              child: Container(
                padding: const EdgeInsets.all(17),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kColor.dark,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  )
                ),
                child: Text('Home', style: TextStyle(color: kColor.light),),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).popAndPushNamed(WidowsData.routeName),
              child: Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                    )
                ),
                child: const Text('Widows Data', style: TextStyle(color: Colors.black),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
