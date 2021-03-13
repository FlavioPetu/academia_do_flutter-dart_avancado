import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'conexao.dart' as conexao;
import 'cadastra_uf.dart' as cad_uf;
import 'cadastra_cidade.dart' as cad_cidade;

Future run() async {
  var url_uf = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
  var resposta_uf = await http.get(url_uf);

  if (resposta_uf.statusCode == 200) {
    var jsonResposta_uf = convert.jsonDecode(resposta_uf.body);
    await conexao.getConnection();

    print('======== LENDO ESTADOS ========');

    for (var estado in jsonResposta_uf) {
      int idUf = estado['id'];
      String uf = estado['sigla'];
      await cad_uf.cadastraUf(idUf, uf);

      print('Lendo municípios referente ao estado de ${uf}');
      await cad_cidade.cadastrarCidade(idUf);
    }
    print('======== FIM ========');
  } else {
    print('Banco de dados não retornado');
  }
}
