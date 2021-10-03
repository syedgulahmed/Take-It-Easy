import 'package:flutter/material.dart';

class EditableTextField extends StatelessWidget {
  final String labelName;
  final String value;
  final bool editable;

  const EditableTextField({Key key, this.labelName, this.value, this.editable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: DataTable(
        columns: [
          DataColumn(label: Text(labelName)),
        ],
        rows: [
          DataRow(cells: [
            DataCell(
              Text(value),
              showEditIcon: editable,
              onTap: () {},
            ),
          ])
        ],
      ),
    );
  }
}
