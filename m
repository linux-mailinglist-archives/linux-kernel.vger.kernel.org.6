Return-Path: <linux-kernel+bounces-558722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED54DA5EA02
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9E017665A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0997186325;
	Thu, 13 Mar 2025 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="zck9GqNx";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="M/I5Zlm4"
Received: from a8-87.smtp-out.amazonses.com (a8-87.smtp-out.amazonses.com [54.240.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2295747F;
	Thu, 13 Mar 2025 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834287; cv=none; b=CnA+LuDZM4FEmrl71IVUpVpvPgefQXh46WlSsGcc0lK3f/WhRo+MRwi8OpeJCdmIJrx2pOWTRQNJLf5Dp8PFvMkog0lOtc+zm7XD890K63qL5WBGd8L8OV7lQ/ag3SJv0PbUR+t+0ngbyjq9Bo+8rO06e9UkqqEfuNFq/EqvAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834287; c=relaxed/simple;
	bh=UnwpjRGOjwu3BdNKqP31+73T3IgQvef5578x4eacuG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=didfTgK+W/QeVuMYPnkl4GTV/BhC8T1X0dilJwkxvrMF6FHaqwdrXSIst03JghVDHs97MLYqy4j0Oy4qgru1a8jlSAx+eH7bIQdC7mzfRPJgWl63Nnmpl/i2KwA+FRSeSCc6XwOYs+6zY1u8n/xVUKpOAYm2rrd0CuZXEDPtvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=zck9GqNx; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=M/I5Zlm4; arc=none smtp.client-ip=54.240.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741834284;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=UnwpjRGOjwu3BdNKqP31+73T3IgQvef5578x4eacuG0=;
	b=zck9GqNx3MjL3Kr4w7RipkctzPb2N0SW0OxjHUJoUlJ7aCn2WUxAFlBICfqunWYq
	JjI/eGnyjU6A5kWVsu2fN5ivSKysxYhhk2JEK4Fz7Ipy6Yl+eoFvhsteusHJYZMtebH
	NR/G/mmI09NOtd8koB+sGw5BNbmkdn4YE4f4ljzUwFHMr0PtHt0G2iniyoRQxRg5Qbr
	aiHcFopeC3J/0r1ofNloHpbUtJi6nekuz/t6dmk0gq/o8Wh9aHZcEPRrcLnp0E05gtY
	D2i2NmqJj7BNFRJmshks1e0P2mDLRvFe2tg7dPW42hpZQRMk8GfrpN5D+l5CNhDm8mh
	TZeddcB6JQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741834284;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=UnwpjRGOjwu3BdNKqP31+73T3IgQvef5578x4eacuG0=;
	b=M/I5Zlm4IY+PtMzrnvVBSMshNtbJNl3wm+gBxEFh7F3yF5hD9CQIlMkAch+vueny
	AWaJS+Bflc1KxdpwVwlJsEEVxtPSmVPYPHK2gjsFRWY+0jI0ZdylOlbvT/a8qOww2ua
	ZrMHwv8UK2b9Mo/jshXaWLXUentWg2p8eWhS68F0=
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
Subject: [PATCH] rust: uaccess: mark UserSliceWriter method inline
Date: Thu, 13 Mar 2025 02:51:24 +0000
Message-ID: <010001958d69ed91-0ccd9e4f-cd18-4451-a982-426b951d2e0c-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.13-54.240.8.87

When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
toolchain provided by kernel.org with ARCH=x86_64, the following symbol
is generated:

$nm vmlinux | grep ' _R' | rustfilt | rg UserSliceWriter
ffffffff817c3390 T <kernel::uaccess::UserSliceWriter>::write_slice

However, this Rust symbol is a trivial wrapper around the function
copy_from_user. It doesn't make sense to go through a trivial wrapper
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


