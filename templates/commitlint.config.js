// Conventional Commits for strict-code. Install at the project root and wire
// templates/hooks/commit-msg (or an equivalent CI check).
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      ['build', 'chore', 'ci', 'docs', 'feat', 'fix', 'perf', 'refactor', 'revert', 'style', 'test'],
    ],
    'header-max-length': [2, 'always', 72],
    'subject-full-stop': [2, 'never', '.'],
    // pt-BR descriptions break the English casing rules; length still applies.
    'subject-case': [0],
  },
};
