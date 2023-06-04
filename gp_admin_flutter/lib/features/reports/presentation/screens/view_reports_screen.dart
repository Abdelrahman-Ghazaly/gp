import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_admin_flutter/core/utils/utilities.dart';
import 'package:gp_admin_flutter/features/reports/presentation/bloc/get_all_reports_bloc/all_reports_bloc.dart';
import 'package:gp_admin_flutter/features/reports/presentation/screens/product_view_screen.dart';

import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as login_bloc;

import '../widgets/report_request_card.dart';

class ViewReportsScreen extends StatelessWidget {
  const ViewReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<login_bloc.LogInBloc, login_bloc.LogInState>(
      builder: (context, loginState) {
        if (loginState is login_bloc.Loading) {
          return const Text("Loading ");
        } else if (loginState is login_bloc.Success) {
          context.read<AllReportsBloc>().add(
              GetReportsEvent(adminToken: loginState.userEntity.accessToken!));
          return Scaffold(
            body: BlocBuilder<AllReportsBloc, AllReportsState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is Loaded) {
                  return SizedBox(
                    width: Utilities.screenWidth,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: List.generate(
                              state.reportList.length,
                              (index) => Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductViewScreen(
                                                furnitureEntity: state
                                                    .reportList[index]
                                                    .furnitureEntity,
                                              ),
                                            )),
                                        child: ReportRequestCard(
                                          productId: state.reportList[index].id,
                                          adminToken: loginState
                                              .userEntity.accessToken!,
                                          description: state
                                              .reportList[index].description,
                                          reportType: state
                                              .reportList[index].reportType,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Error"),
                  );
                }
              },
            ),
          );
        } else {
          return const Text("Loadin ");
        }
      },
    );
  }
}
