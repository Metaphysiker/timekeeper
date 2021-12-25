Cypress.Commands.add('fill_in_category_form', (category) => {

  cy.get("[data-cy=category_form]").within(($form) => {
    cy.get('#category_name').clear().type(category["name"]);
    cy.root().submit()
  })

  cy.fixture('locales/models.de.json').should((de) => {
    cy.contains(de["de"]["activerecord"]["models"]["category"]["one"]).should("be.visible").click();
    cy.contains(de["de"]["activerecord"]["attributes"]["category"]["category_created_successfully"]).should("be.visible").click();
  });

  cy.contains(category["name"]).should("be.visible").parent().within(($parent) => {

  })
})

Cypress.Commands.add('edit_category', (old_category, category) => {


  cy.contains(old_category["name"]).should("be.visible").parent().within(($parent) => {
    cy.get("[data-cy=edit_category]").click({force: true});
  })

    cy.get("[data-cy=category_form]").within(($form) => {
      cy.get('#category_name').clear().type(category["name"]);
      //cy.get('#work_time_categories_' + [Object.keys(work_time["categories"])[0]]).clear().type(work_time["categories"][Object.keys(work_time["categories"])[0]]);
      cy.root().submit()
    })

    cy.fixture('locales/models.de.json').should((de) => {
      cy.contains(de["de"]["activerecord"]["models"]["category"]["one"]).should("be.visible").click();
      cy.contains(de["de"]["activerecord"]["attributes"]["category"]["category_updated_successfully"]).should("be.visible").click();
    });

    cy.contains(category["name"]).should("be.visible").parent().within(($parent) => {

    })
})

Cypress.Commands.add('delete_category', (work_time) => {

  cy.contains(work_time["task"]).should("be.visible").parent().within(($parent) => {
    cy.get("[data-cy=delete_work_time]").click();
  })

  cy.fixture('locales/models.de.json').should((de) => {
    cy.contains(de["de"]["activerecord"]["attributes"]["work_time"]["work_time_destroyed_successfully"]).should("be.visible");
  });

  cy.contains(work_time["task"]).should('not.exist');

})
