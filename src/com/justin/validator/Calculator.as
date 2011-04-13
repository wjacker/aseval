package com.justin.validator
{

    public class Calculator
    {
        public function Calculator()
        {
        }

        public function eval(postfixExpr:Array, offset:int, len:int, ee:ExpressionEvaluator):*
        {
            if (postfixExpr.length - offset < len)
                throw new Error("Error");

            var stackArr:Array = [];
            var currPosition:int = offset;
            while (currPosition < offset + len)
            {
                var element:Object = postfixExpr[currPosition++];
                if (element is Variable)
                {
                    stackArr.push(evalVariable(element as Variable, ee));
                }
                else if(element is ExpressFunction)
                {
                    stackArr.push((element as ExpressFunction).eval());
                }
                else if (element is Operator)
                {
                    var op:Operator = element as Operator;
                    var dimensions:int = op.getDimension();
                    if (dimensions < 1 || stackArr.length < dimensions)
                        throw new Error("lack operand(s) for operator '" + op + "'");

                    var operands:Array = [];
                    for (var j:int = dimensions - 1; j >= 0; j--)
                    {
                        operands.push(stackArr.pop());
                    }
                    stackArr.push(op.eval.apply(null, operands.reverse()));
                }
                else if(!isNaN(Number(element)))
                {
                    stackArr.push(Number(element));
                }
                else
                    throw new Error("Unknown element: " + element);
            }
            if (stackArr.length != 1)
                throw new Error("redundant operand(s)");

            return stackArr.pop();
        }

        private function evalVariable(element:Variable, ee:ExpressionEvaluator):Number
        {
            if(ee.context && ee.context.hasOwnProperty(element.name))
            {
                var value:String = ee.context[element.name];
                if(!isNaN(Number(value)))
                    return Number(value);
                else
                    return ee.eval(value, ee.context);
            }
            else if((Math as Object).hasOwnProperty(element.name))
            {
                return Number((Math as Object)[element.name]);
            }
            else
            {
                throw Error("Error");
            }
        }
    }
}