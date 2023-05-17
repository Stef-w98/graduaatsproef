import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:graduaatsproef/utils/form_style_util.dart';

class CountryCodePickerWidget extends StatelessWidget {
  final ValueChanged<CountryCode> onCountryChanged;
  final TextEditingController phoneController;
  final String? initialCountryCode;

  const CountryCodePickerWidget({
    Key? key,
    required this.onCountryChanged,
    required this.phoneController,
    this.initialCountryCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 170.0,
          child: CountryCodePicker(
            flagWidth: 40.0,
            textStyle: TextStyle(color: Colors.white),
            onChanged: onCountryChanged,
            initialSelection: 'BE',
            favorite: const ['BE', 'NL', 'DE'],
            showFlag: true,
            showDropDownButton: true,
          ),
        ),
        SizedBox(
          height: 40.0,
          width: 180.0,
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration:
                buildInputDecoration('Phone', 'Enter your Phone number'),
            style: FormStyles.inputTextStyle(),
          ),
        ),
      ],
    );
  }
}
