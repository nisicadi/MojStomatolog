import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_desktop/models/working_hours.dart';
import 'package:mojstomatolog_desktop/providers/company_settings_provider.dart';
import 'package:mojstomatolog_desktop/utils/util.dart';

class CompanySettingsForm extends StatefulWidget {
  const CompanySettingsForm({Key? key}) : super(key: key);

  @override
  _CompanySettingsFormState createState() => _CompanySettingsFormState();
}

class _CompanySettingsFormState extends State<CompanySettingsForm> {
  final _companySettingsProvider = CompanySettingsProvider();
  final _workingHoursFormKey = GlobalKey<FormState>();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _breakStartTimeController =
      TextEditingController();
  final TextEditingController _breakEndTimeController = TextEditingController();
  Map<int, WorkingHours> _workingHoursMap = {};
  int? _selectedDay;
  bool _isWorkingDay = false;

  @override
  void initState() {
    super.initState();
    _fetchWorkingHours();
  }

  Future<void> _fetchWorkingHours() async {
    try {
      final searchResult = await _companySettingsProvider.get();
      setState(() {
        for (var item in searchResult.results) {
          final workingHours = item;
          if (workingHours.id != null) {
            _workingHoursMap[workingHours.dayOfWeek!] = workingHours;
          }
        }
      });
    } catch (e) {
      print('Error fetching working hours: $e');
    }
  }

  void _populateFormFields(int dayOfWeek) {
    final workingHours = _workingHoursMap[dayOfWeek];
    if (workingHours != null) {
      _startTimeController.text =
          _formatTimeWithoutSeconds(workingHours.startTime);
      _endTimeController.text = _formatTimeWithoutSeconds(workingHours.endTime);
      _breakStartTimeController.text =
          _formatTimeWithoutSeconds(workingHours.breakStartTime);
      _breakEndTimeController.text =
          _formatTimeWithoutSeconds(workingHours.breakEndTime);
      setState(() {
        _isWorkingDay = true;
      });
    } else {
      _startTimeController.text = '';
      _endTimeController.text = '';
      _breakStartTimeController.text = '';
      _breakEndTimeController.text = '';
      setState(() {
        _isWorkingDay = false;
      });
    }
  }

  String _formatTimeWithoutSeconds(String? time) {
    if (time == null || time.isEmpty) return '';

    final parsedTime = DateFormat.Hms().parse(time);
    return DateFormat.Hm().format(parsedTime);
  }

  @override
  Widget build(BuildContext context) {
    List<String> daysOfWeek = [
      'Nedjelja',
      'Ponedjeljak',
      'Utorak',
      'Srijeda',
      'Četvrtak',
      'Petak',
      'Subota'
    ];

    return Form(
      key: _workingHoursFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedDay != null ? daysOfWeek[_selectedDay!] : null,
            hint: Text('Izaberite dan u sedmici'),
            items: daysOfWeek.map((day) {
              return DropdownMenuItem<String>(
                value: day,
                child: Text(day),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedDay = value != null ? daysOfWeek.indexOf(value) : null;
                _populateFormFields(_selectedDay ?? -1);
              });
            },
            validator: (String? value) {
              if (value == null) {
                return 'Odaberite dan u sedmici';
              }
              return null;
            },
          ),
          if (_selectedDay != null) ...[
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isWorkingDay,
                  onChanged: _selectedDay != null
                      ? (bool? value) {
                          setState(() {
                            _isWorkingDay = value!;
                          });
                        }
                      : null,
                ),
                Text('Radni dan'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Radno vrijeme:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            _buildTimeInput(
              controller: _startTimeController,
              label: 'Početak',
            ),
            _buildTimeInput(
              controller: _endTimeController,
              label: 'Kraj',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Polje ne smije biti prazno';
                }

                final startTime = TimeOfDay.fromDateTime(
                  DateFormat.Hm().parse(_startTimeController.text),
                );
                final endTime = TimeOfDay.fromDateTime(
                  DateFormat.Hm().parse(value),
                );

                if (endTime.hour < startTime.hour ||
                    (endTime.hour == startTime.hour &&
                        endTime.minute <= startTime.minute)) {
                  return 'Kraj radnog vremena mora biti nakon početka';
                }

                return null;
              },
            ),
            SizedBox(height: 16),
            Text(
              'Pauza:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            _buildTimeInput(
              controller: _breakStartTimeController,
              label: 'Početak',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Polje ne smije biti prazno';
                }

                final startTime = TimeOfDay.fromDateTime(
                  DateFormat.Hm().parse(_startTimeController.text),
                );
                final breakStartTime = TimeOfDay.fromDateTime(
                  DateFormat.Hm().parse(value),
                );

                if (breakStartTime.hour < startTime.hour ||
                    (breakStartTime.hour == startTime.hour &&
                        breakStartTime.minute <= startTime.minute)) {
                  return 'Pauza mora početi nakon početka radnog vremena';
                }

                return null;
              },
            ),
            _buildTimeInput(
              controller: _breakEndTimeController,
              label: 'Kraj',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Polje ne smije biti prazno';
                }

                final breakStartTime = TimeOfDay.fromDateTime(
                  DateFormat.Hm().parse(_breakStartTimeController.text),
                );
                final breakEndTime = TimeOfDay.fromDateTime(
                  DateFormat.Hm().parse(value),
                );

                if (breakEndTime.hour < breakStartTime.hour ||
                    (breakEndTime.hour == breakStartTime.hour &&
                        breakEndTime.minute <= breakStartTime.minute)) {
                  return 'Kraj pauze mora biti nakon početka';
                }

                final endTime = TimeOfDay.fromDateTime(
                  DateFormat.Hm().parse(_endTimeController.text),
                );

                if (breakEndTime.hour > endTime.hour ||
                    (breakEndTime.hour == endTime.hour &&
                        breakEndTime.minute >= endTime.minute)) {
                  return 'Kraj pauze mora biti prije kraja radnog vremena';
                }

                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmSaveWorkingHours,
              child: Text('Sačuvaj'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeInput({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: validator,
        onTap: () async {
          TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (time != null) {
            controller.text = time.format(context);
          }
        },
        readOnly: true,
      ),
    );
  }

  void _confirmSaveWorkingHours() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda'),
          content: Text(
              'Ako sačuvate promjene, svi budući termini za odabrani dan u sedmici će biti obrisani. Da li ste sigurni da želite nastaviti?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Odustani'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveWorkingHours();
              },
              child: Text('Nastavi'),
            ),
          ],
        );
      },
    );
  }

  void _saveWorkingHours() async {
    if (_workingHoursFormKey.currentState?.validate() ?? false) {
      if (!_isWorkingDay) {
        if (_workingHoursMap.containsKey(_selectedDay)) {
          await _companySettingsProvider
              .delete(_workingHoursMap[_selectedDay]!.id!);
          _workingHoursMap.remove(_selectedDay);
        }
      } else {
        final workingHours = WorkingHours()
          ..id = _selectedDay
          ..dayOfWeek = _selectedDay
          ..startTime = '${_startTimeController.text}:00'
          ..endTime = '${_endTimeController.text}:00'
          ..breakStartTime = '${_breakStartTimeController.text}:00'
          ..breakEndTime = '${_breakEndTimeController.text}:00'
          ..userModifiedId = User.userId;

        if (_workingHoursMap[_selectedDay]?.id != null) {
          final updatedData = await _companySettingsProvider.update(
            _workingHoursMap[_selectedDay]!.id ?? 0,
            workingHours.toJson(),
          );

          if (updatedData != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Radno vrijeme je ažurirano'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Nije uspjelo ažuriranje radnog vremena'),
              ),
            );
          }
        } else {
          final addedData =
              await _companySettingsProvider.insert(workingHours.toJson());

          if (addedData != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Radno vrijeme je ažurirano'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Nije uspjelo ažuriranje radnog vremena'),
              ),
            );
          }
        }
      }
    }
  }
}
