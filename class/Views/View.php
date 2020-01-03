<?php
namespace Views;
use \Smarty;

/**
* abstrakcyjna klasa widoku
*/
abstract class View
{
    /**
    * szablon widoku
    */
    protected $template;

    /**
    * referencja do obiektu smarty
    */
    protected $smarty;

    /**
    * kolekcja plików js
    */
    protected $js = array();

    /**
    * kolekcja plików CSS
    */
    protected $css = array();

    /**
    * kolekcja globalnych plików dołączanych do każdego szablonu
    */
    protected $globalJS = array('external/jquery', 'external/jquery-ui', 'external/popper', 'external/bootstrap');
    protected $globalCSS = array('external/bootstrap', 'external/jquery-ui', 'external/font-awesome', 'custom');

    public function  __construct($name)
    {
        $this->smarty = new Smarty();
        $this->set('active', $name);
        $this->set('subdir', '/'.\Config\Application\Config::$subdir);
        $this->set('protocol', \Config\Application\Config::$protocol);
    }

    /**
    * ustawienie szablonu
    * @param  $name - nazwa szablonu
    */
    public function setTemplate($name)
    {
	    $path='./templates/'; //DIRECTORY_SEPARATOR
        $path.=$name.'.html.tpl';
        $this->template = $path;
    }

    /**
    * rederowanie szablonu
    */
    public function render()
    {
        if(!isset($this->template)) {
        	throw new \Exceptions\TemplateNotFound();
        }
        $this->set('jsFile', $this->js);
        $this->set('cssFile', $this->css);
        //d($this->template);
        try {
        	if(is_file($this->template)) {
        		$this->smarty->display($this->template);
            } else {
	             throw new \Exceptions\TemplateNotFound(null, $this->template);
        	}
        }
        catch(\Exception $e) {
        	throw new \Exceptions\TemplateNotFound($e, $this->template);
        }
    }

    /**
    * zwrócenie danych w formacie JSON
    * @param array $data dane w postaci tablicy asocjacyjnej
    */
    public function renderJSON($data)
    {
        echo json_encode($data);
    }

    /**
    * skojarzenie zmiennej dla widoku
    * @param String $name nazwa zmiennej
    * @param mixed $value wartość
    */
    public function set($name, $value)
    {
        $this->smarty->assign($name, $value);
    }

    /**
    * pobranie zmiennej widoku
    * @param String $name nazwa zmiennej
    */
    public function get($name)
    {
        return $this->smarty->get_template_vars($name);
    }

    /**
    * skojarzenie kolekcji zmiennych
    * @param array $data tablica zmiennych - klucz to nazwa zmiennej
    */
    public function setData($data)
    {
        if(isset($data) && is_array($data))
        foreach ($data as $key => $value)
          $this->set($key, $value);
    }

    //Funkcje obsługi zasobów JS/CSS
    public function setAssets()
    {
        foreach ($this->globalJS as $file)
            $this->addJSFile($file);

        foreach ($this->globalCSS as $file)
            $this->addCSSFile($file);
    }

    public function addJSFile($file)
    {
        if(file_exists('./js/'.$file.'.js'))
            $this->js[] = $file.'.js';
        else if(file_exists('./js/'.$file.'.min.js'))
            $this->js[] = $file.'.min.js';
    }

    public function addJSSet($files)
    {
        foreach($files as $file)
            $this->addJSFile($file);
    }

    public function addCSSFile($file)
    {
        if(file_exists('./css/'.$file.'.css'))
            $this->css[] = $file.'.css';
        else if(file_exists('./css/'.$file.'.min.css'))
            $this->css[] = $file.'.min.css';
    }

    public function addCSSSet($files)
    {
        foreach($files as $file)
            $this->addCSSFile($file);
    }
}
