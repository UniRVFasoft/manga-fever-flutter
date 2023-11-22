import 'package:flutter/material.dart';
import 'package:mangafaver/screens/HomeScreen.dart';
import 'package:mangafaver/widgets/AppBarHomeScreen.dart';
import 'package:mangafaver/widgets/BotaoAdicionarClassificacao.dart';
import 'package:mangafaver/widgets/CampoTextoCustom.dart';
import 'package:mangafaver/widgets/campoTexto.dart';
import 'package:mangafaver/widgets/textoTitulo.dart';

class AdicionarMangaScreen extends StatefulWidget {
  const AdicionarMangaScreen({Key? key}) : super(key: key);

  _AdicionarMangaScreenState createState() => _AdicionarMangaScreenState();
}

class _AdicionarMangaScreenState extends State<AdicionarMangaScreen> {
  final double botaoTamanho = 25.0;
  String opcaoSelecionada = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: const AppBarHomeScreen(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          final containerMaxWidth = screenWidth * 0.8;
          final containerMaxHeight = screenHeight * 1.0;

          const maxWidth = 800.0;
          const maxHeight = 590.0;

          final containerWidth =
              containerMaxWidth < maxWidth ? containerMaxWidth : maxWidth;
          final containerHeight =
              containerMaxHeight < maxHeight ? containerMaxHeight : maxHeight;

          return Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: containerWidth,
                    maxHeight: containerHeight,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF222222),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const textoTitulo(
                              titulo: 'Adicionar Mangá',
                            ),
                            const campoTexto(descricao: 'Título'),
                            const campoTexto(descricao: 'Link Imagem'),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (screenWidth > 600)
                                        SizedBox(
                                            width: screenWidth *
                                                0.03), // Ajuste a distância do lado direito conforme necessário
                                      const Text(
                                        'Classificação',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // Adiciona um espaço de 8 pixels entre o texto e o botão
                                      BotaoAdicionarClassificacao(
                                        size: botaoTamanho,
                                        iconSize: 18.0,
                                        onPressed: (opcao) {
                                          setState(() {
                                            opcaoSelecionada = opcao;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  if (opcaoSelecionada.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: screenWidth > 600
                                            ? screenWidth * 0.03
                                            : 0,
                                        top: 10,
                                      ),
                                      child: Text(
                                        opcaoSelecionada,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const CampoTextoCustom(
                              descricao: 'Descrição',
                              maxLines: 5,
                            ),
                            SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFCA3A3A),
                                          ),
                                          child: const Text('CANCELAR',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF008405),
                                          ),
                                          child: const Text('SALVAR',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
