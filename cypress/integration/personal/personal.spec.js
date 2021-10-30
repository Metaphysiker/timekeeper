describe('welcomes user', () => {

  before(() => {
    cy.visit('http://localhost:3000/test/generate_json_of_translation')
  })

  beforeEach(() => {

  })

  it('signs up and records working hours', () => {

    cy.sign_up_and_go_to_personal_account();

    //cy.readFile('cypress/fixtures/work_times.json').then((work_times) => {
    //  cy.fill_in_work_time_form(work_times[0]);
    //});

    cy.readFile('cypress/fixtures/work_times.json').then((work_times) => {
      for (var index = 0; index < work_times.length; index++) {
        cy.fill_in_work_time_form(work_times[index]);      }
    });

    cy.logout();

    })
});
