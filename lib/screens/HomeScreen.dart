import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mangafaver/screens/AdicionarMangaScreen.dart';
import 'package:mangafaver/screens/MangaScreen.dart';
import 'package:mangafaver/widgets/Appbar1.dart';
import 'package:mangafaver/widgets/Appbar2.dart';
import 'package:mangafaver/widgets/BotaoAdicionarManga.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/ComponentesDaImagem.dart';
import '../widgets/../widgets/BotoesHomeScreen.dart';

class HomeScreen extends StatefulWidget {
  final String searchTerm;

  const HomeScreen({Key? key, required this.searchTerm}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Future<SharedPreferences> getPrefs() async {
//   return await SharedPreferences.getInstance();
// }

class _HomeScreenState extends State<HomeScreen> {
  late bool isAdmin;

  @override
  void initState() {
    super.initState();
    _initIsAdmin();
  }

  Future<void> _initIsAdmin() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isAdmin = sharedPreferences.getBool('isAdmin') ?? false;
    });
  }

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

  Future<void> initIsAdmin() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isAdmin = sharedPreferences.getBool('isAdmin') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBar2(),
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
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final List<Map<String, dynamic>> dataList = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.all(50),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        String id = data["id"] ?? '';

                        if (title.length > 16) {
                          title =
                              '${title.substring(0, 16)}\n${title.substring(16)}';
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MangaScreen(
                                  mangaId: id,
                                ),
                              ),
                            );
                          },
                          child: ComponentesDaImagem(
                            nota: nota,
                            imageUrl: imageUrl,
                            isFavorito: false,
                            title: title,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('Nenhum dado encontrado.'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: isAdmin
          ? BotaoAdicionarManga(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdicionarMangaScreen(),
                  ),
                );
              },
            )
          : null,
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
