import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/home/desktop_home.dart';
import 'package:flutter_app_erp/widgets/home/mobile_home.dart';

class LoadingHomeData extends StatelessWidget {
  final List<Widget> buildListMobile;
   final List<Widget> buildList;
  final Future? future;
  const LoadingHomeData({
    super.key,
    this.future,
    required this.buildListMobile,
    required this.buildList,
  });

  @override
  Widget build(BuildContext context){
    if(future == null) {
      return buildHome(context);
    }
    return FutureBuilder(
      future: future, 
      builder: (context, snapshot) {
        final bool loading = snapshot.connectionState == ConnectionState.waiting;

         if (loading) {
            return buildLoading(context);
          }

          return buildHome(context);
      
      });
  }

  Widget buildLoading(BuildContext context) {
    Color? color = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(color: color),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHome(BuildContext context){
    return  Expanded(
          child: LayourtTwiceBuilder(
            mobile: MobileHome(
              inventarios: buildListMobile,
            ),
            desktop: DesktopHome(
              inventarios: buildList,
            ),
          ),
        );
  }
}