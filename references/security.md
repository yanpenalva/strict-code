# Guia de segurança

Requisitos verificáveis. Cada item precisa de teste ou evidência; intenção
declarada sem mecanismo não conta.

## Proibições (sem exceção sem justificativa)

- Concatenar SQL ou comando shell; `eval`; `unserialize` sem controle ou sobre
  input de usuário.
- Expor stack trace; logar senha, token, Authorization header.
- `$guarded = []` — declarar `$fillable` explícito em todo model.
- Senha sem hash; comparar segredo/hash com `==` (usar `hash_equals`).
- `{!! !!}` com conteúdo derivado de usuário; `v-html` sem sanitização.
- Upload sem validar mime + tamanho; float para dinheiro (inteiro menor unidade
  ou decimal string).
- `extract()`, `$$var`, `goto`.

## Logs e dados sensíveis

- Contexto sanitizado com identificadores (ids, ação, resultado); mensagem
  específica ("Erro ao sincronizar usuário."), nunca genérica ("Erro.").
- Rastro de exceção só com expurgo de sensíveis; em dúvida, não logar conteúdo.
- Segredo/credencial: referência por nome do cofre, nunca o valor — em código,
  spec, log ou wiki.

## Autenticação e autorização

- Mecanismos existentes do projeto (sessão/token, RBAC por permissão); não
  reinventar auth no trabalho.
- Contrato explícito da rota: middleware, policy, rota pública ou heartbeat
  documentado. Checklist genérico nunca veta exceção documentada.
- Ações sensíveis (senha, aceite, revogação): revalidação de identidade ou
  justificativa registrada.

## Tokens e sessão

- Expiração curta, algoritmo explícito, revogação funcional (logout/bloqueio
  invalida de verdade).
- Testes: expirado, revogado, perfil inativo, isolamento entre usuários
  (A não alcança dado de B; 401/403 nos negativos).

## Entrada e saída

- Input externo validado na borda (FormRequest/validador dedicado); saída
  codificada no contexto; SQL só com binding.
- CORS/origens com matriz explícita + testes negativos; rate limit em credencial.
- Uploads: tipo, tamanho e conteúdo verificados; nada executável em path público.

## Auditoria

- Mutação sensível gera trilha (quem, o quê, quando); retenção e imutabilidade
  no spec.
