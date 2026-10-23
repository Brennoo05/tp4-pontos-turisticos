// TP4 - Catálogo de Pontos Turísticos da Baixada Santista
// Aluno: Brenno Gonçalves Rodrigues

import 'package:flutter/material.dart';

// Nome do aluno (usado na AppBar)
const String nomeAluno = 'Brenno Gonçalves Rodrigues';

void main() {
  runApp(const Principal());
}

// Classe principal do aplicativo
// Aluno: Brenno Gonçalves Rodrigues
class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pontos Turísticos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const TelaCatalogo(),
    );
  }
}

// Modelo de dados de um ponto turístico (mantido apenas em memória)
class PontoTuristico {
  final String nome;
  final String cidade;
  final String imagem;
  final String descricao;
  bool favorito;
  bool visitado;

  PontoTuristico({
    required this.nome,
    required this.cidade,
    required this.imagem,
    required this.descricao,
    this.favorito = false,
    this.visitado = false,
  });
}

// Tela principal com a lista (StatefulWidget)
class TelaCatalogo extends StatefulWidget {
  const TelaCatalogo({super.key});

  @override
  State<TelaCatalogo> createState() => _TelaCatalogoState();
}

class _TelaCatalogoState extends State<TelaCatalogo> {
  // Quantidade de cards por linha da vitrine
  static const int _cardsPorLinha = 2;

  final List<PontoTuristico> _pontos = [
    PontoTuristico(
      nome: 'Quebra Mar',
      cidade: 'Santos',
      imagem: 'imagens/quebra_mar.jpeg',
      descricao:
          'O Quebra-Mar de Santos, localizado no bairro José Menino, é um dos pontos turísticos mais conhecidos de Santos, famoso pelo seu monumento vermelho gigante e pela bela vista do mar.',
    ),
    PontoTuristico(
      nome: 'Memorial dos 500 Anos',
      cidade: 'São Vicente - Ilha Porchat',
      imagem: 'imagens/Memorial_dos_500_Anos.jpeg',
      descricao:
          'Monumento projetado por Oscar Niemeyer, conhecido pelo formato marcante e pela vista panorâmica da Baía de São Vicente e de Santos.',
    ),
    PontoTuristico(
      nome: 'Ponte Pênsil',
      cidade: 'São Vicente',
      imagem: 'imagens/Ponte_Pensil_Sao_Vicente.jpg',
      descricao:
          'Cartão-postal de São Vicente, inaugurada em 1914, liga a ilha '
          'ao continente e é tombada como patrimônio histórico.',
    ),
    PontoTuristico(
      nome: 'Monte Serrat',
      cidade: 'Santos',
      imagem: 'imagens/Monte_Serrat_Santos.jpg',
      descricao:
          'Um dos pontos mais conhecidos da cidade, com bondinho histórico, santuário e um mirante com vista panorâmica de Santos.',
    ),
    PontoTuristico(
      nome: 'Teleférico de São Vicente',
      cidade: 'São Vicente',
      imagem: 'imagens/teleferico_sao_vicente.jpeg',
      descricao:
          'Atração turística que liga a região da Praia do Itararé ao alto do Morro do Voturuá, proporcionando vistas panorâmicas do litoral.',
    ),
    PontoTuristico(
      nome: 'Orquidário Municipal',
      cidade: 'Santos',
      imagem: 'imagens/orquidario.jpeg',
      descricao:
          'Parque tradicional com animais, aves, árvores e diversas espécies de plantas, bastante conhecido entre os moradores e turistas.',
    ),
    PontoTuristico(
      nome: 'Museu do Café',
      cidade: 'Santos',
      imagem: 'imagens/museu_docafe.png',
      descricao:
          'Localizado no edifício histórico da antiga Bolsa Oficial do Café, no Centro de Santos, conta a história da importância do café para a economia brasileira.',
    ),
    PontoTuristico(
      nome: 'Vila Belmiro — Estádio Urbano Caldeira',
      cidade: 'Santos',
      imagem: 'imagens/vila_belmiro.jpg',
      descricao:
          'Estádio histórico do Santos Futebol Clube, inaugurado em 1916 e conhecido mundialmente por ser um dos palcos da história de Pelé. É um dos principais pontos turísticos esportivos da Baixada Santista, atraindo torcedores e visitantes interessados na história do futebol.',
    ),
  ];

  // Atualiza o estado de "favorito" de um ponto
  void _alterarFavorito(int indice, bool? valor) {
    setState(() {
      _pontos[indice].favorito = valor ?? false;
    });
  }

  // Atualiza o estado de "visitado" de um ponto
  void _alterarVisitado(int indice, bool? valor) {
    setState(() {
      _pontos[indice].visitado = valor ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Cada item do ListView é uma linha da vitrine com 2 cards
    final int totalLinhas = (_pontos.length / _cardsPorLinha).ceil();

    return Scaffold(
      appBar: AppBar(
        title: const Text(nomeAluno),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        // Limita a largura para a vitrine não esticar demais no navegador
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: totalLinhas,
            itemBuilder: (context, linha) => _construirLinha(linha),
          ),
        ),
      ),
    );
  }

  // Monta uma linha da vitrine com os cards lado a lado
  Widget _construirLinha(int linha) {
    final List<Widget> cards = [];

    for (int i = 0; i < _cardsPorLinha; i++) {
      final int indice = linha * _cardsPorLinha + i;

      if (indice < _pontos.length) {
        cards.add(Expanded(child: _construirCard(indice)));
      } else {
        // Espaço vazio para manter o tamanho quando a última linha é ímpar
        cards.add(const Expanded(child: SizedBox()));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      // IntrinsicHeight deixa os cards da mesma linha com a mesma altura
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: cards,
        ),
      ),
    );
  }

  // Monta o card de um ponto turístico
  Widget _construirCard(int indice) {
    final ponto = _pontos[indice];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _construirImagem(ponto.imagem),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ponto.nome,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.teal),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          ponto.cidade,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    ponto.descricao,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Spacer(),
                  _construirCheckboxes(indice),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Imagem quadrada do ponto, com tratamento de erro caso o arquivo falhe
  Widget _construirImagem(String caminho) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(
          caminho,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, erro, pilha) {
            return Container(
              color: Colors.grey.shade300,
              child: const Icon(Icons.image_not_supported,
                  size: 48, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }

  // Dois Checkboxes (favorito e visitado), um embaixo do outro
  Widget _construirCheckboxes(int indice) {
    final ponto = _pontos[indice];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: ponto.favorito,
              visualDensity: VisualDensity.compact,
              onChanged: (valor) => _alterarFavorito(indice, valor),
            ),
            const Text('Favorito', style: TextStyle(fontSize: 13)),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: ponto.visitado,
              visualDensity: VisualDensity.compact,
              onChanged: (valor) => _alterarVisitado(indice, valor),
            ),
            const Text('Visitado', style: TextStyle(fontSize: 13)),
          ],
        ),
      ],
    );
  }
}