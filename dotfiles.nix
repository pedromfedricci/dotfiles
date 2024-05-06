let
  dotfiles = ./dotfiles;

  forEach = homeFile: module: paths: f:
    if paths == []
    then homeFile
    else let
      path = builtins.head paths;
      rest = builtins.tail paths;
      file = f homeFile module path;
    in
      forEach file module rest f;

  appendHomeRoot = homeFile: module: path: let
    source = module: path: "${dotfiles}/${module}/${path}";
    target = path: "${path}";
    config = {${target path}.source = source module path;};
  in
    homeFile // config;

  appendManyHomeRoot = homeFile: module: paths:
    forEach homeFile module paths appendHomeRoot;

  insertHomeRoot = module: path:
    appendHomeRoot {} module path;

  insertManyHomeRoot = module: paths:
    appendManyHomeRoot {} module paths;

  appendHomeConfig = homeFile: module: path: let
    source = module: path: "${dotfiles}/${module}/.config/${path}";
    target = path: ".config/${path}";
    config = {${target path}.source = source module path;};
  in
    homeFile // config;

  appendManyHomeConfig = homeFile: module: paths:
    forEach homeFile module paths appendHomeConfig;

  insertHomeConfig = module: path:
    appendHomeConfig {} module path;

  insertManyHomeConfig = module: paths:
    appendManyHomeConfig {} module paths;

  appendHomeConfigWithDir = homeFile: module: path: let
    source = module: path: "${dotfiles}/${module}/.config/${module}/${path}";
    target = module: path: ".config/${module}/${path}";
    config = {${target module path}.source = source module path;};
  in
    homeFile // config;

  appendManyHomeConfigWithDir = homeFile: module: paths:
    forEach homeFile module paths appendHomeConfigWithDir;

  insertHomeConfigWithDir = module: path:
    appendHomeConfigWithDir {} module path;

  insertManyHomeConfigWithDir = module: paths:
    appendManyHomeConfigWithDir {} module paths;
in {
  appendHomeRoot = appendHomeRoot;
  appendManyHomeRoot = appendManyHomeRoot;
  insertHomeRoot = insertHomeRoot;
  insertManyHomeRoot = insertManyHomeRoot;

  appendHomeConfig = appendHomeConfig;
  apapendManyHomeConfig = appendManyHomeConfig;
  insertHomeConfig = insertHomeConfig;
  insertManyHomeConfig = insertManyHomeConfig;

  appendHomeConfigWithDir = appendHomeConfigWithDir;
  apapendManyHomeConfigWithDir = appendManyHomeConfigWithDir;
  insertHomeConfigWithDir = insertHomeConfigWithDir;
  insertManyHomeConfigWithDir = insertManyHomeConfigWithDir;
}
