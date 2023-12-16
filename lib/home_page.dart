import 'package:flutter/material.dart';
import 'package:masb7te_app/shared_service.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool? sel;
bool currentcolor = false;
int goal = 0;
int counter = 0;
int time = 0;
int rad = 0;
List<int> num = [
  0,
  33,
  100,
  100,
  1000,
];
List<Color> maincolor = [
  Colors.red.shade700,
  Colors.blue.shade900,
  Colors.purple.shade700,
];

class _HomePageState extends State<HomePage> {
  var select;

  resettozero({bool restgoal = false}) {
    setcount(counter = 0);
    settime(time = 0);
    restgoal == true ? setgoal(goal = 0) : null;
  }

  setcount(int value) {
    SharedHelper().savedata(key: "count", value: value);
    getdata();
  }

  settime(int value) {
    SharedHelper().savedata(key: "time", value: value);
    getdata();
  }

  setgoal(int value) {
    SharedHelper().savedata(key: "goal", value: value);
    getdata();
  }

  setcolor(int value) {
    SharedHelper().savedata(key: "color", value: value);
  }

  setitem(dynamic value) {
    SharedHelper().savedata(key: "item", value: value);
  }

  getdata() {
    setState(() {
      counter = SharedHelper().getdata(key: "count") ?? 0;
      time = SharedHelper().getdata(key: "time") ?? 0;
      goal = SharedHelper().getdata(key: "goal") ?? 0;
      rad = SharedHelper().getdata(key: "color") ?? 0;
      select = SharedHelper().getdata(key: "item");
    });
  }

  @override
  void initState() {
    getdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: maincolor[rad],
          onPressed: () {
            resettozero(restgoal: true);
          },
          child: const Icon(
            Icons.refresh,
            color: Colors.white,
            size: 25,
          ),
        ),
        appBar: _appbar(),
        body: SafeArea(
          child: Column(
            children: [
              ///Header

              Expanded(
                flex: 1,
                child: Container(
                  color: maincolor[rad],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultText(
                        text: "الهدف",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultButton(
                            icon: Icons.remove,
                            onPressed: () {
                              resettozero();
                              setgoal(goal - 1);
                            },
                          ),
                          DefaultText(
                            text: "$goal",
                            fontwieghttext: FontWeight.normal,
                          ),
                          DefaultButton(
                            onPressed: () {
                              resettozero();

                              setgoal(goal + 1);
                            },
                            icon: Icons.add,
                          ),
                        ],
                      ),
                      Wrap(
                        children: List.generate(num.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: GestureDetector(
                              onTap: () {
                                resettozero();
                                setgoal(index == 3
                                    ? goal + 100
                                    : index == 4
                                        ? goal + 1000
                                        : goal = num[index]);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: index == 0
                                    ? 30
                                    : index == 1
                                        ? 38
                                        : index == 2
                                            ? 45
                                            : index == 3
                                                ? 50
                                                : 55,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: DefaultText(
                                  text: index == 3
                                      ? "${num[index]}+"
                                      : index == 4
                                          ? "${num[index]}+"
                                          : "${num[index]}",
                                  sizetext: 15,
                                  colortext: Colors.black,
                                  fontwieghttext: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),

              ///Middle

              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: maincolor[rad],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton(
                        iconEnabledColor: Colors.white,
                        underline: const SizedBox(),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        isExpanded: true,
                        dropdownColor: maincolor[rad],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        hint: DefaultText(
                          text: "اختر الذكر الذي تريده ",
                          colortext: Colors.white,
                          fontwieghttext: FontWeight.w400,
                          sizetext: 22,
                        ),
                        items: [
                          "أستغفر الله وأتوب اليه",
                          "اللهم صلي و سلم على سيدنا محمد",
                          "سبحان الله وبحمده",
                          "حسبي الله ونعم الوكيل",
                        ]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            select = val;
                            setitem(val);
                          });
                        },
                        value: select,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultText(
                      text: "$counter",
                      colortext: maincolor[rad],
                      sizetext: 20,
                      fontwieghttext: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            if (counter >= goal) {
                              settime(time + 1);

                              setcount(counter = 1);
                            } else {
                              setcount(counter + 1);
                            }
                          },
                        );
                      },
                      child: CircularPercentIndicator(
                        radius: 85.0,
                        lineWidth: 5.0,
                        percent: counter / goal,
                        center: GestureDetector(
                          child: Icon(
                            Icons.touch_app,
                            size: 50.0,
                            color: maincolor[rad],
                          ),
                        ),
                        backgroundColor: maincolor[rad].withOpacity(0.2),
                        progressColor: maincolor[rad],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultText(
                      text: " مرات التكرار : $time",
                      sizetext: 22,
                      colortext: maincolor[rad],
                      fontwieghttext: FontWeight.normal,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DefaultText(
                      text: " المجموع : ${time * goal + counter}",
                      sizetext: 22,
                      colortext: maincolor[rad],
                      fontwieghttext: FontWeight.normal,
                    ),
                  ],
                ),
              ),

              ///Final

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Visibility(
                  visible: currentcolor,
                  child: Row(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          right: 2,
                        ),
                        child: Radio(
                          fillColor: MaterialStatePropertyAll(
                            maincolor[index],
                          ),
                          activeColor: maincolor[index],
                          value: index,
                          groupValue: rad,
                          onChanged: (val) {
                            setState(() {
                              setcolor(rad = val!);
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      backgroundColor: maincolor[rad],
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              currentcolor = !currentcolor;
            });
          },
          icon: Icon(
            currentcolor ? Icons.color_lens_outlined : Icons.color_lens,
            size: 25,
          ),
        ),
      ],
      elevation: 0,
    );
  }
}

class DefaultText extends StatelessWidget {
  DefaultText({
    super.key,
    required this.text,
    this.sizetext = 25,
    this.fontwieghttext = FontWeight.bold,
    this.colortext = Colors.white,
  });
  final String text;
  double sizetext;
  FontWeight? fontwieghttext;
  Color? colortext;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: sizetext,
        color: colortext,
        fontWeight: fontwieghttext,
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  DefaultButton(
      {super.key,
      required this.onPressed,
      this.icon,
      this.height = 20,
      this.width = 20,
      this.sizeicon = 18});
  double height, width, sizeicon;
  void Function()? onPressed;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const CircleBorder(),
      height: height,
      minWidth: width,
      color: Colors.white,
      onPressed: onPressed,
      child: Icon(
        icon,
        color: maincolor[rad],
        size: sizeicon,
      ),
    );
  }
}
