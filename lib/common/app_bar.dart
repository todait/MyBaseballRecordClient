import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const AppBarWidget({
    super.key,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: leadingIcon,
      title: title != null ? Text(title!) : null,
      actions: trailingIcon != null
          ? [
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: trailingIcon!,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
