Return-Path: <linux-kernel+bounces-424762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ADC9DB90F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60059282017
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84D1A9B59;
	Thu, 28 Nov 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZLNeeI2u"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806591E4B2;
	Thu, 28 Nov 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801815; cv=pass; b=MZQ9+3cupPGFF3vE8wJwgZ0P8Kv3mCt2eE/RO3SQZVE/o1eIsTxy9cPgdQiagxrVrBKZHwgMPZd6O/w+YkCLjzd6c0HVQjDF3b3ocXm8+gyZRH9IYMmnA3AVo/NgB0SARsQxsoxNmEgl30Pz7nFm0pIwA++Ovz4el3N/ySyivpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801815; c=relaxed/simple;
	bh=KWmZq8cFkSeV/awc2Ryi7z2GZ+yhv3+OqGec2bAmJn0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kVAH8FI0Xgn8roJFkrRuFI0TQ5wh+KmTt5aMf9uhc85Y27vOZGPypCwKSAWmsC8H95k32jjX+Rd3Hj3WdEoDJnYdl6MA1fA4qNG8RZf7xYBeAN4R3fZT6oWvHLXjoCPJ8Fn5efnN9oKguYrVRJfY9ZM3D3ZgSR6mT74dkMUZo7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZLNeeI2u; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732801777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E9Y0zhgcPvtu5RGK7bsqqY9jEZw6Z8DBNya8WjXsHruIjxrTZglwLSzy6F9zToc4zdNp/cC5AugeWgMg91j1HcS37GnWOMABV2BANwrakjtyyEo1qUNUcOboyVRvKKl9kASFg+u3ON0M0tavOUXeBgwprXsUE2tQzwqKCoeN1N8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732801777; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3DkiWP3kR0ePPXt7DZna7mWR/xlNXx0EHhC2aTvPrmY=; 
	b=nOTvWmNcuxe6fzYhPOk2by6HnDBBOHxIBBuAoDWcgnpbdy+Wq9FDdzCvS0Ohl+J3CAkTntvMxeiMK2AJG3JAQku8K/Zo2JgoMmbd6g0e2uLvv5JwMm7fgPVil6XhoX5TC6PHL3/LYIz5xmQ405subHFiyKqPgZ8Igh5yK0fp56k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732801777;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=3DkiWP3kR0ePPXt7DZna7mWR/xlNXx0EHhC2aTvPrmY=;
	b=ZLNeeI2uY9UtKdQBwLIAOa5hJ69VqRdu7wM+MsMII9Ya56Aa02zX5mU2+WpOUGy2
	7Tc4GyvXp9fNEzx7TixHmzLpPreTKnQstq/71FjWeQzNvZNeG8Rfeo6UGkv15g87n2z
	PCu13dm2f92nenKtqFc1FUcLnuXlZtZKnrOezm40=
Received: by mx.zohomail.com with SMTPS id 173280177603854.46413577602539;
	Thu, 28 Nov 2024 05:49:36 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 23/35] rust: drm/kms: Add DriverPlane::atomic_check()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-24-lyude@redhat.com>
Date: Thu, 28 Nov 2024 10:49:21 -0300
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
Message-Id: <B531D8E8-056C-4081-9741-373EE835B0F4@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-24-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude,

> On 30 Sep 2024, at 20:10, Lyude Paul <lyude@redhat.com> wrote:
>=20
> Optional trait method for implementing a plane's atomic_check().
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms/plane.rs | 41 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/drm/kms/plane.rs =
b/rust/kernel/drm/kms/plane.rs
> index 506ed5ced1270..04f1bdfbb1ea2 100644
> --- a/rust/kernel/drm/kms/plane.rs
> +++ b/rust/kernel/drm/kms/plane.rs
> @@ -74,7 +74,7 @@ pub trait DriverPlane: Send + Sync + Sized {
>             cleanup_fb: None,
>             begin_fb_access: None, // TODO: someday?
>             end_fb_access: None, // TODO: someday?
> -            atomic_check: None,
> +            atomic_check: if Self::HAS_ATOMIC_CHECK { =
Some(atomic_check_callback::<Self>) } else { None },
>             atomic_update: if Self::HAS_ATOMIC_UPDATE { =
Some(atomic_update_callback::<Self>) } else { None },
>             atomic_enable: None, // TODO
>             atomic_disable: None, // TODO
> @@ -118,6 +118,21 @@ fn atomic_update(
>     ) {
>         build_error::build_error("This should not be reachable")
>     }
> +
> +    /// The optional [`drm_plane_helper_funcs.atomic_check`] hook for =
this plane.
> +    ///
> +    /// Drivers may use this to customize the atomic check phase of =
their [`Plane`] objects. The
> +    /// result of this function determines whether the atomic check =
passed or failed.
> +    ///
> +    /// [`drm_plane_helper_funcs.atomic_check`]: =
srctree/include/drm/drm_modeset_helper_vtables.h
> +    fn atomic_check(
> +        plane: &Plane<Self>,
> +        new_state: BorrowedPlaneState<'_, PlaneState<Self::State>>,
> +        old_state: &PlaneState<Self::State>,
> +        state: &AtomicStateComposer<Self::Driver>
> +    ) -> Result {
> +        build_error::build_error("This should not be reachable")
> +    }

Also same comment from the last two patches apply here.

> }
>=20
> /// The generated C vtable for a [`DriverPlane`].
> @@ -794,3 +809,27 @@ fn deref_mut(&mut self) -> &mut Self::Target {
>=20
>     T::atomic_update(plane, new_state, old_state, &state);
> }
> +
> +unsafe extern "C" fn atomic_check_callback<T: DriverPlane>(
> +    plane: *mut bindings::drm_plane,
> +    state: *mut bindings::drm_atomic_state,
> +) -> i32 {
> +    // SAFETY:
> +    // * We're guaranteed `plane` is of type `Plane<T>` via type =
invariants.
> +    // * We're guaranteed by DRM that `plane` is pointing to a valid =
initialized state.
> +    let plane =3D unsafe { Plane::from_raw(plane) };
> +
> +    // SAFETY: We're guaranteed by DRM that `state` points to a valid =
instance of `drm_atomic_state`
> +    let state =3D ManuallyDrop::new(unsafe {
> +        =
AtomicStateComposer::<T::Driver>::new(NonNull::new_unchecked(state))
> +    });

By the way, let me see if I get the bigger picture here: drivers get a =
composer, from which they can derive a mutator
(i.e. BorrowedPlaneState, BorrowedCrtcState, BorrowedConnectorState) =
that they can use to optionally mutate the
modes before atomic_update, right?

Where do the Opaque versions introduced in previous commits come in?=20

> +
> +    // SAFETY: We're guaranteed by DRM that both the old and new =
atomic state are present within
> +    // this `drm_atomic_state`
> +    let (old_state, new_state) =3D unsafe {(
> +        state.get_old_plane_state(plane).unwrap_unchecked(),
> +        state.get_new_plane_state(plane).unwrap_unchecked(),
> +    )};
> +
> +    from_result(|| T::atomic_check(plane, new_state, old_state, =
&state).map(|_| 0))
> +}
> --=20
> 2.46.1
>=20
>=20


=E2=80=94 Daniel=

