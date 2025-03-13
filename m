Return-Path: <linux-kernel+bounces-558725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E9A5EA07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB71189C7DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F986325;
	Thu, 13 Mar 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="1Zgj2Gxr";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="F+ArIc9M"
Received: from a48-107.smtp-out.amazonses.com (a48-107.smtp-out.amazonses.com [54.240.48.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1B92905;
	Thu, 13 Mar 2025 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834633; cv=none; b=R3pqX/hzLZ1nF6T/HUIaDNxTkU5QLqnvS1H1z9wUy2TpyeETsdGhav5MsomlNtB/g92A7T7fFL3/5LfNkGUWTGtLOvkTkVUN5aYny3/bn5Flw3WYS92eb5k3Ez2a8q1OuKtX+739mWZwDB1HapcErbPU4bdDnvpT4/Ekhh/ibdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834633; c=relaxed/simple;
	bh=//GQlZrf5GV3xsSlmBSPrP8XgXqgjfvYg5rycTOIQ50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8kZC7xT31TrXE1ZybHQ1VV2eOsJcGrEjcEYR7jtjtIEg9+I6iXb2PwQjDqeovZHY3nTCQpeJRETb0wN3Zg+QUXPrwljfIprdy/qAA0Mapwm9e97FYpn15dKX0v7xdXzziTJmG+4VIF5MCWOU62I9TaqrVS2hi1t4IHnHT72WzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=1Zgj2Gxr; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=F+ArIc9M; arc=none smtp.client-ip=54.240.48.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741834631;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=//GQlZrf5GV3xsSlmBSPrP8XgXqgjfvYg5rycTOIQ50=;
	b=1Zgj2Gxr+rWniPhi8/T6OgsnM2XRNqFwpXJiCU/5pr41+eVEfrlvii+NqbGfordT
	t/DCZeNvFlRAnBbKrMY2P9TitiizpKsvHe0He5NvilGk6JecRgvYe71U76LOfuGRAs+
	yk2e+tZnpVi4fG4uQYBvdRBKtJkUxs9v6uRfKwWwAdTbmwV86wiDy47N9+z05dHzbfq
	P+IxYhv70D5dz0YLjlKVPO3MrFag8WORP+ikzLRGuatgVqjzE6xlCKiQ/PsMMb2DrLQ
	7ocJIv5ZnU2Z2GYcBiySW3B7tMZurbXA9ESR/woM5971uC5uBl7agliZw6/6Mz4m88C
	lLG63kUv7A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741834631;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=//GQlZrf5GV3xsSlmBSPrP8XgXqgjfvYg5rycTOIQ50=;
	b=F+ArIc9Mlbr8MeXg9fTZAjv0LcvslBD1tIdhK6QIYmeGOen5+TyvTK7GmG0o3+aH
	a2XkNShtrNGH0AxKOUm8aMY/k35x8rEVYO+ulo34HLyTW9mn8PR6p8IBbVnRLpSd6XN
	Ab6O2Kk78XASoc59JIVUfSOWvcF4ZLXmfZn/LEhg=
From: Antonio Hickey <contact@antoniohickey.com>
To: contact@antoniohickey.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
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
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2] rust: uaccess: mark UserSliceWriter method inline
Date: Thu, 13 Mar 2025 02:57:10 +0000
Message-ID: <010001958d6f36b2-fb0a1710-a581-4002-889e-e489004bb72d-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <010001958d69ed91-0ccd9e4f-cd18-4451-a982-426b951d2e0c-000000@email.amazonses.com>
References: <010001958d69ed91-0ccd9e4f-cd18-4451-a982-426b951d2e0c-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.13-54.240.48.107

When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
toolchain provided by kernel.org with ARCH=x86_64, the following symbol
is generated:

$nm vmlinux | grep ' _R' | rustfilt | rg UserSliceWriter
ffffffff817c3390 T <kernel::uaccess::UserSliceWriter>::write_slice

However, this Rust symbol is a trivial wrapper around the function
copy_to_user. It doesn't make sense to go through a trivial wrapper
for this function, so mark it inline.

After applying this patch, the above command will produce no output.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1145
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/uaccess.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 719b0a48ff55..c33ff33d4da2 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -322,6 +322,7 @@ pub fn is_empty(&self) -> bool {
     /// Fails with [`EFAULT`] if the write happens on a bad address, or if the write goes out of
     /// bounds of this [`UserSliceWriter`]. This call may modify the associated userspace slice even
     /// if it returns an error.
+    #[inline]
     pub fn write_slice(&mut self, data: &[u8]) -> Result {
         let len = data.len();
         let data_ptr = data.as_ptr().cast::<c_void>();
-- 
2.48.1


