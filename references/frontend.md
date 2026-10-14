# Vue 3 + TypeScript specifics

Complements `patterns.md` and `conventions.md`.

## Setup and typing

```ts
// RIGHT — Composition API + typed boundaries
<script setup lang="ts">
import { ref, computed } from "vue";
const count = ref(0);
const doubled = computed(() => count.value * 2);
</script>
```

- `<script setup lang="ts">` in all new components; no Options API in new code.
- Typed `defineProps`/`defineEmits` (loses autocomplete and safety otherwise).
- Prefer `ref()` for everything including objects; avoid `reactive()` pitfalls.
- `:key` on every `v-for`; typed service responses and emitted events.

## State and services

- Composable = refs + functions reused by 2+ components; it knows state and
  logic, never DOM or templates. Encapsulates `loading`/`error`/`items` +
  loader functions + global-toast error handling.
- Services: object literal by default; class only when state or DI clearly wins.
- HTTP calls live in services; components orchestrate. Mock the service layer
  in Vitest — never hit real endpoints, no sleeps, await promises/state.

## Templates

- No extensive logic inline — `computed` instead; no `v-else`/`v-else-if`
  (guard-style rendering: early `v-if` returns via computed flags).
- No direct prop mutation; no unnecessary or deep watchers; no `v-html` with
  unsanitized content; loading/error states always handled.
