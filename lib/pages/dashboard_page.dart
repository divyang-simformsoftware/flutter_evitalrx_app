import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_evitalrx_app/utils/app_strings.dart';

import '../cubit/users/user_cubit.dart';
import '../cubit/users/user_state.dart';
import '../model/user_model.dart';
import '../utils/app_nav_path.dart';
import '../widget/custom_text.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<UserCubit>();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          title: const Text("Dashboard"),
          toolbarHeight: theme.appBarTheme
              .copyWith(toolbarHeight: kToolbarHeight)
              .toolbarHeight,
          scrolledUnderElevation: theme.appBarTheme.scrolledUnderElevation,
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    AppNavPath.loginPage, (route) => false),
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserFetchedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: cubit.searchController,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.only(left: 10),
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search as city/phone/name",
                        suffixIcon: BlocSelector<UserCubit, UserState, bool>(
                          selector: (state) => state is UserFetchedState
                              ? state.isSearching
                                  ? true
                                  : false
                              : false,
                          builder: (context, state) {
                            return Visibility(
                              visible: state,
                              child: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                                onPressed: cubit.clearText,
                                icon: const Icon(Icons.clear),
                              ),
                            );
                          },
                        ),
                      ),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      onChanged: (value) {
                        cubit.searchData(
                            searchQuery: value.toLowerCase().trim());
                      },
                      onSubmitted: (value) =>
                          BlocProvider.of<UserCubit>(context).searchData(
                              searchQuery: value.toLowerCase().trim()),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (state.userModelList.isEmpty)
                    const Chip(label: Text("Not found any data")),
                  Expanded(
                    child: ListView.builder(
                      controller: cubit.scrollController,
                      itemCount: state.userModelList.length,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        UserModel userModel =
                            state.userModelList.elementAt(index);

                        return GestureDetector(
                          onTap: () =>
                              onTapItem(index: index, context: context),
                          child: Container(
                            height: 100,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.indigo),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(AppStrings.eVitalRXLogoPath),
                                  maxRadius: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextDisplay(
                                        data: userModel.userName ?? "",
                                        headerText: "Name: ",
                                      ),
                                      CustomTextDisplay(
                                        data: userModel.phone ?? "",
                                        headerText: "Phone: ",
                                      ),
                                      CustomTextDisplay(
                                        data: userModel.city ?? "",
                                        headerText: "City: ",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                        child: Chip(
                                          label: Text(
                                            "₹",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            userModel.rupee! > 50
                                                ? Icons.arrow_upward
                                                : Icons.arrow_downward,
                                            size: 14,
                                            color: userModel.rupee! > 50
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          Text(
                                            userModel.rupee.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: userModel.rupee! > 50
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (state.isLoadMore)
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircularProgressIndicator(),
                    )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void onTapItem({required int index, required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (_) {
        final textController = TextEditingController();
        return AlertDialog(
          title: const Text("Change Rupee"),
          content: TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            maxLength: 2,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "50",
              prefixText: "₹",
              prefixStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              counterText: "",
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                context.read<UserCubit>().updateRupeeOfIndex(
                      index: index,
                      changeRupee: int.parse(textController.text),
                    );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Rupee Updated",
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
