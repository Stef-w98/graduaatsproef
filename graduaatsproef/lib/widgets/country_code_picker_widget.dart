import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';

class CountryCodePickerWidget extends StatelessWidget {
  final ValueChanged<CountryCode> onCountryChanged;
  final TextEditingController phoneController;

  const CountryCodePickerWidget({
    Key? key,
    required this.onCountryChanged,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CountryCodePicker(
            onChanged: onCountryChanged,
            initialSelection: 'BE',
            favorite: const ['BE', 'NL', 'DE'],
            showFlag: true,
            showDropDownButton: true,
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          flex: 2,
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              labelText: 'Phone',
              hintText: 'Enter phone number',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
