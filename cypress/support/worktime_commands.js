Cypress.Commands.add('fill_in_worktime_form', (worktime) => {
  cy.visit('http://localhost:3000/users/sign_up')
  cy.get("[data-cy=new_work_time_form]").within(($form) => {
    cy.get('#user_email').type(user["email"])
    cy.get('#user_password').type("password")
    cy.get('#user_password_confirmation').type("password")
    cy.root().submit()
  })
  cy.contains('Sie haben sich erfolgreich registriert.')

  cy.fixture('locales/de.json').should((de) => {
    cy.contains(de["de"]["logged_in_as"] + " " + user["email"]);
  });
})
