import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';

class UserNameInputField extends StatelessWidget {
  const UserNameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'usernameOrEmail',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.email_outlined, size: 28, color: AppColors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: cubit.signInUsername,
                keyboardType: TextInputType.text,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Please enter username.";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: AppStrings.username,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}