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
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool ifCondition = false; // Variável de classe
  final TextEditingController searchController = TextEditingController();

  
  //Realiza a chamada do banco de dados. MockAPI utilizado para testar a estrutura.
  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse(
        // 'https://653e87429e8bd3be29df705c.mockapi.io/apiteste/Imagens'
        'https://manga-fever-backend-production.up.railway.app/mangas'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<Map<String, dynamic>> data =
          jsonResponse.cast<Map<String, dynamic>>();
      return data;
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
    //Logo.
    return Scaffold(
      appBar: AppBarHomeScreen(),
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
                  return Text('Erro: ${snapshot.error}');
                } else if (snapshot.data is List<Map<String, dynamic>>) {
                  final List<Map<String, dynamic>> dataList = snapshot.data!;
                  if (dataList.isNotEmpty) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the desired screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MangaScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
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

                            //Se o título tiver mais de 16 caracteres quebra a linha.
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
}
