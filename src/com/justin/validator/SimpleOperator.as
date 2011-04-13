package com.justin.validator
{
	public class SimpleOperator extends Operator
	{
        public static const ADD_OPERATOR:String = "+";
        public static const SUBTRACT_OPERATOR:String = "-";
        public static const MULTIPLY_OPERATOR:String = "*";
        public static const DIVIDE_OPERATOR:String = "/";
        public static const POWER_OPERATOR:String = "^";
        public static const REMAINDER_OPERATOR:String = "%";
        public static const PLUS_ADD_OPERATOR:String = "+1";
        public static const PLUS_SUBTRACT_OPERATOR:String = "-1";

		public function SimpleOperator(name:String)
		{
			super(name);
		}
		override public function getDimension():int
		{
            switch(name)
            {
                case PLUS_ADD_OPERATOR:
                case PLUS_SUBTRACT_OPERATOR:
                    return 1;
                default:
                    return 2;
            }
		}

	    override public function eval(...values):*
	    {
            switch(name)
            {
                case PLUS_SUBTRACT_OPERATOR:
                    return 0 - values[0];
                case PLUS_ADD_OPERATOR:
                    return values[0];
                case ADD_OPERATOR:
                    return values[0] + values[1];
                case SUBTRACT_OPERATOR:
                    return values[0] - values[1];
                case POWER_OPERATOR:
                    return Math.pow(values[0], values[1]);
                case MULTIPLY_OPERATOR:
                    return values[0] * values[1];
                case DIVIDE_OPERATOR:
                    return values[0] / values[1];
                case REMAINDER_OPERATOR:
                    return values[0] % values[1];
                default:
                    throw new Error("Illegal Operator");
                    break;
            }
	    }

	    public static function isSimpleOperator(s:String):Boolean
	    {
	    	switch(s)
            {
                case ADD_OPERATOR:
                case SUBTRACT_OPERATOR:
                case MULTIPLY_OPERATOR:
                case DIVIDE_OPERATOR:
                case REMAINDER_OPERATOR:
                case POWER_OPERATOR:
                    return true;
                default:
                    return false;
            }
	    }
	}
}