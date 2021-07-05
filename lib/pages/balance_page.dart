import 'package:expenses_app/widgets/balance_page_wt/months_pageview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/math_operations.dart' as op;
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/widgets/balance_page_wt/add_button.dart';
import 'package:expenses_app/widgets/balance_page_wt/balance_folder_inside.dart';
import 'package:expenses_app/widgets/balance_page_wt/balance_foldertab.dart';

class BalancePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddButton(),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              MonthsPageView(),
              _HeadBalancePage(),
              _FolderBalancePage()
            ]),
          )
        ],
      ),
    );
  }
}

class _HeadBalancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;

    Size size = MediaQuery.of(context).size;


    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        height: size.height / 10,
        child: Column(
          children: [
            Text(
              '\$ ${op.getBalance(expenses, 3500)}',
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.green[400]
              ),
            ),
            Text('Balance')
          ],
        ),
      ),
    );
  }
}

class _FolderBalancePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.ftBoxDecoration,
      child: Column(
        children: [
          BalanceFolderTab(),
          BalanceFolderInside()
        ],
      ),
    );
  }
}