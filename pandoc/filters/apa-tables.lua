-- apa-tables.lua
-- Pandoc Lua filter for APA 7th edition table styling
-- Centers text by default, left-aligns columns with long content
--
-- Usage: pandoc input.md --lua-filter=apa-tables.lua -o output.docx
--
-- Configurable via YAML metadata:
--   apa-table-align-threshold: 20  (default, character count)

local threshold = 20

-- Get plain text length from inline content
local function inline_text_length(inlines)
	local len = 0
	for _, el in ipairs(inlines) do
		if el.t == "Str" then
			len = len + #el.text
		elseif el.t == "Space" then
			len = len + 1
		elseif el.t == "SoftBreak" or el.t == "LineBreak" then
			len = len + 1
		end
	end
	return len
end

-- Get max text length from a cell's content
local function cell_text_length(cell)
	local max = 0
	for _, block in ipairs(cell.contents) do
		local len = 0
		if block.t == "Plain" or block.t == "Para" then
			len = inline_text_length(block.content)
		elseif block.t == "LineBlock" then
			for _, line in ipairs(block.content) do
				len = len + inline_text_length(line)
			end
		end
		if len > max then
			max = len
		end
	end
	return max
end

-- Calculate max text length per column across all body rows
local function column_max_lengths(bodies, ncol)
	local maxes = {}
	for i = 1, ncol do
		maxes[i] = 0
	end
	for _, body in ipairs(bodies) do
		for _, row in ipairs(body.body) do
			for i, cell in ipairs(row.cells) do
				if i <= ncol then
					local len = cell_text_length(cell)
					if len > maxes[i] then
						maxes[i] = len
					end
				end
			end
		end
	end
	return maxes
end

-- Apply alignment to a cell
local function align_cell(cell, alignment)
	return pandoc.Cell(
		cell.contents,
		alignment,
		cell.row_span,
		cell.col_span,
		cell.attr
	)
end

function Table(table)
	-- Read threshold from metadata
	local meta_threshold = table.attr.attributes["apa-table-align-threshold"]
	if meta_threshold then
		threshold = tonumber(meta_threshold) or 20
	end

	local ncol = #table.colspecs
	local maxes = column_max_lengths(table.bodies, ncol)

	-- Determine column alignments based on heuristic
	local col_aligns = {}
	for i = 1, ncol do
		if maxes[i] > threshold then
			col_aligns[i] = pandoc.AlignLeft
		else
			col_aligns[i] = pandoc.AlignCenter
		end
	end

	-- Update colspecs
	local new_colspecs = {}
	for i, spec in ipairs(table.colspecs) do
		new_colspecs[i] = { col_aligns[i], spec[2] }
	end

	-- Update header cells: center-align, bold
	local new_head_rows = {}
	for _, row in ipairs(table.head.rows) do
		local new_cells = {}
		for i, cell in ipairs(row.cells) do
			-- Wrap content in Strong (bold)
			local new_content = {}
			for _, block in ipairs(cell.contents) do
				if block.t == "Plain" then
				new_content[#new_content + 1] = pandoc.Plain(
					pandoc.Inlines{pandoc.Strong(block.content)}
				)
				elseif block.t == "Para" then
					new_content[#new_content + 1] = pandoc.Plain(
						pandoc.Inlines{pandoc.Strong(block.content)}
					)
				else
					new_content[#new_content + 1] = block
				end
			end
			new_cells[i] = pandoc.Cell(
				new_content,
				pandoc.AlignCenter,
				cell.row_span,
				cell.col_span,
				cell.attr
			)
		end
			new_head_rows[#new_head_rows + 1] = pandoc.Row(new_cells, row.attr)
	end
	local new_head = pandoc.TableHead(new_head_rows, table.head.attr)

	-- Update body cells with heuristic alignment
	local new_bodies = {}
	for _, body in ipairs(table.bodies) do
		local new_body_rows = {}
		for _, row in ipairs(body.body) do
			local new_cells = {}
			for i, cell in ipairs(row.cells) do
				if i <= ncol then
					new_cells[i] = align_cell(cell, col_aligns[i])
				else
					new_cells[i] = cell
				end
			end
			new_body_rows[#new_body_rows + 1] = pandoc.Row(new_cells, row.attr)
		end
		new_bodies[#new_bodies + 1] = pandoc.TableBody(
			new_body_rows,
			body.head,
			body.row_head_columns,
			body.attr
		)
	end

	return pandoc.Table(
		table.caption,
		new_colspecs,
		new_head,
		new_bodies,
		table.foot
	)
end
