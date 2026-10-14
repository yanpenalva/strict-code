# Padrões de arquitetura e design

Fronteiras e padrões para backend Laravel/PHP e frontend Vue/TS.

## Fronteiras de camada (backend)

- Controller: recebe input validado, autoriza, chama um service, mapeia resposta.
  Sem regra de negócio, sem query, sem validação inline.
- Service: centraliza regras, orquestra repositories/transações/colaboradores.
  Dependências via construtor (`private readonly`), uma responsabilidade clara.
- Repository: dono da composição de queries e persistência; exposto por interface.
- FormRequest: dono da validação HTTP (regras + mensagens); injetado no controller.
- Resource: dono do formato da resposta; serialização não vaza Eloquent.
- Não criar padrão novo sem necessidade concreta registrada no spec.

## Máquina de estados (FSM)

- Entidades com ciclo de vida (status + transições + ações) usam configuração
  declarativa de workflow + service de domínio que calcula ações disponíveis,
  aplica a transição e registra histórico.
- Frontend consome ações disponíveis da API e renderiza a partir delas; nunca
  hardcode transições válidas no template.

## Autorização

- Middleware de permissão + policies + checagens de service consistentes entre si
  para o mesmo contrato de rota; exceção (rota pública, heartbeat) documentada
  no contrato — checklist genérico nunca veta exceção documentada.

## Auditoria e soft-delete

- Modelos sensíveis: soft-delete + trilha de auditoria (quem, o quê, quando).
  Retenção e imutabilidade definidas no spec.

## Exceções

- Capturar tipos específicos; nunca `catch` amplo sem relançar/embrulhar com
  causa preservada (`previous`). Nunca `catch` vazio, nunca `@`, nunca engolir
  falha com `return false` sem justificativa.
- Falha de consistência com significado de domínio vira exceção tipada de
  domínio + teste unitário, não exceção genérica.

## Queries e persistência

- Sem N+1, sem query em loop, sem `select *`: eager loading, seleção explícita,
  `chunk`/`cursor`/`lazy` para volume.
- Escritas relacionadas em transação; todo endpoint de listagem pagina — nunca
  resultado ilimitado; cache em leitura repetida/pesada.
- Migrações retrocompatíveis (nullable ou default); coluna nova/alterada com
  `comment` em PT-BR (propósito + domínio/valores + nulabilidade/regra).

## Coleções e nulos

- Collection para pipeline de transformação; `foreach` para iteração simples,
  performance crítica ou mutação pontual. Sem cadeia `map/filter/reduce` onde
  um loop resolve.
- Nulos em ordem: `??`, `??=`, `?->`, acesso seguro do framework; sem corrente
  de `isset` nem `if ($o && $o->x)` gigante. Ausência de dado obrigatório nunca
  vira fallback silencioso "válido".

## Frontend

- Componente apresenta e orquestra (props, emits, loading, erro); regra e estado
  reutilizável vivem em services, composables ou tipos de domínio.
- Reutilizar componente existente antes de criar novo; template legível com
  `computed`, sem lógica extensa inline.

## Compatibilidade

- Mudança de interface/contrato não quebra implementação existente: parâmetro
  novo com default, migração compatível, rota nova sem conflito.
- Boolean que alterna o comportamento inteiro do método é proibido: separar
  operações ou usar variante tipada fechada.
