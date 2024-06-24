import '/Controllers/Booking%20Controller/booking_controller.dart';
import '/Controllers/Booking%20Controller/filters_controller.dart';
import '/Controllers/controllers_init.dart';
import '/Widgets/basic_info_tile.dart';
import '/strings_and_const.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilteredTutorsPage extends StatefulWidget {
  const FilteredTutorsPage({super.key});

  @override
  State<FilteredTutorsPage> createState() => _FilteredTutorsPageState();
}

class _FilteredTutorsPageState extends State<FilteredTutorsPage> {
  ScrollController scrollController = ScrollController();

  // String? filterValue;

  @override
  void initState() {
    scrollController.addListener(() {
      return scrollListener();
    });

    super.initState();
  }

  void scrollListener() {
    if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
      filtersTutorsControllers.getFilterTutorByPagination();
    }
  }

  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      initState: (GetBuilderState state) {
        bookingController.getTutorList();
      },
      builder: (BookingController controller) {
        return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: AppTheme.primaryColor,
              title: Text(
                "Tutors and Coaches",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      GetBuilder<FiltersTutorsControllers>(
                        builder: (FiltersTutorsControllers filter) {
                          return bookingController.tutorsList.isNotEmpty? ListView.builder(
                            controller: scrollController,
                            itemCount: bookingController.tutorsList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return BasicInfoTile(
                                bookingController.tutorsList[index],
                              );
                            },
                          ) : Center(
                            child: Text(
                              "No Data Found!",
                              style: AppTStyle.primaryStyle12.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 10));
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
  //   final Offset topLeft = button.localToGlobal(Offset(0, buttonHeight), ancestor: overlay);
  //   final Offset bottomRight =
  //       button.localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay);
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
  //         value: 'high',
  //         child: Text('Price by low to high'),
  //       ),
  //       PopupMenuItem<String>(
  //         value: 'low',
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

  ///
}

class SearchForPeople extends StatelessWidget {
  final ValueChanged<String>? onChange;
  final VoidCallback? onFilterTap;
  final bool showFilters;

  SearchForPeople({
    this.onChange,
    this.showFilters = false,
    this.onFilterTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: AppTheme.appGreyColor,
        ),
        child: TextFormField(
          onChanged: onChange,
          decoration: InputDecoration(
            labelText: showFilters ? "Search and filter" : "Search...",
            filled: true,
            fillColor: AppTheme.appGreyColor,
            enabledBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            border: outlineInputBorder,
            suffixIcon: showFilters
                ? GestureDetector(
                    onTap: onFilterTap,
                    child: Image.asset(
                      ImageRes.assetsFilterIcon,
                      height: 10,
                      width: 10,
                    ).paddingOnly(right: 10),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  );
}
