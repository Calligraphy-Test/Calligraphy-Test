GLOBAL_LIST_INIT(kanji_spells, init_kanji_spells_list()) // Key-Value pair list with kanji as the key and value as to how to handle it

// Flags to limit certain kanji to certain casting tools
#define KANJI_SPELL_COMBAT (1 << 0)
#define KANJI_SPELL_HEALING (1 << 1)
#define KANJI_SPELL_NOT_THROWABLE (1 << 2)
#define KANJI_SPELL_HOSTILE_CREATURE (1 << 3)
#define KANJI_SPELL_BUILDING_MATERIALS (1 << 4)

// Keywords for searching kanji by, update KANJI_FILTER_ALL if you add any
#define KANJI_FILTER_COMBAT "Combat"
#define KANJI_FILTER_HEALING "Healing"

#define KANJI_FILTER_ALL list(KANJI_FILTER_COMBAT, KANJI_FILTER_HEALING)
