import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_firebase_sqflite_bloc/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps_firebase_sqflite_bloc/constants/strings.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  PhoneAuthCubit _phoneAuthCubit = PhoneAuthCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<PhoneAuthCubit>(
          create: (context) => _phoneAuthCubit,
          child: ElevatedButton(
            onPressed: () async{
              await _phoneAuthCubit.logout();
              Navigator.of(context).pushReplacementNamed(loginScreen);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ) ,
    );
  }
}
