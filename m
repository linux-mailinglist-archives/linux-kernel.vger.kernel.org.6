Return-Path: <linux-kernel+bounces-566643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1702A67AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36324175E91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A853721129B;
	Tue, 18 Mar 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ArlGzV8i"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479B157E99;
	Tue, 18 Mar 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318486; cv=pass; b=E1WP6AXzBeMrs9+eUqubT7tUg8iqvrBtw6OlzSZURg7WRIGoX7vv2ZtiSsIX5ShT9M8IWMF1KJy3rEpfMR7xB2Q8nkj8wv9Pns5STsECmLHv3awNN2mvNdsUDQL9c2Sap5aORHs/UC0jnA9s4xj4isLJJLUW1W4a6F+qkl0Nmf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318486; c=relaxed/simple;
	bh=7eLpM/ImdfFLZa4kOn8dbZ86BNhYZsyKJOJtxnwdYpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUbFGvvv290tdq2TqnfuENoJqti8YlLmDLZYAOcmWWj3qpYKSIcrFeXvv3kwL0K29ZaksuFyGXWtI0VS84tSqoo2thkZt2foGTbj76TgLiuc34rr6vKtb7hTM5fNChJ2h3fF2/vvViB/+eUZaJeR6adSxgPHE4mH3jeB7COAIjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ArlGzV8i; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742318464; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WuIchRj2N7sd/u7zBRMYSRMvRq0AWwBagIBiylaWgNoUXWBwZtkgo6RJE/FIeE1kWoFb3N6FL2X6peEXLZXqtKPrNfWnlIHwbnKIEMXMW1phdLZDKGL7SdzPhoK3jPmJ/p09EzPLUU4BscA0UTO09zqrDM2KybMSggRUb20mvOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742318464; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kKEHgAo6DqLhhO69tVzjvTC5yJIdhYIgJuG19wNPJFM=; 
	b=J644+ft2AN6aHNVez23TcM59gcM4CJF9Fr1Vm2ix798QGnQJ1NcT+2vltV2N7TcchN8gMXuKzfWdCDiB+ppZwDsnn3oe6c+rNa6OUlfkUbGBciyUHhkskTVr5oFLu9vuvjFq3BrJN7J/DM9eYC1LJKQmyIDu1QXS/4j0AJVEegw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742318464;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=kKEHgAo6DqLhhO69tVzjvTC5yJIdhYIgJuG19wNPJFM=;
	b=ArlGzV8iPbCH5SsjluxCT7Upr/5Oe5S3ufVJZI89pDMK5kAdkKESSEm0x4Fu3bYX
	CVFKiqbXnsFWx5x+ARm/fCb5jDP2V8mYisJL0/FqOdeMJbxACajFA5LJhuN1utiCeSB
	PfxT8u4oKGbJw3xZ/IOl9dgzD2ci17WBWBK/gzLo=
Received: by mx.zohomail.com with SMTPS id 1742318462871321.5770885997749;
	Tue, 18 Mar 2025 10:21:02 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 18 Mar 2025 14:20:42 -0300
Subject: [PATCH v7 2/3] rust: io: mem: add a generic iomem abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-topics-tyr-platform_iomem-v7-2-7438691d9ef7@collabora.com>
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
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Add a generic iomem abstraction to safely read and write ioremapped
regions.

The reads and writes are done through IoRaw, and are thus checked either
at compile-time, if the size of the region is known at that point, or at
runtime otherwise.

Non-exclusive access to the underlying memory region is made possible to
cater to cases where overlapped regions are unavoidable.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/helpers/io.c     |   5 ++
 rust/kernel/io.rs     |   1 +
 rust/kernel/io/mem.rs | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 939ab38ca61dac4cf884677a20edc760094d5812..4fbd70ab60f64155bef835a43b3c64d441aee7bf 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -8,6 +8,11 @@ void __iomem *rust_helper_ioremap(phys_addr_t offset, size_t size)
 	return ioremap(offset, size);
 }
 
+void __iomem *rust_helper_ioremap_np(phys_addr_t offset, size_t size)
+{
+	return ioremap_np(offset, size);
+}
+
 void rust_helper_iounmap(volatile void __iomem *addr)
 {
 	iounmap(addr);
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 566d8b177e01ada5b184d4250dc24caba6492e49..9ce3482b5ecd9c9de4f46bf949984bb54081f5a3 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -7,6 +7,7 @@
 use crate::error::{code::EINVAL, Result};
 use crate::{bindings, build_assert};
 
+pub mod mem;
 pub mod resource;
 
 /// Raw representation of an MMIO region.
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
new file mode 100644
index 0000000000000000000000000000000000000000..3e7ef8b6f0ca8b5b195a94c7ed0f94a9e6c72944
--- /dev/null
+++ b/rust/kernel/io/mem.rs
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic memory-mapped IO.
+
+use core::ops::Deref;
+
+use crate::device::Device;
+use crate::devres::Devres;
+use crate::io;
+use crate::io::resource::Region;
+use crate::io::resource::Resource;
+use crate::io::Io;
+use crate::io::IoRaw;
+use crate::prelude::*;
+
+/// An exclusive memory-mapped IO region.
+///
+/// # Invariants
+///
+/// - [`ExclusiveIoMem`] has exclusive access to the underlying `iomem`.
+pub struct ExclusiveIoMem<const SIZE: usize> {
+    /// The region abstraction. This represents exclusive access to the
+    /// range represented by the underlying `iomem`.
+    ///
+    /// It's placed first to ensure that the region is released before it is
+    /// unmapped as a result of the drop order.
+    ///
+    /// This field is needed for ownership of the region.
+    _region: Region,
+    /// The underlying `IoMem` instance.
+    iomem: IoMem<SIZE>,
+}
+
+impl<const SIZE: usize> ExclusiveIoMem<SIZE> {
+    /// Creates a new `ExclusiveIoMem` instance.
+    pub(crate) fn ioremap(resource: &Resource) -> Result<Self> {
+        let iomem = IoMem::ioremap(resource)?;
+
+        let start = resource.start();
+        let size = resource.size();
+        let name = resource.name();
+
+        let region = resource
+            .request_region(start, size, name, io::resource::flags::IORESOURCE_MEM)
+            .ok_or(EBUSY)?;
+
+        let iomem = ExclusiveIoMem {
+            iomem,
+            _region: region,
+        };
+
+        Ok(iomem)
+    }
+
+    pub(crate) fn new(resource: &Resource, device: &Device) -> Result<Devres<Self>> {
+        let iomem = Self::ioremap(resource)?;
+        let devres = Devres::new(device, iomem, GFP_KERNEL)?;
+
+        Ok(devres)
+    }
+}
+
+impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
+    type Target = Io<SIZE>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.iomem
+    }
+}
+
+/// A generic memory-mapped IO region.
+///
+/// Accesses to the underlying region is checked either at compile time, if the
+/// region's size is known at that point, or at runtime otherwise.
+///
+/// # Invariants
+///
+/// `IoMem` always holds an `IoRaw` instance that holds a valid pointer to the
+/// start of the I/O memory mapped region.
+pub struct IoMem<const SIZE: usize = 0> {
+    io: IoRaw<SIZE>,
+}
+
+impl<const SIZE: usize> IoMem<SIZE> {
+    fn ioremap(resource: &Resource) -> Result<Self> {
+        let size = resource.size();
+        if size == 0 {
+            return Err(EINVAL);
+        }
+
+        let res_start = resource.start();
+
+        let addr = if resource
+            .flags()
+            .contains(io::resource::flags::IORESOURCE_MEM_NONPOSTED)
+        {
+            // SAFETY:
+            // - `res_start` and `size` are read from a presumably valid `struct resource`.
+            // - `size` is known not to be zero at this point.
+            unsafe { bindings::ioremap_np(res_start, size as usize) }
+        } else {
+            // SAFETY:
+            // - `res_start` and `size` are read from a presumably valid `struct resource`.
+            // - `size` is known not to be zero at this point.
+            unsafe { bindings::ioremap(res_start, size as usize) }
+        };
+
+        if addr.is_null() {
+            return Err(ENOMEM);
+        }
+
+        let io = IoRaw::new(addr as usize, size as usize)?;
+        let io = IoMem { io };
+
+        Ok(io)
+    }
+
+    /// Creates a new `IoMem` instance.
+    pub(crate) fn new(resource: &Resource, device: &Device) -> Result<Devres<Self>> {
+        let io = Self::ioremap(resource)?;
+        let devres = Devres::new(device, io, GFP_KERNEL)?;
+
+        Ok(devres)
+    }
+}
+
+impl<const SIZE: usize> Drop for IoMem<SIZE> {
+    fn drop(&mut self) {
+        // SAFETY: Safe as by the invariant of `Io`.
+        unsafe { bindings::iounmap(self.io.addr() as *mut core::ffi::c_void) }
+    }
+}
+
+impl<const SIZE: usize> Deref for IoMem<SIZE> {
+    type Target = Io<SIZE>;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Safe as by the invariant of `IoMem`.
+        unsafe { Io::from_raw(&self.io) }
+    }
+}

-- 
2.48.1


