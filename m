Return-Path: <linux-kernel+bounces-254651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D49335D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C798284514
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1945D304;
	Wed, 17 Jul 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wbZW8Tok";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Bn8MzfnL"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1277BA53;
	Wed, 17 Jul 2024 03:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188139; cv=none; b=tVOhY9rT5eKOvTirySa80VpJYdAw5EtZP5ptu2H5peBb+81idCxPhe94eHjhvnn2Pp8fQbUF1f0h54Y8QEjFSsGDKhHZ2mwkvPqLxBvasewkdiQWY9lJ89o2UIko9knLCXs0XkICxVxfR8JoyYZ5MYRX0i2m53OBLal1bAttvAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188139; c=relaxed/simple;
	bh=kzcLjw0ZJ1LUOyWZaAd9VLrIqibtp4l0S0m1BKy2X5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1MYZ79F1BXi8s578GPy56kp5dOObc8+1p6ZuF49+lYQRqoYbcrzVlrM5rZwQqZHudGeN+91SX784RrdQCNn66lHtqv3beaqgnh2wic73IwCbR2PBEa7Xrl2iY281oZIGKKYc896PaPnvFPYDGV1OgoMb8n9EW4j+s3P/ow7SSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wbZW8Tok; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Bn8MzfnL; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WP23j3F96z9srb;
	Wed, 17 Jul 2024 05:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721188129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywNnc+MHxw44OkYLuS8j4HRHviDMxXEX4obhKBdL7/w=;
	b=wbZW8TokVNyPL52KoMsTFnmemlud8UR8bUqF/NDERDGdwp71OUwV9NVNj2iJUqWdgjNh1i
	9244omJ2xspuBGt5ey6Lk0qK+kmaFAFn0AqKgH+KaY1oCyLp9bFqBGELc1pUb/x04YI0jx
	pHXONzf0fz79FPxA/Bd+iEg/Z0s6pv7vxhOILpjXpu6mCbKqiF59yhOwjiDYhGDuSPXEqi
	vUaONUHrt5ihcHj/afcARJXR74UlfTBQtcikzgL8Vtr1jRQ8tRAXCMB0fgZIauZnC0Ga3p
	si0gcDhg8F0Iglt9o9QQqTbkYRB3rWR2szuNIVODgezFUVGhgI2ATdM9PhZHUQ==
From: alexmantel93@mailbox.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721188127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywNnc+MHxw44OkYLuS8j4HRHviDMxXEX4obhKBdL7/w=;
	b=Bn8MzfnLsVv/C2Mdi91qYjno1PuwccA17XFu+qiog3lv9y6FnChENwIflTd+8Lrq38rLcI
	9rIyR+J/MwAl+bYyXD9ViAbYwqsdm9v7/DWEKbar7xWShB/kGFjxXkTZLsVPap+XLal8/o
	k5K4EamrmjKYBhsRZ+Y1MqT9wRu6qbxjnv4OUd+NoLFIgitzK7oWpx7YUdB2o1Fr6tad2L
	fRAqctU+50Oeuon35k0PguhmMRuJIk3PPklbXzKQMEdXhLcCG9FlYB+Q5P5O/5iMQBbJXP
	Om7dvJsOQGWMXVbOzPwKlCA/dxLHMC3T7vs4STvCwr2d46OGCnHMcOYkHyJS/A==
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Mantel <alexmantel93@mailbox.org>
Subject: [PATCH] Implement the smart pointer `InPlaceInit` for `Arc`
Date: Tue, 16 Jul 2024 20:48:01 -0700
Message-Id: <20240717034801.262343-2-alexmantel93@mailbox.org>
In-Reply-To: <20240717034801.262343-1-alexmantel93@mailbox.org>
References: <20240717034801.262343-1-alexmantel93@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 85eb6f016e68bffa4b6
X-MBO-RS-META: 19jb8fhb5a39iyfpd4rgj3eqouaja3iu
X-Rspamd-Queue-Id: 4WP23j3F96z9srb

From: Alex Mantel <alexmantel93@mailbox.org>

For pinned and unpinned initialization of structs, a trait named
`InPlaceInit` exists for uniform access. `Arc` did not implement
`InPlaceInit` yet, although the functions already existed. The main
reason for that, was that the trait itself returned a `Pin<Self>`. The
`Arc` implementation of the kernel is already implicitly pinned.

To enable `Arc` to implement `InPlaceInit` and to have uniform access,
for in-place and pinned in-place initialization, an associated type is
introduced for `InPlaceInit`. The new implementation of `InPlaceInit`
for `Arc` sets `Arc` as the associated type. Older implementations use
an explicit `Pin<T>` as the associated type. The implemented methods for
`Arc` are mostly moved from a direct implementation on `Arc`. There
should be no user impact. The implementation for `ListArc` is omitted,
because it is not merged yet.

Link: https://github.com/Rust-for-Linux/linux/issues/1079

Signed-off-by: Alex Mantel <alexmantel93@mailbox.org>
---
 rust/kernel/init.rs     | 37 +++++++++++++++++++++++++++++++++----
 rust/kernel/sync/arc.rs | 25 ++-----------------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 68605b633..46f50cf12 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -213,6 +213,7 @@
 use crate::{
     alloc::{box_ext::BoxExt, AllocError, Flags},
     error::{self, Error},
+    sync::Arc,
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
 };
@@ -1112,11 +1113,15 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 
 /// Smart pointer that can initialize memory in-place.
 pub trait InPlaceInit<T>: Sized {
+    /// A type might be pinned implicitly. An addtional `Pin<ImplicitlyPinned>` is useless. In
+    /// doubt, the type can just be set to `Pin<Self>`.
+    type PinnedResult;
+
     /// Use the given pin-initializer to pin-initialize a `T` inside of a new smart pointer of this
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedResult, E>
     where
         E: From<AllocError>;
 
@@ -1124,7 +1129,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>,
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
-    fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Pin<Self>>
+    fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Self::PinnedResult>
     where
         Error: From<E>,
     {
@@ -1153,9 +1158,31 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
     }
 }
 
+impl<T> InPlaceInit<T> for Arc<T> {
+    type PinnedResult = Self;
+
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedResult, E>
+    where
+        E: From<AllocError>,
+    {
+        UniqueArc::try_pin_init(init, flags).map(|u| u.into())
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        UniqueArc::try_init(init, flags).map(|u| u.into())
+    }
+}
+
 impl<T> InPlaceInit<T> for Box<T> {
+    type PinnedResult = Pin<Self>;
+
     #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedResult, E>
     where
         E: From<AllocError>,
     {
@@ -1184,8 +1211,10 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
 }
 
 impl<T> InPlaceInit<T> for UniqueArc<T> {
+    type PinnedResult = Pin<Self>;
+
     #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedResult, E>
     where
         E: From<AllocError>,
     {
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3673496c2..3021f30fd 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -12,12 +12,13 @@
 //! 2. It does not support weak references, which allows it to be half the size.
 //! 3. It saturates the reference count instead of aborting when it goes over a threshold.
 //! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
+//! 5. The object in [`Arc`] is pinned implicitly.
 //!
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
     alloc::{box_ext::BoxExt, AllocError, Flags},
-    error::{self, Error},
+    bindings,
     init::{self, InPlaceInit, Init, PinInit},
     try_init,
     types::{ForeignOwnable, Opaque},
@@ -209,28 +210,6 @@ pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         // `Arc` object.
         Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
     }
-
-    /// Use the given initializer to in-place initialize a `T`.
-    ///
-    /// If `T: !Unpin` it will not be able to move afterwards.
-    #[inline]
-    pub fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Self>
-    where
-        Error: From<E>,
-    {
-        UniqueArc::pin_init(init, flags).map(|u| u.into())
-    }
-
-    /// Use the given initializer to in-place initialize a `T`.
-    ///
-    /// This is equivalent to [`Arc<T>::pin_init`], since an [`Arc`] is always pinned.
-    #[inline]
-    pub fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
-    where
-        Error: From<E>,
-    {
-        UniqueArc::init(init, flags).map(|u| u.into())
-    }
 }
 
 impl<T: ?Sized> Arc<T> {
-- 
2.39.2


