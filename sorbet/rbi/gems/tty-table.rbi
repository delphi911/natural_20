# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/tty-table/all/tty-table.rbi
#
# tty-table-0.12.0

module TTY
end
class TTY::Table
  def <<(row); end
  def ==(other); end
  def [](row_index, column_index = nil); end
  def []=(row_index, column_index, val); end
  def assoc(*args, &block); end
  def at(row_index, column_index = nil); end
  def coerce(rows); end
  def column(index); end
  def columns_count; end
  def columns_size; end
  def component(row_index, column_index = nil); end
  def data; end
  def each; end
  def each_with_index; end
  def element(row_index, column_index = nil); end
  def empty?; end
  def eql?(other); end
  def flatten(*args, &block); end
  def hash; end
  def header; end
  def include?(*args, &block); end
  def index(*args, &block); end
  def initialize(options = nil, &block); end
  def inspect; end
  def length(*args, &block); end
  def orientation; end
  def orientation=(value); end
  def original_columns; end
  def original_rows; end
  def pretty_print(*args, &block); end
  def rassoc(*args, &block); end
  def render(*args, &block); end
  def render_with(border_class, renderer_type = nil, options = nil, &block); end
  def renderer(type = nil, options = nil); end
  def rotate; end
  def rotate_horizontal; end
  def rotate_vertical; end
  def rotated?; end
  def row(index, &block); end
  def rows; end
  def rows_size; end
  def select(*args, &block); end
  def self.[](*rows); end
  def self.new(*args, &block); end
  def separators; end
  def size; end
  def to_a(*args, &block); end
  def to_header(row); end
  def to_row(row, header = nil); end
  def to_s; end
  def values_at(*args, &block); end
  def width; end
  def yield_or_eval(&block); end
  extend Forwardable
  include Comparable
end
class TTY::Table::DimensionMismatchError < ArgumentError
end
class TTY::Table::TupleMissing < IndexError
  def i; end
  def initialize(i, j); end
  def j; end
end
class TTY::Table::InvalidOrientationError < ArgumentError
end
class TTY::Table::ResizeError < ArgumentError
end
class TTY::Table::NoImplementationError < NotImplementedError
end
class TTY::Table::TypeError < ArgumentError
end
class TTY::Table::ArgumentRequired < ArgumentError
end
class TTY::Table::InvalidArgument < ArgumentError
end
class TTY::Table::UnknownAttributeError < IndexError
end
module TTY::Table::Columns
  def assert_widths(column_widths, table_widths); end
  def extract_widths(data); end
  def find_maximum(data, index); end
  def self.assert_widths(column_widths, table_widths); end
  def self.extract_widths(data); end
  def self.find_maximum(data, index); end
  def self.total_width(data); end
  def self.widths_from(table, column_widths = nil); end
  def total_width(data); end
  def widths_from(table, column_widths = nil); end
end
class TTY::Table::Field
  def ==(other); end
  def alignment; end
  def chars; end
  def colspan; end
  def content; end
  def content=(arg0); end
  def eql?(other); end
  def extract_options(value); end
  def hash; end
  def height; end
  def initialize(value); end
  def inspect; end
  def length; end
  def lines; end
  def reset!; end
  def rowspan; end
  def to_s; end
  def value; end
  def value=(arg0); end
  def width; end
end
class TTY::Table::Header
  def ==(other); end
  def [](attribute); end
  def []=(attribute, value); end
  def attributes; end
  def call(attribute); end
  def each; end
  def empty?; end
  def eql?(other); end
  def fields; end
  def height; end
  def initialize(attributes = nil); end
  def inspect; end
  def join(*args, &block); end
  def length; end
  def map!(*args, &block); end
  def map(*args, &block); end
  def size; end
  def to_a; end
  def to_ary; end
  def to_field(attribute = nil); end
  def to_hash; end
  extend Forwardable
  include Enumerable
end
class TTY::Table::Orientation
  def horizontal?; end
  def initialize(name); end
  def name; end
  def self.coerce(name); end
  def vertical?; end
end
class TTY::Table::Orientation::Horizontal < TTY::Table::Orientation
  def slice(table); end
  def transform(table); end
end
class TTY::Table::Orientation::Vertical < TTY::Table::Orientation
  def slice(table); end
  def transform(table); end
end
class TTY::Table::Row
  def ==(other); end
  def [](attribute); end
  def []=(attribute, value); end
  def attributes; end
  def call(attribute); end
  def coerce_to_fields(values); end
  def data; end
  def each; end
  def empty?; end
  def eql?(other); end
  def fields; end
  def hash; end
  def height; end
  def initialize(data, header = nil); end
  def inspect; end
  def join(*args, &block); end
  def length; end
  def map!(&block); end
  def size; end
  def to_a; end
  def to_ary; end
  def to_field(options = nil); end
  def to_hash; end
  extend Forwardable
  include Enumerable
end
class TTY::Table::AlignmentSet
  def [](index); end
  def alignments; end
  def each; end
  def initialize(alignments); end
  def to_ary; end
  def to_s; end
  include Enumerable
end
class TTY::Table::BorderOptions
  def characters; end
  def characters=(arg0); end
  def initialize(characters: nil, separator: nil, style: nil); end
  def self.from(options); end
  def separator; end
  def separator=(arg0); end
  def separator?(line); end
  def style; end
  def style=(arg0); end
  def to_hash; end
end
class TTY::Table::BorderDSL
  def bottom(value); end
  def bottom_left(value); end
  def bottom_mid(value); end
  def bottom_right(value); end
  def center(value); end
  def characters(*args, &block); end
  def initialize(border_opts = nil, &block); end
  def left(value); end
  def mid(value); end
  def mid_left(value); end
  def mid_mid(value); end
  def mid_right(value); end
  def options; end
  def right(value); end
  def separator(value = nil); end
  def style(value = nil); end
  def top(value); end
  def top_left(value); end
  def top_mid(value); end
  def top_right(value); end
  def yield_or_eval(&block); end
  extend Forwardable
end
class TTY::Table::Border
  def [](type); end
  def border_options; end
  def bottom_line; end
  def color?; end
  def initialize(column_widths, border_opts = nil); end
  def middle_line; end
  def render(type); end
  def render_line(line, left, right, intersection); end
  def row_height_line(row, line_index, line); end
  def row_heights(row, line); end
  def row_line(row); end
  def self.characters; end
  def self.characters=(arg0); end
  def self.def_border(characters = nil, &block); end
  def set_color(color, string); end
  def top_line; end
  def widths; end
end
class Anonymous_Struct_10 < Struct
  def center; end
  def center=(_); end
  def left; end
  def left=(_); end
  def right; end
  def right=(_); end
  def self.[](*arg0); end
  def self.inspect; end
  def self.members; end
  def self.new(*arg0); end
end
class TTY::Table::Border::RowLine < Anonymous_Struct_10
  def colorize(border, style); end
end
class TTY::Table::Border::Null < TTY::Table::Border
  def middle_line; end
end
class TTY::Table::ColumnConstraint
  def assert_minimum_width; end
  def border_size; end
  def distribute_extra_width(widths); end
  def enforce; end
  def expand_column_widths; end
  def initialize(table, renderer); end
  def minimum_width; end
  def natural_width; end
  def outside_border_size; end
  def padding_size; end
  def renderer; end
  def rotate; end
  def shrink; end
  def table; end
end
module TTY::Table::Indentation
  def indent(part, indentation); end
  def insert_indentation(line, indentation); end
  def self.indent(part, indentation); end
  def self.insert_indentation(line, indentation); end
end
class TTY::Table::Operations
  def [](operation); end
  def add(operation_type, object); end
  def apply_to(table, *args); end
  def initialize; end
  def operations; end
end
module TTY::Table::Operation
end
class TTY::Table::Operation::Alignment
  def align_field(field, col); end
  def alignments; end
  def call(field, row, col); end
  def initialize(alignments, widths = nil); end
  def widths; end
end
class TTY::Table::Operation::Truncation
  def call(field, row, col); end
  def initialize(widths); end
  def widths; end
end
class TTY::Table::Operation::Wrapped
  def call(field, row, col); end
  def initialize(widths); end
  def widths; end
end
class TTY::Table::Operation::Filter
  def call(field, row, col); end
  def initialize(filter); end
end
class TTY::Table::Operation::Escape
  def call(field, row, col); end
end
class TTY::Table::Operation::Padding
  def call(field, *arg1); end
  def initialize(padding); end
  def padding; end
end
module TTY::Table::Validatable
  def assert_row_size(row, rows); end
  def assert_row_sizes(rows); end
  def assert_table_type(value); end
  def validate_options!(options); end
end
module TTY::Table::Renderer
  def assert_border_class(border_class); end
  def render(table, options = nil, &block); end
  def render_with(border_class, table, options = nil, &block); end
  def select(type); end
  def self.assert_border_class(border_class); end
  def self.render(table, options = nil, &block); end
  def self.render_with(border_class, table, options = nil, &block); end
  def self.select(type); end
end
class TTY::Table::Renderer::Basic
  def alignments; end
  def alignments=(arg0); end
  def border(border_opts = nil, &block); end
  def border=(border_opts = nil, &block); end
  def border_class; end
  def border_class=(arg0); end
  def column_widths; end
  def column_widths=(arg0); end
  def create_operations(widths); end
  def filter; end
  def filter=(arg0); end
  def indent; end
  def indent=(value); end
  def initialize(table, options = nil); end
  def multiline; end
  def multiline=(arg0); end
  def padding; end
  def padding=(value); end
  def render; end
  def render_data; end
  def render_header(row, data_border); end
  def render_row(row, index, data_border, is_not_last_row); end
  def render_rows(data_border); end
  def resize; end
  def resize=(arg0); end
  def select_operations; end
  def table; end
  def width; end
  def width=(arg0); end
  include TTY::Table::Validatable
end
class TTY::Table::Border::ASCII < TTY::Table::Border
end
class TTY::Table::Renderer::ASCII < TTY::Table::Renderer::Basic
  def initialize(table, options = nil); end
end
class TTY::Table::Border::Unicode < TTY::Table::Border
end
class TTY::Table::Renderer::Unicode < TTY::Table::Renderer::Basic
  def initialize(table, options = nil); end
end
class TTY::Table::Transformation
  def self.extract_tuples(args); end
  def self.group_header_and_rows(value); end
end
