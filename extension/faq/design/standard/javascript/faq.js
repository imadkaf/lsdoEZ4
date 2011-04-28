/* Grouped faq list : show / hide response */

$('.lien-faq').live('click', function () {
	if ($(this).next().hasClass('reponse-faq-fermee')) {
		$(this).addClass('lien-faq-actif');
		$(this).next().removeClass('reponse-faq-fermee').slideDown(500);
	} else {
		$(this).removeClass('lien-faq-actif');
		$(this).next().addClass('reponse-faq-fermee').slideUp(500);
	}
	return false;
});