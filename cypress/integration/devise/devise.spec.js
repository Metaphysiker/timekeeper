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

});
