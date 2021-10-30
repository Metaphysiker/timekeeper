describe('welcomes user', () => {

  before(() => {
    cy.visit('http://localhost:3000/test/generate_json_of_translation')
  })

  beforeEach(() => {

  })

  it('signs up and records working hours', () => {

    cy.request('http://localhost:3000/test/create_users');
    cy.request('http://localhost:3000/test/create_accounts');
    cy.request('http://localhost:3000/test/create_work_times');

    cy.request('http://localhost:3000/test/destroy_all_users')
    cy.request('http://localhost:3000/test/destroy_all_accounts')
    cy.request('http://localhost:3000/test/destroy_all_work_times')

    cy.readFile('cypress/fixtures/users.json').then((users) => {
      cy.signup(users[0]);
    });

    cy.fixture('locales/de.json').should((de) => {
      cy.contains(de["de"]["personal_account"]).should("be.visible").click();
    });

    //cy.readFile('cypress/fixtures/work_times.json').then((work_times) => {
    //  cy.fill_in_work_time_form(work_times[0]);
    //});

    cy.readFile('cypress/fixtures/work_times.json').then((work_times) => {
      for (var index = 0; index < work_times.length; index++) {
        cy.fill_in_work_time_form(work_times[index]);      }
    });



    cy.logout()

    })
});
