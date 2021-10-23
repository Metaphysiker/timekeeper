describe('welcomes user', () => {

  before(() => {
    cy.visit('http://localhost:3000/test/generate_json_of_translation')
  })

  beforeEach(() => {

  })

  it('signs up and records working hours', () => {

    cy.request('http://localhost:3000/test/create_users');
    cy.request('http://localhost:3000/test/destroy_all_users')

    cy.readFile('cypress/fixtures/users.json').then((users) => {
      cy.signup(users[0]);
    });

//    cy.fixture('locales/de.json').should((de) => {
//      cy.contains(de["de"]["welcome"]).should("be.visible")
//      cy.contains(de["de"]["welcome_description"]).should("be.visible")
//    })

    cy.logout()

    })
});
