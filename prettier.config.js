/** @type {import('prettier').Config} */
module.exports = {
  semi: true,
  trailingComma: 'es5',
  singleQuote: true,
  printWidth: 80,
  tabWidth: 2,
  useTabs: false,
  bracketSpacing: true,
  bracketSameLine: false,
  arrowParens: 'always',
  endOfLine: 'lf',
  plugins: ['@trivago/prettier-plugin-sort-imports'],
  importOrder: [
    '^react',
    '^next',
    '^@supabase',
    '^@prisma',
    '^@/?',
    '^[./]',
  ],
  importOrderSeparation: true,
  importOrderSortSpecifiers: true,
};
