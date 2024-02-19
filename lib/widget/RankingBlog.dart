import 'package:flutter/material.dart';

class RankingBlog extends StatefulWidget {
  final int index; // Add a parameter to receive the index

  const RankingBlog({Key? key, required this.index}) : super(key: key);

  @override
  State<RankingBlog> createState() => _RankingBlogState();
}

class _RankingBlogState extends State<RankingBlog> {
  @override
  Widget build(BuildContext context) {
    final fem = MediaQuery.of(context).textScaleFactor;

    return Positioned(
      left: 27 * fem,
      top: (250.0000029802 + widget.index * 120.0) * fem,
      child: Container(
        width: 343 * fem,
        height: 98 * fem,
        child: Stack(
          children: [
            Align(
              child: Container(
                width: 343 * fem,
                height: 87 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20 * fem),
                  color: Color(0xfffafafa),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black, // Change to black
                      offset: Offset(0 * fem, 2 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
              ),
            ),
            // Text ranks
            Positioned(
              left: 36 * fem,
              top: 38 * fem,
              child: SizedBox(
                width: 8 * fem,
                height: 22 * fem,
                child: Text(
                  (widget.index + 1).toString(), // Use the index dynamically
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17 * fem,
                    fontWeight: FontWeight.w700,
                    height: 1.2941176471 * fem,
                    letterSpacing: -0.4079999924 * fem,
                    color: Color(0xad000000),
                  ),
                ),
              ),
            ),
            // Text 'AAA'
            Positioned(
              left: 125 * fem,
              top: 38 * fem,
              child: Align(
                child: SizedBox(
                  child: Text(
                    'name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w700,
                      height: 1.6923076923 * fem,
                      letterSpacing: -0.4079999924 * fem,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
            // Text '1600'
            Positioned(
              left: 278 * fem,
              top: 40 * fem,
              child: Align(
                child: SizedBox(
                  width: 37 * fem,
                  height: 22 * fem,
                  child: Text(
                    '1600',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15 * fem,
                      fontWeight: FontWeight.w700,
                      height: 1.4666666667 * fem,
                      letterSpacing: -0.4079999924 * fem,
                      color: Color(0xffff0000),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
