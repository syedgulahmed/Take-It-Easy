import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tie_customer_app/design_assets/main_button.dart';
import 'package:tie_customer_app/design_assets/primary_button.dart';
import 'package:tie_customer_app/main.dart';
import 'package:tie_customer_app/model/category.dart';
import 'package:tie_customer_app/model/customer.dart';
import 'package:tie_customer_app/model/order_item.dart';
import 'package:tie_customer_app/model/serviceProvider.dart';

class HiringScreen extends StatelessWidget {
  final ServiceProvider status;
  final Category category;
  HiringScreen({
    @required this.status,
    @required this.category,
  });
  TextEditingController date = new TextEditingController();
  TextEditingController issue = new TextEditingController();
  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ' + title + ' here';
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none, hintText: title, filled: true)),
    );
  }

  Widget _dateTimePicker(
      String title, BuildContext context, TextEditingController controller,
      {bool isPassword = false}) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: TextFormField(
            controller: controller,
            obscureText: isPassword,
            onTap: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day), onChanged: (date) {
                print('change $date');
              }, onConfirm: (d) {
                date.text = d.day.toString() +
                    "-" +
                    d.month.toString() +
                    "-" +
                    d.year.toString() +
                    " " +
                    d.minute.toString() +
                    ":" +
                    d.hour.toString();
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ' + title + ' here';
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter ' + title,
                filled: true)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hire Now!'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TextFormField(
                controller: issue,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill it';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                  labelText: 'Problem you are facing...',
                  hintText:
                      'Please provide information about problem you are facing...',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _dateTimePicker('Select Date & Time', context, date),
            SizedBox(
              height: 20,
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Row(
                children: [
                  PrimaryButton(
                    name: 'Cancel',
                    color: Colors.grey,
                    callback: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PrimaryButton(
                    name: 'Hire Now!',
                    color: Colors.blue,
                    callback: () async {
                      int num = await MyApp.database.getNumberofOrders();
                      Customer customer =
                          await MyApp.database.getCustomerByEmail();
                      MyApp.database.insertOrder(new OrderItem(
                          num.toString(),
                          customer,
                          status,
                          date.text,
                          "",
                          category,
                          0,
                          OrderStatus.REQUESTED,
                          customer.address == null ? "" : customer.address,
                          issue.text));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
