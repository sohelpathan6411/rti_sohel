import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rti_sohel/presentation/theme/app_colors.dart';
import 'package:rti_sohel/presentation/widgets/calendar_img.dart';

import '../../data/models/employee.dart';
import '../../data/utils/date_utils.dart';
import '../blocs/employee_bloc.dart';
import '../blocs/employee_event.dart';
import '../screens/add_edit_screen.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;

  const EmployeeListItem({required this.employee});

  @override
  Widget build(BuildContext context) {
    return employee.isArchived == 0
        ? Dismissible(
            key: Key(employee.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              final employeeBloc = context.read<EmployeeBloc>();
              employeeBloc.add(ArchiveEmployee(employee.id, 1));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Employee data has been archived'),
                action: SnackBarAction(
                  label: "UNDO",
                  textColor: AppColors.primary,
                  onPressed: () {
                    employeeBloc.add(ArchiveEmployee(employee.id, 0));
                  },
                ),
              ));
            },
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: DeleteImg(),
              ),
            ),
            child: employeeItem(context),
          )
        : Dismissible(
            key: Key(employee.id.toString()),
            direction: DismissDirection.startToEnd,
            onDismissed: (_) {
              final employeeBloc = context.read<EmployeeBloc>();
              employeeBloc.add(ArchiveEmployee(employee.id, 0));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Employee has been recovered'),
                action: SnackBarAction(
                  label: "UNDO",
                  textColor: AppColors.primary,
                  onPressed: () {
                    employeeBloc.add(ArchiveEmployee(employee.id, 1));
                  },
                ),
              ));
            },
            background: Container(
              alignment: AlignmentDirectional.centerStart,
              color: Colors.green,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
            child: employeeItem(context),
          );
  }

  Widget employeeItem(context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            if (employee.isArchived == 1) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('Swipe left to recover')),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditScreen(employeeId: employee.id),
                ),
              );
            }
          },
          tileColor: AppColors.bgColor_white,
          title: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              employee.name,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                employee.role,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: AppColors.subtitleColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              (employee.endDate == null ||
                      (employee.endDate != null &&
                          employee.endDate!.difference(DateTime.now()).inDays >=
                              0))
                  ? Text(
                      "From ${DateUtilsFormat.formatShortDate(employee.startDate)}",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: AppColors.subtitleColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Text(
                      "${DateUtilsFormat.formatShortDate(employee.startDate)} - ${DateUtilsFormat.formatShortDate(employee!.endDate)}",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: AppColors.subtitleColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColors.borderColor,
        )
      ],
    );
  }
}
