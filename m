Return-Path: <linux-kernel+bounces-566645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC46A67AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4168D170A42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194491B3937;
	Tue, 18 Mar 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RJFpm8sA"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1079460;
	Tue, 18 Mar 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318492; cv=pass; b=hsZPGfL0LxYsPwvtBiIEbeE360zRO6ImknHpgB5uctLr/FwG93iVOcloxu7eoIHL54VzE+2PcIoxtvvgupdcN10XsGWYu+PWzhCYRA8/KVVYqLefNZcsj4gsxIHnqD/SEsc0OtBRCAJuswECS/0ygpAL1FLM66cRGoggNtWJXGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318492; c=relaxed/simple;
	bh=n2btvpBmZMeQIENh3Zzadv3c3kLolgVQU2HLIttBfT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOjlmlTygAgIxajVGLVon3Y125KhNeykvodGyH6Glr5oPOO325eSUux2PgdgecDi2nW6jDo9haqVV2tWDuLWrO91CXA8RplA3U5RX/x0lkUxxGL1PUJFY9YzMB1NchCCI3OxIaJVxR+XdfcKufpVKlY27b/m2NO7rcRN6O5HrDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=RJFpm8sA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742318460; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I0qb3Q37gvfrs5CcZ0GlNMINMcaF38PJu1asyS10DyKJBm3t2mh1zFqt0fqALALSAQuhiMFDL/AfOsAmc52uIf0XUCgdLOSLwxwoOsV9QTuOMi6joRU2+Kv6pXCGevUqoQM1RzUQFWW9jr9DAJZBwE8i46B8ZeDS8ZExkb+MX4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742318460; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=au3/nVCCGkwCalhGMwNSRRogGPQF1thxyLkKuC37igA=; 
	b=TVBpM715Y9j9fUZbx7s94HZBpbrTVf9kiPQYFDYfbUiYu0E4yFRrKXDYA42PWKhKrCRJFWefVxPUGymcWQiQRPmnUrAUxdL2ghSvPil9PK1atzfmmzKH203NZ2ATGP5TcmuDaIAfD2S+hDGaGabJj6MELyGQj/fjE0EF/TPZ0Qs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742318460;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=au3/nVCCGkwCalhGMwNSRRogGPQF1thxyLkKuC37igA=;
	b=RJFpm8sASyZantQJ0jhJL6rrmSq9ZblsKjbie+bpDxycwdY+tq1/pIzmizkg0gk4
	JJp0SvnAD4pSdb+OkxXwUF1PqelZzb28UZy8n7AXgvVftLJ6nyOsuW+QL3LEtMhjS6o
	UrhTPUH4VRWmhahidcKjt4Gve1DCF45NzNTGI18g=
Received: by mx.zohomail.com with SMTPS id 1742318459147606.1655870045697;
	Tue, 18 Mar 2025 10:20:59 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 18 Mar 2025 14:20:41 -0300
Subject: [PATCH v7 1/3] rust: io: add resource abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-topics-tyr-platform_iomem-v7-1-7438691d9ef7@collabora.com>
References: <20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com>
In-Reply-To: <20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Fiona Behrens <me@kloenk.dev>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

In preparation for ioremap support, add a Rust abstraction for struct
resource.

A future commit will introduce the Rust API to ioremap a resource from a
platform device. The current abstraction, therefore, adds only the
minimum API needed to get that done.

Co-developed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/io.c               |  36 +++++++
 rust/kernel/io.rs               |   2 +
 rust/kernel/io/resource.rs      | 222 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 261 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae39fc18a8bf07be385e383e5ee0a2e30c6922b4..89a2a17841b55b31afd385bda3566a8eb08b4f7e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -17,6 +17,7 @@
 #include <linux/file.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
 #include <linux/mdio.h>
diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 4c2401ccd72078af4e6901f4cd95f9070522f396..939ab38ca61dac4cf884677a20edc760094d5812 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/io.h>
+#include <linux/ioport.h>
 
 void __iomem *rust_helper_ioremap(phys_addr_t offset, size_t size)
 {
@@ -99,3 +100,38 @@ void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
 	writeq_relaxed(value, addr);
 }
 #endif
+
+resource_size_t rust_helper_resource_size(struct resource *res)
+{
+	return resource_size(res);
+}
+
+struct resource *rust_helper_request_mem_region(resource_size_t start,
+						resource_size_t n,
+						const char *name)
+{
+	return request_mem_region(start, n, name);
+}
+
+void rust_helper_release_mem_region(resource_size_t start, resource_size_t n)
+{
+	release_mem_region(start, n);
+}
+
+struct resource *rust_helper_request_region(resource_size_t start,
+					    resource_size_t n, const char *name)
+{
+	return request_region(start, n, name);
+}
+
+struct resource *rust_helper_request_muxed_region(resource_size_t start,
+						  resource_size_t n,
+						  const char *name)
+{
+	return request_muxed_region(start, n, name);
+}
+
+void rust_helper_release_region(resource_size_t start, resource_size_t n)
+{
+	release_region(start, n);
+}
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d4a73e52e3ee68f7b558749ed0108acde92ae5fe..566d8b177e01ada5b184d4250dc24caba6492e49 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -7,6 +7,8 @@
 use crate::error::{code::EINVAL, Result};
 use crate::{bindings, build_assert};
 
+pub mod resource;
+
 /// Raw representation of an MMIO region.
 ///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
new file mode 100644
index 0000000000000000000000000000000000000000..3eb5c8ef585078398551fe8189fd96c1b6c1eeff
--- /dev/null
+++ b/rust/kernel/io/resource.rs
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstraction for system resources.
+//!
+//! C header: [`include/linux/ioport.h`](srctree/include/linux/ioport.h)
+
+use core::ops::Deref;
+use core::ptr::NonNull;
+
+use crate::str::CStr;
+use crate::types::Opaque;
+
+#[cfg(CONFIG_HAS_IOPORT)]
+/// Returns a reference to the global `ioport_resource` variable.
+pub fn ioport_resource() -> &'static Resource {
+    // SAFETY: `bindings::ioport_resoure` has global lifetime and is of type Resource.
+    unsafe { Resource::from_ptr(core::ptr::addr_of_mut!(bindings::ioport_resource)) }
+}
+
+#[cfg(CONFIG_HAS_IOMEM)]
+/// Returns a reference to the global `iomem_resource` variable.
+pub fn iomem_resource() -> &'static Resource {
+    // SAFETY: `bindings::iomem_resoure` has global lifetime and is of type Resource.
+    unsafe { Resource::from_ptr(core::ptr::addr_of_mut!(bindings::iomem_resource)) }
+}
+
+/// Resource Size type.
+///
+/// This is a type alias to `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`.
+#[cfg(CONFIG_PHYS_ADDR_T_64BIT)]
+pub type ResourceSize = u64;
+
+/// Resource Size type.
+///
+/// This is a type alias to `u32` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`.
+#[cfg(not(CONFIG_PHYS_ADDR_T_64BIT))]
+pub type ResourceSize = u32;
+
+/// A region allocated from a parent resource.
+///
+/// # Invariants
+///
+/// - `self.0` points to a valid `bindings::resource` that was obtained through
+///   `__request_region`.
+pub struct Region(NonNull<bindings::resource>);
+
+impl Deref for Region {
+    type Target = Resource;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Safe as per the invariant of `Region`
+        unsafe { Resource::from_ptr(self.0.as_ptr()) }
+    }
+}
+
+impl Drop for Region {
+    fn drop(&mut self) {
+        // SAFETY: Safe as per the invariant of `Region`
+        let res = unsafe { Resource::from_ptr(self.0.as_ptr()) };
+        let flags = res.flags();
+
+        let release_fn = if flags.contains(flags::IORESOURCE_MEM) {
+            bindings::release_mem_region
+        } else {
+            bindings::release_region
+        };
+
+        // SAFETY: Safe as per the invariant of `Region`
+        unsafe { release_fn(res.start(), res.size()) };
+    }
+}
+
+// SAFETY: `Region` only holds a pointer to a C `struct resource`, which is safe to be used from
+// any thread.
+unsafe impl Send for Region {}
+
+// SAFETY: `Region` only holds a pointer to a C `struct resource`, references to which are
+// safe to be used from any thread.
+unsafe impl Sync for Region {}
+
+/// A resource abstraction.
+///
+/// # Invariants
+///
+/// `Resource` is a transparent wrapper around a valid `bindings::resource`.
+#[repr(transparent)]
+pub struct Resource(Opaque<bindings::resource>);
+
+impl Resource {
+    /// Creates a reference to a [`Resource`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that for the duration of 'a, the pointer will
+    /// point at a valid `bindings::resource`
+    ///
+    /// The caller must also ensure that the `Resource` is only accessed via the
+    /// returned reference for the duration of 'a.
+    pub(crate) const unsafe fn from_ptr<'a>(ptr: *mut bindings::resource) -> &'a Self {
+        // SAFETY: Self is a transparent wrapper around `Opaque<bindings::resource>`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Requests a resource region.
+    ///
+    /// Exclusive access will be given and the region will be marked as busy.
+    /// Further calls to `request_region` will return `None` if the region, or a
+    /// part of it, is already in use.
+    pub fn request_region(
+        &self,
+        start: ResourceSize,
+        size: ResourceSize,
+        name: &'static CStr,
+        flags: Flags,
+    ) -> Option<Region> {
+        // SAFETY: Safe as per the invariant of `Resource`
+        let region = unsafe {
+            bindings::__request_region(
+                self.0.get(),
+                start,
+                size,
+                name.as_char_ptr(),
+                flags.0 as i32,
+            )
+        };
+
+        Some(Region(NonNull::new(region)?))
+    }
+
+    /// Returns the size of the resource.
+    pub fn size(&self) -> ResourceSize {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`
+        unsafe { bindings::resource_size(inner) }
+    }
+
+    /// Returns the start address of the resource.
+    pub fn start(&self) -> u64 {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`
+        unsafe { *inner }.start
+    }
+
+    /// Returns the name of the resource.
+    pub fn name(&self) -> &'static CStr {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`
+        unsafe { CStr::from_char_ptr((*inner).name) }
+    }
+
+    /// Returns the flags associated with the resource.
+    pub fn flags(&self) -> Flags {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`
+        let flags = unsafe { *inner }.flags;
+
+        Flags(flags)
+    }
+}
+
+// SAFETY: `Resource` only holds a pointer to a C `struct resource`, which is safe to be used from
+// any thead.
+unsafe impl Send for Resource {}
+
+// SAFETY: `Resource` only holds a pointer to a C `struct resource`, references to which are
+// safe to be used from any thead.
+unsafe impl Sync for Resource {}
+
+/// Resource flags as stored in the C `struct resource::flags` field.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`flags`] module.
+#[derive(Clone, Copy, PartialEq)]
+pub struct Flags(usize);
+
+impl Flags {
+    /// Check whether `flags` is contained in `self`.
+    pub fn contains(self, flags: Flags) -> bool {
+        (self & flags) == flags
+    }
+}
+
+impl core::ops::BitOr for Flags {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Flags {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Flags {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}
+
+/// Resource flags as stored in the `struct resource::flags` field.
+pub mod flags {
+    use super::Flags;
+
+    /// PCI/ISA I/O ports.
+    pub const IORESOURCE_IO: Flags = Flags(bindings::IORESOURCE_IO as usize);
+
+    /// Resource is software muxed.
+    pub const IORESOURCE_MUXED: Flags = Flags(bindings::IORESOURCE_MUXED as usize);
+
+    /// Resource represents a memory region.
+    pub const IORESOURCE_MEM: Flags = Flags(bindings::IORESOURCE_MEM as usize);
+
+    /// Resource represents a memory region that must be ioremaped using `ioremap_np`.
+    pub const IORESOURCE_MEM_NONPOSTED: Flags = Flags(bindings::IORESOURCE_MEM_NONPOSTED as usize);
+}

-- 
2.48.1


