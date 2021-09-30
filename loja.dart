void main(){
  String nome = "mimos da tia";
  int bolsas = 10;
  double valor  = 60.99;
  bool aindaTem = true;

  bolsas = 100;

  print(nome);
  print("o nome da loja é " + nome);
  print("a $nome tem $bolsas bolsas");
  print("cada bolsa custa $valor reais");
  print("ainda tem? $aindaTem");

  dynamic teste = 1;
  print(teste);
  teste = "rsrsrsrs";
  print(teste);

}