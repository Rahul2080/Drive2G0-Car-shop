import 'package:drive2go/Bloc/Profile_Bloc/profile_bloc.dart';
import 'package:drive2go/Repository/ModelClass/ProfileModels/ProfileModel.dart';
import 'package:drive2go/UI/Profile_pages/EditProfile.dart';
import 'package:drive2go/UI/Profile_pages/FeedbackPage.dart';
import 'package:drive2go/UI/Profile_pages/Help_Chat_Page.dart';
import 'package:drive2go/UI/Profile_pages/Privacy_Policy.dart';
import 'package:drive2go/UI/Profile_pages/TermsAndConditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Authentication/Login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(FeatchProfile());
    super.initState();
  }

  late ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 180.h,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity.w,
                            height: 60.h,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w, top: 30.h),
                              child: Text(
                                'Share profile',
                                style: TextStyle(
                                  color: Color(0xFF000B17),
                                  fontSize: 15.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 10.h),
                            child: Divider(),
                          ),
                          SizedBox(
                            width: double.infinity.w,
                            height: 60.h,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w, top: 15.h),
                              child: Text(
                                'Copy Link',
                                style: TextStyle(
                                  color: Color(0xFF000B17),
                                  fontSize: 15.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
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
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15.w,
          )
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileBlocLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProfileBlocError) {
            return Center(
              child: Text(
                'Error',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (state is ProfileBlocLoaded) {
            profile = BlocProvider.of<ProfileBloc>(context).profileModel;
print('profileimage '+ profile.profilePhotoUrl.toString());
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: SizedBox(
                    width: 390.w,
                    height: 110.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 94.w,
                          height: 94.h,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.r)),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(7.r),
                              child:profile.profilePhotoUrl==null?Icon(Icons.person_outline,size: 80.sp
                                ,color: Colors.grey,): Image.network( profile.profilePhotoUrl.toString(),
                                fit: BoxFit.cover,
                              )),
                        ),

                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              profile.fullName.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              profile.email.toString(),
                              style: TextStyle(
                                color: Color(0xFFA7B0BB),
                                fontSize: 14.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.35,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 50.w),
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: Text(
                    'Account settings',
                    style: TextStyle(
                      color: Color(0xFF929191),
                      fontSize: 12.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Editprofile(
                              image: profile.profilePhotoUrl.toString(),
                              name:   profile.fullName.toString(),
                              email:    profile.email.toString(),
                            )));
                  },
                  child: SizedBox(
                    height: 80.h,
                    width: double.infinity.w,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 20.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.mode_edit_outline,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 10.h),
                            child: Divider(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: Text(
                    'Support',
                    style: TextStyle(
                      color: Color(0xFF929191),
                      fontSize: 12.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => HelpChatPage())),
                  child: SizedBox(
                    height: 80.h,
                    width: double.infinity.w,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 20.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.help_outline,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                'Help',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 4.w, right: 20.w, top: 10.h),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FeedbackPage())),
                  child: SizedBox(
                    height: 80.h,
                    width: double.infinity.w,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 20.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                'Feedback',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 4.w, right: 20.w, top: 10.h),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        'Share this App',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        'Rate on Google Play',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: Text(
                    'Legal',
                    style: TextStyle(
                      color: Color(0xFF929191),
                      fontSize: 12.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => PrivacyPolicy())),
                  child: SizedBox(
                    height: 80.h,
                    width: double.infinity.w,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 20.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 4.w, right: 20.w, top: 10.h),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => Termsandconditions())),
                  child: SizedBox(
                    height: 80.h,
                    width: double.infinity.w,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 20.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 4.w, right: 20.w, top: 10.h),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => Login()),
                        (route) => (false));
                  },
                  child: Center(
                    child: Container(
                      width: 339.w,
                      height: 56.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r)),
                      ),
                      child: Center(
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 90.h),
              ],
            );
          } else {
            return SizedBox();
          }
        }),
      ),
    );
  }
}
