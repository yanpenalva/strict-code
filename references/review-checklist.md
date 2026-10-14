# Checklist de revisão

Obrigatório antes de abrir PR ou considerar o trabalho pronto. Marcar cada item.

## 1. Guard clauses

```php
// CERTO — validações no topo, fluxo feliz por último
public function history(int $id): array
{
    if ($id <= 0) {
        throw new HttpException(422, 'ID inválido.');
    }
    $this->authorize('view', Model::findOrFail($id));
    return $this->repository->history($id);
}
```

- [ ] Todo método começa com guard clauses para edge cases?
- [ ] Fluxo feliz é o último `return`, sem `else`?

## 2. Queries funcionais

```php
// CERTO — encadeamento sem if/else
$query
    ->when($filters['status'] ?? null, fn ($q, $v) => $q->where('status', $v))
    ->when($filters['from'] ?? null, fn ($q, $v) => $q->whereDate('created_at', '>=', $v));
```

- [ ] Condicionais de query/collection usam `when()` em vez de `if`?
- [ ] Busca textual usa operador case-insensitive do driver quando suportado?

## 3. Ausência de `else`

- [ ] Nenhum arquivo de produção alterado contém `else`, `elseif`, `v-else`, `v-else-if`?
- [ ] Ramificações pré-existentes no arquivo alterado foram refatoradas sem
  mudar ordem de avaliação nem efeitos colaterais?

## 4. Performance e composição

- [ ] Solução mais performática viável considerada (query builder, cache, chunk)?
- [ ] `unset()` evitado onde `data_get`/`Arr::only`/`Arr::except`/`map` resolvem
  sem mutação desnecessária?
- [ ] `Collection` só onde o pipeline melhora a leitura; `foreach` no resto?
- [ ] `??`/`??=` nos defaults simples sem esconder regra de negócio?

## 5. Nomes

- [ ] Nomes autodocumentam (`$activeAnalysts`, não `$dados`/`$x`/`$tmp`)?
- [ ] Métodos revelam intenção (`getHistoryById`, não `get`/`process`)?
- [ ] Sem comentário explicativo onde o nome já comunica?

## 6. Tipagem estrita

- [ ] `declare(strict_types = 1)` no topo dos PHP?
- [ ] Todo parâmetro, retorno e propriedade tipados; `readonly` onde imutável?
- [ ] `#[Override]` em overrides; property hooks ou métodos dedicados p/ get/set?
- [ ] Buscas de array usam `array_find/any/all`; JSON usa `json_validate()`?
- [ ] Comentários esparsos (só decisão não-óbvia); PHPDoc só p/ tipagem/análise?

## 7. SOLID / Clean

- [ ] Responsabilidade única — classe com motivo claro para mudar?
- [ ] Injeção de dependência — sem `new` em services?
- [ ] Nível de abstração — controller orquestra, service tem regra, repository
  tem query; `final class` por padrão?
- [ ] Nenhum método acima do teto sem decomposição no mesmo trabalho?

## 8. Análise estática

- [ ] PHPStan/Larastan e linters passam sem erro no escopo alterado?
- [ ] Sem `Unused variable/import`, complexidade ou returns acima do teto?
- [ ] Respostas HTTP usam constantes (`HTTP_*`), nunca número mágico?

## 9. Testes

- [ ] Unit cobre métodos de service/controller alterados?
- [ ] Testes de autorização (401/403) incluídos?
- [ ] Feature cobre endpoints novos?
- [ ] Focados passam; regressão ampla justificada quando rodada?

## 10. Frontend Vue

- [ ] `defineProps`/`defineEmits` tipados; `ref`/`reactive` corretos?
- [ ] Sem `v-html` com dado de usuário; loading/erro tratados no template?
- [ ] Padrão `<script setup lang="ts">`; sem mutação direta de prop?

## 11. Segurança

- [ ] Rotas com auth + permissão conforme o contrato (inclui exceções
  documentadas)?
- [ ] Validação via FormRequest; queries com binding; sensível mascarado?
- [ ] Caminhos de input, autorização e output revisados nos arquivos alterados?

## 12. Compatibilidade

- [ ] Mudança de contrato não quebra implementação existente?
- [ ] Parâmetro novo com default; migration retrocompatível (nullable/default)?
- [ ] Coluna nova/alterada com `comment` (propósito + domínio + regra)?
- [ ] Rota nova sem conflito com existente?

## 13. Documentação

- [ ] Módulo/domínio atualizado (endpoints, regras, eventos, configs)?
- [ ] Doc oficial consultada para tipos/funções não-triviais?
