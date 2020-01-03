    <!-- FOOTER -->
    {block name=footer}
        <footer class="footer mt-auto py-3">
            <div class="container text-center">
                <span class="text-muted">Projekt Magazyn stworzony przez Bartosz Brzychciński, Szymon Flas, Kacper Klimaszewski, Ewelina Kłobut</span>
            </div>
        </footer>
        {/block}
        {block name=javascript}
            {if isset($jsFile)}
                {foreach $jsFile as $script}
                    <script src="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}js/{$script}"></script>
                {/foreach}
            {/if}
    {/block}
    </body>
</html>
