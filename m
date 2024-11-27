Return-Path: <linux-kernel+bounces-423681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621689DAB49
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17C7B22525
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512A620013D;
	Wed, 27 Nov 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="URs6Go4O"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA520200127;
	Wed, 27 Nov 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723292; cv=pass; b=j4Eeh6505/NK2G39tJKV6csokWMV/fCWDsYb9LPPTVvSkumKvkf5ZaTr10/BZLnv36Ba+ZV9X5v2wf6XcHdY0thMPox9ajgCc4t/eR8DoPzW7Xz2oByV+QjVxHuT0+cNC86L7KMQfjJNmDSN1PYSMFebZaFCI0YQ6ZHrHNC3aIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723292; c=relaxed/simple;
	bh=Ifope+2Im9co9jHJe5x0mBqpzIJZIFVHMxDXOMdujEY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jorIfflKHLRjuuQa6I7qOZC95xLQUZvuVkAfjhLyIAyFcvVzXFNe6sShRBHKw7blbZfFhgv7Y2Ffm4ff2FiABGX5kwf+odYQayTmcakpkT48y2ysRlVkTB5SL1DD2EILj7uhxt1ryH83skpT3FBL4aCH+5C/I691+kJ0Vmmje7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=URs6Go4O; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732723246; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nx+mLXSJ4gNuxmshcVOpUQfzuHyu0wTzXaRE8EhfNYqIdmsVAL74Kmkoqg8jY12F4J4osEpsYf3tcf9vvDv8RSEAXyqhOl/25VuhxezPre+ZVvWvbshyu/etwSOpZTFKVXiLQ2m3IOm9WuiW/RycbgBP/aVovsiD87+xdcXr/ak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732723246; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NA81LvCy7ahNhWTPOvNOJ1qqd3S/0kPAzi+HAw+aYHk=; 
	b=gf0wl1184XIjCz8XCFBELaCTnMfMtLezMqutEKBR7OmjRm6cdCRSdu7lSKaLRRVEcvQlJldxoOyM+Mz25tjHjUwdzYp9bOnFvCMl3mGJ1bJ7IB7mVzG3mdeaCna11C0ggnNatkEZxQYmUSGRjAT8HBLT/+hSaku2dgl1P6HSHKA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732723246;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=NA81LvCy7ahNhWTPOvNOJ1qqd3S/0kPAzi+HAw+aYHk=;
	b=URs6Go4OAejB4v6B61P4gA6FRu1Md4rLR3BWPUGb0xSwxijTawgPnM2iyk7tGCsK
	QefMkrX0QDMUvtY3bvd5BXVxYHny/FawY8bv6gnv77Uor5sySQFA9Jy9nLhfPR33iAp
	6wctF8SxM8Nr0dIFc/7yD4kLoNJr/Ms6moF1TZyY=
Received: by mx.zohomail.com with SMTPS id 1732723245585541.8552567167637;
	Wed, 27 Nov 2024 08:00:45 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 14/35] WIP: rust: drm/kms: Add OpaqueCrtc and
 OpaqueCrtcState
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-15-lyude@redhat.com>
Date: Wed, 27 Nov 2024 13:00:30 -0300
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
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39164069-001D-401D-A037-3C43F27373B9@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-15-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude,

> On 30 Sep 2024, at 20:09, Lyude Paul <lyude@redhat.com> wrote:
>=20
> This is the same thing as OpaqueConnector and OpaqueConnectorState, =
but for
> CRTCs now.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
>=20
> TODO:
> * Add upcast functions
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms/crtc.rs | 131 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 131 insertions(+)
>=20
> diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
> index d84db49948380..1a3c9c448afcc 100644
> --- a/rust/kernel/drm/kms/crtc.rs
> +++ b/rust/kernel/drm/kms/crtc.rs
> @@ -234,6 +234,41 @@ pub fn new<'a, 'b: 'a, P, C>(
>         // SAFETY: We don't move anything
>         Ok(unsafe { &*Box::into_raw(Pin::into_inner_unchecked(this)) =
})
>     }
> +
> +    /// Attempt to convert an [`OpaqueCrtc`] into a fully qualified =
[`Crtc`].
> +    ///
> +    /// This checks if the given [`OpaqueCrtc`] uses the same =
[`DriverCrtc`] implementation, and
> +    /// returns the [`OpaqueCrtc`] as a [`Crtc`] object if so.
> +    pub fn try_from_opaque<'a, D>(opaque: &'a OpaqueCrtc<D>) -> =
Option<&'a Self>
> +    where
> +        D: KmsDriver,
> +        T: DriverCrtc<Driver =3D D>
> +    {
> +        // SAFETY: The vtables for a `Crtc` are initialized =
throughout the lifetime of the object
> +        let funcs =3D unsafe { (*opaque.crtc.get()).funcs };
> +
> +        // SAFETY: We only perform this transmutation if the opaque =
CRTC shares our vtable pointers,
> +        // so the underlying `Crtc` must share our data layout.
> +        ptr::eq(funcs, &T::OPS.funcs).then(|| unsafe { =
mem::transmute(opaque) })
> +    }
> +
> +    /// Convert a [`OpaqueCrtc`] into its fully qualified [`Crtc`].
> +    ///
> +    /// This is an infallible version of [`Self::try_from_opaque`]. =
This function is mainly useful
> +    /// for drivers where only a single [`DriverCrtc`] implementation =
exists.

I am confused. If a driver has a single `DriverCrtc`, why would it care =
for `OpaqueCrtc`?

> +    ///
> +    /// # Panics
> +    ///
> +    /// This function will panic if the underlying CRTC in the =
provided [`OpaqueCrtc`] does not
> +    /// belong to the same [`DriverCrtc`] implementation.
> +    pub fn from_opaque<'a, D>(opaque: &'a OpaqueCrtc<D>) -> &'a Self
> +    where
> +        D: KmsDriver,
> +        T: DriverCrtc<Driver =3D D>
> +    {
> +        Self::try_from_opaque(opaque)
> +            .expect("Passed OpaqueCrtc does not share this DriverCrtc =
implementation")
> +    }
> }
>=20
> /// A trait implemented by any type that acts as a [`struct drm_crtc`] =
interface.
> @@ -267,6 +302,66 @@ unsafe fn from_raw<'a>(ptr: *mut =
bindings::drm_crtc) -> &'a Self {
>     }
> }
>=20
> +/// A [`struct drm_crtc`] without a known [`DriverCrtc`] =
implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the =
[`DriverCrtc`] implementation
> +/// for a [`struct drm_crtc`] automatically. It is identical to =
[`Crtc`], except that it does not
> +/// provide access to the driver's private data.
> +///
> +/// It may be upcasted to a full [`Crtc`] using [`Crtc::from_opaque`] =
or
> +/// [`Crtc::try_from_opaque`].
> +///
> +/// # Invariants
> +///
> +/// - `crtc` is initialized for as long as this object is made =
available to users.
> +/// - The data layout of this structure is equivalent to [`struct =
drm_crtc`].

nit: Maybe worth clarifying that it=E2=80=99s equivalent to =
`bindings::drm_crtc`, not directly to
C=E2=80=99s `struct drm_crtc`. Although it should also be equivalent to =
that in practice.

> +///
> +/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
> +#[repr(transparent)]
> +pub struct OpaqueCrtc<T: KmsDriver> {
> +    crtc: Opaque<bindings::drm_crtc>,
> +    _p: PhantomData<T>
> +}
> +
> +impl<T: KmsDriver> Sealed for OpaqueCrtc<T> {}
> +
> +impl<T: KmsDriver> AsRawCrtc for OpaqueCrtc<T> {
> +    type State =3D OpaqueCrtcState<T>;
> +
> +    fn as_raw(&self) -> *mut bindings::drm_crtc {
> +        self.crtc.get()
> +    }
> +
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) -> &'a Self =
{
> +        // SAFETY: Our data layout starts with `bindings::drm_crtc`
> +        unsafe { &*ptr.cast() }
> +    }
> +}
> +
> +impl<T: KmsDriver> ModeObject for OpaqueCrtc<T> {
> +    type Driver =3D T;
> +
> +    fn drm_dev(&self) -> &Device<Self::Driver> {
> +        // SAFETY: The parent device for a DRM connector will never =
outlive the connector, and this
> +        // pointer is invariant through the lifetime of the connector
> +        unsafe { Device::borrow((*self.as_raw()).dev) }
> +    }
> +
> +    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
> +        // SAFETY: We don't expose DRM connectors to users before =
`base` is initialized
> +        unsafe { addr_of_mut!((*self.as_raw()).base) }
> +    }
> +}
> +
> +// SAFETY: CRTCs are non-refcounted modesetting objects
> +unsafe impl<T: KmsDriver> StaticModeObject for OpaqueCrtc<T> {}
> +
> +// SAFETY: Our CRTC interface is guaranteed to be thread-safe
> +unsafe impl<T: KmsDriver> Send for OpaqueCrtc<T> {}
> +
> +// SAFETY: Our CRTC interface is guaranteed to be thread-safe
> +unsafe impl<T: KmsDriver> Sync for OpaqueCrtc<T> {}
> +
> unsafe impl Zeroable for bindings::drm_crtc_state { }
>=20
> impl<T: DriverCrtcState> Sealed for CrtcState<T> {}
> @@ -400,6 +495,42 @@ unsafe fn from_raw<'a>(ptr: *const =
bindings::drm_crtc_state) -> &'a Self {
>     }
> }
>=20
> +/// A [`struct drm_crtc_state`] without a known [`DriverCrtcState`] =
implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the =
[`DriverCrtcState`]
> +/// implementation for a [`struct drm_crtc_state`] automatically. It =
is identical to [`Crtc`],
> +/// except that it does not provide access to the driver's private =
data.
> +///
> +/// TODO: Add upcast functions
> +///
> +/// # Invariants
> +///
> +/// - `state` is initialized for as long as this object is exposed to =
users.
> +/// - The data layout of this type is identical to [`struct =
drm_crtc_state`].
> +///
> +/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
> +#[repr(transparent)]
> +pub struct OpaqueCrtcState<T: KmsDriver> {
> +    state: Opaque<bindings::drm_crtc_state>,
> +    _p: PhantomData<T>
> +}
> +
> +impl<T: KmsDriver> AsRawCrtcState for OpaqueCrtcState<T> {
> +    type Crtc =3D OpaqueCrtc<T>;
> +}
> +
> +impl<T: KmsDriver> private::AsRawCrtcState for OpaqueCrtcState<T> {
> +    fn as_raw(&self) -> *mut bindings::drm_crtc_state {
> +        self.state.get()
> +    }
> +}
> +
> +impl<T: KmsDriver> FromRawCrtcState for OpaqueCrtcState<T> {
> +    unsafe fn from_raw<'a>(ptr: *const bindings::drm_crtc_state) -> =
&'a Self {
> +        // SAFETY: Our data layout is identical to =
`bindings::drm_crtc_state`
> +        unsafe { &*(ptr.cast()) }
> +    }
> +}
> unsafe extern "C" fn crtc_destroy_callback<T: DriverCrtc>(
>     crtc: *mut bindings::drm_crtc
> ) {
> --=20
> 2.46.1
>=20
>=20

=E2=80=94 Daniel=

