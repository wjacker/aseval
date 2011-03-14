package com.justin.validator
{
	public class Converter
	{
        public static const LEFT_BRACKET:String = "(";
        private var operatorPriority:Object;

		public function Converter()
		{
            operatorPriority = new Object();
            operatorPriority["function"] = 0;
            operatorPriority["("] = 1;
            operatorPriority[")"] = 1;
            operatorPriority["!"] = 2;
            operatorPriority["+1"] = 2;
            operatorPriority["-1"] = 2;
            operatorPriority["*"] = 3;
            operatorPriority["/"] = 3;
            operatorPriority["%"] = 3;
            operatorPriority["+"] = 4;
            operatorPriority["-"] = 4;
            operatorPriority["<"] = 5;
            operatorPriority[">"] = 5;
            operatorPriority["<="] = 5;
            operatorPriority[">="] = 5;
            operatorPriority["=="] = 6;
            operatorPriority["<>"] = 6;
            operatorPriority["&&"] = 7;
            operatorPriority["||"] = 8;
            operatorPriority["?"] = 9;
            operatorPriority[":"] = 9;
		}
		public function precedenceCompare(op1:Operator, op2:Operator):int
		{
            return operatorPriority[op2.name] - operatorPriority[op1.name];
		}

	    public function convert(infixExpr:Array, offset:int, len:int):Array
	    {
	         if (infixExpr.length - offset < len)
	             throw new Error("Error");
	        var outputArr:Array = [];
	        var stackArr:Array = [];
	        var currInputPosition:int = offset;
	        while (currInputPosition < offset + len)
	        {
	            var currInputElement:Object = infixExpr[currInputPosition++];

	            if(currInputElement is Bracket)
	            {
	                var currInputBracket:Bracket = currInputElement as Bracket;
	                if (currInputBracket.equals(Bracket.LEFT_BRACKET))
	                {
	                    stackArr.push(currInputElement);
	                }
	                else
	                {
	                    var stackElement:Object;
	                    do
	                    {
	                         if (stackArr.length > 0)
	                           stackElement = stackArr.pop();
	                         else
	                           throw new Error("bracket(s) mismatch");
	                         if (stackElement is Bracket)
	                           break;
	                         outputArr.push(stackElement);
	                         trace("OPERATOR POPUP:"+stackElement);
	                    } while (true);
	                }
	            }
	            else if (currInputElement is Operator)
	            {
	                var currInputOperator:Operator = currInputElement as Operator;
	                while (stackArr.length != 0) {
	                    var stackElement:Object = stackArr[stackArr.length - 1];
	                    if (stackElement is Bracket) {
	                        break;
	                    } else {
	                        var stackOperator:Operator = stackElement as Operator;
	                        if (precedenceCompare(stackOperator, currInputOperator) >= 0)
	                        {
	                            stackArr.pop();
	                            outputArr.push(stackElement);
	                            trace("OPERATOR:"+stackElement);//TEMP!
	                        } else {
	                            break;
	                        }
	                    }
	                }
	                stackArr.push(currInputElement);
	            }
                else if(!isNaN(Number(currInputElement)))
                {
                    outputArr.push(Number(currInputElement));
                    trace("NUMBER:"+currInputElement)
                }
	            else
	            {
	                outputArr.push(currInputElement);
	                trace("VARIABLE OR FUNCTION:"+currInputElement);
	            }
	        }
	        while (stackArr.length != 0)
	        {
	            var stackElement:Object = stackArr.pop();
	            outputArr.push(stackElement);
	            trace("LEFT STACK OPERATOR:"+stackElement);//TEMP!
	        }
	        return outputArr;
	    }
	}
}