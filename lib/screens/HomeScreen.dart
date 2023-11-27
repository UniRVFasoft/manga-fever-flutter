import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mangafaver/screens/AdicionarMangaScreen.dart';
import 'package:mangafaver/screens/MangaScreen.dart';
import 'package:mangafaver/widgets/AppBarHomeScreen.dart';
import 'package:mangafaver/widgets/BotaoAdicionarManga.dart';
import '../widgets/ComponentesDaImagem.dart';
import '../widgets/../widgets/BotoesHomeScreen.dart';

class HomeScreen extends StatefulWidget {
  final String searchTerm;

  const HomeScreen({Key? key, required this.searchTerm}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(
      Uri.parse(
        'https://manga-fever-backend-production.up.railway.app/mangas',
      ),
    );

    const String imagemPadrao =
        'https://s2.glbimg.com/QeQ9cqGo-kE-TyD1crH7jpUiDE4=/620x455/e.glbimg.com/og/ed/f/original/2020/01/21/gettyimages-463651383.jpg';

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<Map<String, dynamic>> data =
          jsonResponse.cast<Map<String, dynamic>>();

      if (widget.searchTerm.isEmpty) {
        return data;
      } else {
        final List<Map<String, dynamic>> filteredData = data
            .where((element) => element['titulo']
                .toString()
                .toLowerCase()
                .contains(widget.searchTerm.toLowerCase()))
            .toList();
        return filteredData;
      }
    } else {
      throw Exception('Falha ao carregar os dados');
    }
  }

  late double maxWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maxWidth = MediaQuery.sizeOf(context).width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHomeScreen(showSearchBar: true),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Column(
        children: [
          const BotoesHomeScreen(),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Adiciona tratamento de erro aqui
                  return _buildErrorWidget(snapshot.error.toString());
                } else if (snapshot.data is List<Map<String, dynamic>>) {
                  final List<Map<String, dynamic>> dataList = snapshot.data!;
                  if (dataList.isNotEmpty) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MangaScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: maxWidth > 600 ? 6 : 2,
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 45.0,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: dataList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final data = dataList[index];
                            final imageUrl =
                                data['imagem'] ?? data['imagens'] ?? '';
                            final nota = data['nota'] ?? 0.0;
                            String title = data['titulo'] ?? '';

                            if (title.length > 16) {
                              title =
                                  '${title.substring(0, 16)}\n${title.substring(16)}';
                            }

                            return ComponentesDaImagem(
                              nota: nota,
                              imageUrl: imageUrl,
                              isFavorito: false,
                              title: title,
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return const Text('Nenhum dado encontrado.');
                  }
                } else {
                  return const Text('Dados inválidos');
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BotaoAdicionarManga(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdicionarMangaScreen(),
            ),
          );
        },
      ),
    );
  }

  // Função para construir um widget de erro
  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 50,
            color: Colors.red,
          ),
          const SizedBox(height: 10),
          Text(
            'Erro ao carregar os dados: $error',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
