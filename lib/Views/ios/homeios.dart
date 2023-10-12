import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_pr/Components/Helpers/apihelper.dart';
import '../../Model/api_model.dart';
import '../../Provider/platformprovider.dart';
import '../../Provider/theamprovider.dart';

class HomeIos extends StatefulWidget {
  const HomeIos({super.key});

  @override
  State<HomeIos> createState() => _HomeIosState();
}

class _HomeIosState extends State<HomeIos> {
  TextEditingController search = TextEditingController();
  String searchData = "";
  Connectivity connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: StreamBuilder(
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
                            Weather_Model? apimodel =
                                snapshot.data as Weather_Model?;
                            return Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "lib/Components/Assets/istockphoto-502046948-170667a.webp"),
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
                                        margin: EdgeInsets.all(20),
                                        child: CupertinoTextField(
                                          suffix: CupertinoButton(
                                            child: Icon(CupertinoIcons.search),
                                            onPressed: () {
                                              setState(() {
                                                searchData = search.text;
                                              });
                                              search.clear();
                                            },
                                          ),
                                          controller: search,
                                          onEditingComplete: () {
                                            setState(() {
                                              searchData = search.text;
                                            });
                                            search.clear();
                                          },
                                          placeholder: "Search Here..",
                                          placeholderStyle: TextStyle(
                                              color: CupertinoColors.black,
                                              fontSize: 24),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        height: h * .25,
                                        width: w * .9,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "${apimodel?.location['name']}",
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    color:
                                                        CupertinoColors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "${apimodel?.current['temp_c']}°",
                                                  style: const TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 90,
                                                  ),
                                                ),
                                                Text(
                                                  "${apimodel?.current['condition']['text']} ",
                                                  style: const TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  "H:${apimodel?.forecast['forecastday'][0]['day']['maxtemp_c']}°  L:${apimodel?.forecast['forecastday'][0]['day']['mintemp_c']}°",
                                                  style: const TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            CupertinoButton(
                                              child: Icon(
                                                (Provider.of<Themeprovider>(
                                                                context,
                                                                listen: false)
                                                            .theme
                                                            .isdark ==
                                                        false)
                                                    ? CupertinoIcons.sun_max
                                                    : CupertinoIcons
                                                        .sun_min_fill,
                                                color: CupertinoColors.white,
                                              ),
                                              onPressed: () {
                                                Provider.of<Themeprovider>(
                                                        context,
                                                        listen: false)
                                                    .changetheme();
                                              },
                                            ),
                                            CupertinoSwitch(
                                              value:
                                                  Provider.of<PlatformProvider>(
                                                          context,
                                                          listen: true)
                                                      .changePlatform
                                                      .isios,
                                              onChanged: (val) {
                                                Provider.of<PlatformProvider>(
                                                        context,
                                                        listen: false)
                                                    .ConvertPlatform();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Container(
                                          height: h * .25,
                                          width: w * .9,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff3383cc)
                                                .withOpacity(.4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListView.builder(
                                            itemCount: 24,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                Container(
                                              height: h * .20,
                                              width: w * .25,
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
                                                      fontSize: 16,
                                                      color:
                                                          CupertinoColors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 100,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            "http:${apimodel?.forecast['forecastday'][0]['hour'][index]['condition']['icon']}"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${apimodel?.forecast['forecastday'][0]['hour'][index]['temp_c']}°",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          CupertinoColors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            height: h * .17,
                                            width: w * .44,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xff3383cc)
                                                  .withOpacity(.4),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.thermometer,
                                                  color: CupertinoColors.white,
                                                  size: 30,
                                                ),
                                                const Text(
                                                  "Feels like",
                                                  style: TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  "${apimodel?.current['temp_c']}°",
                                                  style: const TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            height: h * .17,
                                            width: w * .44,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xff3383cc)
                                                  .withOpacity(.4),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.wind,
                                                  color: CupertinoColors.white,
                                                  size: 30,
                                                ),
                                                const Text(
                                                  "NNW wind",
                                                  style: TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${apimodel?.current['wind_kph']}",
                                                      style: const TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "  Km/h",
                                                      style: TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            height: h * .17,
                                            width: w * .44,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xff3383cc)
                                                  .withOpacity(.4),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.drop,
                                                  color: CupertinoColors.white,
                                                  size: 30,
                                                ),
                                                const Text(
                                                  "Humidity",
                                                  style: TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${apimodel?.current['humidity']}",
                                                      style: const TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "  % ",
                                                      style: TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            height: h * .17,
                                            width: w * .44,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xff3383cc)
                                                  .withOpacity(.4),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.sun_min_fill,
                                                  color: CupertinoColors.white,
                                                  size: 30,
                                                ),
                                                const Text(
                                                  "UV",
                                                  style: TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${apimodel?.current['uv']}",
                                                      style: const TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "  Strong ",
                                                      style: TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            height: h * .17,
                                            width: w * .44,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xff3383cc)
                                                  .withOpacity(.4),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.eye,
                                                  color: CupertinoColors.white,
                                                  size: 30,
                                                ),
                                                const Text(
                                                  "Visibility",
                                                  style: TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${apimodel?.current['vis_km']}",
                                                      style: const TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "  Km ",
                                                      style: TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            height: h * .17,
                                            width: w * .44,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xff3383cc)
                                                  .withOpacity(.4),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons
                                                      .rectangle_compress_vertical,
                                                  color: CupertinoColors.white,
                                                  size: 30,
                                                ),
                                                const Text(
                                                  "Air pressure",
                                                  style: TextStyle(
                                                    color:
                                                        CupertinoColors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${apimodel?.current['pressure_mb']}",
                                                      style: const TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "  hPa ",
                                                      style: TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Container(
                    height: 450,
                    width: 500,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("lib/Components/Assets/1.gif"),
                            fit: BoxFit.cover)),
                  ),
                );
        },
      ),
    );
  }
}
