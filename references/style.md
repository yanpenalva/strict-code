# Guia de estilo

Detalhamento das regras de escrita. Cada item mostra o padrão, o anti-padrão
e o porquê em uma linha.

## KISS / YAGNI

- Implementar só o comportamento aprovado no spec; abstração (interface,
  parâmetro, camada) entra quando o segundo caso real aparece, nunca antes.
- Apagar código morto no mesmo trabalho que o revela; não carregar "para o futuro".
- Preferir a construção mais simples que passa nos testes e nos limites abaixo.

## Sem `else` / `elseif`

Fluxo linear com saída antecipada. Vale para PHP, TS/JS e templates Vue
(`v-else`, `v-else-if` entram na mesma proibição).

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

Múltiplas ramificações usam `match` (PHP), ternário encadeado legível ou
`computed` (Vue) — nunca pirâmide de condicionais.

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

Valores dinâmicos em SQL sempre via parameter binding — interpolar valor em
query é falha de segurança, não de estilo.

## Funções nativas e callbacks

- PHP com namespace importa nativas: `use function sprintf;`,
  `use function in_array;` (resolução global + otimização do compilador).
- Callbacks/handlers locais como arrow functions (`fn() =>`, `(x) =>`);
  declaração `function` só onde a linguagem/framework exige.

## Tipagem

- `declare(strict_types=1);` em todo arquivo PHP; tipos explícitos em
  parâmetros, retornos e propriedades; evitar `mixed` sem justificativa no spec.
- TS/Vue: sem `any` implícito; tipos nos limites públicos (props, emits,
  respostas de API, payloads).
- Valores fechados: enum dedicado; demais constantes tipadas; nunca string
  ou número mágico espalhado.
- Dependências via construtor, imutáveis onde couber; regra de negócio em
  serviços/domínio — componente Vue só apresenta e orquestra.

## Nomenclatura

| Camada | Padrão | Exemplo |
|---|---|---|
| Classes, componentes | PascalCase | `InvoiceService`, `UserCard` |
| Métodos, vars, funções | camelCase | `issueInvoice`, `dueDate` |
| Banco, payloads | snake_case | `due_date`, `customer_id` |

Nomes revelam intenção (`activeLoans`, não `data2`); idioma do domínio de
negócio, técnico em inglês.

## Limites de tamanho

| Métrica | Teto (bloqueante) | Alvo |
|---|---|---|
| Linhas por arquivo | 500 | — |
| Métodos/funções declaradas | 15 | — |
| Linhas por método/função | 150 | <30; >50 candidatar extração |
| Returns por método | 3 | — |

Arquivo que já encosta no teto é decomposto no mesmo trabalho — sem refatorar
arquivos fora do escopo.

## Comentários

- Produção: só decisão não-óbvia (o porquê, nunca o quê).
- PHPDoc onde tipagem ou análise estática precisa; narração de IA
  (`// busca o usuário e retorna...`) é removida antes do merge.
