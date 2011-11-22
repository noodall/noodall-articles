function categoriesAutocomplete() {
  formFieldAutocomplete('/admin/categories.json', "input.categories-completer");
};

$(function() {
  categoriesAutocomplete();
});