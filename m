Return-Path: <linux-kernel+bounces-577547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09931A71E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9693B992E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA822528F0;
	Wed, 26 Mar 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ex2fV3fX"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253724CEEE;
	Wed, 26 Mar 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014430; cv=pass; b=JLUQ94V23riuhU/P408y+BgLPzkdURSeEqBp5dPSyQXMY2kdXZ1ZhRVNfmnTAuPbFdEmY/u0cIQogNeX9Cqqjn+yy4vo0bzgb0AL3fqxjjUeygW9HUedrq/iJXrS0NtSnqIfSm1U0uyBffnk4KTuSlxHPXQ+bz83rY6S3qWvE3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014430; c=relaxed/simple;
	bh=wdSpG9pKEWrUXR3mxaT5h1jsNyYVPvOw9miNLdLz2vM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sE4nrHkgy3bx79yR5Cyd5bxXGwSnTgCijl/1xxi7QimdYSraWIEE67GvfylqhFwo0vlx5Dw9FzDuGLCs1/EyA/sRHl8uyP7NhA+LcWP0uL5yRWgDYsZx/OdNkmWlLebtIPOibHKh6BWuU3T9NQB/KwyOT3GJ2KWY6r3eZMgdUfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ex2fV3fX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743014401; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FXFptQGX4pYpP62a4MfX24346PEEtBgvXJEGKg0bqKXjNAjiL6OvMaGgDfKMQM5LLorZC2Lmd1GXLVOSdFNELLc7LpvsjLJIbl24Kflboa2m5XjaLl4KrKv24k6Pa1VBccS4LreRoFA6/5mm9b7/ThaxNuEsIuWBb5r60hsI4Ao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743014401; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iDQo+X1Ei3V6zqm2gyyhSXHeLOFRXcPxDWMQLfLdBhU=; 
	b=DmRNNTFeXmz3oIrJ3q98CvtUGIhIY390vcIjLWrAsao08WQAkecGPa0bFy7zklsBSQPs2I7AoQNU9ERNGPz0FbSByTFSNE9kIGv1ieceLWYHclfZ62Q6Tk8cDQROZWaAnwFN42LMD2PI3Qm7gpY3Yke6oo1LkokXuMlVUgq+xmA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743014401;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=iDQo+X1Ei3V6zqm2gyyhSXHeLOFRXcPxDWMQLfLdBhU=;
	b=ex2fV3fXz9wZs/0ufKry7Dx1ZjuIc+keyRWBaIr5p1nBwnUBtiILSBv7g2vZLIKA
	U9H5vC+7A4MUwiu0mzeqZTtP/vMBoaDfQyZp8Gdr9YDJs7SMmLWjr7dxjni8P7hHD/5
	Od/XVZ19Q2ocS7QR2Sk+hLzg03E35tHU/uQiLWKg=
Received: by mx.zohomail.com with SMTPS id 1743014398341520.5026499088717;
	Wed, 26 Mar 2025 11:39:58 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 26 Mar 2025 15:39:33 -0300
Subject: [PATCH RESEND v2] rust: regulator: add a bare minimum regulator
 abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-topics-tyr-regulator-v2-1-780b0362f70d@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, lgirdwood@gmail.com, 
 broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Add a bare minimum regulator abstraction to be used by Rust drivers.
This abstraction adds a small subset of the regulator API, which is
thought to be sufficient for the drivers we have now.

Regulators provide the power needed by many hardware blocks and thus are
likely to be needed by a lot of drivers.

It was tested on rk3588, where it was used to power up the "mali"
regulator in order to power up the GPU.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Changes from v1:
  - Rebased on rust-next
  - Split the design into two types as suggested by Alice Ryhl.
  - Modify the docs to highlight how users can use kernel::types::Either
    or an enum to enable and disable the regulator at runtime.
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/regulator.rs        | 127 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ccb988340df69c84a702fe39a09addcc2663aebe..374f48b5ce2a602b4d1a5791201514ed8a535844 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -30,6 +30,7 @@
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/refcount.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/slab.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ba0f3b0297b27dbda6a7b5d9ef8fdb8b7e6463dc..5b3228e8c80b1eb33bf36929ce3671b982efaf4a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -72,6 +72,8 @@
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
+#[cfg(CONFIG_REGULATOR)]
+pub mod regulator;
 pub mod revocable;
 pub mod security;
 pub mod seq_file;
diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
new file mode 100644
index 0000000000000000000000000000000000000000..4ac9b6c537dff4cfc7f2f99d48aec3cecc3151e8
--- /dev/null
+++ b/rust/kernel/regulator.rs
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Regulator abstractions.
+//!
+//! C header: [`include/linux/regulator/consumer.h`](srctree/include/linux/regulator/consumer.h)
+//!
+//! Regulators are modeled with two types: [`Regulator`] and
+//! [`EnabledRegulator`].
+//!
+//! The transition between these types is done by calling
+//! [`Regulator::enable()`] and [`EnabledRegulator::disable()`] respectively.
+//!
+//! Use an enum or [`kernel::types::Either`] to gracefully transition between
+//! the two states at runtime if needed. Store [`EnabledRegulator`] directly
+//! otherwise.
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{from_err_ptr, to_result, Result},
+    prelude::*,
+};
+
+use core::{mem::ManuallyDrop, ptr::NonNull};
+
+/// A `struct regulator` abstraction.
+///
+/// # Invariants
+///
+/// - [`Regulator`] is a non-null wrapper over a pointer to a `struct
+///   regulator` obtained from `regulator_get()`.
+/// - Each instance of [`Regulator`] is associated with a single count of `regulator_get()`.
+pub struct Regulator {
+    inner: NonNull<bindings::regulator>,
+}
+
+impl Regulator {
+    /// Obtains a [`Regulator`] instance from the system.
+    pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
+        // SAFETY: It is safe to call `regulator_get()`, on a device pointer
+        // received from the C code.
+        let inner = from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_ptr()) })?;
+
+        // SAFETY: We can safely trust `inner` to be a pointer to a valid
+        // regulator if `ERR_PTR` was not returned.
+        let inner = unsafe { NonNull::new_unchecked(inner) };
+
+        Ok(Self { inner })
+    }
+
+    /// Enables the regulator.
+    pub fn enable(self) -> Result<EnabledRegulator> {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        let res = to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) });
+        res.map(|()| EnabledRegulator { inner: self })
+    }
+}
+
+impl Drop for Regulator {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference,
+        // so it is safe to relinquish it now.
+        unsafe { bindings::regulator_put(self.inner.as_ptr()) };
+    }
+}
+
+/// A `struct regulator` abstraction that is known to be enabled.
+///
+/// # Invariants
+///
+/// - [`EnabledRegulator`] is a valid regulator that has been enabled.
+/// - Each instance of [`EnabledRegulator`] is associated with a single count
+///   of `regulator_enable()`.
+pub struct EnabledRegulator {
+    inner: Regulator,
+}
+
+impl EnabledRegulator {
+    fn as_ptr(&self) -> *mut bindings::regulator {
+        self.inner.inner.as_ptr()
+    }
+
+    /// Disables the regulator.
+    pub fn disable(self) -> Result<Regulator> {
+        // Keep the count on `regulator_get()`.
+        let regulator = ManuallyDrop::new(self);
+
+        // SAFETY: Safe as per the type invariants of `Self`.
+        let res = to_result(unsafe { bindings::regulator_disable(regulator.as_ptr()) });
+
+        res.map(|()| Regulator {
+            inner: regulator.inner.inner,
+        })
+    }
+
+    /// Sets the voltage for the regulator.
+    pub fn set_voltage(&self, min_uv: Microvolt, max_uv: Microvolt) -> Result {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        to_result(unsafe { bindings::regulator_set_voltage(self.as_ptr(), min_uv.0, max_uv.0) })
+    }
+
+    /// Gets the current voltage of the regulator.
+    pub fn get_voltage(&self) -> Result<Microvolt> {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        let voltage = unsafe { bindings::regulator_get_voltage(self.as_ptr()) };
+        if voltage < 0 {
+            Err(Error::from_errno(voltage))
+        } else {
+            Ok(Microvolt(voltage))
+        }
+    }
+}
+
+impl Drop for EnabledRegulator {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference,
+        // so it is safe to relinquish it now.
+        unsafe { bindings::regulator_disable(self.as_ptr()) };
+    }
+}
+
+/// A voltage in microvolts.
+///
+/// The explicit type is used to avoid confusion with other multiples of the
+/// volt, which can be desastrous.
+#[repr(transparent)]
+pub struct Microvolt(pub i32);

---
base-commit: e6ea10d5dbe082c54add289b44f08c9fcfe658af
change-id: 20250326-topics-tyr-regulator-e8b98f6860d7

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


