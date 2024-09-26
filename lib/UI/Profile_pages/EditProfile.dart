import 'dart:io';

import 'package:drive2go/Bloc/EditProfile_Bloc/edit_profile_bloc.dart';
import 'package:drive2go/Repository/ModelClass/EditProfileModel.dart';
import 'package:drive2go/UI/Profile_pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../Bloc/Profile_Bloc/profile_bloc.dart';

class Editprofile extends StatefulWidget {
  final String image;
  final String name;
  final String email;

  const Editprofile(
      {super.key,
      required this.image,
      required this.name,
      required this.email});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  TextEditingController newnamecontroller = TextEditingController();
  TextEditingController oldpasswordcontroller = TextEditingController();
  TextEditingController newpasswordcontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();
  bool editname = false;
  bool password = false;
   late EditProfileModel editProfile;

  File? image;
  final picker = ImagePicker( );

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        BlocProvider.of<EditProfileBloc>(context).add(FeatchEditProfile(
          profileurl: image!, forProfile: true
        ));
        Navigator.of(context).pop();
      }
    });
  }

  Future getImageCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        BlocProvider.of<EditProfileBloc>(context).add(FeatchEditProfile(
            profileurl: image!, forProfile: true
        ));

       Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileBlocLoading) {
              print("siginloading");

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }
            if (state is EditProfileBlocError) {
              Navigator.of(context).pop();

              print('error');
            }
            if (state is EditProfileBlocLoaded) {
              BlocProvider.of<ProfileBloc>(context).add(FeatchProfile());
              Navigator.of(context).pop();
              Navigator.of(context).pop();
               editProfile =
                  BlocProvider.of<EditProfileBloc>(context).editProfileModel;
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 140.h),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 180.w,
                    height: 180.h,
                    decoration: ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Image.network(widget.image),
                  ),
                  Positioned(
                      top: 120.h,
                      left: 120.w,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(width: 50.w),
                                      InkWell(
                                        onTap: () {
                                          getImageCamera();
                                        },
                                        child: Container(
                                          width: 150.w,
                                          height: 150.h,
                                          decoration: ShapeDecoration(
                                              color: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r))),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 50.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 30.w),
                                      InkWell(
                                        onTap: () {
                                          getImageGallery();
                                        },
                                        child: Container(
                                          width: 150.w,
                                          height: 150.h,
                                          decoration: ShapeDecoration(
                                              color: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r))),
                                          child: Icon(
                                            Icons.photo_outlined,
                                            size: 50.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                            radius: 28.r,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.photo,
                              size: 30.sp,
                            )),
                      ))
                ],
              ),
              SizedBox(height: 30.h),
              ListTile(
                title: Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: 'sf pro display',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  widget.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontFamily: 'sf pro display',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                leading: Icon(
                  Icons.person_outline_outlined,
                  color: Colors.white,
                ),
                trailing: InkWell(
                  onTap: () {
                    setState(() {
                      editname = !editname;
                    });
                  },
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.green,
                    size: 30.sp,
                  ),
                ),
              ),
              if (editname)
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 340.w,
                      height: 60.h,
                      child: TextField(
                        controller: newnamecontroller,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: Color(0xFFA7B0BB), fontSize: 20.sp),
                          filled: true,
                          fillColor:
                              Colors.white.withOpacity(0.18000000715255737),
                          focusColor:
                              Colors.white.withOpacity(0.18000000715255737),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    InkWell(
                      onTap: () {

                        BlocProvider.of<EditProfileBloc>(context)
                            .add(FeatchEditProfile(
                          name: newnamecontroller.text, forProfile: false,
                        ));
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.18000000715255737),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Ok',
                          style:
                              TextStyle(color: Colors.white, fontSize: 22.sp),
                        )),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  setState(() {
                    password = !password;
                  });
                },
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      'Password Change',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'sf pro display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (password)
                Column(
                  children: [
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: oldpasswordcontroller,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Old Password",
                        hintStyle: TextStyle(
                            color: Color(0xFFA7B0BB), fontSize: 20.sp),
                        filled: true,
                        fillColor:
                            Colors.white.withOpacity(0.18000000715255737),
                        focusColor:
                            Colors.white.withOpacity(0.18000000715255737),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: newpasswordcontroller,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "New Password",
                        hintStyle: TextStyle(
                            color: Color(0xFFA7B0BB), fontSize: 20.sp),
                        filled: true,
                        fillColor:
                            Colors.white.withOpacity(0.18000000715255737),
                        focusColor:
                            Colors.white.withOpacity(0.18000000715255737),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller:confirmPasswordcontroller,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(
                            color: Color(0xFFA7B0BB), fontSize: 20.sp),
                        filled: true,
                        fillColor:
                        Colors.white.withOpacity(0.18000000715255737),
                        focusColor:
                        Colors.white.withOpacity(0.18000000715255737),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none),
                      ),
                    ),

                    SizedBox(height: 30.h),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              password=false;
                            });
                          },
                          child: Container(
                            width: 160.w,
                            height: 50.h,
                            decoration: ShapeDecoration(
                                color: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r))),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        InkWell(
                          onTap: () {
                         oldpasswordcontroller.text.isNotEmpty&&newpasswordcontroller.text.isNotEmpty ?
                            BlocProvider.of<EditProfileBloc>(context).add(
                                FeatchEditProfile(
                                    oldpassword: oldpasswordcontroller.text,
                                    newpassword: newpasswordcontroller.text, forProfile: false)): SizedBox();
                         oldpasswordcontroller.clear();
                         newpasswordcontroller.clear();
                          },
                          child: Container(
                            width: 160.w,
                            height: 50.h,
                            decoration: ShapeDecoration(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r))),
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
