

abstract class  RolesConstants {
  static String manager() => "manager";
  static  String customer() => "customer";
  static String salePerson() => "sale-person";
  static String invetoryPerson() => "inventory-specialist";
}

Map<String, String> roleSpanish = {
  RolesConstants.customer(): "Cliente",
  RolesConstants.invetoryPerson(): "Especialista de Inventario",
  RolesConstants.manager(): "Administrador",
  RolesConstants.salePerson(): "Vendedor",
};

