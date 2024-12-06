import pandas as pd
import sqlite3
import folium
from folium.plugins import HeatMap

# SQLite veritabanına bağlan
conn = sqlite3.connect("../databases/deliveroo.db")  # Veritabanı dosyanızın yolunu belirtin

# Sorguyu çalıştır ve sonucu bir dataframe'e al
query = """
SELECT DISTINCT restaurants.id, restaurants.latitude, restaurants.longitude, restaurants.postal_code
FROM restaurants
JOIN menu_items ON restaurants.id = menu_items .restaurant_id
WHERE LOWER(menu_items.name) LIKE '%halal%';
"""
data = pd.read_sql_query(query, conn)

# Bağlantıyı kapat
conn.close()



# Harita oluştur
belgium_map = folium.Map(location=[50.8503, 4.3517], zoom_start=8)  # Belçika'nın merkez koordinatları

# Restoranları haritaya ekle
for _, row in data.iterrows():
    folium.Marker(
        location=[row['latitude'], row['longitude']],
        popup=f"Posta Kodu: {row['postal_code']}, Restoran ID: {row['id']}",
        icon=folium.Icon(color='green', icon='cutlery', prefix='fa')
    ).add_to(belgium_map)

# Haritayı kaydet
belgium_map.save("belgium_halal_restaurants.html")



# HeatMap için restoran konumlarını hazırlayın
locations = data[['latitude', 'longitude']].values.tolist()

# Harita oluştur ve HeatMap ekle
belgium_map = folium.Map(location=[50.8503, 4.3517], zoom_start=8)
HeatMap(locations).add_to(belgium_map)

# Haritayı kaydet
belgium_map.save("belgium_halal_heatmap.html")

