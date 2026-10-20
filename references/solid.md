# SOLID with worked examples

Each principle: rule, violation, fix. Apply as review tools — never to justify
speculative interfaces or layers.

## SRP — one reason to change

Operational test: list the unrelated reasons this class would change (new
actor, new rule, new format, new datasource). More than one independent
reason → split along the reasons. A split is correct when each part can be
described without mentioning the other.

```php
// WRONG — validation + persistence + notification in one method
public function register(array $data): User
{
    if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
        throw new ValidationException('email');
    }
    $user = $this->users->create($data);
    $this->mailer->sendWelcome($user);
    return $user;
}

// RIGHT — orchestrate collaborators, each with one job
public function register(array $input): User
{
    $this->validator->assertValid($input);
    $user = $this->users->create($input);
    $this->notifier->welcome($user);
    return $user;
}
```

## OCP — open for extension, closed for modification

New behavior via new code (new strategy class, new `match` arm backed by a
collaborator, new policy), not by editing stable branching logic. Finite
dispatch prefers `match` over `elseif` chains.

## LSP — substitutes must honor the contract

An implementation must accept everything the interface promises and keep its
guarantees (no narrowed input types, no new unchecked exceptions, no weakened
postconditions). A test double (fake, mock, stub) must obey the same contract.

## ISP — small focused interfaces

```php
// WRONG — forces implementers to carry unrelated methods
interface Repository { public function find(int $id): ?Model; public function exportPdf(): string; }

// RIGHT — split by role; depend only on what is used
interface Finder { public function find(int $id): ?Model; }
interface Exporter { public function exportPdf(Model $model): string; }
```

## DIP — depend on abstractions

Services receive interfaces through the constructor, never instantiate
concretes with `new`; the framework container wires implementations. This is
what makes repository doubles in unit tests possible.

## DRY — one owner per rule

Consolidate duplicated business rules with a single owner (shared validator,
policy, scope, constant). Do NOT abstract a single occurrence, and do NOT
split code merely to satisfy a metric — abstraction must reduce complexity.
