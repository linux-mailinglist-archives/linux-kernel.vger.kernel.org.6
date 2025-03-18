Return-Path: <linux-kernel+bounces-566441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5331A6780A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F5819A3E72
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849020E314;
	Tue, 18 Mar 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="SkVrIjjs"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A622094;
	Tue, 18 Mar 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312176; cv=pass; b=BSeMfgFuHTXlfK7CrS4YmgYQqUZsFgGXg6C/5JGWh4IV6B+QfcXck0+9uVY4NXnWVtdQ8hfkTTMDKw8jgts3O2M8xg4nbDBiWGiAsiFuvAVbsuKCKk15Th40HWEVcUEchcbhW3jY7jplx//OqqagKNJDQd073ARd0QvSOxgjX18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312176; c=relaxed/simple;
	bh=KSDyh3xX4NpwRCKn8pQcYihDzqthZ1dByOWQeJr5u7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RLb/hraEueAiT+j4sS8/1NXUBh5gXvQqmZgPaThgAye39/yAc1moXAvrtdDeX1I111fotaxlz7zj9qgPKW5J+46e6rV3P1x6/Z3CYhANIeSt7vD4U4po8a0ps8Cla/3tr6a0FKzjQeWieJeaFBcfm/764B0PQ6g2ffNgHWxLwEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=SkVrIjjs; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742312140; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V2HgVpnWNMaZ6MrCUK/16DvH8XxWaRB0bOHiGyQJPLTVy3zoWWPioVfjFpXdcn8qUBV86UeAyhsgFlYOfQ8OUQ0dk9Cya2f0xOdYNSFU17qUEH2MgjJVVpdlw6iykxe0m/Ofs2eILS18hgp18V2gPY0MIgWB1F+RVwXPiCDfb70=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742312140; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+Wz5sL+K/4QpxJnQDP/gRaek9Byo0kkjgZ4jrr/bG9A=; 
	b=hOjm04zW+pwfhI9dVZ8MXpk/hXcZ7/QLGZF6vGyi0zKxIte53FfEMWlZQBVoEagS9D26qb5nmfxjxI7jmLwRYhAeljFkcz6m2Dd/gG5OIye5GkReUMsgkijyXsPMlWn4X2R5jXWuAq3MiHJ04iUsWCQmhtbtCOmJCgRs8s3G+KE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742312140;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=+Wz5sL+K/4QpxJnQDP/gRaek9Byo0kkjgZ4jrr/bG9A=;
	b=SkVrIjjsvuCVFYDaooPrS1XL7LSitYU3Mdh0ad3O5OQ4P0YU/ZAlowx30d4AJPpN
	h3egTbDeopaqvUZYTF3dUSb4qeEdJpdLNXk/L9Biw9jj8dMwm/ED2vTsF7obhAGNCjE
	UU7YuNfvKW0Kr/4D35USkx0Su8f2vDEPEmCOtk3E=
Received: by mx.zohomail.com with SMTPS id 1742312137698822.5459740903046;
	Tue, 18 Mar 2025 08:35:37 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 18 Mar 2025 12:34:57 -0300
Subject: [PATCH v4] rust: kernel: add support for bits/genmask macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-topic-panthor-rs-genmask-v4-1-35004fca6ac5@collabora.com>
X-B4-Tracking: v=1; b=H4sIAKCS2WcC/33NTQqDMBCG4atI1k3JL5aueo/SRRwnGqqJJBJax
 Ls3Cm4K7fL9YJ5ZSMLoMJFrtZCI2SUXfAl1qgj0xndIXVuaCCYUZ0LSOUwO6GT83IdIY6Id+tG
 kJ7WmAV1Li1ZJUs6niNa9dvr+KN27NIf43j9lsa0Hqn6jWVBOL1rIGrhlgOYGYRhME6I5QxjJB
 md5YJpxwf9gsmAaZNNawQGZ/sbWdf0A/5E0axEBAAA=
X-Change-ID: 20241023-topic-panthor-rs-genmask-fabc573fef43
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Fiona Behrens <me@kloenk.dev>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

In light of bindgen being unable to generate bindings for macros,
manually define the bit and genmask C macros in Rust.

Bit and genmask are frequently used in drivers, and are simple enough to
just be redefined. Their implementation is also unlikely to ever change.

These macros are converted from their kernel equivalent. Since
genmask_u32 and genmask_u64 are thought to suffice, these two versions
are implemented as const fns instead of declarative macros.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Changes in v4:
- Split bits into bits_u32 and bits_u64
- Added r-b's
- Rebased on top of rust-next
- Link to v3: https://lore.kernel.org/r/20250121-topic-panthor-rs-genmask-v3-1-5c3bdf21ce05@collabora.com

Changes in v3:
- Changed from declarative macro to const fn
- Added separate versions for u32 and u64
- Link to v2: https://lore.kernel.org/r/20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com

Changes in v2:

- Added ticks around `BIT`, and `h >=l` (Thanks, Benno).
- Decided to keep the arguments as `expr`, as I see no issues with that
- Added a proper example, with an assert_eq!() (Thanks, Benno)
- Fixed the condition h <= l, which should be h >= l.
- Checked that the assert for the condition above is described in the
  docs.
---
 rust/kernel/bits.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |  1 +
 2 files changed, 50 insertions(+)

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
new file mode 100644
index 0000000000000000000000000000000000000000..ec13bb480082de9584b7d23c78df0e76d0fbf132
--- /dev/null
+++ b/rust/kernel/bits.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bit manipulation macros.
+//!
+//! C header: [`include/linux/bits.h`](srctree/include/linux/bits.h)
+
+/// Produces a literal where bit `n` is set.
+///
+/// Equivalent to the kernel's `BIT` macro.
+pub const fn bit_u32(n: u32) -> u32 {
+    1 << n
+}
+
+/// Produces a literal where bit `n` is set.
+///
+/// Equivalent to the kernel's `BIT` macro.
+pub const fn bit_u64(n: u32) -> u64 {
+    1u64 << n as u64
+}
+
+/// Create a contiguous bitmask starting at bit position `l` and ending at
+/// position `h`, where `h >= l`.
+///
+/// # Examples
+/// ```
+///     use kernel::bits::genmask_u64;
+///     let mask = genmask_u64(39, 21);
+///     assert_eq!(mask, 0x000000ffffe00000);
+/// ```
+///
+pub const fn genmask_u64(h: u32, l: u32) -> u64 {
+    assert!(h >= l);
+    (!0u64 - (1u64 << l) + 1) & (!0u64 >> (64 - 1 - h))
+}
+
+/// Create a contiguous bitmask starting at bit position `l` and ending at
+/// position `h`, where `h >= l`.
+///
+/// # Examples
+/// ```
+///     use kernel::bits::genmask_u32;
+///     let mask = genmask_u32(9, 0);
+///     assert_eq!(mask, 0x000003ff);
+/// ```
+///
+pub const fn genmask_u32(h: u32, l: u32) -> u32 {
+    assert!(h >= l);
+    (!0u32 - (1u32 << l) + 1) & (!0u32 >> (32 - 1 - h))
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c92497c7c655e8faefd85bb4a1d5b4cc696b8499..a90aaf7fe6755a5a42055b7b4008714fcafe6f6f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub use ffi;
 
 pub mod alloc;
+pub mod bits;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 #[doc(hidden)]

---
base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
change-id: 20241023-topic-panthor-rs-genmask-fabc573fef43

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


