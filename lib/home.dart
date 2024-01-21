import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String newQuotes = "";
  bool _isLoading = false;
  bool _isError = false;

  void onRefresh() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final resp =
          await Dio().get("https://ron-swanson-quotes.herokuapp.com/v2/quotes");
      final quotes = resp.data[0];
      setState(() {
        newQuotes = quotes;
      });
    } catch (e) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes"),
        backgroundColor: const Color.fromARGB(255, 126, 219, 231),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _isError
                        ? Text(
                            "oops! Something went wrong",
                            style: GoogleFonts.mooli(fontSize: 20),
                          )
                        : SizedBox(
                            height: 20,
                          ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.cyan),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          newQuotes,
                          style: GoogleFonts.mooli(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    OutlinedButton(
                        onPressed: onRefresh, child: Text("Click here")),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Click the button to get new quote",
                      style: GoogleFonts.mooli(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
