import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview/api.dart';
import 'package:interview/model.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoApp(),
    );
  }
}

class DemoApp extends ConsumerStatefulWidget {
  const DemoApp({super.key});

  @override
  ConsumerState<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends ConsumerState<DemoApp> {
  late FutureProvider<Temperatures> currentPriceProvider;
  @override
  void initState() {
    super.initState();
    currentPriceProvider = FutureProvider((ref) => getCurrentPrice());
  }

  @override
  Widget build(BuildContext context) {
    var currentPrice = ref.watch(currentPriceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Get Price Demo',
        ),
      ),
      body: currentPrice.when(
        data: (data) => Column(
          children: [
            Text(data.disclaimer),
            Text(data.chartName),
          ],
        ),
        error: (error, state) => Text('$error'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
