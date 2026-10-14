# Estratégia de testes

Menor conjunto que prova o comportamento alterado + regressão exigida da área.

## Camadas

| Camada | Local típico | Uso |
|---|---|---|
| Service | `tests/Unit/Services/` | regra de negócio com doubles de interface |
| Repository | `tests/Unit/Repositories/` | query/persistência contra banco de teste |
| Controller | `tests/Unit/Http/Controllers/` | delegação e mapeamento de resposta |
| FormRequest | `tests/Unit/Http/Requests/` | regras via validador real (stub local p/ injeção) |
| Model | `tests/Unit/Models/` | relação, cast, fillable, soft-delete |
| Feature HTTP | `tests/Feature/` | rota, middleware, authZ, serialização |
| Feature console | `tests/Feature/Console/` | comando: saída, exit code, efeitos |
| Frontend | `*.spec.ts` junto ao fonte | componente/composable/service com HTTP mockado |

Mudança de autorização/rota pede feature; regra de service pede unit focado.

## Anatomia por camada

- **Service:** mock da interface do repository, injeção por construtor, um
  comportamento por teste incluindo falha.
- **Repository:** refresh de banco + factories + persistência real; assert no
  resultado e no estado.
- **Controller:** mock do service, stub local de FormRequest, assert no mapeamento.
- **FormRequest:** request real, `rules()` pelo validador: válido, ausente,
  tipo errado, nullable.
- **Feature HTTP:** pela rota quando middleware/permissão/status/serialização
  são o contrato; auth e authZ assertados separadamente.

## Convenções

- Nome de teste = comportamento + cenário; assertions específicas (`assertSame`,
  `assertCount`, `assertDatabaseHas`, asserts de status HTTP).
- Sucesso + falhas de auth/validação + edge relevantes; sem testar método
  privado diretamente.
- Factories e states em vez de montar model na mão; nunca mockar Eloquent
  quando o comportamento depende de persistência.
- Front: HTTP mockado, sem endpoint real, sem sleep arbitrário nem assert
  dependente de timing.
- Query dependente de comportamento específico do driver de produção: cobrir em
  ambiente com o driver ou caminho equivalente significativo — nunca enfraquecer
  o teste para fazer query incompatível passar.

## O que não testar por padrão

- Comportamento do framework (getter/setter trivial), privado isolado, config
  fora do escopo, suíte inteira para mudança localizada.
- Exceção: quando rota, config ou integração É o contrato alterado ou a
  fronteira provável de regressão.

## Registro de conclusão

Todo relatório final declara: testes focados + regressão rodada; análise
estática/formatação/typecheck/lint rodados; ambiente/container; passa-falha
com asserts/cobertura; falha pré-existente ou pendente.
