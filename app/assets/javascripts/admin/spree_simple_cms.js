//= require select2
jQuery(function($) {

	$("#static_page_taxon_ids").on({
		change: function(e){
			$('.select2-search-choice .with-tip').powerTip({
				smartPlacement: true,
				fadeInTime: 50,
				fadeOutTime: 50
			});
		}
	});
	
	$("#post_taxon_ids").on({
		change: function(e){
			$('.select2-search-choice .with-tip').powerTip({
				smartPlacement: true,
				fadeInTime: 50,
				fadeOutTime: 50
			});
		}
	});

	$('.dropdown-toggle').on("click", function(){
		$(this).parent('.dropdown-menu').children('div.dropdown').toggle();
	});
});

$(document).ready(function() {
  if ($("#static_page_taxon_ids").length > 0) {
    $("#static_page_taxon_ids").select2({
      placeholder: Spree.translations.taxon_placeholder,
      multiple: true,
      initSelection: function(element, callback) {
        return $.getJSON(Spree.routes.taxon_search + "?ids=" + (element.val()), null, function(data) {
          return callback(self.cleanTaxons(data));
        });
      },
      ajax: {
        url: Spree.routes.taxon_search,
        datatype: 'json',
        data: function(term, page) {
          return { q: term }
        },
        results: function (data, page) {
          return { results: self.cleanTaxons(data) }
        }
      },
      formatResult: function(taxon) {
        return taxon.pretty_name
      },
      formatSelection: function(taxon) {
        return taxon.pretty_name
      }
    });
  }

  if ($("#post_taxon_ids").length > 0) {
    $("#post_taxon_ids").select2({
      placeholder: Spree.translations.taxon_placeholder,
      multiple: true,
      initSelection: function(element, callback) {
        return $.getJSON(Spree.routes.taxon_search + "?ids=" + (element.val()), null, function(data) {
          return callback(self.cleanTaxons(data));
        });
      },
      ajax: {
        url: Spree.routes.taxon_search,
        datatype: 'json',
        data: function(term, page) {
          return { q: term }
        },
        results: function (data, page) {
          return { results: self.cleanTaxons(data) }
        }
      },
      formatResult: function(taxon) {
        return taxon.pretty_name
      },
      formatSelection: function(taxon) {
        return taxon.pretty_name
      }
    });
  }
});
