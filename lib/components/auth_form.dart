//customizacao dos campos
import 'package:flutter/material.dart';
import 'package:flutter_application_app_chat/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>(); // acessando dados do formulário
  final _formData = AuthFormData(); // usando a classe que foi criada

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    // _formKey.currentState?.validate();
    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // chave dp formulário
          child: Column(
            children: [
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  // validação ao seu campo "Nome".
                  validator: (value) {
                    // 1. O valor pode ser nulo ou vazio?
                    final name = value ?? ''; // Garante que não é nulo
                    // 2. Regra: Não pode ser vazio e deve ter 4+ caracteres
                    if (name.trim().length < 4) {
                      return 'Nome deve ter no mínimo 4 caracteres.';
                    }
                    // 3. Se passou, retorne null (válido)
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                // validação ao seu campo "Email".
                validator: (value) {
                  final email = value ?? ''; // Garante que não é nulo
                  // Regra 1: Não pode ser vazio
                  if (email.trim().isEmpty) {
                    return 'E-mail é obrigatório.';
                  }
                  // Regra 2: Deve ser um e-mail válido (básico)
                  if (!email.contains('@') || !email.contains('.')) {
                    return 'Informe um e-mail válido.';
                  }
                  // 3. Se passou, retorne null (válido)
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: true, //para deixar o texto ofuscado
                decoration: const InputDecoration(labelText: 'Senha'),
                // validação ao seu campo "Senha".
                validator: (value) {
                  // 1. O valor pode ser nulo ou vazio?
                  final password = value ?? ''; // Garante que não é nulo
                  // 2. Regra: Não pode ser vazio e deve ter 4+ caracteres
                  if (password.trim().length < 4) {
                    return 'Senha deve ter no mínimo 4 caracteres.';
                  }
                  // 3. Se passou, retorne null (válido)
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'), //botao
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode(); // alternar os modos
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ), //texto com comportamento de clique
              ),
            ],
          ),
        ),
      ),
    );
  }
}
