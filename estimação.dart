class Animal {
  
  String nome;
  double peso;
  
  Animal(this.nome, this.peso);
  
  void calorias() {
    print("$nome comeu!");
  }
  
  void som() {
    print("$nome fez algum som!");
  }
  
}

class Cachorro extends Animal {
  
  int fofura;
  
  Cachorro(String nome, double peso, this.fofura) : super(nome, peso);
  
  void brincar() {
    fofura += 10;
    print("Fofura do $nome aumentou para $fofura!!!");
  }
  
}

class Gato extends Animal {
  
  Gato(String nome, double peso) : super(nome, peso);
  
  bool estaAmigavel() {
    return true;
  }
  
}


void main() {
  Animal animal1 = Animal("Rex", 20.0);
  animal1.som();
  animal1.calorias();
  
  Cachorro cachorro = Cachorro("Dog", 10.0, 100);
  cachorro.som();
  cachorro.calorias();
  cachorro.brincar();
  
  Gato gato = Gato("Cat", 10.0);
  gato.som();
  gato.calorias();
  print("Esta amigável? ${gato.estaAmigavel()}");
}