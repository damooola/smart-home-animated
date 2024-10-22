import 'package:flutter/material.dart';
import 'package:smart_home_animated/core/core.dart';

class ShAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Hero(
        tag: "app-bar-icon-1",
        child: Material(
          type: MaterialType.transparency,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(SHIcons.menu),
            color: SHColors.hintColor,
          ),
        ),
      ),
      actions: [
        Hero(
          tag: "app-bar-icon-2",
          child: Material(
            type: MaterialType.transparency,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(SHIcons.search),
              color: SHColors.hintColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
