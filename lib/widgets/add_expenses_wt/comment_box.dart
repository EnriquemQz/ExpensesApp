import 'package:expenses_app/models/combined_model.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatefulWidget {
  final CombinedModel cModel;
  CommentBox({Key key, @required this.cModel}) : super(key: key);

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  String _text = '';

  @override
  void initState() {
    _text = widget.cModel.comment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.sticky_note_2_outlined,
          size: 35.0
        ),
        Container(
          width: size.width / 1.5,
          child: TextFormField(
            initialValue: _text,
            decoration: InputDecoration(
              hintText: 'Agregar Comentario',
              hintStyle: TextStyle(
                fontSize: 12.0,
              ),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0)
              )
            ),
            keyboardType: TextInputType.text,
            onChanged: (text){
              if(text == ''){
                text = 'Sin Comentarios';
              }
              widget.cModel.comment = text;
            },
          ),
        )
      ],
    );
  }
}