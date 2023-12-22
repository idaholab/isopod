#include "isopodApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
isopodApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  return params;
}

isopodApp::isopodApp(InputParameters parameters) : MooseApp(parameters)
{
  isopodApp::registerAll(_factory, _action_factory, _syntax);
}

isopodApp::~isopodApp() {}

void
isopodApp::registerAll(Factory & f, ActionFactory & af, Syntax & syntax)
{
  ModulesApp::registerAll(f, af, syntax);
  Registry::registerObjectsTo(f, {"isopodApp"});
  Registry::registerActionsTo(af, {"isopodApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
isopodApp::registerApps()
{
  registerApp(isopodApp);
  ModulesApp::registerApps();
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
isopodApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  isopodApp::registerAll(f, af, s);
}
extern "C" void
isopodApp__registerApps()
{
  isopodApp::registerApps();
}
