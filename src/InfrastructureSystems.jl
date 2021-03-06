isdefined(Base, :__precompile__) && __precompile__()

module InfrastructureSystems

import CSV
import DataFrames
import Dates
import JSON
import JSON2
import PrettyTables
import TimeSeries

using DocStringExtensions

@template (FUNCTIONS, METHODS) = """
                                 $(TYPEDSIGNATURES)
                                 $(DOCSTRING)
                                 """

# IS should not export any function since it can have name clashes with other packages.
# Do not add export statements.

# Every subtype must implement InfrastructureSystems.get_name() or have a field called name.
abstract type InfrastructureSystemsType end

"""
Return the internal forecast storage container or nothing, if the type doesn't store
forecasts.

Subtypes need to implement this method if they store forecasts.
"""
function get_forecasts(value::T) where {T <: InfrastructureSystemsType}
    return nothing
end

set_forecasts!(value::T) where {T <: InfrastructureSystemsType} = nothing

get_name(value::InfrastructureSystemsType) = value.name
set_name!(value::InfrastructureSystemsType, name) = value.name = name
get_internal(value::InfrastructureSystemsType) = value.internal

include("common.jl")
include("internal.jl")
include("utils/recorder_events.jl")
include("utils/flatten_iterator_wrapper.jl")
include("utils/generate_structs.jl")
include("utils/lazy_dict_from_iterator.jl")
include("utils/logging.jl")
include("utils/stdout_redirector.jl")
include("utils/utils.jl")
include("time_series_data.jl")
include("time_series_storage.jl")
include("hdf5_time_series_storage.jl")
include("in_memory_time_series_storage.jl")

include("forecasts.jl")
include("forecast_metadata.jl")
include("component.jl")
include("components.jl")
include("generated/includes.jl")
include("supplemental_constructors.jl")
include("forecast_parser.jl")
include("timeseries_formats.jl")
include("results.jl")
include("serialization.jl")
include("system_data.jl")
include("validation.jl")
include("utils/print.jl")
include("utils/test.jl")
include("units.jl")

end # module
