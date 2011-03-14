package com.justin.validator
{
    public class ValidatorLevel
    {
        public static const CRITICAL_STR:String = "critical";
        public static const NONE_STR:String = "none";
        public static const WARNING_STR:String = "warning";
        public static const CRITICAL:int = 8;
        public static const WARNING:Number = 4;
        public static const NONE:int = 0;
        public function ValidatorLevel()
        {

        }

        public static function getLeveStr(level:int):String
        {
            switch(level)
            {
                case NONE:
                    return NONE_STR;
                case WARNING:
                    return WARNING_STR;
                case CRITICAL:
                    return CRITICAL_STR;
                default:
                    return NONE_STR;
            }
        }

        public static function getLeveBy(levelStr:String):int
        {
            switch(levelStr)
            {
                case NONE_STR:
                    return NONE;
                case WARNING_STR:
                    return WARNING;
                case CRITICAL_STR:
                    return CRITICAL;
                default:
                    return NONE;
            }
        }
    }
}