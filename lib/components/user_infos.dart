import 'package:flutter/material.dart';

class UserInfos extends StatelessWidget {
  const UserInfos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Profile',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
            ],
          ),
          Container(
            height: 400,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(
                      0.0,
                      5,
                    ),
                  ),
                ]),
            child: (Column(children: [
              Stack(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 200,
                  ),
                  Container(
                    width: double.infinity,
                    height: 130,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://geo.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fgeo.2F2020.2F01.2F08.2Fd0539a42-8114-44a0-a0bc-ae434b7ef018.2Ejpeg/1150x647/background-color/ffffff/quality/70/quelles-sont-les-plus-belles-plages-du-monde.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: (Container(
                            width: 95,
                            height: 95,
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: (SizedBox(
                              height: 100,
                              child: (Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Dylan Lecomte',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18)),
                                  Text(
                                    'Paris, France',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  )
                                ],
                              )),
                            )))
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: const [
                            Icon(Icons.domain),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text('BPCE-SI',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.work_outline),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text('Développeur Angular',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left),
                          )
                        ],
                      )
                    ],
                  ))
            ])),
          )
        ],
      ),
    );
  }
}
