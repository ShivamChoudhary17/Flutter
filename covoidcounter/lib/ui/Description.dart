import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Description extends StatefulWidget {
  var description, data, index;
  Description(this.data, this.index);

  @override
  _DescriptionState createState() => _DescriptionState(this.data, this.index);
}

class _DescriptionState extends State<Description> {
  var dataPage, indexPage;
  _DescriptionState(this.dataPage, this.indexPage);

  _launchURL() async {
    if (await canLaunch(dataPage[indexPage]['url'])) {
      await launch(dataPage[indexPage]['url']);
    } else {
      throw 'Could not launch ${dataPage[indexPage]['url']}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.lightGreenAccent),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 87.0),
          child: Row(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                height: 40,
                width: 40,
                child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      'images/covid-19'
                      '.png',
                    )),
              ),
              Text(
                "Counter",
                style: TextStyle(color: Colors.green.shade400),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: double.infinity,
                  child: (dataPage[indexPage]['urlToImage'] == null)
                      ? Image(
                          fit: BoxFit.contain,
                          image: AssetImage('images/newspng.png'))
                      : Image(
                          fit: BoxFit.contain,
                          image:
                              NetworkImage(dataPage[indexPage]['urlToImage']),
                        ),
                ),
              ],
            ),
            ListTile(
              leading: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                color: Colors.lightGreenAccent.withOpacity(0.17),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Stay Home Stay Safe",
                    style: TextStyle(fontSize: 12, color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      Share.share(dataPage[indexPage]['url']);
                    });
                  },
                  icon: Icon(Icons.share, color: Colors.redAccent),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: (dataPage[indexPage]['title'] == null)
                      ? Text("Breaking News")
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Text(
                              dataPage[indexPage]['title'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: (dataPage[indexPage]['content'] == null)
                    ? Text("sorry the content is not available now ")
                    : Text(
                        dataPage[indexPage]['content'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
            MaterialButton(
              height: MediaQuery.of(context).size.height * 0.05,
              minWidth: MediaQuery.of(context).size.width * 0.80,
              color: Colors.brown[300],
              onPressed: () {
                _launchURL();
              },
              shape: StadiumBorder(),
              child: Text(
                "Read Full News",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
