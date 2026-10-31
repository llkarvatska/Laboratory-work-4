PRAGMA foreign_keys = ON;

CREATE TABLE ANIMAL_IMAGES (
    image_id INTEGER PRIMARY KEY,
image_uri TEXT NOT NULL,
    CONSTRAINT chk_image_uri
    CHECK (image_uri REGEXP '^(https?://|assets/)[A-Za-z0-9._/-]+$')
);

CREATE TABLE DIFFICULTY_LEVELS (
    difficulty_id INTEGER PRIMARY KEY,
    level_name TEXT NOT NULL UNIQUE,
    CONSTRAINT chk_level_name
    CHECK (level_name REGEXP '^[A-Za-zА-Яа-яІіЇїЄєҐґ]+$')
);

CREATE TABLE TANGRAM_PIECES (
    piece_id INTEGER PRIMARY KEY
);

CREATE TABLE PUZZLES (
    puzzle_id INTEGER PRIMARY KEY,
    image_id INTEGER NOT NULL,
    difficulty_id INTEGER NOT NULL,
    FOREIGN KEY (image_id)
    REFERENCES ANIMAL_IMAGES (image_id),
    FOREIGN KEY (difficulty_id)
    REFERENCES DIFFICULTY_LEVELS (difficulty_id)
);

CREATE TABLE AR_MARKERS (
    marker_id INTEGER PRIMARY KEY,
    piece_id INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (piece_id)
    REFERENCES TANGRAM_PIECES (piece_id)
);

CREATE TABLE TARGET_PLACEMENTS (
    puzzle_id INTEGER NOT NULL,
    piece_id INTEGER NOT NULL,
    x_position REAL NOT NULL,
    y_position REAL NOT NULL,
    orientation_deg REAL NOT NULL,
    PRIMARY KEY (puzzle_id, piece_id),
    FOREIGN KEY (puzzle_id)
    REFERENCES PUZZLES (puzzle_id),
    FOREIGN KEY (piece_id)
    REFERENCES TANGRAM_PIECES (piece_id),
    CHECK (orientation_deg >= 0 AND orientation_deg < 360)
);
