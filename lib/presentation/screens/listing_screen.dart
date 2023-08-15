import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rti_sohel/data/utils/size_config.dart';
import 'package:rti_sohel/presentation/theme/app_colors.dart';

import '../../data/models/employee.dart';
import '../blocs/employee_bloc.dart';
import '../blocs/employee_state.dart';
import '../widgets/employee_list_item.dart';
import '../widgets/no_records_found.dart';
import '../widgets/section_title.dart';

class EmployeeListingScreen extends StatelessWidget {
  const EmployeeListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Employee List',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeesLoaded) {
            final employees = state.employees;
            if (employees.isEmpty) {
              return const NoRecordsFound();
            } else {
              //current: endDate can be future date OR null
              List<Employee> current = employees
                  .where((element) => (element.isArchived == 0 &&
                      (element.endDate == null ||
                          (element.endDate != null &&
                              (element.endDate!
                                      .difference(DateTime.now())
                                      .inDays >=
                                  0)))))
                  .toList();

              List<Employee> previous = employees
                  .where((element) => (element.isArchived == 0 &&
                      (element.endDate != null &&
                          (element.endDate!.difference(DateTime.now()).inDays <
                              0))))
                  .toList();

              List<Employee> archived = employees
                  .where((element) => (element.isArchived == 1))
                  .toList();

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    //current employees

                    current.length == 0
                        ? const SizedBox()
                        : _currentEmployeesList(current),
                    current.length == 0
                        ? const SizedBox()
                        :SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Swipe left to archive',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )),

                    previous.length == 0
                        ? const SizedBox()
                        : _previousEmployeesList(previous),

                    archived.length == 0
                        ? const SizedBox()
                        : _archivedEmployeesList(archived),
                  ],
                ),
              );
            }
          } else if (state is EmployeeError) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            bottom: SizeConfig.mediaQueryData!.padding.bottom, right: 10),
        child: FloatingActionButton(
          elevation: 0,
          mini: SizeConfig.screenWidth! <= 400?true: false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          onPressed: () {
            Navigator.pushNamed(context, '/addEdit');
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Widget _currentEmployeesList(List<Employee> employees) {
    return Column(
      children: [
        const SectionTitle(
          title: "Current employees",
          color: AppColors.primary,
        ),
        _employeeListBuilder(employees),
      ],
    );
  }

  Widget _previousEmployeesList(List<Employee> employees) {
    return Column(
      children: [
        const SectionTitle(
          title: "Previous employees",
          color: AppColors.primary,
        ),
        _employeeListBuilder(employees),

      ],
    );
  }

  Widget _archivedEmployeesList(List<Employee> employees) {
    return Column(
      children: [
        SectionTitle(
          title: "Archived employees",
          color: Colors.red.shade800,
        ),
        _employeeListBuilder(employees),
        SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Swipe right to recover',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }

  Widget _employeeListBuilder(employees) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        return EmployeeListItem(
            employee: employee); // Use the EmployeeListItem widget
      },
    );
  }
}
