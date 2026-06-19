module.exports = {
  env: {
    es6: true,
    node: true,
  },
  parserOptions: {
    "ecmaVersion": 2022,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],

  // original rules
  rules: {
    "no-restricted-globals": ["error", "name", "length"], // Node.js globals are allowed
    "prefer-arrow-callback": "error", // Arrow functions are preferred
    "quotes": ["error", "double", {"allowTemplateLiterals": true}], // Double quotes are preferred

    // new rules
    // configuration of maximum line length
    "max-len": ["error", {"code": 120}],

    // JSDoc active for comments
    "require-jsdoc": "error",

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
