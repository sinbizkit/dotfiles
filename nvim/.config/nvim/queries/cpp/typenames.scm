[
(function_definition
  declarator: (function_declarator
		declarator: (qualified_identifier
			      scope: (namespace_identifier) @typename)))

(class_specifier
  name: (type_identifier) @typename
  body: (field_declaration_list))

(struct_specifier
  name: (type_identifier) @typename
  body: (field_declaration_list))
]
