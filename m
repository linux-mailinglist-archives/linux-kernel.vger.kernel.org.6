Return-Path: <linux-kernel+bounces-424808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 995FF9DB9B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004A0B21404
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A854B1B5EA4;
	Thu, 28 Nov 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="a7cj+0+W"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0D1B0F3C;
	Thu, 28 Nov 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804470; cv=pass; b=ga7GXwe5Pwpxa8bz+C9wAV3LYFdg4AlwtjoDj8w3La+KOe82ebNKpd1SkYkk1HJDyEHdw5woAx59PC034jxYNGdS7+iY7vCp5SYs2XccpK14SpwnWasO+y2NFbUJLK1BuwgKkh2/otT/qZsX+Ff9YwHhWnZ0BHeGHMRzhCwh4NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804470; c=relaxed/simple;
	bh=nhIoa0b9nOMp4PCi1DLvOHNg1t5h2+S+JfbWmH1y+EM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V2l6moBpOxLYiKKHBvYJ6DINdFwF1j8FW7U3M1jjlmUwuQF5zRWF3R2eg9qP42lIcqeUdaZvC/A/HmJj3Ypl9WqS2H2mQNjzmqLWdT6iQxAGPtfwn5gwUg85tipQFzgVV7xsIIDvnRGdDC5J538u2XlNX+yiAUzGr1sET5MV3DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=a7cj+0+W; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732804438; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n5zvhwXRFbPLgoqjTPqGkpL+Fo8/NX4LCsDdsZUiYwYuc3D3P/ZkCiquGV0ZWyVcoJH11YkVrqc+oyuR6elogJfvQ8WtHHEqO0al6rNWwyf0xjdQ/rX+YesemvIKrvy+TvwGTwyByD4jzS/+bLhMCiNS1R/UQRPgtjXMtjA3jw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732804438; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=44SMHeiwbAU0RhAWjfrGdl6/M/LOoFEkF0tpMs/mgBg=; 
	b=jlQSaO+hBk1PXhkX3s2Fg4YWHA0KmRCdR3A+6dzVuncObvQMzDMopKGdIJdpPuu3b8QS1xnbnB3FPU2KJaxMgi9RhANg9JsOwg3Y5XXQxcldT0PIGTi48dI1JfczBahG204VALFTA7FJgY7vqkMBEFKr/z2SETH+rn+booTjpa4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732804438;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=44SMHeiwbAU0RhAWjfrGdl6/M/LOoFEkF0tpMs/mgBg=;
	b=a7cj+0+Wo3lFMfwGTzBW0HkLgJyrq/KTBA7gw3vu4eJQjfLut4v7K1S8oLVQ2pwR
	1P4tXPobKD0/lnIpXyd8Pgbtr8CbLzg3luJBuQnUhHmF4ldRU0I9xQqliSH62IY/eqh
	nCBw+NTqzn74zt485AMiYWk18FBC/dNShF1kTS/M=
Received: by mx.zohomail.com with SMTPS id 1732804436476628.0829886646173;
	Thu, 28 Nov 2024 06:33:56 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 30/35] rust: drm/kms: Add DriverCrtc::atomic_enable()
 and atomic_disable()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-31-lyude@redhat.com>
Date: Thu, 28 Nov 2024 11:33:41 -0300
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
Message-Id: <522F0A49-6A38-40F3-B287-632D1F238223@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-31-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude

> On 30 Sep 2024, at 20:10, Lyude Paul <lyude@redhat.com> wrote:
>=20
> Optional trait methods for implementing the atomic_enable and
> atomic_disable callbacks of a CRTC.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms/crtc.rs | 76 ++++++++++++++++++++++++++++++++++++-
> 1 file changed, 74 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
> index a4e955364bd8c..ef1b331f742d0 100644
> --- a/rust/kernel/drm/kms/crtc.rs
> +++ b/rust/kernel/drm/kms/crtc.rs
> @@ -80,8 +80,8 @@ pub trait DriverCrtc: Send + Sync + Sized {
>         },
>=20
>         helper_funcs: bindings::drm_crtc_helper_funcs {
> -            atomic_disable: None,
> -            atomic_enable: None,
> +            atomic_disable: if Self::HAS_ATOMIC_DISABLE { =
Some(atomic_disable_callback::<Self>) } else { None },
> +            atomic_enable: if Self::HAS_ATOMIC_ENABLE { =
Some(atomic_enable_callback::<Self>) } else { None },
>             atomic_check: if Self::HAS_ATOMIC_CHECK { =
Some(atomic_check_callback::<Self>) } else { None },
>             dpms: None,
>             commit: None,
> @@ -162,6 +162,34 @@ fn atomic_flush(
>     ) {
>         build_error::build_error("This should never be reachable")
>     }
> +
> +    /// The optional [`drm_crtc_helper_funcs.atomic_enable`] hook.
> +    ///
> +    /// This hook will be called before enabling a [`Crtc`] in an =
atomic commit.
> +    ///
> +    /// [`drm_crtc_helper_funcs.atomic_enable`]: =
srctree/include/drm/drm_modeset_helper_vtables.h
> +    fn atomic_enable(
> +        crtc: &Crtc<Self>,
> +        old_state: &CrtcState<Self::State>,
> +        new_state: BorrowedCrtcState<'_, CrtcState<Self::State>>,
> +        state: &AtomicStateMutator<Self::Driver>
> +    ) {
> +        build_error::build_error("This should never be reachable")
> +    }
> +
> +    /// The optional [`drm_crtc_helper_funcs.atomic_disable`] hook.
> +    ///
> +    /// This hook will be called before disabling a [`Crtc`] in an =
atomic commit.
> +    ///
> +    /// [`drm_crtc_helper_funcs.atomic_disable`]: =
srctree/include/drm/drm_modeset_helper_vtables.h
> +    fn atomic_disable(
> +        crtc: &Crtc<Self>,
> +        old_state: &CrtcState<Self::State>,
> +        new_state: BorrowedCrtcState<'_, CrtcState<Self::State>>,
> +        state: &AtomicStateMutator<Self::Driver>
> +    ) {
> +        build_error::build_error("This should never be reachable")
> +    }
> }

Same comment here as in previous patches.

>=20
> /// The generated C vtable for a [`DriverCrtc`].
> @@ -850,3 +878,47 @@ fn as_raw(&self) -> *mut bindings::drm_crtc_state =
{
>=20
>     T::atomic_flush(crtc, old_state, new_state, &state);
> }
> +
> +unsafe extern "C" fn atomic_enable_callback<T: DriverCrtc>(
> +    crtc: *mut bindings::drm_crtc,
> +    state: *mut bindings::drm_atomic_state,
> +) {
> +    // SAFETY:
> +    // * We're guaranteed `crtc` is of type `Crtc<T>` via type =
invariants.
> +    // * We're guaranteed by DRM that `crtc` is pointing to a valid =
initialized state.
> +    let crtc =3D unsafe { Crtc::from_raw(crtc) };
> +
> +    // SAFETY: DRM never passes an invalid ptr for `state`
> +    let state =3D unsafe { =
AtomicStateMutator::new(NonNull::new_unchecked(state)) };
> +
> +    // SAFETY: We're in an atomic enable callback, so we know that =
both the new and old state are
> +    // present
> +    let (old_state, new_state) =3D unsafe {(
> +        state.get_old_crtc_state(crtc).unwrap_unchecked(),
> +        state.get_new_crtc_state(crtc).unwrap_unchecked(),
> +    )};
> +
> +    T::atomic_enable(crtc, old_state, new_state, &state);
> +}
> +
> +unsafe extern "C" fn atomic_disable_callback<T: DriverCrtc>(
> +    crtc: *mut bindings::drm_crtc,
> +    state: *mut bindings::drm_atomic_state,
> +) {
> +    // SAFETY:
> +    // * We're guaranteed `crtc` points to a valid instance of =
`drm_crtc`
> +    // * We're guaranteed that `crtc` is of type `Plane<T>` by =
`DriverPlane`s type invariants.
> +    let crtc =3D unsafe { Crtc::from_raw(crtc) };
> +
> +    // SAFETY: We're guaranteed that `state` points to a valid =
`drm_crtc_state` by DRM
> +    let state =3D unsafe { =
AtomicStateMutator::new(NonNull::new_unchecked(state)) };
> +
> +    // SAFETY: We're in an atomic commit callback, so we know that =
both the new and old state are
> +    // present
> +    let (old_state, new_state) =3D unsafe {(
> +        state.get_old_crtc_state(crtc).unwrap_unchecked(),
> +        state.get_new_crtc_state(crtc).unwrap_unchecked(),
> +    )};
> +
> +    T::atomic_disable(crtc, old_state, new_state, &state);
> +}
> --=20
> 2.46.1
>=20
>=20

FYI, they all look good to me. It=E2=80=99s just a matter of figuring =
out this build_error pattern and whether it=E2=80=99s
really needed.

=E2=80=94 Daniel


