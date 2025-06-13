import 'package:flutter/material.dart';

void main() {
  runApp(const AvaliacaoIMC());
}

class AvaliacaoIMC extends StatelessWidget {
  const AvaliacaoIMC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF3E8FF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelStyle: const TextStyle(color: Colors.deepPurple),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const TelaIMC(),
    );
  }
}

class TelaIMC extends StatefulWidget {
  const TelaIMC({super.key});

  @override
  State<TelaIMC> createState() => _TelaIMCState();
}

class _TelaIMCState extends State<TelaIMC> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  void calcularIMC() {
    final double? peso = double.tryParse(pesoController.text);
    final double? altura = double.tryParse(alturaController.text);

    if (peso == null || altura == null || altura == 0) {
      _mostrarDialogo("Erro", "Por favor, insira valores válidos.");
      return;
    }

    final imc = peso / (altura * altura);
    String classificacao;

    if (imc < 18.5) {
      classificacao = "Abaixo do peso";
    } else if (imc < 25) {
      classificacao = "Peso normal";
    } else if (imc < 30) {
      classificacao = "Sobrepeso";
    } else if (imc < 35) {
      classificacao = "Obesidade Grau I";
    } else if (imc < 40) {
      classificacao = "Obesidade Grau II";
    } else {
      classificacao = "Obesidade Grau III";
    }

    _mostrarDialogo(
      "Resultado do IMC",
      "Seu IMC é ${imc.toStringAsFixed(2)}\n$classificacao",
    );
  }

  void _mostrarDialogo(String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF9F0FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              "Preencha os campos abaixo",
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Peso (kg)",
                prefixIcon: Icon(Icons.monitor_weight),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Altura (m)",
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: calcularIMC,
              icon: const Icon(Icons.favorite),
              label: const Text("Calcular IMC"),
            ),
          ],
        ),
      ),
    );
  }
}
