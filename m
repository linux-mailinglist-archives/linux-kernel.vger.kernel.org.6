Return-Path: <linux-kernel+bounces-380069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9669AE87C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03302908B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A091FDF96;
	Thu, 24 Oct 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LAVL/a8W"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201721DFEF;
	Thu, 24 Oct 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779542; cv=pass; b=C0iiMB04yppASZ8G5clA2Wit2OOC3eKEeRGcdKGHnfESe2AgI7ii6gk+s+9Y2NlenGOppBsV8ZX4izUOisSkgMhdu5nNrKgX12B4zQxC8RyybJp/8XM+xBPIfdezIes3BBCubhORbWB+CFpfNIKCu2hcGu5UQXEpyIHh5oWVIN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779542; c=relaxed/simple;
	bh=3NdYKUfySXxtD63reDBOJZ/wn7LGWiZOFW6xaI6sgqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ugKcy4jgcjqeq6aESMzGuhbRDkB8cEW9pFD+W1sUT8azjheaQiAp1wSm1hODVVf2Fx7NBljqlwlfaMbKGo+5FuB9RBtv64M+EZM6rAXWGLnvzVPH+jIA1gG73v9MmIzPObiDwVF6H+0LVRXy+wW8nQwCK07U7MSiShYelhhX8KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LAVL/a8W; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729779518; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iH0XLxn2OeKqB/byCkNzIDWWI7vC7vaJkUTLjC6v1FvI/CYAUj/aHuh5T3bjgBfY4q2qAftQ58CBYWusRXc3EjqhJ7pwsfDQaNyGi+uLY6blRvrUo1Z8WLgxwD/tc4GrX/20Ibib0TIZytA0LHKQed8HwI50jlcLKLWoKVGfIjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729779518; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PF7cungfDRPFH9gPEK5GCjpDqQca8LfjysnH2xrJJnQ=; 
	b=DF/1FxUZ3kJaMkRFBmgcAIFct0jamxQpsNqTSHt7Pa44ZaReqq2Gxx5JCLkV657TGpR+Go9goPoArzT+tPlSNfCTRNk8Np0V3kwGBFwj1gw76N6EWonpfzoLF2W6t223JoocnTlg/naEF2scS/JRJXWDOothRr9qt0575pu7KUo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729779518;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=PF7cungfDRPFH9gPEK5GCjpDqQca8LfjysnH2xrJJnQ=;
	b=LAVL/a8WOKRL5B8P5ZtLQJ756aErnpd6bmAq5/kHZhcFD+js0TW4MCu5lVSuVUXJ
	nmbyOCy4mNNbr2NW6pQqh6h4F3UzqMZ9kilvr2nKkDgSVah+y13YFNM3XzMzqx02xSp
	NYvsx6iC1aeP2rccfZesULzCA0qDcGsdpGJZCWvk=
Received: by mx.zohomail.com with SMTPS id 1729779517170426.45219885642916;
	Thu, 24 Oct 2024 07:18:37 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 24 Oct 2024 11:17:47 -0300
Subject: [PATCH v2] rust: kernel: add support for bits/genmask macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com>
X-B4-Tracking: v=1; b=H4sIAApXGmcC/x3MQQrDIBBA0auEWWcg0ZRCrhKysHbUoURlJoRC8
 O6VLt/i/xuUhElhHW4Quli55A4zDuCTy5GQ391gJrPMk7F4lsoeq8tnKoKiGCkfTj8Y3Ms/njZ
 QWCz0vAoF/v7X297aD3shCoRqAAAA
X-Change-ID: 20241023-topic-panthor-rs-genmask-fabc573fef43
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

These macros are converted from their kernel equivalent.

---
- Added ticks around `BIT`, and `h >=l` (Thanks, Benno).
- Decided to keep the arguments as `expr`, as I see no issues with that
- Added a proper example, with an assert_eq!() (Thanks, Benno)
- Fixed the condition h <= l, which should be h >= l.
- Checked that the assert for the condition above is described in the
  docs.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/bits.rs | 36 ++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |  1 +
 2 files changed, 37 insertions(+)

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
new file mode 100644
index 0000000000000000000000000000000000000000..479883984f995f6b44272fa4566a08f1c1e6b143
--- /dev/null
+++ b/rust/kernel/bits.rs
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bit manipulation macros.
+//!
+//! C header: [`include/linux/bits.h`](srctree/include/linux/bits.h)
+
+/// Produces a literal where bit `n` is set.
+///
+/// Equivalent to the kernel's `BIT` macro.
+///
+#[macro_export]
+macro_rules! bit {
+    ($n:expr) => {
+        (1 << $n)
+    };
+}
+
+/// Create a contiguous bitmask starting at bit position `l` and ending at
+/// position `h`, where `h >= l`.
+///
+/// # Examples
+/// ```
+///     use kernel::genmask;
+///     let mask = genmask!(39, 21);
+///     assert_eq!(mask, 0x000000ffffe00000);
+/// ```
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
index b5f4b3ce6b48203507f89bcc4b0bf7b076be6247..4f256941ac8fbd1263d5c014a0ce2f5ffb9d1849 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -27,6 +27,7 @@
 extern crate self as kernel;
 
 pub mod alloc;
+pub mod bits;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 mod build_assert;

---
base-commit: 91e21479c81dd4e9e22a78d7446f92f6b96a7284
change-id: 20241023-topic-panthor-rs-genmask-fabc573fef43

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


