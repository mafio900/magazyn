{extends file="./baseTemplate.html.tpl"}

{block name=title}Formularz{/block}
{block name=body}
    <form id="formularz" class="form-horizontal col-12" action="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=action}{/block}" method="post">
        <div class="panel panel-default">
            <div class="panel-body">
                {block name=formBody}{/block}
            </div>
            <div class="panel-footer text-center text-md-left">
                <button id="submit-button" type="submit" class="btn btn-success">{block name=submitName}{/block}</button>
                <a href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=where}{/block}/" role="button" class="btn btn-primary">Cofnij</a>
            </div>
        </div>
    </form>
    {block name=rezusl}{/block}
{/block}
