describe('welcomes user', () => {

  before(() => {
    cy.visit('http://localhost:3000/test/generate_json_of_translation')
  })

  beforeEach(() => {
    cy.request('http://localhost:3000/test/destroy_all_users')
    cy.request('http://localhost:3000/test/destroy_all_accounts')
    cy.request('http://localhost:3000/test/destroy_all_work_times')
    cy.request('http://localhost:3000/test/destroy_all_categories')
    cy.request('http://localhost:3000/test/destroy_all_select_options')

    cy.request('http://localhost:3000/test/create_users_only_json/users_only_json')

    cy.request('http://localhost:3000/test/create_work_times_only_json/work_times_first_batch')
    cy.request('http://localhost:3000/test/create_work_times_only_json/work_times_second_batch')

    cy.request('http://localhost:3000/test/create_categories_only_json/categories_first_batch')
    cy.request('http://localhost:3000/test/create_categories_only_json/categories_second_batch')

    cy.request('http://localhost:3000/test/create_select_options_only_json/select_options_first_batch')
    cy.request('http://localhost:3000/test/create_select_options_only_json/select_options_second_batch')
  })

  it('signs up, records working hours and edits them', () => {

    cy.readFile('cypress/fixtures/users_only_json.json').then((users) => {
      cy.sign_up_and_go_to_personal_account(users[0]);
    });

    //cy.readFile('cypress/fixtures/work_times.json').then((work_times) => {
    //  cy.fill_in_work_time_form(work_times[0]);
    //});

    cy.readFile('cypress/fixtures/categories_first_batch.json').then((categories) => {
        //creates categories
        cy.get("[data-cy=manage_categories]").click();
        for (var index = 0; index < categories.length; index++) {
          cy.fill_in_category_form(categories[index]);

              cy.readFile('cypress/fixtures/select_options_first_batch.json').then((select_options) => {
                for (var inner_index = 0; inner_index < select_options.length; inner_index++) {
                  cy.fill_in_select_option_form(select_options[inner_index]);
                }
              });
        }
      cy.get("[data-cy=back]").click();
    });

    cy.readFile('cypress/fixtures/work_times_first_batch.json').then((work_times) => {
      //creates work_times
      for (var index = 0; index < work_times.length; index++) {
        cy.fill_in_work_time_form(work_times[index]);
      }

      //edits work_times
      cy.readFile('cypress/fixtures/work_times_second_batch.json').then((new_work_times) => {
        for (var index = 0; index < work_times.length; index++) {
          cy.edit_work_time(work_times[index], new_work_times[index]);
        }

        //deletes work_times
        for (var index = 0; index < work_times.length; index++) {
          cy.delete_work_time(new_work_times[index]);
        }


      });

    });

    cy.logout();

    })
});
