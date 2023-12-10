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

class _HomeScreenState extends State<HomeScreen> {
  late bool isAdmin;
  bool sortByRating = false;
  bool orderByAlphabetical = false;
  late List<Map<String, dynamic>> dataList;

  @override
  void initState() {
    super.initState();
    dataList = [];
    _initIsAdmin();
  }

  Future<void> _initIsAdmin() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isAdmin = sharedPreferences.getBool('isAdmin') ?? false;
    });
  }

  void handleAlphabeticalOrder() {
    setState(() {
      orderByAlphabetical = true;
    });
    fetchData();
  }


Future<void> fetchData() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final String? token = sharedPreferences.getString('token');

  try {
    if (token != null && token.isNotEmpty) {
      final response = await http.get(
        Uri.parse(
          'https://manga-fever-backend-production.up.railway.app/mangas/user',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        dataList = jsonResponse.cast<Map<String, dynamic>>();
        print('com login');
        // Restante do seu código para processar os dados conforme necessário
      } else {
        throw Exception('Falha ao carregar os dados do usuário');
      }
    } else {
      
      final response = await http.get(
        Uri.parse(
          'https://manga-fever-backend-production.up.railway.app/mangas',
        ),
      );

      if (response.statusCode == 200) {
         final List<dynamic> jsonResponse = json.decode(response.body);
      dataList = jsonResponse.cast<Map<String, dynamic>>();
      print('sem login');

      if (orderByAlphabetical) {
        dataList.sort(
          (a, b) => a['titulo'].toString().compareTo(b['titulo'].toString()),
        );
      } else {
        dataList.sort((a, b) {
          var notaA = a['nota'];
          var notaB = b['nota'];

          if (notaA != null && notaB != null) {
            return notaB.compareTo(notaA);
          } else if (notaA == null && notaB == null) {
            return 0;
          } else if (notaA == null) {
            return 1;
          } else {
            return -1;
          }
        });
      }

      if (widget.searchTerm.isNotEmpty) {
        dataList = dataList
            .where((element) => element['titulo']
                .toString()
                .toLowerCase()
                .contains(widget.searchTerm.toLowerCase()))
            .toList();
      }
      } else {
        throw Exception('Falha ao carregar os dados');
      }
    }
  } catch (error) {
    print('Erro ao buscar dados: $error');
    // Aqui você pode lidar com possíveis erros ao buscar dados
  }
}

  late double maxWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maxWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBar2(),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Column(
        children: [
          BotoesComCallback(
            onPressedMaisPopulares: () {
              setState(() {
                orderByAlphabetical = false;
                sortByRating = true;
              });
              fetchData();
            },
            handleAlphabeticalOrder: handleAlphabeticalOrder,
            searchTerm: '',
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error.toString());
                } else {
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
                        bool userFavorite = data['userFavorite'] ?? false;
                        
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
                                  userFavorite: userFavorite,
                                ),
                              ),
                            );
                          },
                          child: ComponentesDaImagem(
                            nota: nota,
                            imageUrl: imageUrl,
                            isFavorito: false,
                            title: title,
                            userFavorite: userFavorite,
                          ),
                        );
                      },
                    ),
                  );
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

class BotoesComCallback extends StatefulWidget {
  final String searchTerm;
  final VoidCallback onPressedMaisPopulares;
  final VoidCallback handleAlphabeticalOrder;

  const BotoesComCallback({
    Key? key,
    required this.searchTerm,
    required this.onPressedMaisPopulares,
    required this.handleAlphabeticalOrder,
  }) : super(key: key);

  @override
  _BotoesComCallbackState createState() => _BotoesComCallbackState();
}

class _BotoesComCallbackState extends State<BotoesComCallback> {
  @override
  Widget build(BuildContext context) {
    return BotoesHomeScreen(
      onPressedMaisPopulares: widget.onPressedMaisPopulares,
      searchTerm: widget.searchTerm,
      handleAlphabeticalOrder: widget.handleAlphabeticalOrder,
    );
  }
}
