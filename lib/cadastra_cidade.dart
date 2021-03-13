import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'conexao.dart' as conexao;

Future<void> cadastrarCidade(idUf) async {
  var url_cidade =
      'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${idUf}/distritos';
  var resposta_cidade = await http.get(url_cidade);

  if (resposta_cidade.statusCode == 200) {
    var jsonResposta_cidade = convert.jsonDecode(resposta_cidade.body);
    await conexao.getConnection();
    var conn_cidade = await conexao.getConnection();

    for (var cidade in jsonResposta_cidade) {
      // int idCidade = cidade['municipio']['id'];
      // String nomeCidade = cidade['municipio']['nome'];
      int idCidade = cidade['id'];
      String nomeCidade = cidade['nome'];

      var result = await conn_cidade.query(
          'insert cidades (id_pais, id_cidade, id_uf, nome_cidade) values (?, ?, ?, ?)',
          ['1058', idCidade, idUf, nomeCidade]);
    }
    await conn_cidade.close();
  } else {
    print('Banco de dados não retornado');
  }
}
