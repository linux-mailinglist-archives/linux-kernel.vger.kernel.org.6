Return-Path: <linux-kernel+bounces-319230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0CD96F986
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7B7283762
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310201D460D;
	Fri,  6 Sep 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MWYUc1zl"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAF1D4615
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641108; cv=none; b=Ti21AOdxKAHicS+UygwSU/5aDn+guhWo4P6AEQfYhUNCHnhKYbxAuscoFlhhKQbXKs6K4pnn+R9Kv1IKWQdWpXHO+g03cWoyBbGl/74lb0AJWwJSfBJeNqd2k78i3jzRgjoehn7TDuf4sMuUoswWV1gFoYcXZfD66X4R6+0fqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641108; c=relaxed/simple;
	bh=7Y0fGfd8gtNGKjpca54ENKOe9FY3ANpfvPZyDr8Enbg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=jaABKMV6zV55hdxs3P8DiYYAuBHXnZ04vkPZ+xs8Yp0WeBge/F7DaDlIb9PXsJPK02EYjGdYdfjSd2woArBXOkVRLgXneVIIqbALQV7rj7kD81IH82DWxCT5Ma9cSaXu/kdBxlNxClvdkVOlAJJI0aXu6+MgkY17E6zYJFdEEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MWYUc1zl; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725641104; x=1725900304;
	bh=DpW7uHBkGNqx684nG4+xHcawHofHObHuMW3c0eCE9gg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MWYUc1zlW+q1gzui59qWGcdDaOuaUq0eGocx/FpkUcycWIVrQ38b1rMaoP3veFFr6
	 29c5MqY0k6GjggMmutHcwtfaW6Mp30QDC+yuX37GsV4HM7TNqtQiXk1hbZm9y6xyeb
	 4NB2ldIvAQrTcC20HutXzQxBVjXdc1/g24a5RB3YuvlUpOwG3FRwyUf2PfAOorGSAq
	 eB3m6Ug7GDofexxguGDKVduHU8fr0y317y6XwvALmVHLpU8dnqm3W/M1KSXS97xQ46
	 bBkq7kVvcYpz5YsZjHuhCxwr86Fb9XG/IxIKBblW9nGbImtHFzoE8l8rY7rGlTr3uF
	 7M8xMb5A+s94A==
Date: Fri, 06 Sep 2024 16:44:57 +0000
To: a.hindborg@samsung.com, alex.gaynor@gmail.com, alexmantel93@mailbox.org, aliceryhl@google.com, aswinunni01@gmail.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, kernel@valentinobst.de, linux-kernel@vger.kernel.org, nells@linux.microsoft.com, ojeda@kernel.org, paddymills@proton.me, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com, yakoyoku@gmail.com
From: Patrick Miller <paddymills@proton.me>
Subject: [PATCH 1/2] rust doc: make section names plural
Message-ID: <20240906164448.2268368-1-paddymills@proton.me>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: 5c01377fedcf91852b22d426e2ef770ef2bcff29
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------37e878fbfc678cda84bf215366d7de94dccc3b987ee002e06de4a087c40f8a51"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------37e878fbfc678cda84bf215366d7de94dccc3b987ee002e06de4a087c40f8a51
Content-Type: multipart/mixed;
 boundary=b2bde32a4f00d4314d60e193f064646a8b12d929a1261d49ef402e4ceba3
From: Patrick Miller <paddymills@proton.me>
To: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
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
	nells@linux.microsoft.com,
	ojeda@kernel.org,
	paddymills@proton.me,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	wedsonaf@gmail.com,
	yakoyoku@gmail.com
Subject: [PATCH 1/2] rust doc: make section names plural
Date: Fri,  6 Sep 2024 12:44:48 -0400
Message-ID: <20240906164448.2268368-1-paddymills@proton.me>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0

--b2bde32a4f00d4314d60e193f064646a8b12d929a1261d49ef402e4ceba3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fixes rust documentation section headers to be plural.

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
@@ -464,7 +464,7 @@ im
pl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc
 
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
@@ -307,7 +307,7 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream)
 -> TokenStream {
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


--b2bde32a4f00d4314d60e193f064646a8b12d929a1261d49ef402e4ceba3
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - paddymills@proton.me
 - 0xDCA74891.asc"; name="publickey - paddymills@proton.me - 0xDCA74891.asc"
Content-Type: application/pgp-keys; filename="publickey -
 paddymills@proton.me - 0xDCA74891.asc"; name="publickey -
 paddymills@proton.me - 0xDCA74891.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDIu
Ny40CkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWWs0UnNSWUpLd1lCQkFIYVJ3
OEJBUWRBU1FhVy9FUmQ4dGZncXNNSHQweTY3ZFdRTEU3UnV2T3gzanphCmdhRWI0c0xOSzNCaFpH
UjViV2xzYkhOQWNISnZkRzl1TG0xbElEeHdZV1JrZVcxcGJHeHpRSEJ5YjNSdmJpNXQKWlQ3Q2p3
UVFGZ29BSUFVQ1lrNFJzUVlMQ1FjSUF3SUVGUWdLQWdRV0FnRUFBaGtCQWhzREFoNEJBQ0VKRUp0
UgpHcnN1cjU0UkZpRUUzS2RJa1N2VW5DdmU4MDFtbTFFYXV5NnZuaEZpcUFFQXQwVCtwZ3AwUm9X
d0lmbURQRlRuCjNsbVRRcVA0dUEreDRnNXB2OG5SSHBJQS8xVU1YLzh3akZlK24wZUM0V0pqeTRu
NS9OZUtxMXovOFBKdFlhdXMKZVZnT3pqZ0VZazRSc1JJS0t3WUJCQUdYVlFFRkFRRUhRRi9mTnBE
ZmxsRFJuSEhyZUh2VHRJdEZ3dURMM0taQQphaDhZd3dxV0FyNFJBd0VJQjhKNEJCZ1dDQUFKQlFK
aVRoR3hBaHNNQUNFSkVKdFJHcnN1cjU0UkZpRUUzS2RJCmtTdlVuQ3ZlODAxbW0xRWF1eTZ2bmhH
R2Z3RUFuWkFzR3BvTDdRaTlWQ05PcGNrcjB2OE41S3hic2xJTGZlUCsKMmNJU0hlY0Erd1RxWDNs
Z3dnNVJDN1lBT1MvUTBDc3EwY2tPSTBKbnNMS1VaU3I4TlJvQgo9VzE4bgotLS0tLUVORCBQR1Ag
UFVCTElDIEtFWSBCTE9DSy0tLS0t
--b2bde32a4f00d4314d60e193f064646a8b12d929a1261d49ef402e4ceba3--

--------37e878fbfc678cda84bf215366d7de94dccc3b987ee002e06de4a087c40f8a51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmbbMYkJEJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAHYnAP4+B84s8F02tu+c9sxz4hFoorfiXQ+y8tWvTT24EDroRwD+Iqgb
ziqZzBlL7DKStP5T8p8jPBU1qTHyGhAMA93gEQU=
=w993
-----END PGP SIGNATURE-----


--------37e878fbfc678cda84bf215366d7de94dccc3b987ee002e06de4a087c40f8a51--


