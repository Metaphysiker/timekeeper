Cypress.Commands.add('signup', (user) => {
  cy.visit('http://localhost:3000/users/sign_up')
  cy.get("[data-cy=form_for_registration]").within(($form) => {
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

Cypress.Commands.add('sign_up_and_go_to_personal_account', (user) => {

  cy.signup(user);

  cy.fixture('locales/de.json').should((de) => {
    cy.contains(de["de"]["personal_account"]).should("be.visible").click();
  });

  cy.get("[data-cy=select_account]").first().click();



})
