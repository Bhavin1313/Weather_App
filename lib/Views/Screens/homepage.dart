import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_pr/Components/Helpers/apihelper.dart';
import 'package:weather_app_pr/Model/api_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  String searchData = "";
  Connectivity connectivity = Connectivity();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Api_Helper.api.fetchWeather(search: searchData);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
        stream: connectivity.onConnectivityChanged,
        builder: (
          BuildContext context,
          AsyncSnapshot<ConnectivityResult> snapshot,
        ) {
          return (snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi)
              ? Column(
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future: Api_Helper.api.fetchWeather(search: searchData),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else if (snapshot.hasData) {
                            Weather_Model? apimodel = snapshot.data;
                            return Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "lib/Components/Assets/blue-sky-clouds-aesthetic-background.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          onEditingComplete: () {
                                            setState(() {
                                              searchData = search.text;
                                            });
                                            search.clear();
                                          },
                                          controller: search,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              filled: true,
                                              fillColor: Colors.blueAccent
                                                  .withOpacity(.5),
                                              suffix: IconButton(
                                                icon: Icon(
                                                  Icons.search,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    searchData = search.text;
                                                  });
                                                  search.clear();
                                                },
                                              ),
                                              hintText: "Search Hear........"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 70,
                                      ),
                                      Container(
                                        height: h * .16,
                                        width: w * .9,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${apimodel?.location['name']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40,
                                              ),
                                            ),
                                            Text(
                                              "${apimodel?.location['region']},${apimodel?.location['country']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${apimodel?.location['localtime']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 70,
                                      ),
                                      Center(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          height: h * .14,
                                          width: w * .9,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.6),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${apimodel?.current['temp_c']} ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 50,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 25),
                                                      ),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        child: Text(
                                                          "${apimodel?.current['condition']['text']} ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 19),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          height: h * .25,
                                          width: w * .9,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.6),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: ListView.builder(
                                            itemCount: 24,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                Container(
                                              height: 100,
                                              width: 100,
                                              margin: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "${index}:00",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                  Image.network(
                                                      "http:${apimodel?.forecast['forecastday'][0]['hour'][index]['condition']['icon']}"),
                                                  Text(
                                                      "${apimodel?.forecast['forecastday'][0]['hour'][index]['temp_c']}℃",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          height: h * .25,
                                          width: w * .9,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.6),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: ListView.builder(
                                            itemCount: 24,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                Container(
                                              height: 100,
                                              width: 100,
                                              margin: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "${index}:00",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                  Image.network(
                                                      "http:${apimodel?.forecast['forecastday'][0]['hour'][index]['condition']['icon']}"),
                                                  Text(
                                                      "${apimodel?.forecast['forecastday'][0]['hour'][index]['temp_c']}℃",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
