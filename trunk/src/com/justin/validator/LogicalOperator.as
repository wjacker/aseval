package com.justin.validator
{
    public class LogicalOperator extends Operator
    {
        public static const NOT:String = "!";
        public static const AND:String = "&&";
        public static const OR:String = "||";

        public function LogicalOperator(name:String)
        {
            super(name);
        }

        override public function getDimension():int
        {
            switch(name)
            {
                case NOT:
                    return 1;
                default:
                    return 2;
            }
        }

        override public function eval(...values):*
        {
            switch(name)
            {
                case NOT:
                    return !values[0];
                case AND:
                    return values[0] && values[1];
                case OR:
                    return values[0] || values[1];
                default:
                    return true;
            }

            throw new Error("this method must implement in child");
        }

        public static function isLogicalOperator(s:String):Boolean
        {
            switch(s)
            {
                case NOT:
                case AND:
                case OR:
                    return true;
                default:
                    return false;
            }
        }
    }
}