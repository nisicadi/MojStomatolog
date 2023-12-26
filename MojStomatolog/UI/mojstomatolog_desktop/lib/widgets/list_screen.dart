import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';

class ListScreen extends StatefulWidget {
  final String currentPage;
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final Function()? addButtonCallback;
  final Function(String)? searchCallback;
  final Function()? filterButtonCallback;

  const ListScreen({
    Key? key,
    required this.currentPage,
    required this.columns,
    required this.rows,
    this.addButtonCallback,
    this.searchCallback,
    this.filterButtonCallback,
  }) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentPage: widget.currentPage,
      child: Card(
        elevation: 10,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            _buildAppBar(),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildDataTable(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: widget.addButtonCallback,
            child: Text('Dodaj'),
          ),
          Spacer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                onChanged: widget.searchCallback,
                decoration: InputDecoration(
                  hintText: 'Pretraži',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: widget.filterButtonCallback,
            child: Text('Filter'),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
      columns: widget.columns,
      rows: widget.rows,
    );
  }
}
