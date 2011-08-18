{*Affichage bloc maree*}
{def $tabMaree = file_get_contents('http://www.horaire-maree.fr/widget_data.php?port=LES_SABLES-D_OLONNE')}
{set $tabMaree = $tabMaree|explode(';')}
<div class="maree">
	<table>
		<thead>
			<tr>
				<th class="taille">Pleine Mer</th>
				<th class="taille">Basse Mer</th>
				<th class="vert">Coef</th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td class="taille">Matin : {$tabMaree.1}</td>
				<td class="taille">Matin : {$tabMaree.2}</td>
				<td class="centre vert">{$tabMaree.0}</td>
			</tr>
			<tr>
				<td class="taille">Soir : {$tabMaree.4}</td>
				<td class="taille">Soir : {$tabMaree.5}</td>
				<td class="centre vert">{$tabMaree.3}</td>
			</tr>
		</tbody>
		
		<tfoot>
			<tr>
				<th colspan="3"><a href="http://www.horaire-maree.fr/maree/LES_SABLES-D_OLONNE/" target="blank">http://www.horaire-maree.fr</a></th>
			</tr>
		</tfoot>
	</table>
</div>