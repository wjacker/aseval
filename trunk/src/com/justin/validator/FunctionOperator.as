package com.justin.validator
{
    public class FunctionOperator extends Operator
    {
        public var dimension:int;
        public function FunctionOperator(name:String)
        {
            super(name);
        }

        public override function getDimension():int
        {
            return dimension;
        }

        public override function eval(...values):Number
        {
            throw new Error("this method must implement in child");
        }
    }
}