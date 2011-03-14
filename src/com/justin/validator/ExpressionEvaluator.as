package com.justin.validator
{
    public class ExpressionEvaluator
    {
        public var simpleParser:SimpleParser = new SimpleParser();
        public var converter:Converter = new Converter();
        public var calculator:Calculator = new Calculator();
        public var context:Object;
        public function ExpressionEvaluator()
        {
        }
        public function evalExpression(express:String, contex:Object):String
        {
            this.context = contex;
            var leftresult:Number = this.eval(getLeftExpress(express), contex);
            var rightResult:Number = this.eval(getRightExpress(express), contex);
            if(!isNaN(leftresult) && !isNaN(rightResult))
            {
                return conditionExpressValue(leftresult, getCondition(express), rightResult).toString();
            }
            else
            {
                return "Express Error";
            }
        }

        public function getLeftExpress(express:String):String
        {
            var leftReg:RegExp = new RegExp("[^=><]*",'g');
            var leftMatch:Array = express.match(leftReg);
            return leftMatch[0].toString();
        }

        public function getRightExpress(express:String):String
        {
            var rightReg:RegExp = new RegExp("[^=><]*$",'g');
            var rightMatch:Array = express.match(rightReg);
            return rightMatch[0].toString();
        }

        public function getCondition(express:String):String
        {
            var conditionReg:RegExp = new RegExp(">=|<=|==|<>|>|<",'g');
            var conditionMatch:Array = express.match(conditionReg);
            return conditionMatch[0].toString();
        }

        public function eval(express:String, contex:Object):Number
        {
            this.context = contex;
            var parserExp:Array = getEvalPase(express);
            var postfixExpr:Array = converter.convert(parserExp, 0, parserExp.length);
            var result:Number = calculator.eval(postfixExpr, 0, postfixExpr.length, contex);
            return result;
        }

        public function getEvalPase(express:String):Array
        {
            return simpleParser.parse(express, this);
        }

        private function conditionExpressValue(left:Number, condition:String, right:Number):Boolean
        {
            switch(condition)
            {
                case ">":
                    return left > right;
                case ">=":
                    return left >= right;
                case "<":
                    return left < right;
                case "<=":
                    return left <= right;
                case "==":
                    return left == right;
                case "<>":
                    return left != right;
                default:
                    throw new Error("Error");
            }
        }
    }
}