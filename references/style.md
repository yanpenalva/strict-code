# Guia de estilo

Detalhamento das regras de escrita: padrão, anti-padrão e porquê.

## KISS / YAGNI

- Implementar só o comportamento aprovado; abstração (interface, parâmetro,
  camada) entra no segundo caso real, nunca antes.
- Apagar código morto no trabalho que o revela; sem "para o futuro".
- Extrair abstração só com repetição real de regra com um dono — nunca para
  baixar métrica; não fragmentar em wrappers triviais para driblar teto.

## Sem `else` / `elseif`

Fluxo linear com saída antecipada. Vale para PHP, TS/JS e templates Vue
(`v-else`, `v-else-if` na mesma proibição).

```php
// NÃO
function status(int $score): string {
    if ($score >= 7) {
        return 'aprovado';
    } else {
        return 'reprovado';
    }
}

// SIM
function status(int $score): string {
    if ($score < 7) {
        return 'reprovado';
    }
    return 'aprovado';
}
```

Ramificações finitas usam `match`; decisões complexas viram predicados
nomeados ou colaborador dedicado. Proibido trocar `else` por ternário aninhado
ou pirâmide de `if` — no máximo 3 níveis significativos, alvo 1.

## Strings: interpolação, nunca concatenação

```php
// NÃO
$msg = 'Usuário ' . $nome . ' criado em ' . $data;

// SIM
$msg = "Usuário {$nome} criado em {$data}";
```

```ts
// NÃO
const msg = 'Usuário ' + nome + ' criado';

// SIM
const msg = `Usuário ${nome} criado`;
```

Mensagens de exceção, logs, chaves de tradução, URLs e chaves de array:
interpolação. Query: sempre parameter binding — interpolar valor em SQL é
falha de segurança, não de estilo.

## Funções nativas e callbacks

- PHP com namespace importa nativas: `use function sprintf;`,
  `use function in_array;`, `use function count;` (resolução global +
  otimização do compilador; sem prefixo `\` inline).
- Não usar `require_once` para carregar configuração de código namespaced —
  usar o mecanismo de config do framework.
- Callbacks/handlers locais como arrow functions (`fn() =>`, `(x) =>`);
  `function` só onde a linguagem/framework exige.
- Ternário aninhado: extrair para statements nomeados; parêntese redundante
  em cast/coalescência: remover; parâmetro não usado: remover com callers.

## Tipagem

- `declare(strict_types=1);` em todo PHP; tipos em parâmetros, retornos e
  propriedades; `mixed` só com justificativa; PHPDoc só para generics,
  collections, arrays complexos e contratos inexprimíveis — sem duplicar a
  assinatura.
- TS/Vue: sem `any` (preciso ou `unknown`), sem `!`, strict null checks,
  `satisfies` para literais; tipos nos limites públicos (props, emits, API).
- Conjuntos fechados: enum (backed quando há valor); resto: constante tipada
  ou value object. Nunca número/string mágica espalhada.
- Dependências via construtor (`private readonly` + promoção), imutáveis onde
  couber; estático com dependência: proibido — injetar.
- `final class` por padrão; extensão só com motivo documentado.

## Nomenclatura

| Camada | Padrão | Exemplo |
|---|---|---|
| Classes, componentes | PascalCase | `InvoiceService`, `UserCard` |
| Métodos, vars, funções | camelCase | `issueInvoice`, `dueDate` |
| Constantes | SCREAMING_SNAKE_CASE tipada | `MAX_ITEMS` |
| Banco, payloads | snake_case | `due_date`, `customer_id` |

Nomes revelam intenção (`activeLoans`, não `data2`/`$x`/`get()`); idioma do
domínio de negócio, técnico em inglês.

## Limites de tamanho

| Métrica | Teto (bloqueante) | Alvo |
|---|---|---|
| Linhas por arquivo | 500 | — |
| Métodos/funções declaradas | 15 | — |
| Linhas por método/função | 150 | <30; >50 candidatar extração |
| Returns por método | 3 | — |

Acima do teto no arquivo alterado: decompor no mesmo trabalho (helpers,
services, composables coesos, cada um com seam focada e teste). Sem refatorar
fora do escopo.

## Comentários

- Produção: só decisão não-óbvia (o porquê, restrição de compatibilidade).
- PHPDoc onde tipagem/análise precisa; narração de IA removida antes do merge.
