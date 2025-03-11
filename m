Return-Path: <linux-kernel+bounces-557082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B547DA5D36A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16A917A214
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58225235371;
	Tue, 11 Mar 2025 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="2cNXV4WV";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="UoYVnyIr"
Received: from a8-95.smtp-out.amazonses.com (a8-95.smtp-out.amazonses.com [54.240.8.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96A233D89;
	Tue, 11 Mar 2025 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741737528; cv=none; b=UVepzrs16sRe527T5cH+ClBLOAAgljr2P++2Ri18ymMKQg49LtirIEtujfYGxQQARXsfunYlH2CZWtGU/oif6ISMK7zlP2ToZNYnUitti6Q5XNl330NpE+IL+kTIj7qQjNZ3I3VaL95vrr+Gp8VMnHtDZaRhTQeKlan6RizIZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741737528; c=relaxed/simple;
	bh=S89VYiNjTrAawzR8pDNsckPg14WX/oNcDQkKjNu0KPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN6Y37EjeFPG1tN0vezwUIAnlt1ua43uLUXw14+bsUSmu+sONF5aVJ49e9nkbtQUCYGrsA+jb0Qz9ljg/RUsouaPg1lroZk03KYOBIQ38IlmAfaM567hxPkbZL/PqyHQNVxNpCjjK1/id7cu4K2wZYoziiFgy4uXTontTja23Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=2cNXV4WV; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=UoYVnyIr; arc=none smtp.client-ip=54.240.8.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741737526;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S89VYiNjTrAawzR8pDNsckPg14WX/oNcDQkKjNu0KPc=;
	b=2cNXV4WVUh0BE51JLrfSf+4fdWdlgJ9QJYZ+3MJR9psS5FDJhXmyPU/htyhtEv5u
	S4gm1z87X9wMuV1kMizprRD4MwHzjHGa3glXTd6O5vkjKWy6UX4RI1iwRFy+Bi/Ij2N
	xTJDWafRJfjEOfgnbLPRay+HGsT5hwTerr2lmABIgRgro0puw+n/o+XBA/9Twx5Zn1o
	fknYiaYNTkLz3AkzrpMxlZL9uruLXGjm3U0cErnn9z9Ei0NoE/tbUgWEl04rT4/v6+m
	4H+0F1dh4z0Uj/abO7gJcu5NXWE2QoN0fSoOaCAf+tZ4w1ZSUG7ZslZ27M5WWyTIKxE
	vwb8KtxL6g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741737526;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=S89VYiNjTrAawzR8pDNsckPg14WX/oNcDQkKjNu0KPc=;
	b=UoYVnyIrpN96davRcwMWnJySD49emQU1HoHu+xreGg2Eqvzb9fJsVclZd4bODTa4
	cv2PD6EFbiMy4LqPJ043QrhDdq/4N8i33mRNEXZzD15FYnMitQahR9lR4dz5tRB0HmP
	6t0racLtAVr+6F/Xld/hs5jKiWuajfM7W4Kc6zv4=
From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Antonio Hickey <contact@antoniohickey.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: [PATCH v2] rust: uaccess: mark UserSliceReader methods inline
Date: Tue, 11 Mar 2025 23:58:45 +0000
Message-ID: <0100019587a58230-1aed0f55-60a5-48c1-8791-10f28ce74cb3-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <0100019582fc6956-3b420cce-f122-4a26-8fea-94000b22bc90-000000@email.amazonses.com>
References: <0100019582fc6956-3b420cce-f122-4a26-8fea-94000b22bc90-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.11-54.240.8.95

When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
toolchain provided by kernel.org with ARCH=x86_64, the following symbols
are generated:

$nm vmlinux | grep ' _R'.*UserSliceReader | rustfilt
ffffffff817c3320 T <kernel::uaccess::UserSliceReader>::read_slice
ffffffff817c32b0 T <kernel::uaccess::UserSliceReader>::read_raw

However, these Rust symbols are trivial wrappers around the functions
copy_from_user, _copy_from_user respectively. It doesn't
make sense to go through a trivial wrapper for these functions, so mark
them inline.

After applying this patch, the above command will produce no output.

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Suggested-by: https://github.com/Rust-for-Linux/linux/issues/1145
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/uaccess.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 719b0a48ff55..3d8a08aeed89 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -218,6 +218,7 @@ pub fn is_empty(&self) -> bool {
     /// # Guarantees
     ///
     /// After a successful call to this method, all bytes in `out` are initialized.
+    #[inline]
     pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
         let len = out.len();
         let out_ptr = out.as_mut_ptr().cast::<c_void>();
@@ -239,6 +240,7 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address, or if the read goes out of
     /// bounds of this [`UserSliceReader`]. This call may modify `out` even if it returns an error.
+    #[inline]
     pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
         // `out`.
-- 
2.48.1


