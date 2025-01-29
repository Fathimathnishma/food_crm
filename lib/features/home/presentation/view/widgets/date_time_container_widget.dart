import 'package:flutter/material.dart';
import 'package:food_crm/features/home/presentation/provider/home_provider.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:provider/provider.dart';

class DateTimeContainerWidget extends StatelessWidget {
  const DateTimeContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Container(
      height: 96,
      width: 170,
      decoration: BoxDecoration(
        color: const Color(0XFFE4E4E4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder(
          stream: homeProvider.dateTimeStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                    'Error: Unable to fetch or update the date and time. Please try again later.'),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeProvider.formattedDate,
                    style:
                        const TextStyle(fontSize: 20, color: Color(0XFF000000)),
                  ),
                  Text(
                    homeProvider.formattedTime,
                    style:
                        const TextStyle(fontSize: 29, color: Color(0XFF000000)),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
