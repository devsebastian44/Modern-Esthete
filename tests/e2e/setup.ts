// ==========================================
// tests/e2e/setup.ts
// E2E Testing Environment Configuration
// ==========================================

import { beforeAll, afterAll } from 'vitest';

/**
 * Mocks the Supabase environment for CI testing.
 * This file is part of the private GitLab environment and is removed 
 * automatically by the DevSecOps pipeline before publishing to GitHub.
 */

beforeAll(() => {
    // Setup test environment variables
    process.env.DATABASE_URL = 'postgresql://postgres:postgres@localhost:5432/test_db';
    console.log('[Test Setup] Initializing synthetic test database...');
});

afterAll(() => {
    console.log('[Test Teardown] Cleaning up testing resources...');
});
