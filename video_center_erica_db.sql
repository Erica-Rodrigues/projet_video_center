-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : dim. 31 août 2025 à 21:55
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `video_center_erica_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20250728150320', '2025-07-28 17:03:46', 25),
('DoctrineMigrations\\Version20250805092929', '2025-08-05 11:30:52', 88),
('DoctrineMigrations\\Version20250805110540', '2025-08-05 13:06:46', 37),
('DoctrineMigrations\\Version20250805174018', '2025-08-05 19:41:39', 74),
('DoctrineMigrations\\Version20250805180754', '2025-08-05 20:08:39', 22),
('DoctrineMigrations\\Version20250813225500', '2025-08-14 00:57:07', 36),
('DoctrineMigrations\\Version20250815162132', '2025-08-15 18:23:15', 46);

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

CREATE TABLE `reset_password_request` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `selector` varchar(20) NOT NULL,
  `hashed_token` varchar(100) NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `is_verified` tinyint(1) NOT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `image_size` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `created_at`, `updated_at`, `is_verified`, `image_name`, `image_size`) VALUES
(1, 'carinajose@gmail.com', '[]', '$2y$13$ewvUngfCJY.hJcGg1Xls..u45XgIMIfwYvwpl6gw1mmlCemaznCVy', 'Carina', 'Jose', '2025-08-05 19:31:45', '2025-08-19 23:43:28', 0, 'img-2602-68a4f00042e68374399975.jpg', 339915),
(2, 'erica@medium.be', '[]', '$2y$13$SlKf1Q2J7S.OVWMADDwJpOpP8Xd6OVUA.zIoVUq/KHB.PuYmePX72', 'Erica', 'Rodrigues', '2025-08-12 12:06:55', '2025-08-15 18:35:36', 1, 'img-2594-689f61d83580a496277043.jpg', 91872),
(3, 'vitoriacavadas@hotmail.com', '[]', '$2y$13$5SRD9mz8KqjB2kIHQzDVbeNPUu/2WmNDl9kX/D9h74yrtlrLOz1Dq', 'Vitoria', 'Cavadas', '2025-08-19 21:14:54', '2025-08-19 23:39:59', 1, 'img-2601-68a4ef2f469f1571477028.jpg', 248216),
(4, 'vania.c@gmail.com', '[]', '$2y$13$HarUcmZ7mEx3HMd3UmzdCebb5gQlyWLHvNYShpocqeoYmBkR.Tlhe', 'Vania', 'Coutinho', '2025-08-19 22:47:34', '2025-08-19 22:47:34', 1, 'noProfile.JPG', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `videos`
--

CREATE TABLE `videos` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `video_link` varchar(500) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `user_id` int(11) NOT NULL,
  `premium_video` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `videos`
--

INSERT INTO `videos` (`id`, `title`, `video_link`, `description`, `created_at`, `updated_at`, `user_id`, `premium_video`) VALUES
(1, 'Fall Clothing haul', 'https://www.youtube.com/embed/lRvxMbSCYYw', 'Try On Fall Clothing Haul | wardrobe essentials, accessories, shoes, etc.', '2025-08-14 00:20:01', '2025-08-14 01:05:20', 2, 1),
(2, 'What Are People Wearing in New York ?', 'https://www.youtube.com/embed/nygP5RV3jRI', 'What are people wearing in New York? Explore the fashion trends 2025 has to offer and learn what\'s hot! From nyc street style to casual summer outfits, we\'ve got you covered. We take a look at the coolest street fashion and hottest summer wardrobes that are sure to be awesome in the coming year.', '2025-08-14 01:01:37', '2025-08-14 01:04:39', 2, 0),
(3, 'My first trip to Kauai', 'https://www.youtube.com/embed/_ns9pSkMpU0', 'Kauai, The most beautiful island in Hawaii', '2025-08-19 21:03:33', '2025-08-19 21:03:33', 2, 1),
(4, 'Living in London', 'https://www.youtube.com/embed/4Lzhzl9E81U', 'Spring in the city, outfits of the week', '2025-08-19 21:05:23', '2025-08-19 21:05:23', 2, 0),
(5, 'Vlog japon |Ep.1', 'https://www.youtube.com/embed/hKAucSW1l7A', 'Mon road trip au Japon tourne mal', '2025-08-19 21:07:13', '2025-08-19 21:07:13', 2, 1),
(6, 'Vlog Japon |Ep.2', 'https://www.youtube.com/embed/lF_2UEMVWIE', 'J\'ai dormi dans une maison HANTÉE au Japon', '2025-08-19 21:08:26', '2025-08-19 21:08:26', 2, 1),
(7, 'Vlog Japon |Ep.3', 'https://www.youtube.com/embed/W07bukS6xPc', 'J’ai visitée l’île de Princesse Mononoké au Japon!', '2025-08-19 21:09:29', '2025-08-19 21:09:29', 2, 1),
(8, 'Vlog Japon |Ep.4', 'https://www.youtube.com/embed/Z0NLMqXjJro', 'Le PLUS VIEIL ARBRE du Japon', '2025-08-19 21:10:28', '2025-08-19 21:10:28', 2, 1),
(9, 'Lua', 'https://www.youtube.com/embed/PUtNnf1yZ-A', 'Lua - Ivandro | Letra e instrumental por Ivandro', '2025-08-19 21:21:08', '2025-08-19 21:21:08', 3, 1),
(10, 'Damson Idris |Chicken Shop Date', 'https://www.youtube.com/embed/fIaB88pgfg0', 'Amelia meets Damson Idris for a date in a Chicken Shop.', '2025-08-19 21:22:47', '2025-08-19 21:22:47', 3, 0),
(11, 'Does Cleo Still Want to Be White? - Ep. 4', 'https://www.youtube.com/embed/a_tA9D12lAo', 'In this episode of DBR, Bretman sits down with his niece Cleo for a heartwarming and hilarious chat. They dive into Cleo’s life growing, share behind-the-scenes family stories, and explore Cleo’s own dreams and ambitions.', '2025-08-19 21:24:28', '2025-08-19 21:24:28', 3, 0),
(12, 'Billie Eilish Gets Ready for the Met Gala | Vogue', 'https://www.youtube.com/embed/4FVbWTCO8Kc', 'Pop superstar Billie Eilish embodies a Gen-Z take on the classic Chanel darling.', '2025-08-19 21:26:08', '2025-08-19 21:26:08', 3, 0),
(13, 'Billie Eilish: Same Interview', 'https://www.youtube.com/embed/PsHx7bMIFC4', '“I can’t believe where my life has gone, and where it is now.” We\'ve been following Billie Eilish\'s journey through pop superstardom–and many different hair colors–for the last seven years. Though we didn’t release an interview in 2023, the “What Was I Made For?” singer did sit for one. Billie rewatches clips of that never-before-seen interview in this year’s video. For the eighth year, the pop star sits down to answer questions about her career, her fans, her romantic life, and more.', '2025-08-19 21:30:40', '2025-08-19 21:30:40', 3, 0),
(14, 'Self Control', 'https://www.youtube.com/embed/BME88lS6aVY', 'Self Control - Frank Ocean', '2025-08-19 22:35:27', '2025-08-19 22:35:27', 3, 1),
(15, 'Move like you have time', 'https://www.youtube.com/embed/6xmOLoBKrdg', 'a reverent chat on sacred kindness, emotional alchemy, living unhurried, and staying open to the universe\'s endless outcomes— no expectations, just god and good.', '2025-08-19 22:50:58', '2025-08-19 22:50:58', 4, 0),
(16, 'It\'s been done before but not by you', 'https://www.youtube.com/embed/JMCzTBlODIw', 'creativity is something that is thought of as belonging to select individuals. but the truth is, we are all creators. everything that we can (and cannot) see, was crafted by divine. by source. by god energy. so creativity is inherently apart of each and every one of us. it’s woven into the nuances of everyday life. even when you think you aren’t creating, you are creating. when you breathe. when you move your body. when you have a conversation. when you write. when you cook. when you laugh. you are collaborating with the universe and everyone and everything else that exists within it.   while we are all creatives, we are all individual beings with unique experiences and perspectives. therefore, no one that exists will ever be able to do something the way that you will do it. originality and authenticity is a beautiful result of being deeply connected to your soul. in the age of aquarius, so much knowledge, information, and tools are accessible to us—which i’m so grateful for. with the accessibility, the one thing that remains inaccessible to the rest of the world is you. your mind. your authenticity. you are your greatest asset. now is the time to be yourself more than ever. we desperately need you to be you. we are rooting for you.', '2025-08-19 22:53:09', '2025-08-19 22:53:09', 4, 1),
(17, 'Vulnerability is a bridge', 'https://www.youtube.com/embed/WzyTd-VaSpw', 'Tom Rosenthal approaches a stranger on a park bench and asks if he can sit down next to them and record their conversation.', '2025-08-19 22:54:37', '2025-08-19 22:54:37', 4, 1),
(18, 'You’re too afraid to build the life you want', 'https://www.youtube.com/embed/U_73ghRDzYQ', 'You say you want change, but are you actually ready for it? The truth is, you’re not stuck because of your circumstances—you’re stuck because you’re afraid of becoming the person who can live the life you dream of.  The version of you that plays it safe? That overthinks? That waits for permission? That version has to go.  This video is for the people who know they were made for more but keep hesitating. It’s time to stop waiting and start becoming.  Watch now and take the first step toward the life you actually want.  always remember that  • before we are anything else, we are first human • everybody deserves to be treated with dignity and respect • kindness costs nothing :)', '2025-08-19 22:57:47', '2025-08-19 22:57:47', 4, 0),
(19, 'The Orishas - Yoruba Mythology', 'https://www.youtube.com/embed/v1MEo2a1k7w', 'In this video, we invite you to join us on a fascinating journey into the world of African mythology and religion, as we explore the Yoruba pantheon of Orishas, deities, and spirits.  The Yoruba religion is one of the most complex and influential religious systems in Africa, with a rich history and vibrant traditions that continue to inspire and influence people around the world.  In this video, we delve into the fascinating history of the Yoruba people and their spiritual beliefs, examining the unique qualities and characteristics of each Orisha and exploring their cultural significance.  Whether you\'re a fan of mythology and religion, or simply curious about the diverse traditions of African culture, this video is sure to provide a wealth of insights and information.', '2025-08-19 22:59:24', '2025-08-19 22:59:24', 4, 1),
(20, 'Ponto de Zé Pelintra - Na porta da delegacia', 'https://www.youtube.com/embed/py6eQPGPXuY', 'LETRA DO PONTO  Na porta da delegacia seu delegado eu não matei minha pretinha  Homem que estava com ela era um covarde   Quando meu punhal eu joguei  O homem saiu da frente e a mulher que eu mais amava eu matei  Chorei, chorei a mulher que eu mais amava eu matei  Foram sete punhaladas em cima do coração eu me chamo malandro e não aceito traição🥃🎲', '2025-08-19 23:00:40', '2025-08-19 23:00:40', 4, 1),
(21, 'Change your Reality and get Unstuck', 'https://www.youtube.com/embed/z7-R5U65ZP4', 'Rishani P STORYTELLER', '2025-08-19 23:02:13', '2025-08-19 23:02:13', 4, 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7CE748AA76ED395` (`user_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`);

--
-- Index pour la table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_29AA6432A76ED395` (`user_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `FK_29AA6432A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
