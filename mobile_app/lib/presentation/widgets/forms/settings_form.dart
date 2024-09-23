import 'package:bookshopapp/core/app_enviroment.dart';
import 'package:bookshopapp/presentation/widgets/login_styled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostSettginsForm extends StatefulWidget {
  const HostSettginsForm({super.key});

  @override
  State<HostSettginsForm> createState() => _HostSettginsFormState();
}

class _HostSettginsFormState extends State<HostSettginsForm> {
  final _hostFieldController = TextEditingController();

  void saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final host = _hostFieldController.text;

    prefs.setString('server_host', host);
    AppEnviroment.serverHost = host;
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Saved')));
    }
  }

  void loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final host = prefs.getString('server_host') ?? 'localhost';
    AppEnviroment.serverHost = host;

    setState(() {
      _hostFieldController.text = host;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(153, 94, 105, 238);
    const Color hintColor = Color.fromARGB(153, 94, 105, 238);
    const Color textColor = Color.fromARGB(255, 94, 106, 238);
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoginStyledTextField(
              controller: _hostFieldController,
              validator: (value) => null,
              padding: const EdgeInsets.only(bottom: 10),
              textColor: textColor,
              hintColor: hintColor,
              borderColor: borderColor,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              hintText: 'Server Host',
              prefixIconData: Icons.wifi),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: ElevatedButton(
              onPressed: saveSettings,
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Text(
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF4F4FB),
                          fontSize: 30),
                      'Save')),
            ),
          )
        ],
      ),
    );
  }
}
