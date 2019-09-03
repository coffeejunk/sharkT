jQuery(document).on('turbolinks:load', function() {
  if (!checkController('pages')) {
    return;
  }

  runSelect2('species');

  $('#species').on('select2:select', function (e) {
    var data = e.params.data;
    Turbolinks.visit('/species/' + data.id);
  });

  $('#trait_search').select2();

  $('#trait_search').on('select2:select', function (e) {
    var data = e.params.data;
    Turbolinks.visit('/traits/' + data.id);
  });
});
