import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/state/transaction_model.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {super.key});
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      );
}

class TransactionHome {
  BuildContext context;

  late List<List<RenderObjectWidget>> _children;

  var transactions;
  get children => _children;

  TransactionHome({required this.context, required this.transactions}) {
    _children = [];
    for (Service transaction in transactions) {
      print(transaction.id);
      _children.add([
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              transaction.id,
              style: Theme.of(context).textTheme.headline5,
            ),
            Container(
              height: 31,
              width: 78,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '',
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(transaction.status,
                style: Theme.of(context).textTheme.headline4),
            Text(
              transaction.timestamp.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 31,
            ),
            SizedBox(
              height: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.5),
                child: LinearProgressIndicator(
                  value: 0.7,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  backgroundColor: const Color(0xFFF8F8F8),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 60,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transaction.type,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SvgPicture.asset(
                    'assets/images/icon_details.svg',
                  ),
                ],
              ),
              Container(
                height: 2,
                color: Colors.black,
              )
            ],
          ),
        )
      ]);
    }
  }
}
