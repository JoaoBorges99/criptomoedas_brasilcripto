
import 'package:criptomoedas_brasilcripto/global/widgets_personalizados.dart';
import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:criptomoedas_brasilcripto/stores/main_store.dart';
import 'package:criptomoedas_brasilcripto/views/cripto_details_page.dart';
import 'package:flutter/material.dart';

class CarrosselPage extends StatefulWidget {
  final MainStore pageController;

  const CarrosselPage({super.key, required this.pageController});

  @override
  State<CarrosselPage> createState() => _CarrosselPageState();
}

class _CarrosselPageState extends State<CarrosselPage> {
  int paginaAtual = 0;

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.trending_up, color: Colors.orange[400], size: 24),
            const SizedBox(width: 8),
            const Text(
              'Oportunidades',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.withValues(alpha: 0.2),
                Colors.orange[600]!.withValues(alpha:0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.orange.withValues(alpha:0.3),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    paginaAtual = index;
                  });
                },
                itemCount: widget.pageController.criptoCurrencyTrendList.sublist(10, 13).length,
                itemBuilder: (context, index) {
                  CriptoCurrency topMoedas = widget.pageController.criptoCurrencyTrendList.sublist(10, 13)[index];
                  return PersonWidgets.carrosselItem(
                    cripto: topMoedas,
                    onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CriptoDetailsPage(cripto: widget.pageController.criptoCurrencyTrendList.sublist(10, 13)[index],),
                        ),
                      );                      
                    },
                  );
                },
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.pageController.criptoCurrencyTrendList.sublist(10, 13).length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: paginaAtual == index ? 32 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: paginaAtual == index
                            ? Colors.green[400]
                            : Colors.white.withValues(alpha:0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}