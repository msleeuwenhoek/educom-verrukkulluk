-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 28 nov 2022 om 13:34
-- Serverversie: 10.4.25-MariaDB
-- PHP-versie: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `verrukkulluk`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `article`
--

CREATE TABLE `article` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(256) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `packaging` int(11) NOT NULL,
  `file_name` varchar(50) NOT NULL,
  `calories` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `article`
--

INSERT INTO `article` (`id`, `name`, `description`, `price`, `unit`, `packaging`, `file_name`, `calories`) VALUES
(1, 'Refrigerated pizza crust dough', 'Refrigerated dough will keep several days. It may also be successfully frozen and thawed. Keeping preweighed individual frozen dough balls on hand makes it easy to have pizza whenever you like.', '4.25', 'can', 1, 'pizza_crust', 292),
(2, 'Cooking spray', 'This cooking spray can be used to avoid having food particles to cookware or to each other.', '4.16', 'spray', 1, 'cooking_spray', 792),
(3, 'extra-virgin olive oil', 'Extra Virgin Olive Oil is the highest grade and purest quality olive oil available.', '7.19', 'ml', 750, 'olive_oil', 833),
(4, 'Garlic ', 'A herb growing from a strongly aromatic, rounded bulb composed of around 10 to 20 cloves covered in a papery coat.', '1.09', 'g', 100, 'garlic', 140),
(5, 'tomato', 'A herb growing from a strongly aromatic, rounded bulb composed of around 10 to 20 cloves covered in a papery coat.', '2.99', 'pieces', 5, 'tomato', 17),
(6, 'Mozzarella', 'Mild, refreshing and supple, this Mozzarella gets its flavors from either cow or buffalo milk.', '1.79', 'g', 125, 'mozzarella', 245),
(7, 'Balsamic vinegar ', 'Balsamic vinegar is a deep brown vinegar that\'s made from unfermented grape juice.', '2.95', 'ml', 250, 'balsamic_vinegar', 96),
(8, 'Fresh basil', 'Fresh basil is an herb commonly used in Italian food, particularly pesto. ', '1.57', 'g', 20, 'basil', 23),
(9, 'Salt', 'Kosher salt or kitchen salt (also called cooking salt, flake salt, rock salt, kashering salt or koshering salt) is coarse edible salt without common additives such as iodine. ', '4.78', 'g', 250, 'salt', 0),
(10, 'Black pepper', 'Black pepper is the dried, mature but unripe berry (fruit) of Piper nigrum, a branching vine or climbing, perennial shrub. ', '2.70', 'g', 47, 'pepper', 251),
(11, 'Butter', 'Butter is a dairy product made from the fat and protein components of churned cream. ', '3.68', 'g', 250, 'butter', 717),
(12, 'Egg', 'An egg is an oval object that is produced by a female bird and which contains a baby bird. ', '2.00', 'pieces', 10, 'egg', 66),
(13, 'Sweet potato', 'Sweet potatoes are vegetables that look like large ordinary potatoes but taste sweet. ', '2.25', 'kilo', 1, 'sweet_potato', 92),
(14, 'hotdog', 'a small cooked sausage that is mild in flavor and is usually served in a long roll (called a hot dog bun)', '3.58', 'g', 550, 'hotdogs', 247),
(15, 'Bread bun', 'A bun is a type of bread roll, typically filled with savory fillings ', '1.19', 'pieces', 6, 'bread_bun', 122);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `grocery`
--

CREATE TABLE `grocery` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `grocery`
--

INSERT INTO `grocery` (`id`, `user_id`, `article_id`, `amount`) VALUES
(1, 1, 5, 2),
(4, 1, 10, 1),
(5, 1, 13, 2),
(6, 1, 15, 1),
(7, 3, 6, 1),
(8, 2, 13, 1),
(9, 3, 12, 2),
(10, 2, 8, 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `ingredient`
--

CREATE TABLE `ingredient` (
  `id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `ingredient`
--

INSERT INTO `ingredient` (`id`, `recipe_id`, `article_id`, `amount`) VALUES
(2, 1, 1, 1),
(3, 1, 9, 1),
(4, 1, 10, 1),
(5, 1, 8, 10),
(6, 1, 7, 5),
(7, 1, 6, 114),
(8, 1, 5, 5),
(9, 1, 4, 5),
(10, 1, 3, 5),
(11, 1, 2, 1),
(12, 3, 13, 1),
(13, 4, 14, 135),
(14, 4, 15, 4),
(15, 2, 12, 2);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `kitchen_type`
--

CREATE TABLE `kitchen_type` (
  `id` int(11) NOT NULL,
  `record_type` enum('K','T') NOT NULL,
  `description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `kitchen_type`
--

INSERT INTO `kitchen_type` (`id`, `record_type`, `description`) VALUES
(1, 'K', 'Italian'),
(2, 'T', 'Vegetarian'),
(3, 'K', 'English'),
(4, 'T', 'Breakfast'),
(5, 'K', 'American'),
(6, 'T', 'Meat-dish');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `recipe`
--

CREATE TABLE `recipe` (
  `id` int(11) NOT NULL,
  `kitchen_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `title` varchar(50) NOT NULL,
  `short_description` varchar(256) NOT NULL,
  `long_description` varchar(256) NOT NULL,
  `file_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `recipe`
--

INSERT INTO `recipe` (`id`, `kitchen_id`, `type_id`, `user_id`, `date_added`, `title`, `short_description`, `long_description`, `file_name`) VALUES
(1, 1, 2, 1, '2022-11-17 14:19:41', 'Pizza margherita', 'Experience the taste of Italy with the help of the humble Margherita pizza. A simple pizza with minimal ingredients that’s still able to create a mouthful of heaven with a crispy crust, creamy mozzarella, fragrant tomato sauce and a few fresh basil leaves ', 'A traditional Neapolitan Margherita pizza recipe is tomato sauce with fresh tomatoes, mozzarella cheese and basil which represent the colours of the Italian flag – white cheese, green basil and red tomato. ', 'pizza_margherita'),
(2, 3, 4, 2, '2022-11-17 15:54:03', 'Omelet', 'Master the omelette with our simple recipe then add the filling of your choice – grated cheese, ham, fresh herbs, mushrooms and smoked salmon are favourites.', 'lorem ipsum longer omelet text', 'omelet'),
(3, 5, 2, 3, '2022-11-17 16:07:00', 'Baked sweet potatoes', 'A perfect baked potato is hard to beat. The outside is brown and crisp, coated in a crust of sea salt. Pierce the skin, and your fork gives way to a soft, fluffy interior. ', 'It might be hard to resist eating the whole thing straight out of the oven, but if you take the time to top it with a pat of butter or a dollop of (cashew) sour cream, you won’t be able to deny that it was worth the wait.', 'sweet_potatoes'),
(4, 5, 6, 3, '2022-11-18 08:19:28', 'Air fryer hot dogs', 'These air fryer hot dogs in toasted buns turn out perfectly crisp in minutes with the help of your air fryer. Top with ketchup, mustard, relish, chili, or condiments of choice.', 'From summer barbecues through to Bonfire Night, hot dogs will never go out of style.', 'hotdog');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `recipe_info`
--

CREATE TABLE `recipe_info` (
  `id` int(11) NOT NULL,
  `record_type` enum('C','R','F','P') NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `nummeric_field` int(11) DEFAULT NULL,
  `text_field` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `recipe_info`
--

INSERT INTO `recipe_info` (`id`, `record_type`, `recipe_id`, `user_id`, `date`, `nummeric_field`, `text_field`) VALUES
(1, 'P', 1, NULL, '2022-11-17 14:28:57', 1, 'Preheat oven to 400°.'),
(2, 'P', 1, NULL, '2022-11-17 14:29:32', 2, 'Unroll crust dough onto a baking sheet coated with cooking spray; pat into a 13 x 11-inch rectangle. Bake at 400° for 8 minutes. Remove crust from oven, and brush with 1/2 teaspoon oil. Rub crust with cut sides of garlic.'),
(3, 'P', 1, NULL, '2022-11-17 14:29:57', 3, 'Arrange tomato slices on crust, leaving a 1/2-inch border; sprinkle evenly with cheese. Bake at 400° for 12 minutes or until cheese melts and crust is golden.'),
(4, 'P', 1, NULL, '2022-11-17 14:30:36', 4, 'Combine 1/2 teaspoon oil and vinegar, stirring with a whisk.'),
(5, 'P', 1, NULL, '2022-11-17 14:31:02', 5, 'Sprinkle pizza evenly with sliced basil, salt, and pepper. Drizzle the vinegar mixture evenly over the pizza. Cut pizza into 8 pieces.'),
(6, 'C', 1, 1, '2022-11-17 15:41:44', NULL, 'Wat een lekker recept.'),
(7, 'C', 1, 2, '2022-11-17 15:45:13', NULL, 'Gadverdamme!!! EWW'),
(8, 'R', 1, 2, '2022-11-17 15:45:32', 1, NULL),
(9, 'R', 1, 1, '2022-11-17 15:46:23', 5, NULL),
(10, 'F', 1, 1, '2022-11-17 15:46:47', NULL, NULL),
(11, 'P', 2, NULL, '2022-11-17 15:57:11', 1, 'Season the beaten eggs well with salt and pepper. Heat the oil and butter in a non-stick frying pan over a medium-low heat until the butter has melted and is foaming.'),
(12, 'P', 2, NULL, '2022-11-17 15:57:32', 2, 'Pour the eggs into the pan, tilt the pan ever so slightly from one side to another to allow the eggs to swirl and cover the surface of the pan completely. Let the mixture cook for about 20 seconds then scrape a line through the middle with a spatula.'),
(13, 'P', 2, NULL, '2022-11-17 15:57:53', 3, 'Tilt the pan again to allow it to fill back up with the runny egg. Repeat once or twice more until the egg has just set.'),
(14, 'P', 2, NULL, '2022-11-17 15:58:16', 4, 'At this point you can fill the omelette with whatever you like – some grated cheese, sliced ham, fresh herbs, sautéed mushrooms or smoked salmon all work well. Scatter the filling over the top of the omelette and fold gently in half with the spatula. Slide'),
(15, 'R', 2, 3, '2022-11-17 15:58:51', 4, NULL),
(16, 'F', 2, 2, '2022-11-17 15:59:15', NULL, NULL),
(17, 'C', 2, 2, '2022-11-17 15:59:34', NULL, 'Yummy!'),
(18, 'P', 3, NULL, '2022-11-17 16:07:33', 1, 'Wash the sweet potatoes thoroughly. Make small holes with fork. Cut into small pieces and bake at 120 degrees for 10 minutes. Occasionally flip till crispy sweet potatoes are ready. '),
(19, 'P', 4, NULL, '2022-11-18 08:27:23', 1, 'Preheat an air fryer to 400 degrees F (200 degrees C).'),
(20, 'P', 4, NULL, '2022-11-18 08:27:23', 2, 'Place buns in a single layer in the air fryer basket; cook in the preheated air fryer until crisp, about 2 minutes. Remove buns to a plate. '),
(21, 'P', 4, NULL, '2022-11-18 08:27:45', 3, 'Place hot dogs in a single layer in the air fryer basket; cook for 3 minutes. Serve hot dogs in toasted buns. '),
(22, 'R', 4, 2, '2022-11-18 08:28:00', 4, NULL),
(24, 'C', 4, 3, '2022-11-18 08:28:58', NULL, 'I love this recipe!'),
(25, 'F', 4, 3, '2022-11-18 08:29:17', NULL, NULL),
(26, 'F', 2, 1, '2022-11-18 11:40:05', NULL, NULL),
(27, 'F', 3, 2, '2022-11-18 11:47:04', NULL, NULL),
(45, 'F', 3, 1, '2022-11-28 11:53:51', NULL, NULL),
(46, 'F', 3, 3, '2022-11-28 11:56:05', NULL, NULL),
(48, 'R', 1, 3, '2022-11-28 12:26:40', 5, NULL),
(50, 'R', 3, 3, '2022-11-28 12:38:39', 2, NULL),
(51, 'R', 4, 3, '2022-11-28 13:22:31', 1, NULL);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `file_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `user`
--

INSERT INTO `user` (`id`, `user_name`, `password`, `email`, `file_name`) VALUES
(1, 'merel2001', 'password', 'merel@merel.com', 'merel_pfp'),
(2, 'BobTheWizzard', 'password', 'bob@bob.nl', 'bob_pfp'),
(3, 'JanDeMan', 'password', 'jan@jan.com', 'jan_pfp');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `grocery`
--
ALTER TABLE `grocery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_id` (`article_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexen voor tabel `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dish_id` (`recipe_id`),
  ADD KEY `article_id` (`article_id`);

--
-- Indexen voor tabel `kitchen_type`
--
ALTER TABLE `kitchen_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type_id` (`type_id`),
  ADD KEY `kitchen_id` (`kitchen_id`);

--
-- Indexen voor tabel `recipe_info`
--
ALTER TABLE `recipe_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dish_id` (`recipe_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexen voor tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `article`
--
ALTER TABLE `article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT voor een tabel `grocery`
--
ALTER TABLE `grocery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT voor een tabel `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT voor een tabel `kitchen_type`
--
ALTER TABLE `kitchen_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT voor een tabel `recipe`
--
ALTER TABLE `recipe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT voor een tabel `recipe_info`
--
ALTER TABLE `recipe_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT voor een tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `grocery`
--
ALTER TABLE `grocery`
  ADD CONSTRAINT `grocery_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`),
  ADD CONSTRAINT `grocery_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Beperkingen voor tabel `ingredient`
--
ALTER TABLE `ingredient`
  ADD CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`),
  ADD CONSTRAINT `ingredient_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`);

--
-- Beperkingen voor tabel `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `recipe_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `kitchen_type` (`id`),
  ADD CONSTRAINT `recipe_ibfk_3` FOREIGN KEY (`kitchen_id`) REFERENCES `kitchen_type` (`id`);

--
-- Beperkingen voor tabel `recipe_info`
--
ALTER TABLE `recipe_info`
  ADD CONSTRAINT `recipe_info_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`),
  ADD CONSTRAINT `recipe_info_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
