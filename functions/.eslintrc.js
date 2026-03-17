module.exports = {
  env: {
    es2022: true,
    node: true,
  },
  parserOptions: {
    "ecmaVersion": 2022,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    "no-restricted-globals": ["error", "name", "length"],
    "prefer-arrow-callback": "error",
    "quotes": ["error", "double", {"allowTemplateLiterals": true}],
    "max-len": ["warn", {"code": 150}],
    "require-jsdoc": "off",
    "valid-jsdoc": "off",
    "object-curly-spacing": "off",
    "indent": ["error", 2, {"SwitchCase": 1}],
    "comma-dangle": ["error", "always-multiline"],
    "no-trailing-spaces": "off",
    "camelcase": "off",
    "no-unused-vars": ["error", {"argsIgnorePattern": "^_"}],
  },
  overrides: [
    {
      files: ["**/*.spec.*"],
      env: {
        mocha: true,
      },
      rules: {},
    },
  ],
  globals: {},
};
