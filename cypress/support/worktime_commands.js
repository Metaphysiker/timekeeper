Cypress.Commands.add('fill_in_work_time_form', (work_time) => {

  var date_regex = /\d\d\d\d-\d\d-\d\d/gm
  var extracted_date = work_time.datetime.match(date_regex)[0];

  cy.get("[data-cy=work_time_form]").within(($form) => {
    cy.get('#work_time_task').clear().type(work_time["task"]);
    cy.get('#work_time_minutes').clear().type(work_time["minutes"]);
    cy.get('#work_time_datetime_3i').select(Number(extracted_date.split("-")[2]).toString());
    cy.get('#work_time_datetime_2i').select(Number(extracted_date.split("-")[1]).toString());
    cy.get('#work_time_datetime_1i').select(Number(extracted_date.split("-")[0]).toString());
    cy.readFile('cypress/fixtures/categories_first_batch.json').then((categories) => {
      cy.readFile('cypress/fixtures/select_options_first_batch.json').then((select_options) => {

      for (var cat_index = 0; cat_index < categories.length; cat_index++) {
          cy.get('#work_time_categories_' + categories[cat_index].name).select(select_options[cat_index].name);
        }
      })
    })

    //cy.get('#work_time_categories_' + [Object.keys(work_time["categories"])[0]]).select(work_time["categories"][Object.keys(work_time["categories"])[0]]);
    //cy.get('#work_time_categories_' + [Object.keys(work_time["categories"])[0]]).clear().type(work_time["categories"][Object.keys(work_time["categories"])[0]]);
    cy.root().submit()
  })

  cy.fixture('locales/models.de.json').should((de) => {
    cy.contains(de["de"]["activerecord"]["models"]["work_time"]["one"]).should("be.visible").click();
    cy.contains(de["de"]["activerecord"]["attributes"]["work_time"]["work_time_created_successfully"]).should("be.visible").click();
  });

  cy.contains(work_time["task"]).should("be.visible").parent().within(($parent) => {
    cy.contains(work_time["minutes"]).should("be.visible");
    cy.contains(extracted_date.split("-")[2]).should("be.visible");
    cy.contains(extracted_date.split("-")[1]).should("be.visible");
    cy.contains(extracted_date.split("-")[0]).should("be.visible");
    //cy.contains(work_time["categories"][Object.keys(work_time["categories"])[0]]).should("be.visible");

    cy.readFile('cypress/fixtures/categories_first_batch.json').then((categories) => {
      cy.readFile('cypress/fixtures/select_options_first_batch.json').then((select_options) => {

      for (var cat_index = 0; cat_index < categories.length; cat_index++) {
        var category_name = categories[cat_index].name;
        var select_option_name = select_options[cat_index].name;

        cy.get("[data-category=" + category_name + "]").contains(select_option_name).should("be.visible");

        }
      })
    })

  })
})

Cypress.Commands.add('edit_work_time', (old_work_time, work_time) => {

  var date_regex = /\d\d\d\d-\d\d-\d\d/gm
  var extracted_date = work_time.datetime.match(date_regex)[0];

  cy.contains(old_work_time["task"]).should("be.visible").parent().within(($parent) => {
    cy.get("[data-cy=edit_work_time]").click();
  })

    cy.get("[data-cy=work_time_form]").within(($form) => {
      cy.get('#work_time_task').clear().type(work_time["task"]);
      cy.get('#work_time_minutes').clear().type(work_time["minutes"]);
      cy.get('#work_time_datetime_3i').select(Number(extracted_date.split("-")[2]).toString());
      cy.get('#work_time_datetime_2i').select(Number(extracted_date.split("-")[1]).toString());
      cy.get('#work_time_datetime_1i').select(Number(extracted_date.split("-")[0]).toString());
      //cy.get('#work_time_categories_' + [Object.keys(work_time["categories"])[0]]).select(work_time["categories"][Object.keys(work_time["categories"])[0]]);

      cy.readFile('cypress/fixtures/categories_first_batch.json').then((categories) => {
        cy.readFile('cypress/fixtures/select_options_first_batch.json').then((select_options) => {

        for (var cat_index = 0; cat_index < categories.length; cat_index++) {
          cy.log(cat_index);
          //selects next option: (cat_index + 1) % select_options.length
            cy.get('#work_time_categories_' + categories[cat_index].name).select(select_options[(cat_index + 1) % select_options.length].name);
          }
        })
      })

      //cy.get('#work_time_categories_' + [Object.keys(work_time["categories"])[0]]).clear().type(work_time["categories"][Object.keys(work_time["categories"])[0]]);
      cy.root().submit()
    })

  cy.fixture('locales/models.de.json').should((de) => {
    cy.contains(de["de"]["activerecord"]["models"]["work_time"]["one"]).should("be.visible").click();
    cy.contains(de["de"]["activerecord"]["attributes"]["work_time"]["work_time_updated_successfully"]).should("be.visible").click();
  });

  cy.contains(work_time["task"]).should("be.visible").parent().within(($parent) => {
    cy.contains(work_time["minutes"]).should("be.visible");
    cy.contains(extracted_date.split("-")[2]).should("be.visible");
    cy.contains(extracted_date.split("-")[1]).should("be.visible");
    cy.contains(extracted_date.split("-")[0]).should("be.visible");
    //cy.contains(work_time["categories"][Object.keys(work_time["categories"])[0]]).should("be.visible");

    cy.readFile('cypress/fixtures/categories_first_batch.json').then((categories) => {
      cy.readFile('cypress/fixtures/select_options_first_batch.json').then((select_options) => {

      for (var cat_index = 0; cat_index < categories.length; cat_index++) {
        var category_name = categories[cat_index].name;
        var select_option_name = select_options[(cat_index + 1) % select_options.length].name;

        cy.get("[data-category=" + category_name + "]").contains(select_option_name).should("be.visible");

        }
      })
    })

  })
})

Cypress.Commands.add('delete_work_time', (work_time) => {

  cy.contains(work_time["task"]).should("be.visible").parent().within(($parent) => {
    cy.get("[data-cy=delete_work_time]").click();
  })

  cy.fixture('locales/models.de.json').should((de) => {
    cy.contains(de["de"]["activerecord"]["attributes"]["work_time"]["work_time_destroyed_successfully"]).should("be.visible");
  });

  cy.contains(work_time["task"]).should('not.exist');

})
