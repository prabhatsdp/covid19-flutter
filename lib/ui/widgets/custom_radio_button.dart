import 'package:covid_19/data/models/custom_radio_model.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final CustomRadioModel customRadioModel;
  final Function onChanged;
  const CustomRadioButton({Key key, @required this.customRadioModel, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Container(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: 4,
          bottom: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: customRadioModel.isSelected ? customRadioModel.bgColor : customRadioModel.bgColor.withOpacity(0.1),
        ),
        child: Align(
          child: Text(
            customRadioModel.title,
            style: TextStyle(
              color: customRadioModel.isSelected ? Colors.white : customRadioModel.bgColor.withOpacity(0.75),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
