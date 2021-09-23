import 'package:expenses_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthsPageView extends StatelessWidget {
  const MonthsPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentPage = uiProvider.selectedMonth;
    PageController _controller;

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4
    );


    return SafeArea(
      child: SizedBox.fromSize(
        size: Size.fromHeight(40.0),
        child: PageView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          onPageChanged: (int i) => uiProvider.selectedMonth = i,
          children: [

            _pageItems('Enero', 0, currentPage),
            _pageItems('Febrero', 1, currentPage),
            _pageItems('Marzo', 2, currentPage),
            _pageItems('Abril', 3, currentPage),
            _pageItems('Mayo', 4, currentPage),
            _pageItems('Junio', 5, currentPage),
            _pageItems('Julio', 6, currentPage),
            _pageItems('Agosto', 7, currentPage),
            _pageItems('Septiembre', 8, currentPage),
            _pageItems('Octubre', 9, currentPage),
            _pageItems('Noviembre', 10, currentPage),
            _pageItems('Diciembre', 11, currentPage),

          ],
        ),
      ),
    );
  }

  _pageItems(String name, int position, int currentPage){
    var _aligment;

    final selected = TextStyle(
      fontSize: 25.0, 
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0
    );
    final unSelected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.grey[700]
    );

    if(position == currentPage){
      _aligment = Alignment.center;
    } else if(position > currentPage){
      _aligment = Alignment.centerRight / 2;
    } else {
      _aligment = Alignment.centerLeft / 2;
    }
    return Align(
      alignment: _aligment,
      child: Text(
        name,
        style: position == currentPage ? selected : unSelected,
      )
    );
  }
}