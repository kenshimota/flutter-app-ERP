import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/container_white.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/users/list_users_mobile.dart';
import 'package:flutter_app_erp/widgets/users/table_users.dart';
import 'package:flutter_app_erp/widgets/users/toobal_users.dart';
import 'package:flutter_app_erp/core/http/users/get_list_users.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';

class ShowListUsers extends StatefulWidget {
  final String token; 
  const ShowListUsers({
    super.key,
    required this.token,
  });

  @override
  State<ShowListUsers> createState() => _ShowListUsers();
}

class _ShowListUsers extends State<ShowListUsers> {
  String search = '';
  int numberPage = 1;
  Future? futureList;
  List<UserResponse> result = <UserResponse>[];

  @override
  void initState(){
    setState(() {
      futureList = onRequestApi();
    });

    super.initState();
  }


  Future<void> onRequestApi() async {
    final List<UserResponse> users =
        await getListUsers(
      token: widget.token,
      page: numberPage,
      search: search,
    );

    setState(() {
      result = users;
    });
  }


  Future<void> onRequest() async {
    setState(() {
      futureList = onRequestApi();
    });
  }

 

  onSearch(String s) {
    setState(() {
      search = s;
      numberPage = 1;
    });

    onRequest();
  }

  onBack() {
    setState(() {
      numberPage -= 1;
    });

    onRequest();
  }

  void onForwad() {
    setState(() {
      numberPage += 1;
    });

    onRequest();
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ToobalUsers(
            inputSeach: InputSearch(onSearch: onSearch),
          ),
          Expanded(
            child: ContainerWhite(
              child: LayourtTwiceBuilder(
              mobile: ListTileUsers(
                page: numberPage,
                future: futureList,
                onForward: onForwad,
                list: result,
                onAfterChange: onRequest,
              ),
              
              desktop:TableUsers(
                list: result,
                onBack: onBack,
                onForwad: onForwad,
                numberPage: numberPage,
                onAfterDelete: onRequest,
              )
            ),),
          ),
        ],
      ),
    );
  }

}