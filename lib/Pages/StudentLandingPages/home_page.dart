import '/Controllers/Booking%20Controller/booking_controller.dart';
import '/Controllers/Booking%20Controller/filters_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Pages/StudentLandingPages/search_filters.dart';
import '/Widgets/basic_info_tile.dart';
import '/Widgets/form_loading.dart';
import '/strings_and_const.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  ScrollController scrollController = ScrollController();

  String? filterValue;

  @override
  void initState() {
    scrollController.addListener(() {
      return scrollListener();
    });

    super.initState();
  }

  void scrollListener() {
    if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
      filterValue == null
          ? bookingController.getTutorByPagination()
          : filtersTutorsControllers.getTutorByPagination(filterValue ?? "");
    }
  }

  bool searching = false;

  TextEditingController searchingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      initState: (GetBuilderState state) {
        bookingController.getTutorList();
      },
      builder: (BookingController controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: controller.tutorListModel != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SearchForPeople(
                              textEditingController: searchingController,
                              onChange: (String value) {
                                controller.searchTutors(value);

                                if (value.isEmpty) {
                                  searching = false;
                                } else {
                                  searching = true;
                                }
                                filterValue = null;

                                setState(() {});
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SearchFiltersPage());
                            },
                            child: Image.asset(
                              ImageRes.assetsFilterIcon,
                              height: 30,
                              width: 30,
                              color: Colors.black,
                            ).paddingOnly(left: 10),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showPopupMenu(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tutors & Coaches List",
                              style: AppTStyle.primaryStyle12
                                  .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.appGreyColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Sort by",
                                      style: AppTStyle.regularStyle12
                                          .copyWith(fontWeight: FontWeight.w400)),
                                  SizedBox(width: 20),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ).paddingSymmetric(horizontal: 10),
                            ),
                          ],
                        ),
                      ),
                      if (filterValue != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(filterValue?.toUpperCase() ?? "", style: AppTStyle.primaryStyle12),
                            IconButton(
                                onPressed: () {
                                  filterValue = null;
                                  setState(() {});
                                  bookingController.getTutorList();
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: AppTheme.primaryColor,
                                ))
                          ],
                        ),
                      Expanded(
                        child: Stack(
                          children: [

                            if (controller.loadingMore)
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            /// Apply Filters

                            GetBuilder<FiltersTutorsControllers>(
                              builder: (FiltersTutorsControllers filter) {
                                return ListView.builder(
                                  controller: scrollController,
                                  itemCount: bookingController.tutorsList.isNotEmpty
                                      ? bookingController.tutorsList.length
                                      : 1,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return bookingController.tutorsList.isNotEmpty
                                        ? BasicInfoTile(
                                            bookingController.tutorsList[index],
                                          )
                                        : Center(
                                            child: Text(
                                              "No Result Found!",
                                              style: AppTStyle.primaryStyle12.copyWith(
                                                  fontWeight: FontWeight.bold, fontSize: 25),
                                            ),
                                          ).paddingOnly(top: 100);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    children: List.generate(5, (index) => FormLoading()),
                  ),
          ),
        );
      },
    );
  }

  ///

  // void showPopupMenu(BuildContext context) {
  //   final RenderBox button = context.findRenderObject() as RenderBox;
  //   final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  //
  //   final double buttonWidth = button.size.width;
  //   final double buttonHeight = button.size.height;
  //
  //
  //   final Offset topLeft = button.localToGlobal(Offset(0, buttonHeight), ancestor: overlay);
  //   final Offset bottomRight =
  //       button.localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay);
  //
  //
  //   final RelativeRect position = RelativeRect.fromRect(
  //     Rect.fromPoints(
  //       topLeft,
  //       Offset(bottomRight.dx + buttonWidth, bottomRight.dy),
  //     ),
  //     Offset.zero & overlay.size,
  //   );
  //   showMenu<String>(
  //     context: context,
  //     position: position,
  //     items: [
  //       PopupMenuItem<String>(
  //         value: 'low',
  //         child: Text('Price by low to high'),
  //       ),
  //       PopupMenuItem<String>(
  //         value: 'high',
  //         child: Text('Price by high to low'),
  //       ),
  //       PopupMenuItem<String>(
  //         value: 'ascending',
  //         child: Text('Ascending Order'),
  //       ),
  //       PopupMenuItem<String>(
  //         value: 'descending',
  //         child: Text('Descending Order'),
  //       ),
  //     ],
  //   ).then(
  //     (value) {
  //       if (value != null) {
  //         searchingController.clear();
  //         searching = false;
  //         setState(() {});
  //         filtersTutorsControllers.applySortingFilters(value).then((value) {
  //           setState(() {});
  //         });
  //
  //         setState(
  //           () {
  //             filterValue = value;
  //           },
  //         );
  //       }
  //     },
  //   );
  // }
  void showPopupMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final double buttonWidth = button.size.width;
    final double buttonHeight = button.size.height;

    // Define the offset you want from the top of the screen
    const double paddingFromTop = 100.0; // Adjust this value as needed

    // Adjust the topLeft position to include padding from top
    final Offset topLeft = button.localToGlobal(Offset(0, buttonHeight + paddingFromTop), ancestor: overlay);
    final Offset bottomRight = button.localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay);

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        topLeft,
        Offset(bottomRight.dx + buttonWidth, bottomRight.dy + paddingFromTop),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<String>(
          value: 'low',
          child: Text('Price (Low to High)'),
        ),
        PopupMenuItem<String>(
          value: 'high',
          child: Text('Price (High to Low)'),
        ),
        PopupMenuItem<String>(
          value: 'ascending',
          child: Text('Name (A to Z'),
        ),
        PopupMenuItem<String>(
          value: 'descending',
          child: Text('Name(Z to A)'),
        ),
      ],
    ).then(
          (value) {
        if (value != null) {
          searchingController.clear();
          searching = false;
          setState(() {});
          filtersTutorsControllers.applySortingFilters(value).then((value) {
            setState(() {});
          });

          setState(
                () {
              filterValue = value;
            },
          );
        }
      },
    );
  }

  ///
}

class SearchForPeople extends StatelessWidget {
  final ValueChanged<String>? onChange;
  final TextEditingController? textEditingController;

  SearchForPeople({
    this.onChange,
    this.textEditingController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return

    //   Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 10),
    //   child: Container(
    //     height: 50,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: AppTheme.appGreyColor,
    //     ),
    //     child: TextFormField(
    //       controller: textEditingController,
    //       onChanged: onChange,
    //       decoration: InputDecoration(
    //         labelText: "Search",
    //         filled: true,
    //         fillColor: Colors.white,
    //         enabledBorder: outlineInputBorder,
    //         errorBorder: outlineInputBorder,
    //         border: outlineInputBorder,
    //       ),
    //     ),
    //   ),
    // );

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.appGreyColor,
          ),
          child: TextFormField(
            controller: textEditingController,
            onChanged: onChange,
            decoration: InputDecoration(
              labelText: "Search here",
              labelStyle: TextStyle(color: Colors.grey), // Set the label text color to grey
              prefixIcon: Icon(Icons.search, color: Colors.grey), // Add a search icon
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey, // Set the border color to grey
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey, // Set the border color to grey when focused
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey, // Set the border color to grey when there is an error
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey, // Set the default border color to grey
                ),
              ),
            ),
          ),
        ),
      );

  }

  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  );
}
