package com.justin.validator
{
    public class ExpressFunction
    {
        public static const parameterReg:RegExp = /[^,()]*[,()]|[^,()]*$/g;
        public var name:String;
        public var parameterList:Array;
        public var parameterString:String;
        public var ee:ExpressionEvaluator;
        public function ExpressFunction(name:String, parameterString:String, ee:ExpressionEvaluator):void
        {
            this.name = name;
            this.parameterString = parameterString;
            this.ee = ee;
        }

        protected function parserParmaeter():void
        {
            var sArr:Array = parameterString.substring(1, parameterString.length - 1).match(parameterReg);
            parameterList = new Array();
            var count:int = 0;
            var tempStr:String = "";
            var str:String;
            for(var i:int = 0; i < sArr.length; i++)
            {
                str = sArr[i];
                if(str.length > 0)
                {
                    tempStr += str;
                    if(str.charAt(str.length - 1) == "(")
                    {
                        count++;
                    }
                    else if(str.charAt(str.length - 1) == ")")
                    {
                        count--;
                    }
                    else
                    {
                        if(count == 0)
                        {
                            if(tempStr.charAt(tempStr.length - 1) == ",")
                                tempStr = tempStr.substring(0, tempStr.length - 1)
                            parameterList.push(tempStr);
                            tempStr = "";
                        }
                    }
                }
            }
            if(tempStr != "")
            {
                parameterList.push(tempStr);
            }
        }

        public function eval():Number
        {
            parserParmaeter();
            var parameterResultList:Array = new Array();
            for each(var s:String in parameterList)
            {
                parameterResultList.push(ee.eval(s,ee.context));
            }
            if(ee.context[name] is Function)
                return Number(ee.context[name].apply(null, parameterResultList));
            else if((Math as Object).hasOwnProperty(name))
            {
                if((Math as Object)[name] is Function)
                    return Number((Math as Object)[name].apply(null, parameterResultList));
                else
                    return Number((Math as Object)[name]);
            }

            else
                throw new Error("Function Not Found");
        }

        public function toString():String
        {
            return name;
        }

    }
}