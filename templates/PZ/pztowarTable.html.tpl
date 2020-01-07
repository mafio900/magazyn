<h2 class="mt-5">Towary</h2>
{if !empty($pztowary)}
<div class="table-responsive tlo">
    <div class="tlo2" style="padding-bottom: 15px;">
<form action="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pztowar/usunwiele/{$data['id']}" method="post">
<table id="mainTable" class="table table-borderless text-center responsive-table border-spacing">
    <thead>
        <tr>
            <th></th>
            <th>Nazwa towaru</th>
            <th>Ilość</th>
            <th>Cena kupna</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        {foreach $pztowary as $id => $pztowar}
            <tr class="table-row">
                <td class="text-center"><input type="checkbox" value="{$id}" name="ids[]" /></td>
                <td>{$towary[$pztowar['IdTowar']]['Nazwa']}</td>
                <td>{$pztowar['Ilosc']}</td>
                <td>{$pztowar['CenaKupna']}</td>
                <td><span class="btn-group">
                    <button type="button" data-url="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pztowar/formedytuj/{$id}"
                    role="button" class="edit-button btn btn-primary btn-sm ml-2"
                    title="Pokaż szczegółowe informacje">
                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                    </button>
                    <a href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pztowar/usun/{$id}"
                        role="button" class="btn btn-danger btn-sm"><i class="fa fa-times" aria-hidden="true"></i></a>
                </span></td>
            </tr>
        {/foreach}
    </tbody>
    <tfoot>
    </tfoot>
</table>
<button type="submit" class="btn btn-danger btn-sm" title="Usuń zaznaczone"><i class="fa fa-times" aria-hidden="true"></i> Usuń zaznaczone</button></br>
</form>
{/if}
<button data-url="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pztowar/formularz/{$data['id']}"
role="button" class="add-button btn btn-primary btn-sm mt-2"><i class="fa fa-plus" aria-hidden="true"></i> Dodaj towar</button>
</div>
</div>
{include file="../modals/base.html.tpl"}
