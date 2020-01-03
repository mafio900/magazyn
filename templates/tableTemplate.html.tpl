{extends file="./baseTemplate.html.tpl"}
{block name=body}
{if isset($data)}
    <!-- BEGIN TABLE WITH DATA -->
<form action="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=footUrlName}{/block}/usunwiele/" method="post">
<table id="mainTable" class="table text-center text-light">
    <thead>
        <tr>
            <th></th>
            {block name=thead}
            {/block}
            <th class="hidden-print"></th>
        </tr>
    </thead>
    <tbody>
        {foreach $data as $key => $row}
        <tr>
            <td class="text-center"><input type="checkbox" value="{$row['id']}" name="ids[]" /></td>
            {block name=tbody}
            <th></th>
            {/block}
            <td class="buttons"><span class="btn-group">{block name=editButton}<button data-url="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=footUrlName}{/block}/{$row['id']}"
            role="button" type="button" class="edit-button btn btn-primary btn-sm ml-2" title="Pokaż szczegółowe informacje"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>{/block}
            <a href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=footUrlName}{/block}/usun/{$row['id']}"
            role="button" class="btn btn-danger btn-sm"><i class="fa fa-times" aria-hidden="true"></i></a></span></td>
        </tr>
        {/foreach}
    </tbody>
    <tfoot>
        <tr>
            {block name=tfoot}{/block}
        </tr>
    </tfoot>
</table><!-- END TABLE WITH DATA -->
<button type="submit" class="btn btn-danger btn-sm" title="Usuń zaznaczone"><i class="fa fa-times" aria-hidden="true"></i> Usuń zaznaczone</button></br>
</form>
<button data-url="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=footUrlName}{/block}/formularz"
role="button" class="add-button btn btn-primary btn-sm mt-2"><i class="fa fa-plus" aria-hidden="true"></i> {block name=footButtonName}{/block}</button>
{/if}
{include file="./modals/base.html.tpl"}
{/block}
