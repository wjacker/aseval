package com.justin.validator
{
    public class Condition extends Operator
    {
        public static const LESS_THAN:String = "<";
        public static const LESS_THAN_OR_EQUAL_TO:String = "<=";
        public static const GREATER_THAN:String = ">";
        public static const GREATER_THAN_OR_EQUAL_TO:String = ">=";
        public static const EQUALS:String = "==";
        public static const NOT_EQUAL_TO_1:String = "!=";
        public static const NOT_EQUAL_TO_2:String = "<>";


        public function Condition(name:String)
        {
            super(name);
        }

        override public function getDimension():int
        {
            return 2;
        }

        override public function eval(...values):*
        {
            switch(name)
            {
                case GREATER_THAN:
                    return values[0] > values[1];
                case GREATER_THAN_OR_EQUAL_TO:
                    return values[0] >= values[1];
                case LESS_THAN:
                    return values[0] < values[1];
                case LESS_THAN_OR_EQUAL_TO:
                    return values[0] <= values[1];
                case NOT_EQUAL_TO_1:
                case NOT_EQUAL_TO_2:
                    return values[0] != values[1];
                case EQUALS:
                    return values[0] == values[1];
                default:
                    throw new Error("Illegal Condition");
                    break;
            }
        }

        override public function toString():String
        {
            return name;
        }

        public static function isCondition(s:String):Boolean
        {
            switch(s)
            {
                case LESS_THAN:
                case LESS_THAN_OR_EQUAL_TO:
                case GREATER_THAN:
                case GREATER_THAN_OR_EQUAL_TO:
                case EQUALS:
                case NOT_EQUAL_TO_1:
                case NOT_EQUAL_TO_2:
                    return true;
                default:
                    return false;
            }
        }
    }
}