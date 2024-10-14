import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Welcome to My Flutter App!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Button Clicked!");
              },
              child: const Text('Click Me'),
            ),
            const SizedBox(height: 20),
            Image.network(
              'https://flutter.dev/images/flutter-logo-sharing.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const Center(
        child: Text('Welcome to the Dashboard!'),
      ),
    );
  }
}

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  String? _recipientName;
  double? _amount;
  String _paymentMethod = 'Bank Transfer';
  bool _isFavorite = false;
  bool _showSuccessMessage = false;

  final List<String> _paymentMethods = ['Bank Transfer', 'Credit Card', 'PayPal'];

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
  
      setState(() {
        _showSuccessMessage = true;
        // Use _recipientName here
        print('Sending money to: $_recipientName');
      });
  
      // Hide the success message after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _showSuccessMessage = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Recipient Name Field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recipient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter recipient\'s name';
                  }
                  return null;
                },
                onSaved: (value) => _recipientName = value,
              ),
              const SizedBox(height: 16),
              
              // Amount Field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                onSaved: (value) => _amount = double.parse(value!),
              ),
              
              const SizedBox(height: 16),
              
              // Payment Method Dropdown
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                items: _paymentMethods.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Payment Method'),
              ),
              const SizedBox(height: 16),
              
              // Favorite Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Mark as Favorite'),
                  Switch(
                    value: _isFavorite,
                    onChanged: (value) {
                      setState(() {
                        _isFavorite = value;
                      });
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Success Message Animation
              AnimatedOpacity(
                opacity: _showSuccessMessage ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: const Text(
                  'Transaction Successful!',
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
              ),
              
              const SizedBox(height: 30),
              // Send Money Button
              ElevatedButton(
                onPressed: _validateAndSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18, color: Colors.white), // Set the text color here
                ),
                child: const Text('Send Money'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
