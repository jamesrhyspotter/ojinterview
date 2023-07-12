import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OJ Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NumberInput(),
    );
  }
}

class NumberInput extends StatefulWidget {
  const NumberInput({super.key});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  List<int> input = [];
  int target = -1;
  List<int> answer = [];
  late TextEditingController inputCtrl;
  late TextEditingController targetCtrl;
  bool hasCalculated = false;

  @override
  void initState() {
    super.initState();
    inputCtrl = TextEditingController();
    targetCtrl = TextEditingController();
  }

  List<int> findNumbers({required List<int> input, required int target}) {
    // Test 1
    // 1,2,3,4,5,6
    // 11
    // [5,6]
    // 4,3,5,7,6
    // 10
    // [3,7]

    List<int> output = [];

    for (int numb in input) {
      int index = input.indexOf(numb);
      int num1 = numb;

      if (index < input.length - 1) {
        break;
      } else {
        for (int i = index + 1; i < input.length - 1; i++) {
          int num2 = input[i];
          int sum = num1 + num2;
          if (sum == target) {
            output = [num1, num2];
          }
        }
      }
    }

    return output;
  }

  reset() {
    setState(() {
      input = [];
      target = -1;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    inputCtrl.dispose();
    targetCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('${answer.isNotEmpty ? answer : 'Not found'}'),
            TextFormField(
                controller: inputCtrl,
                onChanged: (value) {
                  setState(() {
                    input = value.split(',').map(int.parse).toList();
                  });
                },
                decoration:
                    const InputDecoration(hintText: 'Input list (csv)')),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  target = int.parse(value);
                });
              },
              controller: targetCtrl,
              decoration: const InputDecoration(hintText: 'Input target'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    answer = findNumbers(input: input, target: target);
                  });

                  reset();
                },
                child: const Text('Calculate'))
          ],
        ),
      ),
    );
  }
}
