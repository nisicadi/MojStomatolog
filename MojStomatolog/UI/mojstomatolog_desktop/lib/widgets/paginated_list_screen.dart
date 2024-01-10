import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';

class PageableListScreen extends StatefulWidget {
  final String currentPage;
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final Function()? addButtonCallback;
  final Function(String)? searchCallback;
  final Function()? filterButtonCallback;
  final int totalCount;

  const PageableListScreen({
    Key? key,
    required this.currentPage,
    required this.columns,
    required this.rows,
    this.addButtonCallback,
    this.searchCallback,
    this.filterButtonCallback,
    required this.totalCount,
  }) : super(key: key);

  @override
  _PageableListScreenState createState() => _PageableListScreenState();
}

class _PageableListScreenState extends State<PageableListScreen> {
  final int _rowsPerPage = 10;
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final List<DataRow> paginatedRows = _getPaginatedRows();

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
                child: _buildDataTable(paginatedRows),
              ),
            ),
            _buildPaginationControls(),
            _buildResultInfo(),
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

  Widget _buildDataTable(List<DataRow> paginatedRows) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: widget.columns,
          rows: paginatedRows,
        ),
      ),
    );
  }

  Color _getRowColor(int index) {
    return index % 2 == 0 ? Colors.white : Colors.grey[100]!;
  }

  Widget _buildPaginationControls() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Stranica $_currentPage'),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _currentPage > 1 ? () => _changePage(-1) : null,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: _currentPage * _rowsPerPage < widget.totalCount
                ? () => _changePage(1)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildResultInfo() {
    final int startIndex = (_currentPage - 1) * _rowsPerPage + 1;
    final int endIndex = _currentPage * _rowsPerPage;
    final int totalResults = widget.totalCount;

    String infoText;
    if (endIndex <= totalResults) {
      infoText =
          'Prikazano $startIndex - $endIndex od ukupno $totalResults rezultata';
    } else {
      infoText =
          'Prikazano $startIndex - $totalResults od ukupno $totalResults rezultata';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(infoText),
    );
  }

  void _changePage(int delta) {
    setState(() {
      _currentPage += delta;
    });
  }

  List<DataRow> _getPaginatedRows() {
    final int startIndex = (_currentPage - 1) * _rowsPerPage;
    final int endIndex = startIndex + _rowsPerPage;

    return List.generate(
      endIndex > widget.rows.length
          ? widget.rows.length - startIndex
          : _rowsPerPage,
      (index) {
        final originalIndex = startIndex + index;
        return DataRow(
          color: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            return _getRowColor(originalIndex);
          }),
          cells: widget.rows[originalIndex].cells,
        );
      },
    );
  }
}
