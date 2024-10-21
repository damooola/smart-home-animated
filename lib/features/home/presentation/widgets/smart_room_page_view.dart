import 'package:flutter/material.dart';
import '../../../../core/shared/domain/entities/smart_room.dart';
import '../../../../core/shared/presentation/widgets/room_card.dart';
import '../../../smart_room/screens/room_details_screen.dart';

class SmartRoomsPageView extends StatelessWidget {
  const SmartRoomsPageView({
    super.key,
    required this.controller,
    required this.pageNotifier,
    required this.roomSelectorNotifier,
  });

  final PageController controller;
  final ValueNotifier pageNotifier;
  final ValueNotifier roomSelectorNotifier;

  double _getOffsetX(double percent) => percent.isNegative ? 30 : -30;
  Matrix4 _getOutTranslate(
      {required double percent,
      required int selectedRoom,
      required int index}) {
    final double x =
        selectedRoom != index && selectedRoom != -1 ? _getOffsetX(percent) : 0;
    return Matrix4.translationValues(x, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (_, page, __) {
          return ValueListenableBuilder(
              valueListenable: roomSelectorNotifier,
              builder: (_, selected, __) {
                return PageView.builder(
                  controller: controller,
                  clipBehavior: Clip.none,
                  itemCount: SmartRoom.fakeValues.length,
                  itemBuilder: (_, index) {
                    final room = SmartRoom.fakeValues[index];
                    double percent = page - index;
                    return AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      transform: _getOutTranslate(
                          percent: percent,
                          selectedRoom: selected,
                          index: index),
                      child: RoomCard(
                        percent: percent,
                        // no item selected if -1
                        expand: selected == index,
                        room: room,
                        onSwipeUp: () => roomSelectorNotifier.value = index,
                        onSwipeDown: () => roomSelectorNotifier.value = -1,
                        onTap: () {
                          if (selected == index) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 800),
                                reverseTransitionDuration:
                                    const Duration(milliseconds: 800),
                                pageBuilder: (_, animation, __) =>
                                    FadeTransition(
                                  opacity: animation,
                                  child: RoomDetailScreen(room: room),
                                ),
                              ),
                            );
                            roomSelectorNotifier.value = -1;
                          }
                        },
                      ),
                    );
                  },
                );
              });
        });
  }
}
