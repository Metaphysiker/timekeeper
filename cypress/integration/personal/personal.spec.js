describe('welcomes user', () => {

  before(() => {
    cy.visit('http://localhost:3000/test/generate_json_of_translation')
  })

  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    //cy.visit('https://example.cypress.io/todo')
  })

  it('visits welcome page', () => {
    // We use the `cy.get()` command to get all elements that match the selector.
    // Then, we use `should` to assert that there are two matched items,
    // which are the two default items.
      cy.visit('http://localhost:3000/')
      cy.fixture('locales/de.json').should((de) => {
        cy.contains(de["de"]["welcome"]).should("be.visible")
        cy.contains(de["de"]["welcome_description"]).should("be.visible")
      })

    })
});
