import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicinesPage extends StatelessWidget {
  const MedicinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.greenAccent,
              size: 28,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
              ),
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                  //color: widget.color.withOpacity(0.2)
                ),
                width: MediaQuery.of(context).size.width,
                child: LayoutBuilder(
                  builder: (ctx, constraint) => Stack(
                    children: <Widget>[
                      //Name
                      Positioned(
                        top: constraint.maxHeight * 0.4,
                        left: 20,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: constraint.maxWidth * 0.55,
                            child: AutoSizeText(
                              "Medicines",
                              style: TextStyle(
                                color: Colors.redAccent.shade100,
                                fontFamily: "Montserrat",
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              maxFontSize: 31,
                              stepGranularity: 1,
                            ),
                          ),
                        ),
                      ),

                      //Image
                      Positioned.fill(
                        bottom: -10.0,
                        right: -6.0,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: LayoutBuilder(
                            builder: (ctx, constraint) => Hero(
                              tag: 'images/medicines.png',
                              child: Container(
                                color: Colors.white,
                                height: 190,
                                width: 240,
                                child: Image(
                                  image: AssetImage('images/medicines.png'),
                                  height: constraint.maxHeight * 0.93,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Asking questions about your treatment or medicine is "
                          "important to help you understand your options. You"
                          " have a right to ask your pharmacist or doctor "
                          "about the medicines you are prescribed, so don't feel shy. It also helps you to know what to expect if you take a medicine, stop taking it OR don't take it at all.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),),
                  SizedBox(height: 14,),
                  Text('_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _'
                      ' _ _ _ _ _ _ _ _ _ _ _ _ _',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                        fontSize: 16
                    ),),
                  SizedBox(height: 14,),
                  Text('List:',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700
                  ),),
                  SizedBox(height: 14,),
                  Text('⚈ Vitamin C',
                    style: TextStyle(fontWeight: FontWeight
                        .w600, fontSize: 18,),),
                  Text('(Ascorbic acid is crucial for immune responses)', style: TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
                  SizedBox(height: 14,),
                  Text('⚈ B-Complex with Zinc:',
                    style: TextStyle(fontWeight: FontWeight
                        .w600, fontSize: 18,),),
                  Text('(Vitamin B not only helps to build and maintain a '
                      'healthy immune system but it could potentially prevent '
                      'or reduce Covid-19 symptoms, zinc has a broad-spectrum antiviral activity against a variety of viruses.)', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
                  SizedBox(height: 14,),
                  Text('⚈ Ivermectin:',
                    style: TextStyle(fontWeight: FontWeight
                        .w600, fontSize: 18,),),
                  Text('(This medicine has been shown to inhibit the replication of SARS-CoV-2 in cell cultures.)', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
                  SizedBox(height: 14,),
                  Text('⚈ Paracetamol:',
                    style: TextStyle(fontWeight: FontWeight
                        .w600, fontSize: 18,),),
                  Text('(650mg as antipyretic for fever or body ache.)', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
                  SizedBox(height: 14,),
                  Text('⚈ Favipiravir',
                    style: TextStyle(fontWeight: FontWeight
                        .w600, fontSize: 18,),),
                  Text('(It acts as an oral antiviral and is proven to be active against coronavirus.)', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
                  SizedBox(height: 14,),
                  Text('⚈ Steroids',
                    style: TextStyle(fontWeight: FontWeight
                        .w600, fontSize: 18,),),
                  Text('(If the patient has oxygen requirement or if his persistent fever is not settling despite giving adequate antiviral and other vitamin supplements.)', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
                  SizedBox(height: 14,),
                  Text('⚈ Plenty of liquids',
                    style: TextStyle(fontWeight: FontWeight
                        .w600, fontSize: 18,),),
                  Text('(To be consumed to keep oneself well hydrated as it '
                      'is essential to fight out viral or any infection for that matter.)', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
                  SizedBox(height: 14,
                  ),
                  Text('⚈ Gargle',
                    style: TextStyle(fontWeight: FontWeight
                        .w600, fontSize: 18,),),
                  Text('(Take a sip of salt water, without swallowing, tilt '
                      'your head back and gargle with the warm salt water for '
                      '10-15 seconds, before spitting it out into a sink, '
                      'repeat this 4-5 time in a day)', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),),
                  SizedBox(height: 50,),
                  Text('ATTENTION: Please consult your doctor before taking '
                      'any medicine',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.redAccent
                  ),),
                  SizedBox(height: 100,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
