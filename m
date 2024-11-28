Return-Path: <linux-kernel+bounces-424800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4DA9DB995
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151EC163EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718621AF0A0;
	Thu, 28 Nov 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="WhBbX/RH"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A7192D77;
	Thu, 28 Nov 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804070; cv=pass; b=bYECtaA7snm5lV++Kjvds+0YQ89fUC7dvQhGq9lb2vmOlSEsBc+NZ1Ngrll9rbkRO3GoGgex2C3+bZlo8BM3u0+GxBjiUTpv467fz8RHkoTDM2p0IGsvtuLgRaHebnMSIT8yc3NircOWranMUNJmXfpW+Mkfwv7FdTUAh3aa0aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804070; c=relaxed/simple;
	bh=/OCdELABhELiTD3yLV24GkZuTIydvNkMEyXt7wZ6V0I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Pb25EN5OJ4kxSRnz2vjtoWfiLsT62GJ8bX7H16PXQPmleT3WYE7Htc4Hk/we/SaGqNo4oed8rjTJfZBu4S78nWljCDs1CO0V3bnKZUIBffam6cWyEd1bR3o3HlU5KKuDAFoJPjD7yaAcRvmHdrASDjeuTMe1dEjDc8BDS0v9+is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=WhBbX/RH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732804018; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M1I+R5hdGrfBQtFpfqbuU9AcQm+ENDw21pA+ztFM8QVYrMKPTTjU4xFMqv5SAjP9UhUdGsxoE82RpM1V0cs1QdzdrFRo7nv6Z8sTlhs6JtgNv8RLfKa/qA4Q2TgJTpARSUXAztOLirzCvqUrlSds7ZSkEynMMch4uoHD4kc5i7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732804018; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BTc+58swVCnQAxbgfn+nct2bnJo2uB0XZdEQl2ZEf2M=; 
	b=Eo8cbIH8dHJjqNQlICxpQkOkTdnidKvqbgrM1xWzgSNl+ekciRrvYyL3s+7ksM2qLiknyXh1bYy0Sc0rlrcNCbJwU+xrZS1MYY5MpC46xnij0FnWPAZdXIy9WKEHY2rhg6m2dfcVWi2lvRh0a8kLztNsB2cN1CsdLhkKyktFG7I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732804018;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=BTc+58swVCnQAxbgfn+nct2bnJo2uB0XZdEQl2ZEf2M=;
	b=WhBbX/RHlGsMUlVCUkI7AWGgbzJ3A4XYZWSDfsmieBVjFnZ1igdCdtoIH9oa/8B9
	cEJzleDGMMT8z/gBrVwXsAq0TVF16CPDFgIW2bp7/aVo3ez8F1EmYcTRM4m64986hTJ
	Ym0WnFuEn9Z8t76w3POfeWogTN4b6iFArENutINw=
Received: by mx.zohomail.com with SMTPS id 1732804017539591.382249497848;
	Thu, 28 Nov 2024 06:26:57 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 27/35] rust: drm/kms: Add drm_framebuffer bindings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-28-lyude@redhat.com>
Date: Thu, 28 Nov 2024 11:26:42 -0300
Cc: dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Asahi Lina <lina@asahilina.net>,
 Danilo Krummrich <dakr@kernel.org>,
 mcanal@igalia.com,
 airlied@redhat.com,
 zhiw@nvidia.com,
 cjia@nvidia.com,
 jhubbard@nvidia.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@redhat.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9ADBAF1-7A13-4756-8787-C05CF36DC2BD@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-28-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External



> On 30 Sep 2024, at 20:10, Lyude Paul <lyude@redhat.com> wrote:
>=20
> This adds some very simple bindings for drm_framebuffer. We don't use =
them
> much yet, but we'll eventually be using them when rvkms eventually =
gets CRC
> and writeback support. Just like Connector objects, these use =
RcModeObject.

Yeah, for the non-KMS devs like me, a brief explanation on CRC and =
writeback support
would be helpful

>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/bindings/bindings_helper.h    |  1 +
> rust/kernel/drm/kms.rs             |  1 +
> rust/kernel/drm/kms/framebuffer.rs | 58 ++++++++++++++++++++++++++++++
> 3 files changed, 60 insertions(+)
> create mode 100644 rust/kernel/drm/kms/framebuffer.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index 7695f11f4363c..7c324003c3885 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -15,6 +15,7 @@
> #include <drm/drm_fourcc.h>
> #include <drm/drm_fbdev_dma.h>
> #include <drm/drm_fbdev_shmem.h>
> +#include <drm/drm_framebuffer.h>
> #include <drm/drm_gem.h>
> #include <drm/drm_gem_framebuffer_helper.h>
> #include <drm/drm_gem_shmem_helper.h>
> diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
> index 4ab039d67352e..3edd90bc0025a 100644
> --- a/rust/kernel/drm/kms.rs
> +++ b/rust/kernel/drm/kms.rs
> @@ -7,6 +7,7 @@
> pub mod crtc;
> pub mod encoder;
> pub mod fbdev;
> +pub mod framebuffer;
> pub mod plane;
>=20
> use crate::{
> diff --git a/rust/kernel/drm/kms/framebuffer.rs =
b/rust/kernel/drm/kms/framebuffer.rs
> new file mode 100644
> index 0000000000000..bbe408c187670
> --- /dev/null
> +++ b/rust/kernel/drm/kms/framebuffer.rs
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +//! DRM Framebuffer related bindings
> +
> +use crate::{
> +    drm::{
> +        device::Device,
> +        fourcc::*,
> +    },
> +    types::*,
> +    prelude::*,
> +};
> +use bindings;
> +use core::{
> +    marker::*,
> +    slice,
> +};
> +use super::{ModeObject, RcModeObject, KmsDriver};
> +
> +/// The main interface for [`struct drm_framebuffer`].
> +///
> +/// [`struct drm_framebuffer`]: srctree/include/drm/drm_framebuffer.h
> +#[repr(transparent)]
> +pub struct Framebuffer<T: KmsDriver> {
> +    inner: Opaque<bindings::drm_framebuffer>,
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> ModeObject for Framebuffer<T> {
> +    type Driver =3D T;
> +
> +    fn drm_dev(&self) -> &Device<Self::Driver> {
> +        unsafe { Device::borrow((*self.inner.get()).dev) }
> +    }
> +
> +    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
> +        // SAFETY: We don't expose Framebuffer<T> to users before =
it's initialized, so `base` is
> +        // always initialized
> +        unsafe { &mut (*self.inner.get()).base }
> +    }
> +}
> +
> +// SAFETY: Framebuffers are refcounted mode objects.
> +unsafe impl<T: KmsDriver> RcModeObject for Framebuffer<T> {}
> +
> +// SAFETY: References to framebuffers are safe to be accessed from =
any thread
> +unsafe impl<T: KmsDriver> Send for Framebuffer<T> {}
> +// SAFETY: References to framebuffers are safe to be accessed from =
any thread
> +unsafe impl<T: KmsDriver> Sync for Framebuffer<T> {}
> +
> +impl<T: KmsDriver> crate::private::Sealed for Framebuffer<T> {}

A brief comment on why you=E2=80=99re implementing Sealed would also be =
good :)

> +
> +impl<T: KmsDriver> Framebuffer<T> {
> +    #[inline]
> +    pub(super) unsafe fn from_raw<'a>(ptr: *const =
bindings::drm_framebuffer) -> &'a Self {
> +        // SAFETY: Our data layout is identical to drm_framebuffer
> +        unsafe { &*ptr.cast() }
> +    }
> +}
> --=20
> 2.46.1
>=20

This LGTM.

=E2=80=94 Daniel


