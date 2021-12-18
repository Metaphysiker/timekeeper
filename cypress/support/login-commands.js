Cypress.Commands.add('login', (user) => {
  cy.visit('http://localhost:3000/users/sign_in')
  cy.get("[data-cy=form_for_login]").within(($form) => {
    cy.get('#user_email').type(user["email"])
    cy.get('#user_password').type("password")
    cy.root().submit()
  })
  cy.contains('Erfolgreich angemeldet.')

  cy.fixture('locales/de.json').should((de) => {
    cy.contains(de["de"]["logged_in_as"] + " " + user["email"]);
  });
})

Cypress.Commands.add('logout', () => {
  cy.get("[data-cy=logout]").click();
  cy.contains('Erfolgreich abgemeldet.');
})
