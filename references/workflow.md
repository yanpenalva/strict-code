# Guia de testes e processo

## Testes

- Toda mudança de comportamento adiciona ou atualiza teste focado, salvo
  cobertura existente comprovada (citar o teste que já cobre).
- Alvo: 80% no código novo; negativos de segurança e regras de negócio têm
  prioridade sobre cobertura percentual.
- Rodar no ambiente dono do código (container/serviço do projeto), restrito ao
  escopo alterado; suíte ampla só quando a ferramenta exige contexto.

## Commits e Git

- Conventional Commits (`tipo(escopo): descrição`); hooks de lint/autofix ativos.
- `changed_files` = arquivos fonte adicionados, copiados, modificados ou
  renomeados no escopo; lista vazia é erro.
- Modo de finalização Git indefinido = confirmar cada ação (commit e push
  separados); nunca force-push nem inferir aprovação de resposta anterior.
- Merge e PR somente com OK explícito do Yan, com CI verde e branch limpa.

## Processo do trabalho

1. Spec/plano aprovados antes de qualquer execução.
2. Implementar backend primeiro quando houver contrato; frontend consome o
   contrato registrado, nunca adivinha.
3. Checks (lint, formatação, policy) restritos a `changed_files`.
4. Revisão com `file:line`, severidade (bloqueante/não-bloqueante) e veredito
   final com contagem.
5. Ajustar só o aprovado ou pedido; documentar o afetado e fechar com mensagem
   de commit proposta.
