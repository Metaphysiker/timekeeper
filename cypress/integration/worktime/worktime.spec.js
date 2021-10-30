describe('working_time', () => {

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
        expect(de["de"]["welcome"]).to.exist
        expect(de["de"]["welcome_description"]).to.exist
      })

    })

    it('submits an empty worktime and expects error messages', () => {

      cy.sign_up_and_go_to_personal_account();

      cy.get("[data-cy=work_time_form]").within(($form) => {
        //cy.get('#work_time_task').type(work_time["task"]);
        //cy.get('#work_time_minutes').type(work_time["minutes"]);
        cy.root().submit()
      })

      cy.fixture('locales/models.de.json').should((models_de) => {

        cy.fixture('locales/de.json').should((de) => {
          cy.contains(models_de["de"]["activerecord"]["attributes"]["work_time"]["task"] + " " + de["de"]["errors"]["messages"]["blank"]).should("be.visible");
          cy.contains(models_de["de"]["activerecord"]["attributes"]["work_time"]["minutes"] + " " + de["de"]["errors"]["messages"]["not_a_number"]).should("be.visible");
          cy.contains(models_de["de"]["activerecord"]["attributes"]["work_time"]["minutes"] + " " + de["de"]["errors"]["messages"]["blank"]).should("be.visible");
        })

      });

      cy.logout();

    });

});
