import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mangafaver/screens/loginScreen.dart';
import 'package:mangafaver/widgets/BotaoAdicionarManga.dart';

import '../widgets/../widgets/NotasManga.dart';
import '../widgets/../widgets/BotoesHomeScreen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  //Realiza a chamada do banco de dados. MockAPI utilizado para testar a estrutura.
  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://653e87429e8bd3be29df705c.mockapi.io/apiteste/Imagens'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<Map<String, dynamic>> data =
          jsonResponse.cast<Map<String, dynamic>>();
      return data;
    } else {
      throw Exception('Falha ao carregar os dados');
    }
  }

  @override
  Widget build(BuildContext context) {
    //Logo.
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF242424),
        elevation: 0,
        centerTitle: true,
        title: Row(
          children: [
            Image.asset(
              'assets/images/icon.png',
              height: AppBar().preferredSize.height * 1.1,
            ),
            const SizedBox(width: 12),
            //Título da AppBar.
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'MANGA',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontFamily: 'KronaOne-Regular',
                  ),
                ),
                Text(
                  'FEVER',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontFamily: 'KronaOne-Regular',
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFE67D0B),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              //Barra de Pesquisa.
              child: Row(
                children: [
                  SizedBox(
                    //Tamanho da barra de pesquisa em telas maiores.
                    width: MediaQuery.of(context).size.width > 600 ? 420 : 180,
                    height: 28,
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Pesquisar...',
                        hintStyle: TextStyle(
                          color: const Color(0xFF878787).withOpacity(0.5),
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.5,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.search,
                      color: Color(0XFFE67D0B),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const loginScreen(),
                  ),
                );
              },
              //Botão de usuário.
              child: Column(
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Color(0XFFE67D0B),
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/images/icone-user.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0XFFE67D0B),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //Linha branca abaixo da AppBar.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 1,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF1A1A1A),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BotoesHomeScreen(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else if (snapshot.data
                            is List<Map<String, dynamic>>) {
                          final List<Map<String, dynamic>> dataList =
                              snapshot.data!;

                          if (dataList.isNotEmpty) {
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                /*Se o tamanho da tela for menor que 600px aparece 2 colunas de Mangá,
                                e se for maior aparece 5 colunas*/
                                final screenWidth = constraints.maxWidth;
                                int crossAxisCount = 2;
                                if (screenWidth > 600) {
                                  crossAxisCount = 5;
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 40.0,
                                    right: 50.0,
                                  ),
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      //Espaço entre as imagens: do lado e da parte de baixo.
                                      crossAxisCount: crossAxisCount,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 95.0,
                                    ),
                                    itemCount: dataList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final data = dataList[index];
                                      final imageUrl = data['imagem'] ??
                                          data['imagens'] ??
                                          '';
                                      final nota = data['nota'] ?? 0.0;
                                      String title = data['titulo'] ?? '';

                                      //Se o título tiver mais de 16 caracteres quebra a linha.
                                      if (title.length > 16) {
                                        title =
                                            '${title.substring(0, 16)}\n${title.substring(16)}';
                                      }

                                      return Padding(
                                          padding: const EdgeInsets.only(
                                            //Distância do lado esquerdo da tela.
                                            left: 50.0,
                                            bottom: 0.5,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              NotasManga(
                                                nota: nota,
                                                imageUrl: imageUrl,
                                                isFavorito: false,
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              Text(
                                                title,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            ],
                                          ));
                                    },
                                  ),
                                );
                              },
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
            ),
          ),
          Positioned(
            //Posição do botão de Adicionar Manga.
            bottom: 40,
            right: 30,
            child: BotaoAdicionarManga(
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
