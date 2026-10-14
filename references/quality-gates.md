# Gates de qualidade

Limites objetivos. Teto = bloqueante; alvo = direção de revisão.

## Tetos estruturais (produção)

| Métrica | Teto | Alvo |
|---|---|---|
| Linhas por arquivo | 500 | — |
| Métodos/funções declaradas (inclui privadas) | 15 | — |
| Linhas por método/função | 150 | <30; >50 candidatar extração |
| Returns por método | 3 | — |
| Parâmetros por método | 7 (acima: DTO/objeto imutável) | — |
| Complexidade ciclomática | 10 | — |
| Complexidade cognitiva | 15 | — |
| Níveis de aninhamento | 3 (preferir 1) | 1 |

Arquivo no teto é decomposto por responsabilidade no mesmo trabalho; função
no teto é dividida em validação/busca/transformação/persistência/resposta.
Desvio de MUST exige exceção aprovada, com escopo e motivo.

## Literais duplicados

- Literal significativo (`len >= 5` com `: . * /`, ou `len >= 20`) repetido
  `>= 3x` no mesmo arquivo de produção = falha. Palavras curtas de API
  (`string`, `required`) não contam; params de regra e mensagens longas contam.
- Números/strings reutilizáveis viram constante tipada, enum ou value object.

## Metas de código novo (Sonar)

- Cobertura ≥80%; duplicação <3%; zero vulnerabilidades abertas; zero hotspots
  sem revisão; zero novos code smells bloqueantes; zero novos bugs.
- Limiar de perfil ativo do servidor Sonar cita-se do servidor; sem evidência,
  o valor é recomendação, nunca "configurado".

## Supressões e hotspots

- Sem `NOSONAR`/equivalente sem motivo técnico + referência do trabalho;
  supressões antigas são revisadas e removidas quando injustificadas.
- Antes do merge, conferir: Bugs, Vulnerabilities, Security Hotspots, Code
  Smells, Coverage, Duplications, ratings Maintainability/Reliability/Security.

## Execução local

- Checks (lint, formatação, policy) restritos aos arquivos alterados, read-only
  por padrão; autofix só em caminho autorizado (hook pre-commit / comando de
  fix explícito).
- Job de CI com `allow_failure: true` é informativo — não dispensa gate verde
  na revisão.
