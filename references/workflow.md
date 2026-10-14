# Guia de processo

## Ordem do trabalho

1. Spec/plano aprovados antes de qualquer execução.
2. Backend primeiro quando há contrato; frontend consome o contrato registrado.
3. Trabalho em ondas por dependência; fatias pequenas com gates verdes.
4. Revisão (`review-checklist.md`) → ajustar só o aprovado/pedido → documentar
   o afetado → fechar com mensagem de commit proposta.

## Escopo de verificação

- `changed_files` = fonte adicionada, copiada, modificada ou renomeada; vazia = erro.
- Lint, formato e policy SÓ nesses arquivos; suíte/typecheck/análise ampla só
  quando a ferramenta exige contexto — registrar motivo e escopo.
- Comandos no ambiente dono do código (container/serviço do projeto).

## Commits e Git

- Conventional Commits + hooks (lint/autofix no commit, gates no push).
- Finalização indefinida = confirmar cada ação; nunca force-push nem inferir
  aprovação passada. Merge/PR só com OK explícito, CI verde, branch limpa.

## Documentação do trabalho

- Mudança de comportamento/contrato atualiza doc do módulo: responsabilidade,
  inputs/outputs/erros, invariantes, efeitos colaterais, auth/privacidade,
  config e exemplos. Sem duplicar fato sem dono canônico.
- Relatório final: comandos, ambientes, passa-falha, asserts/cobertura, falha
  pré-existente ou pendente — com `file:line` por achado e veredito com contagem.
