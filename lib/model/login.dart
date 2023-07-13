class Login {
  String login;
  String senha;
  String permissao;
  String token;

  Login(this.login, this.senha, this.permissao, this.token);

  factory Login.fromJson(Map<String, dynamic> json){
    return Login(json['login'], json['senha'],
    json['permissao'], json['token']);
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'senha': senha,
      'permissao': permissao,
      'token': token,
    };
  }
}