Return-Path: <linux-kernel+bounces-422788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBDB9D9E27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F01166D79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683111DED7F;
	Tue, 26 Nov 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="CVTqKuBd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0B1CF284;
	Tue, 26 Nov 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651155; cv=pass; b=RbCDW0+U/HoxOXvAoUGqpAyvqSvBDbGUHOZYr0GjmkeyQCCRVGszOKvIHF/VKIzNvPGtHsTiugCQd2IHiiyNvcnj4XxtAzvuZVU69Oy0zI7cP6hra/jG+Zjb4mMQNdNYKd4lUMHH2coiKs1lORiqCddnMNqeVmNnkDB693x8lMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651155; c=relaxed/simple;
	bh=8b8K7dif9/wk3uF4MTWXrkm0in+O0ln3yOiyBIwz78o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mrnwHTAg7nCoJqz//VDC8nRRcrhx2TQ55E+1bXgU7NRw8e8J3bXw7IoenQWd8dwdkBrH6DE+t/0/GApiA406iFTlbXzpu2JhRwBEVxk9cYLXayNTDVIIx9DrL+01putp+ElC+EgB7mkcbjvGnILF2++2x2Hm+sHLLvDnO9/grKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=CVTqKuBd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732651115; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UinnDUSSLJLQP0EWj5w3ZHKQsDu1njWXMxaPrUFZhoADN1OBqCe4GoujKgtVUklK5pYhayDCszD14cUR2xnUym2ZGYGGBopVFppQmVtuLZKVh47lvM3OUiGgiVwZM7AoUfT3AGcrmh6OTh7J7+r9mRdlGXPZO5owciF2JnCkbuw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732651115; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=n31/42psIzep6nT0gmMfc3YsqkLTl00DNbtqZXa3F+c=; 
	b=jB7C2pX2Dgl4+UQVzA1MtbL0OPzeHAURHw/qfVCQ45W+oFbyJvhJP5qh4uQMmT3Nz44sI8QNXCK0nbAXfuy4xXoSvtSDh0LQhd+ey/0MkT6K8HZj1kx6co+r9uJ27pbj9yTW6+5J0NiP2FBdQuMlwTDY9p7N9qM2fyNy4HPdlSw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732651115;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=n31/42psIzep6nT0gmMfc3YsqkLTl00DNbtqZXa3F+c=;
	b=CVTqKuBd3oHe+eZxdnaAuTyovxL2fWlAWL7Ojn6F4Fe4M4SMa0oo7LEmAuMS/jUr
	Dn6k38MC/k7PSz6smZQDAM+zTA1Yk5VL0jPGEMUgoufZNki29OqNwv1So1ittR6hwFn
	mqMdOaA8BOBMLraQqv5QxnA4EqShLL7hRxvJLo1A=
Received: by mx.zohomail.com with SMTPS id 1732651112310938.0447124159992;
	Tue, 26 Nov 2024 11:58:32 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 03/35] rust: drm/kms/fbdev: Add FbdevShmem
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-4-lyude@redhat.com>
Date: Tue, 26 Nov 2024 16:58:16 -0300
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
Message-Id: <891964F7-71C5-4869-9CD2-9052A0758F74@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-4-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude,

> On 30 Sep 2024, at 20:09, Lyude Paul <lyude@redhat.com> wrote:
>=20
> For drivers which use the shmem based GEM helpers, they'll want to use =
the
> relevant drm_fbdev_shmem_setup() functions instead of the
> drm_fbdev_dma_setup() functions. To allow for this, introduce another
> FbdevImpl that such drivers can use instead of FbdevDma.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/bindings/bindings_helper.h    |  1 +
> rust/kernel/drm/kms/fbdev.rs       |  8 +++++++-
> rust/kernel/drm/kms/fbdev/shmem.rs | 33 ++++++++++++++++++++++++++++++
> 3 files changed, 41 insertions(+), 1 deletion(-)
> create mode 100644 rust/kernel/drm/kms/fbdev/shmem.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index 4a8e44e11c96a..9803e0ecac7c1 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -13,6 +13,7 @@
> #include <drm/drm_file.h>
> #include <drm/drm_fourcc.h>
> #include <drm/drm_fbdev_dma.h>
> +#include <drm/drm_fbdev_shmem.h>
> #include <drm/drm_gem.h>
> #include <drm/drm_gem_framebuffer_helper.h>
> #include <drm/drm_gem_shmem_helper.h>
> diff --git a/rust/kernel/drm/kms/fbdev.rs =
b/rust/kernel/drm/kms/fbdev.rs
> index bdf97500137d8..a1035d948949a 100644
> --- a/rust/kernel/drm/kms/fbdev.rs
> +++ b/rust/kernel/drm/kms/fbdev.rs
> @@ -5,6 +5,12 @@
> use crate::{private::Sealed, drm::{kms::*, device::Device, gem}};
> use bindings;
>=20
> +#[cfg(CONFIG_DRM_GEM_SHMEM_HELPER =3D "y")]
> +mod shmem;
> +
> +#[cfg(CONFIG_DRM_GEM_SHMEM_HELPER =3D "y")]
> +pub use shmem::FbdevShmem;
> +
> pub(crate) mod private {
>     use super::*;
>=20
> @@ -17,7 +23,7 @@ pub trait FbdevImpl {
> /// The main trait for a driver's DRM implementation.
> ///
> /// Drivers are expected not to implement this directly, and to =
instead use one of the objects
> -/// provided by this module such as [`FbdevDma`].
> +/// provided by this module such as [`FbdevDma`] and [`FbdevShmem`].
> pub trait FbdevImpl: private::FbdevImpl {}
>=20
> /// The fbdev implementation for drivers using the gem DMA helpers.
> diff --git a/rust/kernel/drm/kms/fbdev/shmem.rs =
b/rust/kernel/drm/kms/fbdev/shmem.rs
> new file mode 100644
> index 0000000000000..16c3533ad2a0f
> --- /dev/null
> +++ b/rust/kernel/drm/kms/fbdev/shmem.rs
> @@ -0,0 +1,33 @@
> +//! The GEM shmem fbdev implementation for rust.
> +//!
> +//! This module provides an Fbdev implementation that can be used by =
Rust KMS drivers using the GEM
> +//! shmem helpers provided by [`shmem`].
> +
> +use core::marker::*;
> +use crate::drm::{gem::shmem, kms::*, device::Device};
> +use super::{private::FbdevImpl as FbdevImplPrivate, FbdevImpl};
> +use bindings;
> +
> +/// The fbdev implementation for drivers using the gem shmem helpers.
> +///
> +/// KMS Drivers which use the GEM helpers provided by [`shmem`] =
should use this for [`Kms::Fbdev`].
> +pub struct FbdevShmem<T: Driver>(PhantomData<T>);

As I said in the preceding patch, I find this a bit confusing. On one =
hand, it seems like there=E2=80=99s the possibility
of a mismatch when reading the paragraph above,=20

> +
> +impl<T, G> FbdevImplPrivate for FbdevShmem<T>
> +where
> +    T: Driver<Object =3D shmem::Object<G>>,
> +    G: shmem::DriverObject

But on the other hand, you seem to be enforcing some consistency using =
bounds.

Again, a small example would be nice in a future iteration.

> +{
> +    #[inline]
> +    fn setup_fbdev<D: Driver>(drm: &Device<D>, mode_config_info: =
&ModeConfigInfo) {
> +        // SAFETY: Our implementation bounds are proof that this =
driver is using the gem shmem
> +        // helpers
> +        unsafe { bindings::drm_fbdev_shmem_setup(drm.as_raw(), =
mode_config_info.preferred_depth) };
> +    }
> +}
> +
> +impl<T, G> FbdevImpl for FbdevShmem<T>
> +where
> +    T: Driver<Object =3D shmem::Object<G>>,
> +    G: shmem::DriverObject
> +{}
> --=20
> 2.46.1
>=20

Barring the comment above, the rest of this patch looks good to me.

=E2=80=94 Daniel


