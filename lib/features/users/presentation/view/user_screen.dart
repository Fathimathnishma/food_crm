import 'package:flutter/material.dart';
import 'package:food_crm/features/home/presentation/view/home_page.dart';
import 'package:food_crm/features/users/presentation/provider/user_provider.dart';
import 'package:food_crm/features/users/presentation/view/add_user_screen.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:food_crm/general/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        userProvider.fetchUser();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            )),
        title: const Text(
          "Peoples",
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddUserScreen(),
              ));
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: Consumer<UserProvider>(builder: (context, stateAdduser, child) {
        if (stateAdduser.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
            ),
          );
        }

        if (stateAdduser.users.isEmpty) {
          return const Center(
            child: Text(
              "No People",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
            ),
          );
        }

        return ListView.separated(
          itemCount: stateAdduser.users.length,
          itemBuilder: (context, index) {
            final data = stateAdduser.users[index];

            return ListTile(
              leading: SizedBox(
                width: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showCustomDialog(
                          context,
                          'delete user',
                          'delete',
                          () async {
                            await stateAdduser.removeUser(userId: data.id!);
                          },
                        );
                      },
                      child: Image.asset('assets/images/trash.png'),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: AppColors.whiteColor,
                      child: Text(
                        stateAdduser.getInitials(data.name),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                data.name,
                style: const TextStyle(
                    fontSize: 17, color: AppColors.whiteColor),
              ),
              subtitle: Text(
                data.phoneNumber,
                style: const TextStyle(color: AppColors.greyColor),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 30,
            );
          },
        );
      }),
    );
  }
}
