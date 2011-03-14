package com.justin.validator
{
	public class SimpleOperator extends Operator
	{
		public function SimpleOperator(name:String)
		{
			super(name);
		}
		override public function getDimension():int
		{
            switch(name)
            {
                case "-1":
                case "+1":
                    return 1;
                default:
                    return 2;
            }
		}

	    override public function eval(...values):Number
	    {
            switch(name)
            {
                case "-1":
                    return 0 - values[0];
                case "+1":
                    return values[0];
                case "+":
                    return values[0] + values[1];
                case "-":
                    return values[0] - values[1];
                case "*":
                    return values[0] * values[1];
                case "/":
                    return values[0] / values[1];
                default:
                    return values[0] + values[1];
            }
	    }

	    public static function isSimpleOperator(s:String):Boolean
	    {
	    	switch(s)
            {
                case "+":
                case "-":
                case "*":
                case "/":
                    return true;
                default:
                    return false;
            }
	    }
	}
}