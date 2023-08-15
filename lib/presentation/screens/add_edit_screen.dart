import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rti_sohel/presentation/theme/app_colors.dart';

import '../../data/models/employee.dart';
import '../../data/utils/date_utils.dart';
import '../../data/utils/size_config.dart';
import '../blocs/employee_bloc.dart';
import '../blocs/employee_event.dart';
import '../blocs/employee_state.dart';
import '../widgets/calendar_img.dart';
import '../widgets/custom_date_picker.dart';

class AddEditScreen extends StatefulWidget {
  final int? employeeId;

  const AddEditScreen({super.key, this.employeeId});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late TextEditingController _nameController;
  String? _selectedRole;
  late DateTime _startDate;
  DateTime? _endDate;

  final List<String> _roleOptions = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _startDate = DateTime.now();

    // Load existing employee data if editing
    if (widget.employeeId != null) {
      // Load existing employee data for editing
      final employeeBloc = BlocProvider.of<EmployeeBloc>(context);
      final employeesState = employeeBloc.state;
      if (employeesState is EmployeesLoaded) {
        final employee = employeesState.employees.firstWhere(
          (emp) => emp.id == widget.employeeId,
          orElse: () => Employee(
              id: 0,
              name: '',
              role: '',
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              isArchived: 0),
        );
        _nameController.text = employee.name;
        _selectedRole = employee.role;
        _startDate = employee.startDate;
        _endDate = employee.endDate;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showRoleBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ..._roleOptions.map((role) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      role,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedRole = role;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    height: 1,
                    color: AppColors.borderColor,
                  )
                ],
              );
            }).toList(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor_white,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: Text(
            widget.employeeId != null
                ? 'Edit Employee Details'
                : 'Add Employee Details',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: SizeConfig.mediaQueryData!.padding.bottom + 90,
          child: Column(
            children: [
              const Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.roboto(
                          color: AppColors.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_selectedRole == null ||
                          _nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill the details')),
                        );
                      } else {
                        _saveEmployee();
                      }
                    },
                    child: Text(
                      'Save',
                      style: GoogleFonts.roboto(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _nameController,
                    maxLines: 1,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.borderColor),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.borderColor),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.borderColor),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 10),
                        hintText: 'Employee Name',
                        hintStyle: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: AppColors.primary,
                          size: 16,
                        )),
                  ),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _showRoleBottomSheet();
                  },
                  child: Container(
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.work_outline,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          _selectedRole == null
                              ? "Select Role"
                              : '$_selectedRole',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: _selectedRole == null
                                  ? Colors.grey.shade700
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: _selectedRole == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down,
                            color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await showDialog<DateTime>(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDatePicker(
                                isEndDate: false,
                                onDateSelected: (date) {
                                  if (date != null) {
                                    // Handle the selected date
                                    setState(() {
                                      _startDate = date;
                                      // endDate should be future of start date, needs to clear on start date selected
                                      // whenever start date changes, endDate can be selected (optional)
                                      _endDate = null;
                                    });
                                  }
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CalendarImg(
                                calendarSize: 16,
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                _startDate == null
                                    ? "No Date"
                                    : DateUtilsFormat.formatShortDate(
                                        _startDate.toLocal()),
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: _startDate == null
                                        ? Colors.grey.shade700
                                        : Colors.black,
                                    fontSize: 16,
                                    fontWeight: _startDate == null
                                        ? FontWeight.w400
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await showDialog<DateTime>(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDatePicker(
                                isEndDate: true,
                                initialDate: _startDate,
                                onDateSelected: (date) {
                                  // Handle the selected date
                                  setState(() {
                                    _endDate = date;
                                  });
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CalendarImg(
                                calendarSize: 16,
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                _endDate == null
                                    ? "No Date"
                                    : DateUtilsFormat.formatShortDate(
                                        _endDate!.toLocal()),
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: _endDate == null
                                        ? Colors.grey.shade700
                                        : Colors.black,
                                    fontSize: 16,
                                    fontWeight: _endDate == null
                                        ? FontWeight.w400
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveEmployee() {
    final employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    final employee = Employee(
        id: widget.employeeId ?? DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text,
        role: _selectedRole!,
        startDate: _startDate,
        endDate: _endDate);

    if (widget.employeeId != null) {
      employeeBloc.add(UpdateEmployee(employee));
    } else {
      employeeBloc.add(AddEmployee(employee));
    }

    Navigator.of(context).pop();
  }
}
