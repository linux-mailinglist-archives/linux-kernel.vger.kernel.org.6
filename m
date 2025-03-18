Return-Path: <linux-kernel+bounces-566646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDFDA67ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F3A42180F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4856211A2E;
	Tue, 18 Mar 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Vw8k+VOe"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E53212D6A;
	Tue, 18 Mar 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318497; cv=pass; b=Q7GHEHsgNEwPThs474EBn9I49X6ZPbeQNtaiDPbhoNymy2oOtKNsfCYoCl9caYAr9wS9uIZE1eSrfxKoEiljA/SzY8T3YcDxTNgJsq129WJX/Y4NNSqCqQGCHqiOqFzqoV+iZ6x2by6MtFyDg/w5dB+BUrQNj7m+XdnVZncsdIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318497; c=relaxed/simple;
	bh=8voI0LPzq63dvHyzxFwvUGo83/EmzUKr0HB8ev4pbIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNGSqsqHY/+cDYsYBv4O/ejDEm7BaMpavkq+FZgLwNECpJMgBTBx7wFBx5iZg+gO3zXq9zmjEsPmKcH3sHw6QCJsM0CrAUmKOAUiGlpJSKxDJZekD8FFDjYLRmfoMQQJbC5/AvFNMPPqgwkIMEmlpMd8VI0jhz+Y1pMLu6YN/VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Vw8k+VOe; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742318468; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gb5mr9nNS8POngPQeshhsJEhSkdQIxYoaI/8ch2flhHrmvX6kG1gdEdlbznQ8W96GfoO+7YO/B9woLPucJiigbRPLu6EYxPYepfkdM8tFnffrPBp1JE6NU3bFZh775Bt945/fc4hfvUeHj3HJYuRIufXIyuf6btbeZkTSnugvTo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742318468; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AD2UW8E22yWG4zcDqiXe+HUMhBtjHR8VFVahxY25pS0=; 
	b=aR8Cl3H5bsZTvok5m2EfDQ9neRLkDiZmGjHyzbimvhvqZDuxr1eAcsW72Ryez1lUq6cME16TE/bS+H//sXzSDAybXHKTYl6kzyBW2HhTD2F89z8qC/TOsiSwh7zbfy6ay58A/3OOPpzoVy8tCApxACfl0w7jGLeGNTWMOMwFzp4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742318468;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=AD2UW8E22yWG4zcDqiXe+HUMhBtjHR8VFVahxY25pS0=;
	b=Vw8k+VOeSF4tvnpiW/95BKhorjaIx6yT7RkeBl+81qxFd1gRGacO8HSMMjdfn2G+
	pO5gHeSwdhPh4iTIYwTVrjkTyeAe813lEOzWWcPr3kV+yWRr8mWsiX+iMuBZs4TZsZm
	392mCzrujhHgDhahqV1a/Z1jnBs/VWfZ69UAnksU=
Received: by mx.zohomail.com with SMTPS id 1742318466700899.8228548300469;
	Tue, 18 Mar 2025 10:21:06 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 18 Mar 2025 14:20:43 -0300
Subject: [PATCH v7 3/3] rust: platform: allow ioremap of platform resources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-topics-tyr-platform_iomem-v7-3-7438691d9ef7@collabora.com>
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

The preceding patches added support for resources, and for a general
IoMem abstraction, but thus far there is no way to access said IoMem
from drivers, as its creation is unsafe and depends on a resource that
must be acquired from some device first.

Now, allow the ioremap of platform resources themselves, thereby making
the IoMem available to platform drivers.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/platform.rs | 123 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1297f5292ba9b7ca9784f84979efbeccb0768bd3..56f3d7c0d536d77082d7f8d2407de17ee3e95ffa 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,8 +5,14 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    bindings, container_of, device, driver,
+    bindings, container_of, device,
+    devres::Devres,
+    driver,
     error::{to_result, Result},
+    io::{
+        mem::{ExclusiveIoMem, IoMem},
+        resource::Resource,
+    },
     of,
     prelude::*,
     str::CStr,
@@ -191,6 +197,121 @@ fn as_raw(&self) -> *mut bindings::platform_device {
         // embedded in `struct platform_device`.
         unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
     }
+
+    /// Maps a platform resource through ioremap() where the size is known at
+    /// compile time.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::{bindings, c_str, platform};
+    ///
+    /// fn probe(pdev: &mut platform::Device, /* ... */) -> Result<()> {
+    ///     let offset = 0; // Some offset.
+    ///
+    ///     // If the size is known at compile time, use `ioremap_resource_sized`.
+    ///     // No runtime checks will apply when reading and writing.
+    ///     let resource = pdev.resource(0).ok_or(ENODEV)?;
+    ///     let iomem = pdev.ioremap_resource_sized::<42>(&resource)?;
+    ///
+    ///     // Read and write a 32-bit value at `offset`. Calling `try_access()` on
+    ///     // the `Devres` makes sure that the resource is still valid.
+    ///     let data = iomem.try_access().ok_or(ENODEV)?.readl(offset);
+    ///
+    ///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
+    ///
+    ///     # Ok::<(), Error>(())
+    /// }
+    /// ```
+    pub fn ioremap_resource_sized<const SIZE: usize>(
+        &self,
+        resource: &Resource,
+    ) -> Result<Devres<IoMem<SIZE>>> {
+        IoMem::new(resource, self.as_ref())
+    }
+
+    /// Same as [`Self::ioremap_resource_sized`] but with exclusive access to the
+    /// underlying region.
+    pub fn ioremap_resource_exclusive_sized<const SIZE: usize>(
+        &self,
+        resource: &Resource,
+    ) -> Result<Devres<ExclusiveIoMem<SIZE>>> {
+        ExclusiveIoMem::new(resource, self.as_ref())
+    }
+
+    /// Maps a platform resource through ioremap().
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::{bindings, c_str, platform};
+    ///
+    /// fn probe(pdev: &mut platform::Device, /* ... */) -> Result<()> {
+    ///     let offset = 0; // Some offset.
+    ///
+    ///     // Unlike `ioremap_resource_sized`, here the size of the memory region
+    ///     // is not known at compile time, so only the `try_read*` and `try_write*`
+    ///     // family of functions should be used, leading to runtime checks on every
+    ///     // access.
+    ///     let resource = pdev.resource(0).ok_or(ENODEV)?;
+    ///     let iomem = pdev.ioremap_resource(&resource)?;
+    ///
+    ///     let data = iomem.try_access().ok_or(ENODEV)?.try_readl(offset)?;
+    ///
+    ///     iomem.try_access().ok_or(ENODEV)?.try_writel(data, offset)?;
+    ///
+    ///     # Ok::<(), Error>(())
+    /// }
+    /// ```
+    pub fn ioremap_resource(&self, resource: &Resource) -> Result<Devres<IoMem<0>>> {
+        self.ioremap_resource_sized::<0>(resource)
+    }
+
+    /// Same as [`Self::ioremap_resource`] but with exclusive access to the underlying
+    /// region.
+    pub fn ioremap_resource_exclusive(
+        &self,
+        resource: &Resource,
+    ) -> Result<Devres<ExclusiveIoMem<0>>> {
+        self.ioremap_resource_exclusive_sized::<0>(resource)
+    }
+
+    /// Returns the resource at `index`, if any.
+    pub fn resource(&self, index: u32) -> Option<&Resource> {
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct platform_device`.
+        let resource = unsafe {
+            bindings::platform_get_resource(self.as_raw(), bindings::IORESOURCE_MEM, index)
+        };
+
+        if resource.is_null() {
+            return None;
+        }
+
+        // SAFETY: `resource` is a valid pointer to a `struct resource` as
+        // returned by `platform_get_resource`.
+        Some(unsafe { Resource::from_ptr(resource) })
+    }
+
+    /// Returns the resource with a given `name`, if any.
+    pub fn resource_by_name(&self, name: &CStr) -> Option<&Resource> {
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct
+        // platform_device` and `name` points to a valid C string.
+        let resource = unsafe {
+            bindings::platform_get_resource_byname(
+                self.as_raw(),
+                bindings::IORESOURCE_MEM,
+                name.as_char_ptr(),
+            )
+        };
+
+        if resource.is_null() {
+            return None;
+        }
+
+        // SAFETY: `resource` is a valid pointer to a `struct resource` as
+        // returned by `platform_get_resource`.
+        Some(unsafe { Resource::from_ptr(resource) })
+    }
 }
 
 impl AsRef<device::Device> for Device {

-- 
2.48.1


