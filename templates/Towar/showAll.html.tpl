{extends file="../tableTemplate.html.tpl"}

{block name=title}Lista towarów{/block}

{block name=thead}
	<th>Nazwa</th>
    <th>Cena(zł)</th>
    <th>Jednostka</th>
    <th>Procent vat</th>
    <th>Dział/Regał/Półka</th>
    <th>Stan magazynowy</th>
    <th>Stan Min/Max</th>
    <th>Stan dysponowany</th>
{/block}
{block name=tbody}
	<td>{$row['Nazwa']}</td>
    <td>{$row['CenaSprzedazy']}</td>
    <td>{$jednostki[$row['IdJednostkaMiary']]['Nazwa']}</td>
    <td>{$row['ProcentVat']}</td>
    <td>{$row['Dzial']}/{$row['Regal']}/{$row['Polka']}</td>
    <td>{$row['StanMagazynowy']}</td>
    <td>{$row['StanMin']}/{$row['StanMax']}</td>
    <td>{$row['StanDysponowany']}</td>
{/block}
{block name=tfoot}
{/block}
{block name=footUrlName}towar{/block}
{block name=footButtonName}Dodaj towar{/block}
