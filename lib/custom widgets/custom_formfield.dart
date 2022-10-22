import 'package:flutter/material.dart';
import 'package:music_app/constants.dart';

Widget customTextField(
  hintTitle,
  isPassword,
  sIcon,
  controllerName,
  validationFunc,
  onSavedFunc,
  wSize,
  hSize,
  border, {
  pIcon,
  filled,
  fillColor,
  labeltext,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: wSize * 4 / 100),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isPassword,
      decoration: InputDecoration(
          filled: filled,
          labelStyle: TextStyle(
            fontFamily: font_family,
          ),
          disabledBorder: border,
          enabledBorder: border,
          fillColor: fillColor,
          labelText: labeltext,
          hintText: hintTitle,
          suffixIcon: sIcon,
          prefixIcon: Icon(
            pIcon,
          ),
          border: border,
          contentPadding: EdgeInsets.symmetric(
              horizontal: wSize * 2.5 / 100, vertical: hSize * 2 / 100)),
      controller: controllerName,
      validator: validationFunc,
      onSaved: onSavedFunc,
    ),
  );
}

Widget customDatePickerField(hintTitle, controllerName, wSize, hSize, border,
    {filled, fillColor, suffixWidget}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: wSize * 4 / 100),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      decoration: InputDecoration(
          filled: filled,
          labelStyle: TextStyle(
            fontFamily: font_family,
          ),
          disabledBorder: border,
          enabledBorder: border,
          fillColor: fillColor,
          hintText: hintTitle,
          suffix: suffixWidget,
          border: border,
          contentPadding: EdgeInsets.symmetric(
              horizontal: wSize * 2.5 / 100, vertical: hSize * 2 / 100)),
      controller: controllerName,
    ),
  );
}

Widget customsearchField(hintTitle, controllerName, validationFunc, onSavedFunc,
    wSize, hSize, border,
    {filled, fillColor, labeltext}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: wSize * 2 / 100, vertical: 5.0),
    child: TextFormField(
      toolbarOptions: const ToolbarOptions(
        paste: true,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          alignLabelWithHint: true,
          labelStyle: TextStyle(
            fontFamily: font_family,
          ),
          disabledBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: Colors.white,
          labelText: labeltext,
          hintText: hintTitle,
          prefixIcon: const Icon(
            Icons.search,
          ),
          border: border,
          contentPadding: EdgeInsets.symmetric(
              horizontal: wSize * 2.5 / 100, vertical: hSize * 2 / 100)),
      controller: controllerName,
      validator: validationFunc,
      onSaved: onSavedFunc,
    ),
  );
}

Widget customDropDownFormField(
    {required fieldTitle,
    required dropDownValue,
    required List<String> listOfItems,
    required onChangedFunc,
    required ctx}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: responsiveHW(ctx, wd: 4)!.toDouble(),
        vertical: responsiveHW(ctx, wd: 1)!.toDouble()),
    child: DropdownButtonFormField(
        isExpanded: true,
        isDense: true,
        elevation: 0,
        onTap: null,
        focusColor: Colors.grey.shade100.withOpacity(1.0),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hoverColor: Colors.grey.shade100.withOpacity(1.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              style: BorderStyle.none,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              style: BorderStyle.none,
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              style: BorderStyle.none,
              color: Colors.white,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value == null ? 'Required*' : null,
        icon: const Icon(
          Icons.arrow_drop_down_sharp,
          color: Colors.grey,
        ),
        hint: Text(
          'Select $fieldTitle',
        ),
        value: dropDownValue,
        items: listOfItems.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: onChangedFunc),
  );
}
