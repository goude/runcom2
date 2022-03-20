local g = vim.g

g.ale_sign_error = '»'
g.ale_sign_warning = '•'
--g.ale_lint_delay = 1000
g.ale_fix_on_save = 1
g.ale_python_flake8_options = '--ignore=E501'
g.ale_fixers = {
  python = {'isort', 'black'},
  html = {'prettier'},
  css = {'prettier', 'stylelint'},
  markdown = {'prettier'},
  javascript = {'eslint', 'prettier'}
}
