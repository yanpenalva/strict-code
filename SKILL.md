---
name: code-standards
description: Use when writing or reviewing code for Yan's projects.
version: 0.3.0
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

## Regras nucleares

- Sem `else`, `elseif`, `v-else`, `v-else-if`: guard clauses, early return,
  `match`, `computed` ou fluxo linear equivalente (`style.md`).
- Strings por interpolação; SQL só com parameter binding (`style.md`).
- PHP com namespace importa nativas com `use function <nome>;` (`style.md`).
- Tipagem completa + `strict_types = 1`; enums para conjuntos fechados (`style.md`).
- Tetos bloqueantes: 500 linhas/arquivo, 15 métodos/funções, 150 linhas/método,
  3 returns, 7 params, complexidade ciclomática ≤10 / cognitiva ≤15
  (`quality-gates.md`). Alvo: <30 linhas; >50 candidatar extração.
- Camadas: controller fino, regra no service, query no repository, validação no
  FormRequest, formato no Resource (`patterns.md`).
- Logs sanitizados; authZ pelo contrato explícito da rota (`security.md`).
- Toda mudança de comportamento tem teste focado; alvo 80% no código novo
  (`testing.md`, `workflow.md`).
- Conventional Commits + hooks; merge/PR só com OK explícito (`conventions.md`).
- Revisão fecha com `file:line` + severidade + veredito (`review-checklist.md`).

## Guias

| Precisa de | Leia |
|---|---|
| Estilo, tipagem, nomenclatura, limites | `references/style.md` |
| Padrões de camada, queries, exceções, compat | `references/patterns.md` |
| Gates numéricos, Sonar, hotspots | `references/quality-gates.md` |
| Commits, hooks, toolchain, migrations | `references/conventions.md` |
| Segurança e privacidade | `references/security.md` |
| Estratégia e anatomia de testes | `references/testing.md` |
| Processo do trabalho | `references/workflow.md` |
| Checklist de revisão | `references/review-checklist.md` |

## Pitfalls

- Ausência de executável/CI num recorte só de docs é limite do recorte, não
  falha do padrão; contradição entre documentos presentes é falha real.
- `allow_failure: true` no CI não dispensa gate verde na revisão.
- Validação de manifesto de contexto não comprova qualidade do código.
- Spec desatualizada contra manifesto: sincronizar a spec.
- Supressão de alerta de analisador (`NOSONAR` e equivalentes) só com motivo
  técnico + referência do trabalho; revisar supressões antigas.

## Verification

- Gates rodados no escopo alterado, com comando, resultado e cobertura afetada.
- Entrega cita `file:line` por achado e fecha com veredito + contagem
  (bloqueantes / não-bloqueantes).
