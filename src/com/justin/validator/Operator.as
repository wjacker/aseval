package com.justin.validator
{
	public class Operator
	{
		public var name:String;
		public function Operator(name:String):void
		{
			this.name = name;
		}
		public function getDimension():int
		{
			throw new Error("this method must implement in child");
		}

	    public function eval(...values):Number
	    {
	    	throw new Error("this method must implement in child");
	    }

	    public function toString():String
	    {
	        return name;
	    }


	}
}