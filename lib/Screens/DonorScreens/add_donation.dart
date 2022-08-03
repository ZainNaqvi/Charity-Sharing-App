
import 'package:charity/provider/expiry_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
class AddDonation extends StatefulWidget {
  const AddDonation({Key? key}) : super(key: key);

  @override
  State<AddDonation> createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
final formKey = GlobalKey<FormState>();
   final _titleOfDonation = TextEditingController();
   final _nameOfItem = TextEditingController();
   final _quantity = TextEditingController();
   final _description = TextEditingController();
   final _pickUpLocation= TextEditingController();
   final _destLocation= TextEditingController();
    int count =0;
  Widget myTextField(String hintText, Icon preIcon, TextEditingController mycontroller )
  {
    return TextFormField(
      controller: mycontroller,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle:  const TextStyle(
                            fontSize: 16,
                            fontFamily:"Rubik Medium",
                            color: Colors.black),
                        fillColor: Colors.orange,
                        prefixIcon:  preIcon,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: ((value) {

                        if(value!.isEmpty)
                        {
                          if(hintText=="Enter Title of Doantion")
                        {
                          return "Enter Title Please";
                        }
                         if(hintText=="Enter Name of Item")
                        {
                          return "Enter Name Please";
                        }
                        if(hintText=="Enter Quantity")
                        {
                          return "Enter Quantity Please";
                        }
                        if(hintText=="Enter Description")
                        {
                          return "Enter Description Please";
                        }
                        if(hintText=="Enter PickUp location")
                        {
                          return "Choose PickUp Please";
                        }
                        if(hintText=="Enter destination location")
                        {
                          return "Choose PickUp Please";
                        }
                        }
                      }
                      ),
                    );
                  
  }

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title:const Text("Add Doantion")),
 body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              // logo + app name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    height: 50.h,
                    image: const AssetImage("assets/logo/donateLogo.jpg"),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Charity Sharing",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Colors.black),
                      ),
                      Text(
                        "App",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Colors.orange),
                      ),
                    ],
                  )
                ],
              ),
          
              SizedBox(
                height: 20.h,
              ),
              // Add Donation Text
              const Center(
                  child: Text(
                "Add Your Donation ",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Rubik Medium',
                    color: Colors.black),
              )),
          
              SizedBox(
                height: 14.h,
              ),
              // quote text
              const Center(
                  child: Text(
                "Feeding someOne is the Highest \nReward You can Give to Humanity",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Rubik Regular',
                    color: Colors.orange),
              )),
              if(count>0)
               ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange,
                ),
                title: Text("$count item added . Tap if You want to check the details"),

              ),
                // text Fields 
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                        
                    //  Enter Title field,
                      myTextField("Enter Title of Doantion", const Icon(Icons.title), _titleOfDonation),
                      SizedBox(height: 10.h),
                    // Enter name of Item
                      myTextField("Enter Name of Item", const Icon(Icons.description_sharp), _nameOfItem),
                      SizedBox(height: 10.h),
                      // Enter Quantity   
                     myTextField("Enter Quantity", const Icon(Icons.numbers), _quantity),
                      SizedBox(height: 10.h),
                     // Enter Description
                     myTextField("Enter Description", const Icon(Icons.description_sharp), _description),
                     SizedBox(height: 10.h),
                       // Enter pickUp location  
                     myTextField("Enter PickUp location", const Icon(Icons.location_on), _pickUpLocation),
                          
                       SizedBox(height: 10.h),
                       
                       
                      // choose the destination location 
                     myTextField("Enter destination location", const Icon(Icons.location_on), _destLocation),
                       SizedBox(height: 10.h),
                  
                   
                    Consumer<ExpiryDate>(builder: (context, value, child) => 
                       TextFormField(
                          controller: value.dob,
                          readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Enter Expiry Date ",
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Rubik Medium',
                              color: Colors.black),
                          fillColor: Colors.orange,
                           prefixIcon: const Icon(Icons.calendar_month_sharp,color: Colors.orange,),
                          suffixIcon: IconButton(
                            
                            onPressed: () async {
                        
                          await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 1500)),
                          lastDate: DateTime.now().add(const Duration(days: 1500)))
                  .then((pickedDate) {
                              if (pickedDate != null) {
                              value.setExpDate(pickedDate);
                              }
                          });
                            },
                            icon: const Icon(Icons.calendar_month),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                            borderRadius:  BorderRadius.all(Radius.circular(20)),
                          ),
                                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                            ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                
                          if(value!.isEmpty)
                          {
                            return "Enter Expiry Date First";
                          }
                        } ,
                      ),
                       )
                     
                    ],
                  ),
                ),
              ),
          
              SizedBox(height: 20.h),
              //Donate button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (() {
                        if (formKey.currentState!.validate())
                        {
                         setState(() {
                           count++;
                         });
                        }
                      
                    }),
                    child: Container(
                      height: 30.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text("Donate"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w,),
                    InkWell(
                    onTap: (()  {
                        if (formKey.currentState!.validate())
                        {
     
                     Get.snackbar(
                      
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.black,
                      "Message", "item added successfully");
                         
                      
                        }
                  
                    }),
                    child: Container(
                      height: 30.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text("Add more item"),
                      ),
                    ),
                  ),
                 
                ],
              ),
             
             
              SizedBox(
                height: 10.h,
              ),
               
            ],
          ),
        ),
    
        ));
  }
}