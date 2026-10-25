-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: sql105.infinityfree.com
-- Waktu pembuatan: 24 Okt 2026 pada 22.03
-- Versi server: 11.4.13-MariaDB
-- Versi PHP: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `if0_43145767_hackercrowds`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `programs`
--

CREATE TABLE `programs` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `scope` text DEFAULT NULL,
  `reward` varchar(100) NOT NULL DEFAULT '',
  `status` varchar(50) NOT NULL DEFAULT 'Live',
  `verification_status` varchar(50) NOT NULL DEFAULT 'Active/Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `hacker_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `vulnerability_type` varchar(100) NOT NULL DEFAULT 'Lainnya / Umum',
  `severity` varchar(20) NOT NULL DEFAULT 'Medium',
  `vulnerability_details` text DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'New',
  `payment_status` varchar(20) NOT NULL DEFAULT 'Unpaid',
  `reward` decimal(12,2) NOT NULL DEFAULT 0.00,
  `verification_status` varchar(50) NOT NULL DEFAULT 'Active/Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `report_comments`
--

CREATE TABLE `report_comments` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(30) NOT NULL DEFAULT 'hacker',
  `fullname` varchar(255) NOT NULL DEFAULT '',
  `profile_pic` varchar(255) DEFAULT NULL,
  `ptkp_status` varchar(20) NOT NULL DEFAULT 'TK/0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `fullname`, `profile_pic`, `ptkp_status`, `created_at`) VALUES
(1, 'Joseaja.py', 'migeljose33@gmail.com', '$2y$12$brFFW4PJq2h3T3oc8vAtZ.Q2bFa9FnxVCXbzV70zV4cRaMr0HgV1G', 'owner', '', NULL, 'TK/0', '2026-10-25 01:53:57');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activity_logs_user_created` (`user_id`,`created_at`),
  ADD KEY `idx_activity_logs_action_created` (`action`,`created_at`);

--
-- Indeks untuk tabel `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_messages_sender_receiver_created` (`sender_id`,`receiver_id`,`created_at`),
  ADD KEY `idx_messages_receiver_sender_created` (`receiver_id`,`sender_id`,`created_at`),
  ADD KEY `idx_messages_receiver_read` (`receiver_id`,`is_read`);

--
-- Indeks untuk tabel `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_programs_company_status` (`company_id`,`status`),
  ADD KEY `idx_programs_verification_status` (`verification_status`),
  ADD KEY `idx_programs_created_at` (`created_at`);

--
-- Indeks untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_reports_hacker_status` (`hacker_id`,`status`),
  ADD KEY `idx_reports_program_status` (`program_id`,`status`),
  ADD KEY `idx_reports_payment_status` (`payment_status`),
  ADD KEY `idx_reports_verification_status` (`verification_status`),
  ADD KEY `idx_reports_created_at` (`created_at`);

--
-- Indeks untuk tabel `report_comments`
--
ALTER TABLE `report_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_report_comments_report_created` (`report_id`,`created_at`),
  ADD KEY `idx_report_comments_user_id` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_username` (`username`),
  ADD UNIQUE KEY `uniq_email` (`email`),
  ADD KEY `idx_users_role` (`role`),
  ADD KEY `idx_users_created_at` (`created_at`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `programs`
--
ALTER TABLE `programs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `report_comments`
--
ALTER TABLE `report_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `fk_activity_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_messages_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_messages_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `programs`
--
ALTER TABLE `programs`
  ADD CONSTRAINT `fk_programs_company` FOREIGN KEY (`company_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_reports_hacker` FOREIGN KEY (`hacker_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reports_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `report_comments`
--
ALTER TABLE `report_comments`
  ADD CONSTRAINT `fk_report_comments_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_report_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
