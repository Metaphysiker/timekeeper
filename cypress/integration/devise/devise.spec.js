describe('Devise', () => {

  before(() => {
    cy.request('http://localhost:3000/test/generate_json_of_translation');
    //cy.request('http://localhost:3000/test/destroy_all_users')
  })

  beforeEach(() => {
    //cy.request('http://localhost:3000/test/create_users');
  })

  afterEach(() => {
    //cy.logout();
  })

  it('signs up a new user', () => {
    cy.request('http://localhost:3000/test/create_users');
    cy.request('http://localhost:3000/test/destroy_all_users')

    cy.readFile('cypress/fixtures/users.json').then((users) => {
      cy.signup(users[0]);
    });

    cy.logout()
  })

  it('expects error message when email is empty or if email already exists', () => {
    cy.visit('http://localhost:3000/users/sign_up')
    cy.get("[data-cy=form_for_registration]").within(($form) => {
      cy.root().submit()
    })
    cy.contains('e-Mail muss ausgefüllt werden')
    cy.contains('Passwort muss ausgefüllt werden')

    cy.readFile('cypress/fixtures/users.json').then((users) => {
      cy.login(users[0]);
      cy.logout();

      cy.visit('http://localhost:3000/users/sign_up')

      cy.get("[data-cy=form_for_registration]").within(($form) => {
        cy.get('#user_email').type(users[0]["email"])
        cy.get('#user_password').type("password")
        cy.get('#user_password_confirmation').type("password")
        cy.root().submit()
      })

      cy.contains('e-Mail ist bereits vergeben')

    });
  })

});
