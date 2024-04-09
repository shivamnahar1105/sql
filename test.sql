with ranked_value as (
    select    id,
            car,
	        ROW_NUMBER() OVER (ORDER BY CASE WHEN CAR IS NOT NULL THEN ID END DESC) AS CarRank,
            length,
	        ROW_NUMBER() OVER (ORDER BY CASE WHEN LENGTH IS NOT NULL THEN ID END DESC) AS LengthRank,
            width,
	        ROW_NUMBER() OVER (ORDER BY CASE WHEN WIDTH IS NOT NULL THEN ID END DESC) AS WidthRank,
            height,
	        ROW_NUMBER() OVER (ORDER BY CASE WHEN HEIGHT IS NOT NULL THEN ID END DESC) AS HeightRank
        -- Assign a rank to non-null values in reverse order
        -- so that the first non-null is ranked as 1
    from 
        FOOTER
)
    select 
        MAX(CASE WHEN CarRank = 1 THEN CAR END) AS car,
        MAX(CASE WHEN LengthRank = 1 THEN LENGTH END) AS length,
        MAX(CASE WHEN WidthRank = 1 THEN WIDTH END) AS width,
        MAX(CASE WHEN HeightRank = 1 THEN HEIGHT END) AS height
    from ranked_value