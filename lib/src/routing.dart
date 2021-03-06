import 'package:angular_router/angular_router.dart';

import 'package:taco_party/everything.g.dart';

import 'screens/bundle_manager/bundle_manager.template.dart'
    as bundle_manager_template;
import 'screens/home/home.template.dart' as home_template;
import 'screens/sprite_set_editor/sprite_set_editor.template.dart'
    as sprite_set_editor_template;
import 'screens/stage/stage.template.dart' as stage_template;

/*
 supposedly, putting the RoutePaths and RouteDefinitions in the same file is a
 bad idea.

 so I guess I'm about to find out why.
*/

class Routes {
  static final home = RouteDefinition(
    path: "home",
    component: home_template.HomeScreenComponentNgFactory,
    useAsDefault: true,
  );

  static const _stageBundle = "bundle";
  static const _stageSpriteSet = "name";
  static final stage = RouteDefinition(
    path: "stage/:$_stageBundle/:$_stageSpriteSet",
    component: stage_template.StageScreenComponentNgFactory,
  );
  static final stageNoArgs = RouteDefinition(
    path: "stage",
    component: stage_template.StageScreenComponentNgFactory,
  );
  static String stageLink(String bundle, String spriteSet,
          [Map<String, String> queryParameters]) =>
      stage.toUrl({_stageBundle: bundle, _stageSpriteSet: spriteSet});

  static String getStageBundle(Map<String, String> parameters) =>
      normalizeBundleIdentifier(parameters[_stageBundle]);
  static String getStageSpriteSet(Map<String, String> parameters) =>
      parameters[_stageSpriteSet];

  static final spriteSetEditor = RouteDefinition(
    path: "tools/sprite_set_editor",
    component:
        sprite_set_editor_template.SpriteSetEditorScreenComponentNgFactory,
  );

  static final bundleManager = RouteDefinition(
    path: "tools/bundle_manager",
    component: bundle_manager_template.BundleManagerScreenComponentNgFactory,
  );

  static final all = [
    home,
    stage,
    stageNoArgs,
    spriteSetEditor,
    bundleManager,
  ];
}
