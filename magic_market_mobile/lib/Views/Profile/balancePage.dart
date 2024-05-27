import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Util/globals.dart';

class BalancePage extends StatefulWidget {
  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  double _balance = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchBalance();
  }

  void _fetchBalance() async {
    final response = await http.get(Uri.parse('$API_URI_SERVER/getBalance'));

    print("FETCH BALANCE STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        _balance = json.decode(response.body)['balance'];
      });
    } else {
      // Manejo de error
      print("Error fetching balance");
    }
  }

  void _addBalance() async {
    final response = await http.post(
      Uri.parse('$API_URI_SERVER/paypal/order'),
      body: json.encode({'amount': '500.33'}),
      headers: {'Content-Type': 'application/json'},
    );

    print("ADD BALANCE STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      final approvalUrl = json
          .decode(response.body)['links']
          .firstWhere((link) => link['rel'] == 'approve')['href'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PayPalWebView(approvalUrl, _capturePayment),
        ),
      );
    } else {
      // Manejo de error
      print("Error adding balance");
    }
  }

  void _capturePayment(String orderID) async {
    final response = await http.post(
      Uri.parse('$API_URI_SERVER/paypal/capture'),
      body: json.encode({'orderID': orderID, 'userID': 'user_id'}),
      headers: {'Content-Type': 'application/json'},
    );

    print("CAPTURE PAYMENT BALANCE STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'COMPLETED') {
        setState(() {
          _balance += double.parse(result['amount']);
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BalancePage()),
        );
      } else {
        // Manejo de error
        print("Payment not completed");
      }
    } else {
      // Manejo de error
      print("Error capturing payment");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        title: const Text('Magic Online Market'),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 11, 214, 153),
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Saldo',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Saldo: $_balance€', style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addBalance,
                  child: const Text('Recargar Saldo'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Retirar Saldo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PayPalWebView extends StatelessWidget {
  final String approvalUrl;
  final Function(String) onApprove;

  const PayPalWebView(this.approvalUrl, this.onApprove, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        title: const Text('Confirmación de Pago'),
      ),
      body: WebView(
        initialUrl: approvalUrl,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          print("Navegando a: ${request.url}");
          if (request.url.contains('return_url')) {
            String orderID = Uri.parse(request.url).queryParameters['token']!;
            onApprove(orderID);
            Navigator.pop(context);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
