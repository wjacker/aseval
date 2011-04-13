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

        public function eval(express:String, context:Object):*
        {
            this.context = context;
            var parserExp:Array = simpleParser.parse(express, this);
            var postfixExpr:Array = converter.convert(parserExp, 0, parserExp.length);
            var result:* = calculator.eval(postfixExpr, 0, postfixExpr.length, this);
            return result;
        }
    }
}