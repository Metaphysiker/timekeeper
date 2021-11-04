Cypress.Commands.add('fill_in_work_time_form', (work_time) => {

  cy.get("[data-cy=work_time_form]").within(($form) => {
    cy.get('#work_time_task').type(work_time["task"]);
    cy.get('#work_time_minutes').type(work_time["minutes"]);
    cy.root().submit()
  })

  cy.fixture('locales/models.de.json').should((de) => {
    cy.contains(de["de"]["activerecord"]["models"]["work_time"]["one"]).should("be.visible").click();
    cy.contains(de["de"]["activerecord"]["attributes"]["work_time"]["work_time_created_successfully"]).should("be.visible").click();
  });

  cy.contains(work_time["task"]).should("be.visible");
  cy.contains(work_time["minutes"]).should("be.visible");

})


Cypress.Commands.add('sign_up_and_go_to_personal_account', () => {

  cy.request('http://localhost:3000/test/create_users');
  cy.request('http://localhost:3000/test/create_accounts');
  cy.request('http://localhost:3000/test/create_work_times');
  cy.request('http://localhost:3000/test/create_work_times_only_json');


  cy.request('http://localhost:3000/test/destroy_all_users')
  cy.request('http://localhost:3000/test/destroy_all_accounts')
  cy.request('http://localhost:3000/test/destroy_all_work_times')

  cy.readFile('cypress/fixtures/users.json').then((users) => {
    cy.signup(users[0]);
  });

  cy.fixture('locales/de.json').should((de) => {
    cy.contains(de["de"]["personal_account"]).should("be.visible").click();
  });
})
