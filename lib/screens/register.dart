import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'This is Profile/Register',
            style: TextStyle(fontSize: 16, color: Colors.black),
          )
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Information'),
        backgroundColor: const Color.fromRGBO(79, 52, 34, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            const Text(
              'Name',
              style: TextStyle(
                color: Color.fromRGBO(79, 52, 34, 1),
                fontFamily: 'urbanist',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              height: 60,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(79, 52, 34, 1),
                      width: 3,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color.fromRGBO(79, 52, 34, 1),
                    size: 25,
                  ),
                  hintText: 'Enter your name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(155, 177, 104, 1),
                      width: 3,
                    ),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 40, minWidth: 60),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Gender
            const Text(
              'Gender',
              style: TextStyle(
                color: Color.fromRGBO(79, 52, 34, 1),
                fontFamily: 'urbanist',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              height: 60,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(79, 52, 34, 1),
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(155, 177, 104, 1),
                      width: 3,
                    ),
                  ),
                ),
                items: const [
                  DropdownMenuItem(child: Text("Male"), value: "Male"),
                  DropdownMenuItem(child: Text("Female"), value: "Female"),
                  DropdownMenuItem(child: Text("Other"), value: "Other"),
                ],
                onChanged: (value) {},
                hint: const Text('Select your gender'),
              ),
            ),
            const SizedBox(height: 20),

            // Age
            const Text(
              'Age',
              style: TextStyle(
                color: Color.fromRGBO(79, 52, 34, 1),
                fontFamily: 'urbanist',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              height: 60,
              child: TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(79, 52, 34, 1),
                      width: 3,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Color.fromRGBO(79, 52, 34, 1),
                    size: 25,
                  ),
                  hintText: 'Enter your age',
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(155, 177, 104, 1),
                      width: 3,
                    ),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 40, minWidth: 60),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Birthday
            const Text(
              'Birthday',
              style: TextStyle(
                color: Color.fromRGBO(79, 52, 34, 1),
                fontFamily: 'urbanist',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              height: 60,
              child: TextField(
                controller: _birthdayController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(79, 52, 34, 1),
                      width: 3,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.cake_outlined,
                    color: Color.fromRGBO(79, 52, 34, 1),
                    size: 25,
                  ),
                  hintText: 'Enter your birthday (dd/mm/yyyy)',
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(155, 177, 104, 1),
                      width: 3,
                    ),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 40, minWidth: 60),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
*/