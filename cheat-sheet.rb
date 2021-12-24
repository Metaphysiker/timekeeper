//edits categories
cy.readFile('cypress/fixtures/categories_second_batch.json').then((new_categories) => {
  for (var index = 0; index < categories.length; index++) {
    cy.edit_category(categories[index], new_categories[index]);
  }

  //deletes categories
  for (var index = 0; index < categories.length; index++) {
    cy.delete_category(new_categories[index]);
  }
});
