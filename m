Return-Path: <linux-kernel+bounces-327217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E2797727B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECACB282780
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF261BFDE5;
	Thu, 12 Sep 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BUPSlXGi"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96313D530;
	Thu, 12 Sep 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171005; cv=none; b=g565rqrMQu2X9laDO0WjA4POPBxKuLTr+LusDSKkDhdPqk/ugKcJtdPwLIwDFRZp6jcuSI7s8IYyJ9nt09jeFYuWoTlFfW+yuxm9rWyuaKzQhIbhIqq7fnac2yFY5HPvDPwUjDH3MB4FoXWVarYoQxG75Pxnr/GICTZqGIc/Zhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171005; c=relaxed/simple;
	bh=jn24PCsRq7rS3UjmaQrGE6VHsaCJKDC/zjSJEp9fxgI=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=MfC9uDwH28QmTdnnDbRqNsvcmbpp5QM6J4vgN79pu1+uuR6kd0vFy5yQxALvctxq3PlKEP3GvenxbcsV5ptvaNEoZqFcW/MUGHVgXvwVEj4cEkjAVql6Dt53+NR/DoR1AXYrTO1uLfm4o5aXNigB4At/rynt0Q6P/Bg27SYR26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BUPSlXGi; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726171000; x=1726430200;
	bh=UtTV70sJnMZEWjp2Gmu0UPl2yJFbUM1VFJZP0vfjRqI=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BUPSlXGiY7Sog9nnc6qBCwQhLWaxm9T3tVX0AZRrTKhewJHejqSmZa89cyvlAJZRV
	 kT6VeA604s1udVAjQoNDp/S+eyY6wv9T34eW+Tbp5ccAsyHfrZlS52SjFQz6W42uRt
	 lUQ2p9jWpFbgV8yJ8LxXmKyAEbeCRvsdmh6bqS0PiYkYtDly7hdBPdfrlTir050MOw
	 fRkU9f9IEchH3c3WB4Arq85YsTaPXYfrJ+CKoe0HeCw8yzhMLtNeDtcx1sS6asSt5q
	 h3UNpEMszbNKtk25GJ9+rvlfsD15ZVWohjWSlOPQT0Yl23QVDxiGOVzYK3vKyaMwgf
	 a7+5O1+aA4cfA==
Date: Thu, 12 Sep 2024 19:56:36 +0000
To: a.hindborg@samsung.com, alex.gaynor@gmail.com, alexanderaltman@me.com, alexmantel93@mailbox.org, aliceryhl@google.com, aswinunni01@gmail.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, kernel@valentinobst.de, linux-kernel@vger.kernel.org, ojeda@kernel.org, paddymills@proton.me, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com, yakoyoku@gmail.com
From: Patrick Miller <paddymills@proton.me>
Subject: [PATCH v3 1/2] docs: rust: make section names plural
Message-ID: <20240912195629.227696-1-paddymills@proton.me>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: b1cf0e057c641509777efcb77f939149bf1a1420
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------fa271470f0deb941e48ffe37d3d7b57d36e8427dc6ad3a5518552c2bccb1c818"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------fa271470f0deb941e48ffe37d3d7b57d36e8427dc6ad3a5518552c2bccb1c818
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
From: Patrick Miller <paddymills@proton.me>
To: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	alexanderaltman@me.com,
	alexmantel93@mailbox.org,
	aliceryhl@google.com,
	aswinunni01@gmail.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	paddymills@proton.me,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	wedsonaf@gmail.com,
	yakoyoku@gmail.com
Subject: [PATCH v3 1/2] docs: rust: make section names plural
Date: Thu, 12 Sep 2024 15:56:29 -0400
Message-ID: <20240912195629.227696-1-paddymills@proton.me>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0

Fixes existing rust documentation section headers to be use plural names.

Signed-off-by: Patrick Miller <paddymills@proton.me>
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1110

---
 rust/kernel/init.rs     | 2 +-
 rust/kernel/list/arc.rs | 2 +-
 rust/kernel/sync/arc.rs | 2 +-
 rust/macros/lib.rs      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a17ac8762d8f..98889ddf9828 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -746,7 +746,7 @@ macro_rules! try_init {
 /// Asserts that a field on a struct using `#[pin_data]` is marked with `#[pin]` ie. that it is
 /// structurally pinned.
 ///
-/// # Example
+/// # Examples
 ///
 /// This will succeed:
 /// ```
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index d801b9dc6291..611ce07cd290 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ 
-464,7 +464,7 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc
 
 /// A utility for tracking whether a [`ListArc`] exists using an atomic.
 ///
-/// # Invariant
+/// # Invariants
 ///
 /// If the boolean is `false`, then there is no [`ListArc`] for this value.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3021f30fd822..3d3c100b0c0d 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -436,7 +436,7 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
 /// There are no mutable references to the underlying [`Arc`], and it remains valid for the
 /// lifetime of the [`ArcBorrow`] instance.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```
 /// use kernel::sync::{Arc, ArcBorrow};
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index a626b1145e5c..3879e1162866 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -307,7 +307,7 @@ pub fn pinned_drop(args: TokenStream, 
input: TokenStream) -> TokenStream {
 /// literals (lifetimes and documentation strings are not supported). There is a difference in
 /// supported modifiers as well.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```ignore
 /// use kernel::macro::paste;
-- 
2.46.0


--------fa271470f0deb941e48ffe37d3d7b57d36e8427dc6ad3a5518552c2bccb1c818
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmbjR3QJEJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAG7zAQClZpMPoxdLb1YtVW1FRyB4QwOW+x7uPSJaYV67/1YApwD/aKdO
MtCDMSdf6ii81N8GgOjimTNxTdhCw5uoGcI1RQs=
=f4lu
-----END PGP SIGNATURE-----


--------fa271470f0deb941e48ffe37d3d7b57d36e8427dc6ad3a5518552c2bccb1c818--


