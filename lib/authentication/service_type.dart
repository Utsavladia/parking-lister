import 'package:flutter/material.dart';
import 'package:doctor_app/global/global.dart';
import 'package:doctor_app/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServiceType extends StatefulWidget
{
  const ServiceType({super.key});


  @override
  State<ServiceType> createState() => _ServiceTypeState();
}



class _ServiceTypeState extends State<ServiceType>
{
  TextEditingController institutionNameTextEditingController = TextEditingController();
  TextEditingController specialtyTextEditingController = TextEditingController();
  TextEditingController registeredIdTextEditingController = TextEditingController();
  TextEditingController visitingPriceTextEditingController =  TextEditingController();

  List<String> serviceTypesList = ["Hospital","Doctor","Pathology","Pharmacy"];
  String? selectedServiceType;

  saveServiceInfo()
  {
    Map doctorServiceInfoMap =
    {
      "institution_name": institutionNameTextEditingController.text.trim(),
      "specialty": specialtyTextEditingController.text.trim(),
      "registeredId": registeredIdTextEditingController.text.trim(),
      "service_type": selectedServiceType,
      "base_price": visitingPriceTextEditingController.text.trim(),
    };

    DatabaseReference doctorsRef = FirebaseDatabase.instance.ref().child("doctors");
    doctorsRef.child(currentFirebaseUser!.uid).child("service_details").set(doctorServiceInfoMap);

    Fluttertoast.showToast(msg: "Medical Service Details has been saved, Congratulations.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              const SizedBox(height: 24,),



              const SizedBox(height: 30,),

              const Text(
                "Request for listing the parking",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50,),

              TextField(
                controller: institutionNameTextEditingController,
                keyboardType: TextInputType.text,
                style:const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "State name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20                ),
                ),

              ),
              const SizedBox(height: 10,),

              TextField(
                controller: specialtyTextEditingController,
                keyboardType: TextInputType.text,
                style:const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "City name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),

              ),
              const SizedBox(height: 10,),


              TextField(
                controller: registeredIdTextEditingController,
                keyboardType: TextInputType.text,
                style:const TextStyle(
                    color: Colors.black
                ),
                decoration: const InputDecoration(
                  labelText: "Area name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20                ),
                ),
              ),
              // TextField(
              //   controller: visitingPriceTextEditingController,
              //   keyboardType: TextInputType.number,
              //   style:const TextStyle(
              //       color: Colors.black
              //   ),
              //   decoration: const InputDecoration(
              //     labelText: "Base Visit Fee",
              //     hintText: "Amount you would charge for a visit",
              //     enabledBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(
              //           color: Colors.black),
              //     ),
              //     focusedBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black),
              //     ),
              //     hintStyle: TextStyle(
              //         color: Colors.grey,
              //         fontSize: 10
              //     ),
              //     labelStyle: TextStyle(
              //         color: Colors.black,
              //         fontSize: 14                ),
              //   ),
              //
              // ),

              // DropdownButton(
              //   iconSize: 20,
              //   dropdownColor: Colors.lightBlueAccent,
              //   hint:const Text(
              //     "Please choose the service type",
              //     style: TextStyle(
              //       fontSize: 14.0,
              //       color:Colors.black,
              //     ),
              //   ),
              //     value: selectedServiceType,
              //     onChanged: (newValue)
              //   {
              //     setState((){
              //       selectedServiceType = newValue.toString();
              //     });
              //   },
              //   items: serviceTypesList.map((service){
              //     return DropdownMenuItem(
              //       child: Text(
              //       service,
              //       style: const TextStyle(color: Colors.black),
              //       ),
              //       value: service,
              //     );
              //   }).toList(),
              // ),

              const SizedBox(height: 40,),

              ElevatedButton(onPressed:()
              {

                  saveServiceInfo();

              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                ),
                child: const Text(
                  "Request Varification",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
