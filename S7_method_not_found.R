# A class with a getter dependent on a property
try_obj <- S7::new_class(
  name = "try_obj",
  properties = list(
    values = S7::class_numeric,
    # Not really wanting to extend an S3 method, just an example
    try_mean = S7::new_property(
      getter = function(self) mean(self@values)
    )
  ),
  # My real constructor is not this banal
  constructor = function(values) {
    S7::new_object(
      S7::S7_object(),
      values = values
    )
  }
)

# A setter
set_values <- S7::new_generic("set_values", "x")
S7::method(set_values, try_obj) <- function(x, values) {
  x@values <- values
  return(x)
}

# Run me and watch the method not be found
do_try <- function(newvals = 1:5) {
  # Construct an object
  try_instance <- try_obj(values = 1:7)

  print(set_values)

  # Change the property that feeds the getter
  try_instance <- set_values(try_instance, values = newvals)

  print(try_instance@try_mean)
}
