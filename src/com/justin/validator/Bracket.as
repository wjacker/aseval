package com.justin.validator
{
	public class Bracket
	{
		public var name:String;
		public function Bracket(name:String):void
		{
			this.name = name;
		}

	    public static const LEFT_BRACKET:Bracket = new Bracket("(");
	    public static const RIGHT_BRACKET:Bracket = new Bracket(")");
	    public function toString():String
	    {
			 return name;
	    }
	    public function equals(bracket:Bracket):Boolean
	    {
	    	return this.name == bracket.name;
	    }

        public static function isBracket(value:String):Boolean
        {
            if(value == LEFT_BRACKET.toString() || value == RIGHT_BRACKET.toString())
                return true;
            else
                return false;
        }
	}
}