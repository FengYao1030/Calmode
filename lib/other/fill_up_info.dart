import 'package:flutter/material.dart';

class FillUpInfo extends StatefulWidget {
  const FillUpInfo({Key? key}) : super(key: key);

  @override
  _FillUpInfoState createState() => _FillUpInfoState();
}

class _FillUpInfoState extends State<FillUpInfo> {
  final TextEditingController _nicknameController = TextEditingController();
  String? _gender = ''; // To store selected gender
  String? _birthYear; // Use String? to allow null values
  bool _isLoading = false;

  List<String> _generateYears() {
    int currentYear = DateTime.now().year;
    return List<String>.generate(
        currentYear - 1899, (index) => (currentYear - index).toString());
  }

  void _basicInfo() {
    if (_nicknameController.text.isEmpty ||
        _gender == null ||
        _birthYear == null) {
      // Show error if fields are not filled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or processing
    Future.delayed(const Duration(seconds: 2), () {
      // Process the information (e.g., save to a database)
      setState(() {
        _isLoading = false;
      });
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Information submitted successfully!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(154, 177, 103, 1),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(154, 177, 103, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45))),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    'Your Basic Information',
                    style: TextStyle(
                        fontFamily: 'urbanist',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          // Form section below the header
          Padding(
            padding: const EdgeInsets.only(top: 200), // Move the content down
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align items to the left
              children: [
                // Nickname Label
                const Padding(
                  padding: EdgeInsets.only(left: 20), // Add space on the left
                  child: Text(
                    'Nickname',
                    style: TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(79, 52, 34, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: 350,
                    height: 60,
                    child: TextFormField(
                      controller: _nicknameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors
                              .white, // set the textfield background as white color
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(79, 52, 34,
                                  1), // Normal (unfocused) border color
                              width: 3, // Normal border width
                            ),
                          ),
                          /*prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: Color.fromRGBO(79, 52, 34, 1),
                            size: 25,
                          ),*/

                          hintText: 'Enter your nickname',
                          hintStyle: const TextStyle(color: Colors.grey),
                          //focus tetxfield
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(155, 177, 104, 1),
                                width: 3),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                              maxHeight: 40, minWidth: 60)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Gender',
                    style: TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(79, 52, 34, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Male Choice
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gender = 'male';
                          });
                        },
                        child: Container(
                          width: 150,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: _gender == 'male'
                                  ? const Color.fromRGBO(155, 177, 104, 1)
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Male',
                                  style: TextStyle(
                                    fontFamily: 'urbanist',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: _gender == 'male'
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _gender == 'male'
                                        ? const Color.fromRGBO(155, 177, 104, 1)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: _gender == 'male'
                                          ? const Color.fromRGBO(
                                              155, 177, 104, 1)
                                          : Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Female Choice
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gender = 'female';
                          });
                        },
                        child: Container(
                          width: 150,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: _gender == 'female'
                                  ? const Color.fromRGBO(155, 177, 104, 1)
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Female',
                                  style: TextStyle(
                                    fontFamily: 'urbanist',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: _gender == 'female'
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _gender == 'female'
                                        ? const Color.fromRGBO(155, 177, 104, 1)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: _gender == 'female'
                                          ? const Color.fromRGBO(
                                              155, 177, 104, 1)
                                          : Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Birth Year',
                    style: TextStyle(
                      fontFamily: 'urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(79, 52, 34, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: DropdownButtonFormField<String>(
                    value: _birthYear,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(155, 177, 104, 1),
                          width: 10,
                        ),
                      ),
                      //contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 30), 
                      hintText:
                          'Select your birth year', // set the text at the center and at left
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    items: _generateYears().map((year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _birthYear = value; // Update the selected year
                      });
                    },
                  ),
                ),
                const SizedBox(height: 60),
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 350,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        backgroundColor: const Color.fromRGBO(79, 52, 34, 1),
                      ),
                      onPressed: _isLoading ? null : _basicInfo,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Submit',
                              style: TextStyle(
                                  fontFamily: 'urbanist',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
