package com.justin.validator
{
	public interface Parser
	{
		function parse(expr:String, ee:ExpressionEvaluator = null):Array
	}
}