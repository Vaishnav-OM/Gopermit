import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import '/newPermission/components/background.dart';

const kheight = SizedBox(
  height: 15,
);

class PrincipalSidePermissionScreen extends StatelessWidget {
  PrincipalSidePermissionScreen({super.key});
  final commentsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const background(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Nirmana',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              pinned: false,
              snap: false,
              floating: false,
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleWithDetailWidget(
                              title: 'Event Name', details: 'Nirmana'),
                          const TitleWithDetailWidget(
                              title: 'Organizing Society', details: 'IEEE'),
                          const TitleWithDetailWidget(
                              title: 'Event Location/ Utility Centre - I',
                              details: 'Seminar Hall'),
                          const TitleWithDetailWidget(
                              title: 'Date', details: '21st March 2023'),
                          Row(
                            children: const [
                              TitleWithDetailWidget(
                                  title: 'Starting Time', details: '4:00 PM'),
                              SizedBox(
                                width: 15,
                              ),
                              TitleWithDetailWidget(
                                  title: 'Ending Time', details: '6:00 PM'),
                            ],
                          ),
                          const TitleWithDetailWidget(
                              title: 'Event Description',
                              details:
                                  '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent facilisis in nulla non tincidunt. Sed ac justo in odio blandit interdum. Suspendisse vel cursus nisi, eget interdum arcu. Curabitur rutrum magna laoreet, luctus diam ut, suscipit nibh. Mauris venenatis tincidunt libero, vel fringilla mauris. Duis feugiat placerat dui a convallis. Suspendisse enim purus, condimentum nec ante id, fringilla tempus mauris. Fusce posuere placerat lectus, vitae tempor libero euismod sit amet. In facilisis luctus est in pretium. Quisque mollis velit sodales augue suscipit, at varius sem sagittis. Praesent laoreet consectetur blandit.'''),
                          const TitleWithDetailWidget(
                              title: 'Point of Contact',
                              details: 'George Mammen Kurien - S8 C'),
                          _CommentsSection(
                            controller: commentsController,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DecisionButtonWidget(
                                buttonText: 'APPROVE',
                                onPressed: () {},
                              ),
                              DecisionButtonWidget(
                                buttonText: 'REJECT',
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ],
    ));
  }
}

class _CommentsSection extends StatelessWidget {
  const _CommentsSection({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Comments',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            )),
        kheight,
        TextFormField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
        ),
        kheight,
      ],
    );
  }
}

class DecisionButtonWidget extends StatelessWidget {
  const DecisionButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            Color.fromRGBO(0, 0, 0, 0.1),
          ),
        ),
      ),
    );
  }
}

class TitleWithDetailWidget extends StatelessWidget {
  const TitleWithDetailWidget(
      {super.key, required this.title, required this.details});
  final String title;
  final String details;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        kheight,
        Text(details,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            )),
        kheight,
      ],
    );
  }
}
