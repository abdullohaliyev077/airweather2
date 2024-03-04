import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  
  dynamic data = {};
 
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
String formattedDate = DateFormat('E d MMM \n kk:mm:ss').format(now);
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments;
    // print(data);

    String bgImage = data['isDay'] ?  'weather2-01.jpg' :'weather1-01.jpg' ;

    String currentHour;
    int hour = data['time'].hour;
    currentHour = (hour % 12 == 0 ? 12 : hour % 12).toString() + (hour < 12 ? " AM" : " PM");

    // Icon conditionalIcon;
    // if (data['isDay']) {
    //   conditionalIcon = const Icon(
    //     FontAwesomeIcons.sun,
    //     size: 75.0,
    //     color: Colors.white,
    //   );
    // } else {
    //   conditionalIcon = const Icon(
    //     FontAwesomeIcons.moon,
    //     size: 75.0,
    //     color: Colors.white,
    //   );
    // }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Weather',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: () async {
              dynamic result = await Navigator.pushNamed(context, '/location');
              setState(() {
                data = {
                  'location': result['location'],
                  'temperature': result['temperature'],
                  'temperatureMin': result['temperatureMin'],
                  'temperatureMax': result['temperatureMax'],
                  'condition': result['condition'],
                  'icon': result['icon'],
                  'time': result['time'],
                  'isDay': result['isDay']
                };
              });
            },
            icon: const Icon(Icons.edit_location),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/$bgImage'),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${data['location']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                currentHour,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Image.network('http://openweathermap.org/img/wn/${data['icon']}@2x.png'),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "${data['temperature']}°c",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 80.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                "-----------",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 60.0,
                    fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "${data['condition']}",
                style: const TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                "${data['temperatureMin']}°c/${data['temperatureMax']}°c",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 20,
              ),
               Center(child: Text(formattedDate,textAlign: TextAlign.center, style: const TextStyle(
                  color: Colors.red,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w900,
                ),)),
            ],
          ),
        ),
      ),
    );
  }
}