package com.justin.validator
{
	public class SimpleParser implements Parser
	{
        private var ee:ExpressionEvaluator;
		public function SimpleParser()
		{
		}

		public function parse(expr:String, ee:ExpressionEvaluator = null):Array
		{
            this.ee = ee;
			var result:Array = [];
			var parseString:String = "";
            var variableStr:String;
			//a+b-(c*d)
			for(var i:int = 0; i< expr.length; i++)
            {
            	if(isOperate(expr.charAt(i)))
            	{
                    variableStr = expr.substring(parseString.length, i);
            		if(variableStr != "")
                	{
                        if(!isNaN(Number(variableStr)))
                        {
                            result.push(Number(variableStr));
                        }
                        else if(expr.charAt(i) == Bracket.LEFT_BRACKET.toString() && isFunction(variableStr))
                        {
                            var parameterString:String = "(";
                            var count:int = 1;
                            while(count > 0)
                            {
                                i++;
                                if(expr.charAt(i) == Bracket.LEFT_BRACKET.toString())
                                    count++;
                                else if(expr.charAt(i) == Bracket.RIGHT_BRACKET.toString())
                                    count--;
                                parameterString += expr.charAt(i);
                            }
                            result.push(new ExpressFunction(variableStr,parameterString,ee));
                            parseString = expr.substring(0, i + 1);
                            continue;
                        }
                        else
                        {
                            result.push(new Variable(variableStr));
                        }
                	}
                	parseString = expr.substring(0, i + 1);
            		if(SimpleOperator.isSimpleOperator(expr.charAt(i)))
	                {
                        if(isPlusOperate(result))
                        {
                            result.push(new SimpleOperator(expr.charAt(i)+1));
                        }
                        else
                        {
                            result.push(new SimpleOperator(expr.charAt(i)));
                        }
	                }
	                else
	                {
                        result.push(new Bracket(expr.charAt(i)));
	                }
            	}
            }
            variableStr = expr.substring(parseString.length, expr.length);
            if(variableStr != "")
        	{
                if(!isNaN(Number(variableStr)))
                    result.push(Number(variableStr));
                else
                    result.push(new Variable(variableStr));
        	}
            return result;
		}

        private function isFunction(functionName:String):Boolean
        {
            if(ee && ee.context && ee.context.hasOwnProperty(functionName)
                || (Math as Object).hasOwnProperty(functionName))
                return true;
            else
                return false;
        }

        private function isPlusOperate(resultArr:Array):Boolean
        {
            var cont:int = resultArr.length - 1;
            while(cont >= 0)
            {
                if(resultArr[cont] is Operator)
                    return true;
                else if(resultArr[cont] is Bracket)
                    cont--;
                else
                    return false;
            }
            return true;
        }

		private function isOperate(s:String):Boolean
        {
            switch(s)
            {
                case "+":
                case "-":
                case "*":
                case "/":
                case "(":
                case ")":
                case ">":
                case "<":
                case "=":
                case "!":
                case "|":
                    return true;
                default:
                    return false;
            }
        }
	}
}