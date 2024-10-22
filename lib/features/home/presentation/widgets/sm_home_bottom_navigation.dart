import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SmHomeBottomNavigationBar extends StatelessWidget {
  const SmHomeBottomNavigationBar({
    super.key,
    required this.selectedRoomNotifier,
  });
  final ValueNotifier selectedRoomNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ValueListenableBuilder(
          valueListenable: selectedRoomNotifier,
          builder: (_, selectedRoom, builder) {
            return
                //animated opacity allows to dynamically set the transparency of a widget with a duration to set the speed of change
                AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: selectedRoom == -1 ? 1 : 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.translationValues(
                    0, selectedRoom == -1 ? 0 : 30, 0),
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(SHIcons.lock),
                      ),
                      label: 'UNLOCK',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(SHIcons.home),
                      ),
                      label: 'MAIN',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(SHIcons.settings),
                      ),
                      label: 'SETTINGS',
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
