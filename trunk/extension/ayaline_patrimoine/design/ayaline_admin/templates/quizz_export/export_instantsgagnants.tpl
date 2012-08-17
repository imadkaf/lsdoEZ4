<h1>Instants Gagnants</h1>
<div id="quizzcontent">
    <div class="container-bloc-quizz">
        <h2>Export des Instants Gagnants</h2>
        <form action="" method="post">
            <div class="ligne-form">
                <label>Entre le : <input type="text" name="date_deb" class="date_deb" id="quizz_export_instantsgagnants_date_deb"/>&nbsp;<img class="datepicker-icon" src="{'images/calendar_icon.png'|ezdesign('no')}" /></label>&nbsp;&nbsp;
                <label>et le : <input type="text" name="date_fin" class="date_fin" id="quizz_export_instantsgagnants_date_fin"/>&nbsp;<img class="datepicker-icon" src="{'images/calendar_icon.png'|ezdesign('no')}" /></label>&nbsp;&nbsp;
                <input class="button" type="submit" name="export_quizz_instantsgagnants" value="Télécharger"/>
            </div>
        </form>
    </div>
    <div class="container-bloc-quizz generate_instantsgagnants">
        <h2>Génération aléatoire de nouveaux Instants Gagnants</h2>
        <form action="" method="post">
            <div class="ligne-form">
                <label>Entre le : <input type="text" name="date_deb" class="date_deb" id="quizz_generate_instantsgagnants_date_deb"/>&nbsp;<img class="datepicker-icon" src="{'images/calendar_icon.png'|ezdesign('no')}" /></label>&nbsp;&nbsp;
                <label>et le : <input type="text" name="date_fin" class="date_fin" id="quizz_generate_instantsgagnants_date_fin"/>&nbsp;<img class="datepicker-icon" src="{'images/calendar_icon.png'|ezdesign('no')}" /></label>&nbsp;&nbsp;
            </div>
            <div class="ligne-form">
                <label>Nombre des Instants Gagnants à générer pour cette période : <input type="text" name="nombre" size="5"/></label>
                <input class="button" type="submit" name="generer_quizz_instantsgagnants"  value="Générer"/>
            </div>
        </form>
    </div>
</div>
{*getlist_instantsgagnants()|attribute(show)*}
<script>
    {def $listInstantsGagnants = getlist_instantsgagnants()}
        {concat('var unavailableDates = [')}
        {foreach $listInstantsGagnants as $keyInst=>$instantsGagnants}
            {def $dateInstantG = $instantsGagnants.date_heure}
            {set $dateInstantG = $dateInstantG|explode(' ')}
            {set $dateInstantG = $dateInstantG[0]}
            {set $dateInstantG = $dateInstantG|explode('-')}
            
            {concat('"',$dateInstantG[2],'-',$dateInstantG[1]|int,'-',$dateInstantG[0],'"')}
            {if $keyInst|ne($listInstantsGagnants|count|sub(1))}
                {concat(',')}
            {/if}
            {undef $dateInstantG}
        {/foreach}
        {concat('];')}
    {literal}
        /* script date picker pour Génération des instants gagnants */
        //var unavailableDates = ["29-8-2012","25-8-2012","23-8-2012"];
        function unavailable(date) {
            dmy = date.getDate() + "-" + (date.getMonth()+1) + "-" + date.getFullYear();
            if ($.inArray(dmy, unavailableDates) < 0) {
                return [true,"",""];
            } else {
                return [false,"","Il y'a déjà un instant gagnant dans cette date"];
            }
        }
        $("#quizzcontent .container-bloc-quizz.generate_instantsgagnants .ligne-form").each(function(){
            var eDateDeb = $(this).find(".date_deb");
            var eDateFin = $(this).find(".date_fin");


            var dates = $( "#" +eDateDeb.attr('id')+ ", #" +eDateFin.attr('id')).datepicker({
                defaultDate: "+1w",
                minDate: new Date(),
                changeMonth: true,
                dateFormat: "yy-mm-dd",
                numberOfMonths: 1,
                beforeShowDay: unavailable,
                onSelect: function( selectedDate ) {
                    var option = this.id == eDateDeb.attr('id') ? "minDate" : "maxDate",
                    instance = $( this ).data( "datepicker" ),
                    date = $.datepicker.parseDate(
                        instance.settings.dateFormat ||
                        $.datepicker._defaults.dateFormat,
                        selectedDate, instance.settings );
                    dates.not( this ).datepicker( "option", option, date );
                }
            }).datepicker( $.datepicker.regional[ "fr" ] );

        });
        /* script date picker pour exportation CSV */
        $("#quizzcontent .container-bloc-quizz .ligne-form").each(function(){
            if(!$(this).parents(".container-bloc-quizz").is(".generate_instantsgagnants")){
                
                var eDateDeb = $(this).find(".date_deb");
                var eDateFin = $(this).find(".date_fin");


                var dates = $( "#" +eDateDeb.attr('id')+ ", #" +eDateFin.attr('id')).datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    dateFormat: "yy-mm-dd",
                    numberOfMonths: 1,
                    onSelect: function( selectedDate ) {
                        var option = this.id == eDateDeb.attr('id') ? "minDate" : "maxDate",
                        instance = $( this ).data( "datepicker" ),
                        date = $.datepicker.parseDate(
                            instance.settings.dateFormat ||
                            $.datepicker._defaults.dateFormat,
                            selectedDate, instance.settings );
                        dates.not( this ).datepicker( "option", option, date );
                    }
                }).datepicker( $.datepicker.regional[ "fr" ] );
                 
            }
            

        });
    {/literal}
        {undef $listInstantsGagnants}
</script>