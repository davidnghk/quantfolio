var init_vehicle_lookup ;

init_vehicle_lookup = function() {
		
	$('#vehicle-lookup-form').on('ajax:success', function(event, data, status) {
		$('#vehicle-lookup-results').replaceWith(data);
		$('#vehicle-lookup-errors').replaceWith('Stock was found.');
		init_vehicle_lookup();
	});

	$('#vehicle-lookup-form').on('ajax:error', function(event, xhr, status, error){ 
		$('#vehicle-lookup-results').replaceWith(' ');
		$('#vehicle-lookup-errors').replaceWith('Stock was not found.');
	}) ;
}

$(document).ready(function() {
	init_vehicle_lookup(); 
})
