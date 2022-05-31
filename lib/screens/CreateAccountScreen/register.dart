import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ip_movie_recomandation/data/data.dart';
import 'package:ip_movie_recomandation/widgets/my_text_field.dart';
import 'package:ip_movie_recomandation/widgets/my_button.dart';
import 'package:http/http.dart' as http;


class FieldValidator{
  static String? validateEmail(String value){
    if (value.isEmpty) return 'Enter Email!';



    if(!RegExp(r"^(?=.{5,30})[\w-\.]+@([\w-]+\.)+[\w-]{2,5}$")
                                  .hasMatch(value)){
      return 'Enter Valid Email!';
    }
    return null;
  }
  static String? validatePassword(String value){
    if (value.isEmpty) return 'Enter Password';
    if(value.length < 7){
        return 'Password must be longer than 6 char';
  }
  return null;
  }
static String? validateName(String value){
    if (value.isEmpty) return 'Enter Email!';



    if(!RegExp(r"^(?=.{2,25}$)(\w{2,}(\s?\w{2,})?)$")
                                  .hasMatch(value)){
      return 'Enter Valid Name!';
    }
    return null;
  }
  static bool isLeapYear(int year) =>
      ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);

  static int daysInMonth(int month, int year) {
    int days = 28 +
        (month + (month / 8).floor()) % 2 +
        2 % month +
        2 * (1 / month).floor();
    return (isLeapYear(year) && month == 2) ? 29 : days;
  }

  static String? validateData(String value){
    
    if (value.isEmpty) return "Enter Date!";
    
    
    value = value.replaceAll(RegExp(r'\.|\/'), '-');
    var dtSplit = value.split("-");
    var year = int.parse(dtSplit[0]);
    var month = int.parse(dtSplit[1]);
    var day = int.parse(dtSplit[2]);
    var now = DateTime.now();
    
    if (month > 12 ||
        month < 1 ||
        day < 1 ||
        day > daysInMonth(month, year) ||
        year < 1900 ||
        (year > now.year - 10 && day > now.day && month > now.month)) return "Enter a valid date";
    
    return null;
  }
  static String? validateGenre(String value){

    if(value.isEmpty) return "Enter a genre";
    
    String male = 'M';
    String female = 'F';

    if(!identical(value, male) && !identical(value, female)) return "Enter a valid genre";

    return null;
  }
  static String? validateCountry(String value){
                    
      if(value.isEmpty) return "Enter a country";

      if(!RegExp(r"^(?=.{2,25}$)(\w{2,}(\s?\w{2,})?)$").hasMatch(value)){
        return "Invalid Country";
        }
      return null;
  }
  static String? validatePhone(String value){
    if(value.isEmpty) return "Enter a phone number";

    // text.isEmpty ||
    //                           !RegExp(r"^07[0-9]{8}$").hasMatch(text)) {
    //                         return "Invalid phone number.";
    //                       }
    if(!RegExp(r"^07[0-9]{8}$").hasMatch(value)){
        return "Invalid phone number";
        }
        return null;
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final myNameController = TextEditingController();
  final myPasswordController = TextEditingController();
  final myEmailController = TextEditingController();
  final myGenderController = TextEditingController();
  final myBirthdateController = TextEditingController();
  final myCountryController = TextEditingController();
  final myPhoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double padding = 10.0;
  double containerWidth = 700;
  double containerHeight = 850;
  bool isSmallScreen = false;
  bool isLargeScreen = true;
  bool isPressed = false;
  bool isFinish = false;
  bool isLoading = true;

  String email = "";
  String password = "";
  String gender = "";
  String name = "";
  String birthday = "";
  String phoneNumber = "";
  String country = "";

  String errorText = "Error registering user!";

  // late AnimationController _controller;
  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: const Interval( 0.0,1.0, curve: Curves.fastOutSlowIn),
  // );
  //
  // late Animation<double> fadeInAnimation2 = Tween<double>(
  //   begin: 0.0,
  //   end: 1.0,
  // ).animate(CurvedAnimation(
  //     parent: _controller,
  //     curve: const Interval(0.0, 0.75, curve: Curves.easeIn)));

  @override
  void initState() {
    super.initState();
    // _controller= AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // );
    // _controller.forward();
  }

  showLoaderDialog(BuildContext context) {
    createUser();
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
            if (isCreatedUser) {
              Navigator.pushNamed(context, '/genre');
            } else {
              showAlert(context);
            }
          });
          return alert;
        });
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(errorText),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  void logUser() async {
    final Uri apiUrl = Uri.parse("http://157.230.114.95:8090/api/v1/login");
    final response = await http.post(apiUrl,
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
        });
    if (response.statusCode == 200) {
      token = response.headers["authorization"] as String;
    }
  }

  bool isCreatedUser = false;

  void createUser() async {
    final Uri apiUrl =
        Uri.parse("http://157.230.114.95:8090/api/v1/users/register");
    final response = await http.post(apiUrl,
        body: jsonEncode({
          "email": email,
          "name": name,
          "password": password,
          "gender": gender,
          "birthdate": birthday,
          "country": country,
          "phoneNumber": phoneNumber,
        }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          "Content-Type": "application/json",
        });

    switch (response.statusCode) {
      case 201:
        {
          isCreatedUser = true;
          logUser();
        }
        break;
      case 401:
        {
          errorText =
              "Unauthorized!\nYou don't have permission to access this page.";
          isCreatedUser = false;
        }
        break;
      case 403:
        {
          errorText = "Forbidden!\nPermission denied";
          isCreatedUser = false;
        }
        break;
      case 404:
        {
          errorText = "Page Not Found!";
          isCreatedUser = false;
        }
        break;
      default:
    }
  }

  void setValue() {
    if (MediaQuery.of(context).size.width >= 700) {
      setState(() {
        padding = 10.0;
        containerWidth = 700;
        containerHeight = 850;
        isSmallScreen = false;
        isLargeScreen = true;
      });
    } else {
      setState(() {
        padding = 0;
        containerWidth = double.infinity;
        containerHeight = double.infinity;
        isSmallScreen = true;
        isLargeScreen = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
    myNameController.dispose();
    myPasswordController.dispose();
    myPhoneNumberController.dispose();
    myCountryController.dispose();
    myBirthdateController.dispose();
    myGenderController.dispose();
    myEmailController.dispose();
  }

  void goBack() {
    Navigator.pop(context);
  }

  void register() {
    showLoaderDialog(context);
  }

  bool isValidDate(String date) {
    if (date.length != 10) return false;
    int day, month, year;
    date = date.replaceAll(RegExp(r'\.|\/'), '-');
    var dtSplit = date.split("-");
    year = int.parse(dtSplit[0]);
    month = int.parse(dtSplit[1]);
    day = int.parse(dtSplit[2]);
    var now = DateTime.now();
    if (month > 12 ||
        month < 1 ||
        day < 1 ||
        day > daysInMonth(month, year) ||
        year < 1900 ||
        (year > now.year - 10 && day > now.day && month > now.month)) {
      return false;
    }
    return true;
  }

  static int daysInMonth(int month, int year) {
    int days = 28 +
        (month + (month / 8).floor()) % 2 +
        2 % month +
        2 * (1 / month).floor();
    return (isLeapYear(year) && month == 2) ? 29 : days;
  }

  static bool isLeapYear(int year) =>
      ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);

  @override
  Widget build(BuildContext context) {
    setValue();
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF99D98C),
        gradient: LinearGradient(
          colors: [Colors.white, Color.fromRGBO(52, 160, 164, 1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Container(
                //height: containerHeight,
                width: containerWidth,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius:
                      isLargeScreen ? BorderRadius.circular(50) : null,
                  boxShadow: isLargeScreen
                      ? [
                          const BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 7,
                          ),
                        ]
                      : null,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SvgPicture.asset(
                            "assets/images/LogoSvg2.svg",
                            height: 100,
                          ),
                        ),
                      ),
                      Center(
                          child: MyTextField(
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !RegExp(r"^(?=.{2,25}$)(\w{2,}(\s?\w{2,})?)$")
                                  .hasMatch(text)) {
                            return "Invalid name.";
                          }
                          name = myNameController.text;
                          return null;
                        },
                        hintText: 'Popescu Maria',
                        text: 'Name',
                        controller: myNameController,
                        begin: 0.0,
                        end: 0.15,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !RegExp(r"^(?=.{5,30})[\w-\.]+@([\w-]+\.)+[\w-]{2,5}$")
                                  .hasMatch(text)) {
                            return "Invalid email address.";
                          }
                          email = myEmailController.text;
                          return null;
                        },
                        hintText: 'name@gmail.com',
                        text: 'Email',
                        controller: myEmailController,
                        begin: 0.15,
                        end: 0.30,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        //12+ caractere, cel putin o cifra, o litera mare, o litera mica, un caracter special
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&_]{10,50}$")
                                  .hasMatch(text)) {
                            return "Invalid password, must contain at least 10 to 50 \ncharacters, a mix of upper and lower case letters, \nnumbers and special characters.";
                          }
                          password = myPasswordController.text;
                          return null;
                        },
                        hintText: 'password',
                        text: 'Password',
                        obscureText: true,
                        controller: myPasswordController,
                        begin: 0.30, end: 0.45,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !RegExp(r"^(M|F)$").hasMatch(text)) {
                            return "Invalid gender.";
                          }
                          gender = myGenderController.text;
                          return null;
                        },
                        hintText: 'M/F',
                        text: 'Gender',
                        controller: myGenderController,
                        begin: 0.45,
                        end: 0.60,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !isValidDate(text)) {
                            return "Invalid date.";
                          }
                          birthday = myBirthdateController.text
                              .replaceAll(RegExp(r'\.|\/'), '-');
                          return null;
                        },
                        hintText: 'Year-Month-Day',
                        text: 'Birthdate',
                        controller: myBirthdateController,
                        begin: 0.60,
                        end: 0.75,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !RegExp(r"^(?=.{2,25}$)(\w{2,}(\s?\w{2,})?)$")
                                  .hasMatch(text)) {
                            return "Invalid country.";
                          }
                          country = myCountryController.text;
                          return null;
                        },
                        hintText: 'Romania',
                        text: 'Country',
                        controller: myCountryController,
                        begin: 0.75,
                        end: 0.90,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyTextField(
                        formFieldValidator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              !RegExp(r"^07[0-9]{8}$").hasMatch(text)) {
                            return "Invalid phone number.";
                          }
                          phoneNumber = myPhoneNumberController.text;
                          return null;
                        },
                        hintText: '07xxxxxxxx',
                        text: 'Phone Number',
                        controller: myPhoneNumberController,
                        begin: 0.9,
                        end: 1.0,
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyButton(
                              text: "Back",
                              buttonMethod: goBack,
                            ),
                            MyButton(
                              text: 'Register',
                              buttonMethod: register,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
