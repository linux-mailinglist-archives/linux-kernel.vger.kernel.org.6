Return-Path: <linux-kernel+bounces-555373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDADA5B693
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5711A171CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73A1E4929;
	Tue, 11 Mar 2025 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="eB/RiN0p";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="RnmMrFsP"
Received: from a8-87.smtp-out.amazonses.com (a8-87.smtp-out.amazonses.com [54.240.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2151E522;
	Tue, 11 Mar 2025 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659338; cv=none; b=VbbwEfzBN7U1ZVSW8fUwxujNp6w67L3OFMH3Cvz/5qquwoEpFmN9QQL3UYQZk5wO35sxN7hS/ZYMO9M3NB6TV7DmfaezV4kW1b6bvuaPcxFH2POTQtW6hycQkgWy4MFjDjRlljcGd2IS+Ch6sEK8v72+f/45aB1pKB13atn0Nh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659338; c=relaxed/simple;
	bh=avBbpXuLghR+QCylMU4TexjL870/yz8BwhT4jBHuwvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4uz0z4YSOfCDprYwhyaiPze8ibLFapvWmaG1TRrS7Q6RpJQoCnFkAdELPNxsjSjbgq/uk94S9V8YI5olQICRd/QOWu+Fm1iEzdsP08+lEKv0Omyx5BcCuu6rbBo1oq41gCEVijp4iKx5/Ps8IAoFlMF/PSXcCjVzj4pZok8RzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=eB/RiN0p; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=RnmMrFsP; arc=none smtp.client-ip=54.240.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741659335;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=avBbpXuLghR+QCylMU4TexjL870/yz8BwhT4jBHuwvw=;
	b=eB/RiN0pn76xbGG4OlUovFSY3tgEMvKgSDWbkgSDbAi3d4IhYRKFlR5sQ5cZDYq2
	jYf+cUF1NUonc4CWMQc5t686Zcq68Usu/vGr6221Culu0w03lmR1LHR800zrB2QXvT9
	WWZdLrstbnP2GrfS97dJEh5eYfLNjpSUMbY84cBVrdCcFWB1nSYuBh+Z30ZJfQOtDjC
	DgqfH1oX26X1kO80lVbQZ4PEVS1k9AOyuxqSifSfPgHYpg29aWDF6ugIe1TIr9ex7Lw
	zn3BO58toJSf4tD+dfM6ix+TQvh7rV9B26uH3up0qpKq4c71d8Ux5+c4sc0WWOo5vGh
	Wm6SLCZaow==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1741659335;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=avBbpXuLghR+QCylMU4TexjL870/yz8BwhT4jBHuwvw=;
	b=RnmMrFsPtt7WPSlkWUbdfI5kX7jDoiLKdlmRh48QmHUDCkjmHeHjM9Pa2OCLMpEf
	NzDzFsJd/7IOKHuvxLrx9l7z5No5NBJ3WPA5HfHFrXXYfU785cgkj1MQH/baqe2s7n8
	1BPh+HvYpZn7J54sYT4TF5ewj0ayhGtL9XRX3qd4=
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
Subject: [PATCH] rust: uaccess: mark UserSliceReader methods inline
Date: Tue, 11 Mar 2025 02:15:35 +0000
Message-ID: <0100019582fc6956-3b420cce-f122-4a26-8fea-94000b22bc90-000000@email.amazonses.com>
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


