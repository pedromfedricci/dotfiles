let
  insertSource' = homeFile: module: path:
    let
      source = module: path: ./config + "/${module}/.config/${module}/${path}";
      target = module: path: ".config/${module}/${path}";
      config = { ${target module path}.source = source module path; };
    in
      homeFile // config
  ;

  insertSource = module: path:
    insertSource' {} module path
  ;

  insertModule' = homeFile: module: paths:
    if paths == [] then
      homeFile
    else
      let
        path = builtins.head paths;
        rest = builtins.tail paths;
        file = insertSource' homeFile module path;
      in
        insertModule' file module rest
  ;

  insertModule = module: paths:
    insertModule' {} module paths
  ;

in
{
  insertSource = insertSource;
  insertModule = insertModule;
}
