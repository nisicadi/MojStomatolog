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
  final Function(int) onPageChanged;
  final int currentPageIndex;
  final bool isAddButtonHidden;

  const PageableListScreen({
    Key? key,
    required this.currentPage,
    required this.columns,
    required this.rows,
    this.addButtonCallback,
    this.searchCallback,
    this.filterButtonCallback,
    required this.totalCount,
    required this.onPageChanged,
    required this.currentPageIndex,
    this.isAddButtonHidden = false,
  }) : super(key: key);

  @override
  _PageableListScreenState createState() => _PageableListScreenState();
}

class _PageableListScreenState extends State<PageableListScreen> {
  List<DataRow> _getRowsWithAlternatingColor(List<DataRow> rows) {
    for (var i = 0; i < rows.length; i++) {
      final originalRow = rows[i];
      rows[i] = DataRow(
        color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return i % 2 == 0 ? Colors.white : Colors.grey[100]!;
        }),
        cells: originalRow.cells,
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> coloredRows = _getRowsWithAlternatingColor(widget.rows);

    List<DataColumn> fixedWidthColumns = widget.columns.map((column) {
      return DataColumn(
        label: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200),
          child: Text(
            (column.label as Text).data!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }).toList();

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
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: fixedWidthColumns,
                    rows: coloredRows,
                  ),
                ),
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
          if (!widget.isAddButtonHidden)
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

  Widget _buildPaginationControls() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Stranica ${widget.currentPageIndex}'),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: widget.currentPageIndex > 1
                ? () => widget.onPageChanged(widget.currentPageIndex - 1)
                : null,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: widget.currentPageIndex * 10 < widget.totalCount
                ? () => widget.onPageChanged(widget.currentPageIndex + 1)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildResultInfo() {
    final int startIndex = (widget.currentPageIndex - 1) * 10 + 1;
    final int endIndex = widget.currentPageIndex * 10;
    final int totalResults = widget.totalCount;

    String infoText =
        'Prikazano $startIndex - ${endIndex > totalResults ? totalResults : endIndex} od ukupno $totalResults rezultata';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(infoText),
    );
  }
}
