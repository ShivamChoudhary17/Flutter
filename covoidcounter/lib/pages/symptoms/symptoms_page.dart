
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SymptomsScreen extends StatefulWidget {

  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
          children: <Widget>[
            //image container
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
                              "Symptoms",
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
                              tag: 'images/symp.png',
                              child: Container(
                                height: 190,
                                width: 210,
                                child: Image(
                                  image: AssetImage('images/symp.png'),
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


            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                "Most common symptoms:",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24
                              ),),
                              SizedBox(height: 20,),
                              Text('⚈ Fever', style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.w600,
                              color: Colors.black54),),
                              Text('⚈ Cough', style: TextStyle(fontWeight:
                              FontWeight
                                  .w600, fontSize: 18,
                              color: Colors.black54),),
                              Text('⚈ Tiredness', style: TextStyle(fontWeight:
                              FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              Text('⚈ Loss of taste or smell', style: TextStyle
                                (fontWeight: FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              SizedBox(height: 14,),
                              Text('Less common symptoms:', style: TextStyle(fontWeight: FontWeight
                                  .w700, fontSize: 24,),),
                              Text('⚈ Sore throat', style: TextStyle
                                (fontWeight: FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              Text('⚈ Headache', style: TextStyle(fontWeight:
                              FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              Text('⚈ Aches and pains', style: TextStyle
                                (fontWeight: FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              Text('⚈ Diarrhoea', style: TextStyle(fontWeight:
                              FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              Text('⚈ A rash on skin, or discolouration of '
                                  'fingers or toes', style: TextStyle(fontWeight: FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              Text('⚈ Red or irritated eyes', style: TextStyle
                                (fontWeight: FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              SizedBox(height: 14,),
                              Text('Serious symptoms:', style: TextStyle(fontWeight: FontWeight
                                  .w700, fontSize: 24,),),
                              Text('⚈ Difficulty breathing or shortness of '
                                  'breath', style: TextStyle(fontWeight: FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              Text('⚈ Loss of speech or mobility, or confusion',
                                style: TextStyle(fontWeight: FontWeight
                                  .w600, fontSize: 18,
                                  color: Colors.black54),),
                              Text('⚈ Chest pain',
                                style: TextStyle(fontWeight: FontWeight
                                    .w600, fontSize: 18,
                                    color: Colors.black54),),
                              SizedBox(height: 14,),
                              Text('_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _'
                                  ' _ _ _ _ _ _ _ _ _ _ _ _ _',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black26,
                                fontSize: 16
                              ),),
                              SizedBox(height: 14,),
                              Text(
                                  'Seek immediate MEDICAL ATTENTION if you '
                                      'have serious symptoms. Always call before visiting your doctor or health facility.'
                                      'People with mild symptoms who are otherwise healthy should manage their symptoms at home.'
                                      'On average it takes 5–6 days from '
                                      'when someone is infected with the virus for symptoms to show, however it can take up to 14 days.'
                              ,style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent
                              ),
                              ),

                              SizedBox(height: 70,),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
*
*




*
*
* */