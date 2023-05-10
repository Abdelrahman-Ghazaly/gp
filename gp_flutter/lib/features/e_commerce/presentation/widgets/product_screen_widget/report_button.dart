import 'package:flutter/material.dart';

import '../../../../../core/app_constants/app_constants.dart';
import '../../../../../core/utils/utilities.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: Utilities.screenWidth * 0.8,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
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
                          child: DropdownButton(
                            onChanged: (_) {},
                            isExpanded: true,
                            hint: const Text('Select Report Type'),
                            items: const [
                              DropdownMenuItem(
                                value: 'Wrong Category',
                                child: Text('Wrong Category'),
                              ),
                              DropdownMenuItem(
                                value: 'Offensive Title or Description',
                                child: Text('Offensive Title or Description'),
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
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(25),
                              hintText: 'Description',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
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
              ),
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
