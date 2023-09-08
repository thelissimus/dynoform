module.exports = {
	root: true,
	env: { browser: true, es2020: true },
	parserOptions: {
		ecmaVersion: "latest",
		sourceType: "module",
		project: ["./tsconfig.json", "./tsconfig.node.json"],
		tsconfigRootDir: __dirname,
	},
	extends: [
		"eslint:recommended",
		"plugin:@typescript-eslint/strict-type-checked",
		"plugin:@typescript-eslint/stylistic-type-checked",
		"plugin:react-hooks/recommended",
	],
	ignorePatterns: ["dist", ".eslintrc.cjs"],
	parser: "@typescript-eslint/parser",
	plugins: ["react-refresh"],
	rules: {
		"react-refresh/only-export-components": ["warn", { allowConstantExport: true }],
		quotes: ["warn", "double"],
		semi: ["warn", "always"],
		"linebreak-style": ["error", "unix"],
		"eol-last": "error",
		"@typescript-eslint/no-unused-vars": [
			"error",
			{
				argsIgnorePattern: "^_",
				varsIgnorePattern: "^_",
				caughtErrorsIgnorePattern: "^_",
			},
		],
		// todo: remove for stricter type checking
		"@typescript-eslint/no-non-null-assertion": ["off"],
		"@typescript-eslint/prefer-nullish-coalescing": ["off"],
		"@typescript-eslint/no-unnecessary-condition": ["off"],
	},
};
