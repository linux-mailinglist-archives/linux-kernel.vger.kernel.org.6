Return-Path: <linux-kernel+bounces-423908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4109DAE24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE09166564
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2AA202F73;
	Wed, 27 Nov 2024 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="szzFNdQF"
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681C82D66;
	Wed, 27 Nov 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737130; cv=none; b=WnxySwbRmURufTLghoDBajgUiBaOj5wceygXWThSoUkEBOxYNSPV3qFj6QafjfrDiJmRDgQ4Uytycdgnr5aSLvalCheZe697d+Ej22TE+4mDvgEzf3PLRuNn/UrlrqvKs7K2eYhvc6ChWnv3xw47fQ2kQqgQKMba2OAHS9ebXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737130; c=relaxed/simple;
	bh=9OXWDCL+ZUm0Rd4Zlgsj1Uw1/4MpCmgYer0oaJua2iU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QulnEx7v6xoPTsvPIy57m3P3YdYLJUAOzEUcCvHpCc0AjNcoUrAREPJp7/02CKyQ81WC7ObIPZq4HsXX7gcMuFv25caoOwKFAnJpwXl5/aBx5o1AXD5brLs/ixckLRZ8GCLN+3Svf0+y4D5IzZ0iadOec/mTxgNjVJkKmKcSjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=szzFNdQF; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id BCA363F4D5EE;
	Wed, 27 Nov 2024 20:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732736761;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=9OXWDCL+ZUm0Rd4Zlgsj1Uw1/4MpCmgYer0oaJua2iU=;
	b=szzFNdQFIfU7RJm/QK/TMQ9Z8aNLzvy0B+Qj/XhaYc/1RnFgDFhoSBKtXhcdqXOL
	CC5gH2Us1sgnnDLUrD0vXsiaIyyChGBklqbQJaqUfpMF+RJVVmIUHXeoo64WS+xjaIU
	gUZM62YPPDY+YcAn/Din9uhqQH3zejBor0t3yiA/v2RxONLME6gyCRIdBN6S7S36LEV
	b/ttKJIG3MHR9f3TFUVffe/XRCvDwxlw+gWKyHy4f8RQfeUqTPs/m7kNuRjx9QEkG6J
	Z+b9HXWcRBxQtgrt+0/fRyJ4GNLckUskD7C5EAZNAXyLLCl2Q94l8ARPnDySGmIGYY/
	Wn0AJrib7w==
Date: Wed, 27 Nov 2024 20:46:01 +0100 (CET)
From: jens.korinth@tuta.io
To: Daniel Sedlak <daniel@sedlak.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rust For Linux <rust-for-linux@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <OCj9As8--F-9@tuta.io>
In-Reply-To: <230b3602-5d68-4e79-969d-0d2df1fdf033@sedlak.dev>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io> <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io> <230b3602-5d68-4e79-969d-0d2df1fdf033@sedlak.dev>
Subject: Re: [PATCH v4 1/3] rust: Add `OnceLite` for executing code once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Have you considered it to be implemented like `AtomicU32`? I think=E2=84=
=A2 that
> one atomic variable is more than enough.

Just to clarify - you mean something like this? Nevermind the magic numbers=
,
I'd replace them, of course.

diff --git a/rust/kernel/once_lite.rs b/rust/kernel/once_lite.rs
index 723c3244fc85..0622ecbfced5 100644
--- a/rust/kernel/once_lite.rs
+++ b/rust/kernel/once_lite.rs
@@ -16,7 +16,7 @@
//!
//! Reference: <https://doc.rust-lang.org/std/sync/struct.Once.html>
=C2=A0
-use core::sync::atomic::{AtomicBool, Ordering::Relaxed};
+use core::sync::atomic::{AtomicU32, Ordering::Acquire, Ordering::Relaxed};
=C2=A0
/// A low-level synchronization primitive for one-time global execution.
///
@@ -44,13 +44,13 @@
/// assert_eq!(x, 42);
/// ```
///
-pub struct OnceLite(AtomicBool, AtomicBool);
+pub struct OnceLite(AtomicU32);
=C2=A0
impl OnceLite {
=C2=A0=C2=A0=C2=A0=C2=A0 /// Creates a new `OnceLite` value.
=C2=A0=C2=A0=C2=A0=C2=A0 #[inline(always)]
=C2=A0=C2=A0=C2=A0=C2=A0 pub const fn new() -> Self {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(AtomicBool::new(false), At=
omicBool::new(false))
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(AtomicU32::new(0))
=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 /// Performs an initialization routine once and on=
ly once. The given
@@ -71,10 +71,10 @@ pub const fn new() -> Self {
=C2=A0=C2=A0=C2=A0=C2=A0 /// [`DO_ONCE_LITE_IF`]: srctree/include/once_lite=
.h
=C2=A0=C2=A0=C2=A0=C2=A0 #[inline(always)]
=C2=A0=C2=A0=C2=A0=C2=A0 pub fn call_once<F: FnOnce()>(&self, f: F) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if !self.0.load(Relaxed) && !se=
lf.0.swap(true, Relaxed) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f()
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.0.load(Relaxed) =3D=3D =
0 && self.0.compare_exchange(0, 1, Acquire, Relaxed) =3D=3D Ok(0) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f();
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.0.=
store(2, Relaxed);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.1.store(true, Relaxed);
=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 /// Returns `true` if some `call_once` call has co=
mpleted successfully.
@@ -98,7 +98,7 @@ pub fn call_once<F: FnOnce()>(&self, f: F) {
=C2=A0=C2=A0=C2=A0=C2=A0 /// ```
=C2=A0=C2=A0=C2=A0=C2=A0 #[inline(always)]
=C2=A0=C2=A0=C2=A0=C2=A0 pub fn is_completed(&self) -> bool {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.1.load(Relaxed)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.0.load(Relaxed) > 1
=C2=A0=C2=A0=C2=A0=C2=A0 }
}

> The `rust` part should be default value for rustdoc tests, can we please
> omit that?

Will do!

Jens

