# Guia de segurança

Requisitos verificáveis. Cada item precisa de teste ou evidência; intenção
declarada sem mecanismo não conta.

## Logs e dados sensíveis

- Logar contexto diagnóstico sanitizado (ids, ação, resultado); nunca senha,
  token, segredo, documento pessoal ou stack trace bruto.
- Rastro de exceção entra só com expurgo de dados sensíveis e nível adequado;
  em dúvida, não logar o conteúdo.

## Autenticação e autorização

- Usar os mecanismos existentes do projeto (sessão/token, RBAC por permissão);
  não reinventar auth no trabalho.
- Autorização segue o contrato explícito da rota: middleware, policy, rota
  pública ou heartbeat documentado. Checklist genérico nunca veta uma rota
  cuja exceção está documentada.
- Ações sensíveis (senha, aceite, revogação) exigem revalidação de identidade
  ou justificativa registrada, conforme o domínio.

## Tokens e sessão

- Expiração curta, algoritmo explícito, revogação funcional (logout/bloqueio
  invalida de verdade).
- Testes obrigatórios: token expirado, token revogado, perfil inativo e
  isolamento entre usuários (A não alcança dado de B; 401/403 nos negativos).

## Entrada e saída

- Todo input externo validado na borda (FormRequest/validador dedicado);
  saída codificada conforme o contexto; SQL só com binding.
- CORS/restrições de origem com matriz explícita de origens e testes negativos;
  limite de tentativas onde houver credencial.
- Uploads: tipo, tamanho e conteúdo verificados; nada executável em path público.

## Auditoria

- Mutações sensíveis geram trilha persistida (quem, o quê, quando); retenção e
  proteção contra alteração definidas no spec.
- Nenhum segredo, token ou credencial em código, spec, log ou wiki — referência
  por nome do cofre, nunca o valor.
