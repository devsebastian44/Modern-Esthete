import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    setupFiles: ['./tests/e2e/setup.ts'],
    environment: 'node',
  },
});
