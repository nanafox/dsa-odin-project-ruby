# frozen_string_literal: true

require_relative 'lib/hash_map'

hash_map = HashMap.new

hash_map.set('apple', 'red')
hash_map.set('banana', 'yellow')
hash_map.set('carrot', 'orange')
hash_map.set('dog', 'brown')
hash_map.set('elephant', 'gray')
hash_map.set('frog', 'green')
hash_map.set('grape', 'purple')
hash_map.set('hat', 'black')
hash_map.set('ice cream', 'white')
hash_map.set('jacket', 'blue')
hash_map.set('kite', 'pink')
hash_map.set('lion', 'golden')

# see the current entries
p hash_map.entries

# update a few values
hash_map.set('apple', 'green')
hash_map.set('banana', 'brown')
hash_map.set('carrot', 'purple')

# see the updated entries
p hash_map.entries

# add a new entry to test that the hashmap can resize
hash_map.set('moon', 'silver')
