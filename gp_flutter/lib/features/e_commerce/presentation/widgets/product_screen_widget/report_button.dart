import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/report_entity.dart';
import 'package:gp_flutter/features/e_commerce/presentation/bloc/report_furniture_bloc/report_furniture_bloc.dart';

import '../../../../../core/app_constants/app_constants.dart';
import '../../../../../core/common_widgets/not_signed_in_dialoge.dart';
import '../../../../../core/utils/utilities.dart';
import '../../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import '../../bloc/product_view_bloc/product_view_bloc.dart' as product;

class ReportButton extends StatelessWidget {
  const ReportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<log_in.LogInBloc>().state;
    final productState = context.read<product.ProductViewBloc>().state;
    final isLogedIn = logInState is log_in.Success;
    return Center(
      child: SizedBox(
        height: 50,
        width: Utilities.screenWidth * 0.8,
        child: ElevatedButton(
          onPressed: isLogedIn && productState is product.Loaded
              ? () {
                  showDialog(
                    context: context,
                    builder: (context) => ReportWidget(
                      accessToken: logInState.userEntity.accessToken!,
                      furnitureId: productState.furnitureEntity.id!,
                    ),
                  );
                }
              : () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotSignedInDialoge(),
                  );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_outlined,
                color: Colors.black,
              ),
              Text(
                'Report This Product',
                style: AppTextStyles.titileTextStyle.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportWidget extends StatelessWidget {
  const ReportWidget({
    super.key,
    required this.furnitureId,
    required this.accessToken,
  });
  final String furnitureId;
  final String accessToken;

  @override
  Widget build(BuildContext context) {
    final TextEditingController reportDescription = TextEditingController();
    final TextEditingController reportType = TextEditingController();

    return Dialog(
      child: Container(
        height: Utilities.screenHeight * 0.4,
        width: Utilities.screenWidth * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0.5, 0.5))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: Utilities.screenHeight * 0.1,
                width: Utilities.screenWidth * 0.7,
                child: DropdownMenu(
                  controller: reportType,
                  width: Utilities.screenWidth,
                  hintText: 'Select Report Type',
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(
                      value: 'wrong Category',
                      label: 'wrong Category',
                    ),
                    DropdownMenuEntry(
                      value: 'offensive title or description',
                      label: 'offensive title or description',
                    ),
                  ],
                ),
              ),
              Container(
                height: Utilities.screenHeight * 0.2,
                width: Utilities.screenWidth * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 2,
                    color: Colors.blueAccent,
                  ),
                ),
                child: TextField(
                  controller: reportDescription,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(25),
                    hintText: 'Description',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ReportFurnitureBloc>().add(
                        ReportFurnitureEvent(
                          accessToken: accessToken,
                          productId: furnitureId,
                          report: ReportEntity(
                            reportType: reportType.text,
                            description: reportDescription.text,
                          ),
                        ),
                      );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[200],
                ),
                child: const Text(
                  'Send Report',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
