Return-Path: <linux-kernel+bounces-297773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4276795BD86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5DD1C2330A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9331CF29D;
	Thu, 22 Aug 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GHgcFMhA"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DBA487AE;
	Thu, 22 Aug 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348541; cv=pass; b=HRzEr6fHxTdGe6N0EZRoyilwnTsMUuXlvxSjyZsu1R1uW3SIhpLZKI/H61r+7z3hDvRjVFeHVWzsUxD9liIhWyIeGCmlnHd4xMLcMIe6mLnXfyPNxVg5RsmxBuMH9Ox90jZbiQK9AqzcfrNhc+PxTahUb4EHInhVW8efsBsc3OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348541; c=relaxed/simple;
	bh=pJo3IItqLTuWfWlzXgr6lFXycFBd+dbxoqHla3s2OZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKomicjRsvBgMahnSMJvZm+QEi2Q5FPUBceLXb8y0dZh0j/VXmWDZWHMKaFHT0lPJTv1HIqP/3YMY3MTZFwCQ5H2NJPAFC7QX38RRqqn9M5WDCApb2hTtzJsoRCWj5i4IRb2DU2zOo12pC672RF4Ket2imAOsI3pWTLf7so2jrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GHgcFMhA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: daniel.almeida@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724348534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fdbNa7Ji5MFVW6syk7i/H7Y3SpI8BKoWZfbteR5MRXr0lJiMT38Txaz6hyTEo/bkYH4+YOAVg9pVTNm4lJNnUwqpK2z0L6ItQEYVLHNFlUThBv7w5Z+v9wD0zBVQd4mE8DiwSJY3k4Muk7UNJ0ZvYTJEU1wbnHEfqkZRCUDzljI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724348534; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BUHc0eQ0h+KvwEezOpf3+G+PjwpjDpBw+nDAGnUcAuM=; 
	b=GBAzoJwnjU5GG7ynWl4H8ujb7Hmbm4CQWc/yAjZZb+MVuehkPYWvRGaR+ItIP/9bbRs1LHLU2LwsVCd9IOUgrYpiRAIBIh23b3W/wtJDq3U+nOV4Ad1QvHANXzDegMRjE+MDMiXeRG3yb+ttowswfJdO1erc9ULDdJ2Ta6IReZs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724348534;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BUHc0eQ0h+KvwEezOpf3+G+PjwpjDpBw+nDAGnUcAuM=;
	b=GHgcFMhAqOe2WTvUaqWD/o1nLm3YWnS1JhwXaDUZrLiIQ2Vb8/rsoCrz5KkKMr3/
	3N5ZLCxiXUrIx5bRICWwCiWd/doxWzespdb3lHO1c8G+m+0R75K6TPSbK9xJrPpD+6c
	FTOjzf9RsSbu+ZL42Vy5rfdU7Bttz0qbU5nDLU84=
Received: by mx.zohomail.com with SMTPS id 1724348532364877.0917933602898;
	Thu, 22 Aug 2024 10:42:12 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: wedsonaf@gmail.com,
	ojeda@kernel.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: kernel: add support for bits/genmask macros
Date: Thu, 22 Aug 2024 14:35:17 -0300
Message-ID: <20240822173518.2717-1-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

These macros were converted from their C equivalent.
---

Hey all, I did not see any patch for this floating in the mailing list.

Please let me know your thoughts. This one should be rather trivial.


 rust/kernel/bits.rs | 32 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 rust/kernel/bits.rs

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
new file mode 100644
index 000000000000..8ac142392086
--- /dev/null
+++ b/rust/kernel/bits.rs
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bit manipulation macros.
+//!
+//! C header: [`include/linux/bits.h`](srctree/include/linux/bits.h)
+
+/// Produces a literal where bit `n` is set.
+///
+/// Equivalent to the kernel's BIT macro.
+///
+#[macro_export]
+macro_rules! bit {
+    ($n:expr) => {
+        (1 << $n)
+    };
+}
+
+/// Create a contiguous bitmask starting at bit position `l` and ending at
+/// position `h`, where h <= l.
+///
+/// For example genmask(39, 21) gives us the 64bit vector
+/// 0x000000ffffe00000.
+///
+#[macro_export]
+macro_rules! genmask {
+    ($h:expr, $l:expr) => {{
+        const _: () = {
+            assert!($h >= $l);
+        };
+        ((!0u64 - (1u64 << $l) + 1) & (!0u64 >> (64 - 1 - $h)))
+    }};
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 274bdc1b0a82..3aaa1c410d2c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -27,6 +27,7 @@
 extern crate self as kernel;
 
 pub mod alloc;
+pub mod bits;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 mod build_assert;
-- 
2.45.2


