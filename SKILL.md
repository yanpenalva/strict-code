---
name: code-standards
description: Use when writing or reviewing code for Yan's projects.
version: 0.2.0
author: Yan Penalva, Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Code-Quality, Security, Conventions]
    related_skills: [requesting-code-review]
---

# Code Standards

Padrões obrigatórios de escrita e revisão de código. Valem em todo projeto,
salvo regra contrária registrada no spec do trabalho.

## When to Use

- Escrever, refatorar ou revisar código PHP/Laravel e TypeScript/JavaScript/Vue.
- Pull requests, testes, migrations, commits, auditoria de código.
- Não usar para: documentação sem código; decisão de produto (decisão é humana).

## Princípios

- KISS/YAGNI: a menor solução funcional. Sem abstração antecipada, sem código
  morto, sem comportamento fora do escopo aprovado.
- Mudança pequena, localizada e reversível. Sem refator oportunista fora do escopo.
- Desconhecido registra-se `NOT FOUND`; nunca inventar requisito, contrato ou evidência.
- Nunca alegar validação ou sucesso sem rodar o comando correspondente.

## Estilo (detalhes em `references/style.md`)

- Sem `else`, `elseif`, `v-else`, `v-else-if`: guard clauses, early return,
  `match`, `computed` ou fluxo linear equivalente.
- Strings por interpolação (`"texto {$var}"`, template literal, `sprintf`);
  nunca concatenação para montar texto; SQL sempre com parameter binding.
- PHP com namespace: importar nativas com `use function <nome>;`.
- JS/TS/Vue: arrow functions em locais, callbacks e handlers; PHP: `fn() =>`
  em closures simples.
- Tipagem completa: `strict_types = 1` em todo PHP, tipos explícitos em
  assinaturas, injeção por construtor, dependências imutáveis onde couber.
- Nomenclatura: PascalCase (classes, componentes), camelCase (métodos, vars,
  funções), snake_case (banco, payloads); idioma do domínio, sem magic strings.
- Teto bloqueante: 500 linhas/arquivo, 15 métodos/funções, 150 linhas/método,
  3 returns. Alvo: <30 linhas; >50 candidatar extração. Revisão nunca rejeita
  código dentro do teto.
- Comentário em produção só para decisão não-óbvia; PHPDoc para tipagem/análise.

## Segurança (detalhes em `references/security.md`)

- Logs com contexto diagnóstico sanitizado; nunca segredo, token, senha, dado
  pessoal ou stack trace bruto.
- Autorização pelo contrato explícito da rota (middleware/policy/rota pública/
  heartbeat); checklist genérico nunca veta exceção documentada.
- Validar todo input externo; autenticar/autorizar pelos mecanismos existentes.
- Tokens: expiração, algoritmo, revogação — com testes de expirado/revogado,
  perfil inativo e isolamento entre usuários.
- Auditar mutações sensíveis; retenção e imutabilidade definidas no spec.

## Testes e processo (detalhes em `references/workflow.md`)

- Toda mudança de comportamento tem teste focado, salvo cobertura existente
  comprovada; alvo 80% no código novo.
- Conventional Commits + hooks de lint/autofix; modo de finalização Git
  indefinido = confirmar cada ação.
- Spec/plano aprovados antes de executar; checks (lint/format/policy) restritos
  aos arquivos alterados; lista vazia é erro.
- Merge e PR somente com OK explícito do Yan.

## Pitfalls

- Ausência de executável/CI num recorte só de docs é limite do recorte, não
  falha do padrão; contradição entre documentos presentes é falha real.
- `allow_failure: true` no CI não dispensa gate verde na revisão.
- Validação de manifesto de contexto não comprova qualidade do código.
- Spec desatualizada contra manifesto: sincronizar a spec.

## Verification

- Gates rodados no escopo alterado, com comando, resultado e cobertura afetada.
- Entrega cita `file:line` por achado e fecha com veredito + contagem
  (bloqueantes / não-bloqueantes).
