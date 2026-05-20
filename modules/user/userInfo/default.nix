{ lib, ... }:

# INFO: defines home-manager's user definition

{
  options = {
    userSettings = {
      name = lib.mkOption {
        default = "";
        description = "User full name";
        type = lib.types.str;
      };
      userEmail = lib.mkOption {
        default = "";
        description = "User email";
        type = lib.types.str;
      };
    };
  };
}
