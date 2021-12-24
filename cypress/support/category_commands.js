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

Cypress.Commands.add('edit_work_time', (old_work_time, work_time) => {

  var date_regex = /\d\d\d\d-\d\d-\d\d/gm
  var extracted_date = work_time.datetime.match(date_regex)[0];

  cy.contains(old_work_time["task"]).should("be.visible").parent().within(($parent) => {
    cy.get("[data-cy=edit_work_time]").click();
  })

    cy.get("[data-cy=work_time_form]").within(($form) => {
      cy.get('#work_time_task').clear().type(work_time["task"]);
      cy.get('#work_time_minutes').clear().type(work_time["minutes"]);
      cy.get('#work_time_datetime_3i').select(Number(extracted_date.split("-")[2]).toString());
      cy.get('#work_time_datetime_2i').select(Number(extracted_date.split("-")[1]).toString());
      cy.get('#work_time_datetime_1i').select(Number(extracted_date.split("-")[0]).toString());
      cy.get('#work_time_categories_' + [Object.keys(work_time["categories"])[0]]).select(work_time["categories"][Object.keys(work_time["categories"])[0]]);

      //cy.get('#work_time_categories_' + [Object.keys(work_time["categories"])[0]]).clear().type(work_time["categories"][Object.keys(work_time["categories"])[0]]);
      cy.root().submit()
    })

  cy.fixture('locales/models.de.json').should((de) => {
    cy.contains(de["de"]["activerecord"]["models"]["work_time"]["one"]).should("be.visible").click();
    cy.contains(de["de"]["activerecord"]["attributes"]["work_time"]["work_time_updated_successfully"]).should("be.visible").click();
  });

  cy.contains(work_time["task"]).should("be.visible").parent().within(($parent) => {
    cy.contains(work_time["minutes"]).should("be.visible");
    cy.contains(extracted_date.split("-")[2]).should("be.visible");
    cy.contains(extracted_date.split("-")[1]).should("be.visible");
    cy.contains(extracted_date.split("-")[0]).should("be.visible");
    cy.contains(work_time["categories"][Object.keys(work_time["categories"])[0]]).should("be.visible");
  })
})

Cypress.Commands.add('delete_work_time', (work_time) => {

  cy.contains(work_time["task"]).should("be.visible").parent().within(($parent) => {
    cy.get("[data-cy=delete_work_time]").click();
  })

  cy.fixture('locales/models.de.json').should((de) => {
    cy.contains(de["de"]["activerecord"]["attributes"]["work_time"]["work_time_destroyed_successfully"]).should("be.visible");
  });

  cy.contains(work_time["task"]).should('not.exist');

})
