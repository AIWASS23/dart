class Pessoa {
  
  String nome;
  int idade;
  double altura
  
  Pessoa(this.nome, this.idade, this.altura);
  
  Pessoa.nascer(this.nome, this.altura) {
    idade = 0;
    print("$nome ele vive!");
    sonhar();
  }
  
  void sonhar() {
    print("$nome está dormindo!");
  }
  
  void festa() {
    idade++;
  }
  
  int get idade => idade;
  
  double get altura => altura;
  
  set altura(double altura){
    if(altura > 0.0 && altura < 3.0){
       altura = altura;
    }
  }
   
}

void main() {
  
  String algumaCoisa = "valor";
  
  Pessoa pessoa1 = Pessoa("Paulo", 30, 1.80);
  
  Pessoa pessoa2 = Pessoa("Sonia", 28, 1.90);
  
  print(pessoa1.nome);
  print(pessoa2.nome);
  
  print(pessoa1.idade);
  pessoa1.aniver();
  print(pessoa1.idade);
  
  pessoa2.dormir();
  
  Pessoa nene = Pessoa.nascer("Enzo", 0.30);
  print(nene.nome);
  print(nene.idade);
  
  nene.altura = 15.0;
  print(nene.altura);
  
}


