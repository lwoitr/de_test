select
    craft,
    count(*) as astronauts_count
from de_test.people FINAL
group by craft