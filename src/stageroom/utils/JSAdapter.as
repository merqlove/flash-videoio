/**
 * Created by mrcr on 11.04.16.
 */
package stageroom.utils {
import flash.external.ExternalInterface;
import flash.system.Security;

import mx.core.FlexGlobals;

public class JSAdapter {

    private static var instance :JSAdapter = new JSAdapter();

    public static function getInstance() :JSAdapter {
        return instance;
    }

    private var flashId :String;

    public function JSAdapter()	{
        if (instance) {
            throw new Error("Singleton, use getInstance");
        }

        if (ExternalInterface.available) {
            Security.allowDomain("*");

            const application :* = FlexGlobals.topLevelApplication;
            const parameters :* = application.parameters;

            flashId = parameters.flashId;
        }
        else {
            throw new Error('ExternalInterface has to be available to be able to use this adapter');
        }

        instance = this;
    }

    public function fireFlashReady(externalName :String) :void {
        trace("invoking JavaScript flashId=" + flashId);
        ExternalInterface.call(externalName, flashId);
    }

    public function call(expression :String, locals :Object = null) :* {
        trace("invoking JavaScript flashId=" + flashId);
        return ExternalInterface.call("stageFlashCallback", flashId, expression, locals);
    }

    public function expose(externalName :String, func :Function) :void {
        ExternalInterface.addCallback(externalName, func);
    }
}


}
