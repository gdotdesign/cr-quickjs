# require "./lib_quickjs"

@[Link(ldflags: "-L#{__DIR__}/../quickjs -lquickjs")]
lib LibQuickJS
  alias JSContext = Void*
  alias JSRuntime = Void*
  alias JSValue = Void*

  fun JS_NewRuntime : JSRuntime*
  fun JS_NewContextRaw(runtime : JSRuntime*) : JSContext*
  fun JS_NewContext(runtime : JSRuntime*) : JSContext*
  fun JS_Eval(ctx : JSContext*, input : UInt8*, input_len : LibC::SizeT, filename : UInt8*, eval_flags : LibC::Int) : JSValue
  fun JS_AddIntrinsicBaseObjects(ctx : JSContext*) : Void

  fun JS_ToBool(ctx : JSContext*, value : JSValue) : Bool
  fun JS_ToString(ctx : JSContext*, value : JSValue) : JSValue
  fun JS_ToCStringLen2(ctx : JSContext*, plen : LibC::SizeT*, value : JSValue, cesu : UInt8) : LibC::Char*
  fun JS_ToInt32(ctx : JSContext*, pres : Int32*, value : JSValue) : Int32

  fun JS_GetException(ctx : JSContext*) : JSValue
  fun JS_IsError(ctx : JSValue) : Bool
end

# TODO: Write documentation for `Cr::Quickjs`
module Quickjs
  VERSION = "0.1.0"

  # TODO: Put your code here
end

puts "Running..."
runtime = LibQuickJS.JS_NewRuntime
ctx = LibQuickJS.JS_NewContext(runtime)
source = "var x = 100 + 250; x.toString()"

evaled = LibQuickJS.JS_Eval(ctx, source, source.size, "test.js", 0)
val = LibQuickJS.JS_ToString(ctx, evaled)
puts String.new(LibQuickJS.JS_ToCStringLen2(ctx, nil, val, 0)).inspect
