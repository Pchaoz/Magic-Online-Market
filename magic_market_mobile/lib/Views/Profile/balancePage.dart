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
    final response =
        await http.get(Uri.parse('$API_URI_SERVER/getSalary/$userID'));

    print("FETCH BALANCE STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        _balance = json.decode(response.body)['saldo'];
      });
    } else {
      print("Error fetching balance");
    }
  }

  void _addBalance() async {
    final response = await http.post(
      Uri.parse('$API_URI_SERVER/paypal/order'),
      body: json.encode({'amount': '30.33'}),
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
      body: json.encode({'orderID': orderID, 'userID': userID}),
      headers: {'Content-Type': 'application/json'},
    );

    print("CAPTURE PAYMENT BALANCE STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print("Capture Payment Result: $result");
      if (result['status'] == 'COMPLETED') {
        final amount = result['purchase_units'][0]['payments']['captures'][0]
            ['amount']['value'];
        print("Captured Amount: $amount");
        setState(() {
          _balance += double.parse(amount);
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BalancePage()),
        );
      } else {
        print("Payment not completed");
      }
    } else {
      print("Error capturing payment");
    }
  }

  void _withdrawBalance(double amount) async {
    final response = await http.post(
      Uri.parse('$API_URI_SERVER/paypal/withdraw'),
      body: json.encode({'userID': userID, 'amount': amount}),
      headers: {'Content-Type': 'application/json'},
    );

    print("WITHDRAW BALANCE STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        _balance -= amount;
      });
      print("Withdraw successful");
    } else {
      if (response.statusCode == 400) {
        var error = json.decode(response.body)["message"];
        print("Error: $error");
      } else {
        print("Error withdrawing balance");
      }
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
                  onPressed: () {
                    double amountToWithdraw = 10.0; //CANTIDAD A RETIRAR
                    _withdrawBalance(amountToWithdraw);
                  },
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
          if (request.url.contains('api/paypal/success')) {
            String orderID = Uri.parse(request.url).queryParameters['token']!;
            onApprove(orderID);
            Navigator.pop(context);
            return NavigationDecision.prevent;
          } else if (request.url.contains('api/paypal/cancel')) {
            Navigator.pop(context); // Navegar a la pantalla de cancelación
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
