# Convenções

## Nomenclatura

| Camada | Padrão | Exemplo |
|---|---|---|
| Classes, interfaces | PascalCase | `InvoiceService`, `InvoiceRepositoryInterface` |
| Métodos, funções, vars | camelCase | `issueInvoice`, `dueDate` |
| Constantes | SCREAMING_SNAKE_CASE (tipadas quando possível) | `MAX_ITEMS` |
| Colunas e tabelas | snake_case (tabela no plural) | `due_date`, `invoice_status_histories` |
| Componentes Vue (arquivo + template) | PascalCase | `InvoiceList.vue` |
| Constantes/enums globais (front) | SCREAMING_SNAKE_CASE ou PascalCase | `SCREENS`, `ACTIONS` |

Nomes genéricos (`$dados`, `$x`, `get()`, `process()`) são falha de revisão —
o nome documenta a intenção. Exceção: `$q`/`$query` em closures de `when()`.
Propriedade de classe: camelCase interno, snake_case em mapeamento de banco.

## Commits

Formato: `tipo: descrição` ou `tipo(escopo): descrição`. Tipos: `build`,
`chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style`, `test`.
Mensagem validada no hook `commit-msg` (commitlint).

## Hooks (sugerido)

- `pre-commit`: lint-staged (ESLint com autofix no front, Pint no back).
- `pre-push`: quality check dos arquivos alterados + typecheck do front quando
  aplicável + PHPStan/testes focados no back. Suíte completa só em mudança de
  dependência ou runner.

## Toolchain de referência

| Área | Ferramenta | Papel |
|---|---|---|
| PHP formatação | Pint (PSR-12/Laravel) | formatar |
| PHP análise | PHPStan/Larastan (+ baseline p/ débito existente) | tipos/bugs |
| PHP testes | PHPUnit/ParaTest | unidade/integração |
| Front lint | ESLint | estilo/boas práticas |
| Front formato | Prettier | formatação |
| Front testes | Vitest (+ coverage) | unidade/componente |

## PHP moderno (usar quando a versão do projeto suporta)

- `final class` por padrão; `private readonly` + promoção no construtor;
  `match` em vez de `elseif`; enums backed para conjuntos fechados;
  `#[Override]`; constantes tipadas; `array_find/any/all`; `json_validate()`;
  `mb_*`; named arguments (3+ params); spread `[...$a, ...$b]` para mesclar;
  `Response::HTTP_*` em vez de número mágico; `when()` em queries/collections.
- `extract()`, `$$var`, `goto`, referência `&$var` sem justificativa: proibidos.
- Comparação sempre `===`/`!==`; dinheiro nunca em float (inteiro menor unidade
  ou decimal string).

## JS/TS/Vue

- `const` por padrão, `let` só com reatribuição, nunca `var`; `===`, `??`, `?.`.
- TS: sem `any` (tipo preciso ou `unknown`), sem `!` non-null, strict null checks,
  `satisfies` para estreitar literais; `async/await`, sem promise hell.
- Vue: Composition API + `<script setup lang="ts">`; props/emits tipados;
  `:key` em todo `v-for`; sem mutar prop; sem `v-html` com conteúdo não
  sanitizado; watchers profundos só com motivo.

## Migrations

- Retrocompatíveis; `change()` redeclara definição completa + `comment`.
- `->comment()` em PT-BR: propósito + domínio/valores + nulabilidade/regra.

## Documentação oficial

- Tipo/função/recurso desconhecido: consultar a doc oficial (via Context7 quando
  disponível) antes de implementar; se desatualizada, complementar com a doc
  oficial atual no browser. Pacotes: repositório/packagist.
