Return-Path: <linux-kernel+bounces-557077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A222A5D34F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129DE3B8C17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D9233722;
	Tue, 11 Mar 2025 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="PaB7etwo";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DfrZ0Xrt"
Received: from a8-87.smtp-out.amazonses.com (a8-87.smtp-out.amazonses.com [54.240.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8C23370D;
	Tue, 11 Mar 2025 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736691; cv=none; b=QOBmrwGLV+k7us6MBdawYYSUaF5/loBWd4t7n9Oh5eyWx5dW62ouJuMawLtakCMPzaU0vt4Q+6Wggy964MD4rHDEIY1KzxXWgZ0GRpd0un4j9l6iGykDAVAnG4PrNNQQqNrPEUlqyXhEizn7DuK0GU9uzOGXnYgvlyXAbR+zBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736691; c=relaxed/simple;
	bh=S89VYiNjTrAawzR8pDNsckPg14WX/oNcDQkKjNu0KPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWfH9rHxDHIi+q9clXJgPTaMjGJTI+MeadWnp9oRDZcud2Mo3/MZCHqMLScdwb4d+HtdDwSdcxEBGujDL75BNidFlSyzlWeLfEqoWUTEZo3qW4bQ9ubZMstoBvbrqvR7jau1mxLj6OR9V7JNCXnyViWrs/dTN4PRn2yra06oYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=PaB7etwo; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=DfrZ0Xrt; arc=none smtp.client-ip=54.240.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741736688;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=S89VYiNjTrAawzR8pDNsckPg14WX/oNcDQkKjNu0KPc=;
	b=PaB7etwoTpUVDWqWzpBGCip4F2pzz64G/bkm4VKstBA20dVEM8DO6CjpXu0FX2bi
	StiWAsdOBdDra75ChClOwxQcpn0mH099BCb3PeI7MSzkkwIOX5eBMxVlE7zLRWNGT+M
	RH1yxh3GcSYqe9eU9hSqAo/gTRiketHH0PaXorlFladxBsnN3oORfX4PKQHe1XkccT0
	dEZ6UahjDWxAUotAbhVTVI0zdp0m9J9LPzdW3I812awicABp68AQRFipNTmDvnz955p
	671OBHbSP9v6xUuFkkbGkYGyIxC38YAIEUEXkfMEtsQO9vw8AEZjlswKjnzXlv+INsp
	AMWVzU+4Gg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741736688;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=S89VYiNjTrAawzR8pDNsckPg14WX/oNcDQkKjNu0KPc=;
	b=DfrZ0Xrt5/J4KFKOyhZND61FHTMXKECxpwF1bWH5UsehDaL4kZi00x/jA6aL2KiV
	qKgWH470Ssflue7VgdONEHXzKP5q1vYZtF1bwWaBLz1CMSgpClyg4REW1n4ZZ4T+xBC
	Qg37D9qSyQPqAyi6AT0+DYNGA2lP/jydLnvOY8rA=
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
Date: Tue, 11 Mar 2025 23:44:48 +0000
Message-ID: <010001958798b97c-4da7647e-d0bc-4f81-9132-ad24353139cb-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.11-54.240.8.87

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


