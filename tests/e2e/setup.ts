// ==========================================
// tests/e2e/setup.ts
// E2E Testing Environment Configuration
// ==========================================

import { beforeAll, afterAll } from 'vitest';

/**
 * Mocks the Supabase environment for CI testing.
 * This file is used for testing the application logic locally or in CI.
 */

beforeAll(() => {
    // Setup test environment variables
    process.env.DATABASE_URL = 'postgresql://postgres:postgres@localhost:5432/test_db';
    console.log('[Test Setup] Initializing synthetic test database...');
});

afterAll(() => {
    console.log('[Test Teardown] Cleaning up testing resources...');
});
