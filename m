Return-Path: <linux-kernel+bounces-423885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D99DADDD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AF0284BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7878202F6B;
	Wed, 27 Nov 2024 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZnkUFkVW"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695F13D89D;
	Wed, 27 Nov 2024 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735900; cv=pass; b=HJHiMPJtVtXlc2bPdHLIMEsDkDROceA1dL6rmiSF3YbYTOVEjjdVKgCiNeqv+ZmhVf7SxTAT/vwnc40Vgvr34U1rb6WJXHpkSiHgMDdEJVhz2KmzStDP93WJ6T82ggOnF9n5XAMMkX+v6KDRl4X5ZCfeeTG21dHtHPqnQSjypvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735900; c=relaxed/simple;
	bh=Dv2qljR+WQMx1v46rWerpe+tYNyL/J2PUmxNUjH5/o0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=liJr9FOiA8mYco2wYHmc2ae0va6ucbenidIvlUaXmBa34rI2GRppb8hTXf5Jo3pWEt1dqS7xxCdJOTr0DnK1hr05njQLPwZ62Vci/mg1iQjJcds2kDE1qHjcP78i+GDoBaU5owxidH4CNz9fOAjUyfO1YUiQl8h/D+NXj6OXViI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZnkUFkVW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732735865; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HlSAK+vbChOESf6CajiRJQzPO42oC6fQF8pUfas81XKOr+xR5fLMG/omzasec3da//DwPZUJYv+29U4qBpY8kwxtsMEfkAuk85rHfDI0//3ZrpMqc5503elUf7bQYhVYwByYq+Er1CgVBYLoHOXNSGfCeENutMAmzh29h2akmHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732735865; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=puooQMdPcEt9xW6FRzJ4TgjZrgpqYcoxpKKozms2RUw=; 
	b=W0zxjR6y+Y4Vmge8IC2KrZCujeb8ZOPcJJ9NtvX87PZjjuX6xGvwzQkgnzlmJ5tfmH67qXOYcBokRwwLdybYXj8gwXbjkVLWqCw4IeJHtCd4F4ItE05xne2KaECZdX0dL7rqb8mu7MeZj2nU4dtwtbHaDxHLw9N5q1GKtuYDXDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732735865;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=puooQMdPcEt9xW6FRzJ4TgjZrgpqYcoxpKKozms2RUw=;
	b=ZnkUFkVWDHoRYWqTDiEHh//Sa20UD/qIMEaKaqlGh7/j1VeCrmV6f5CzQbIkUoC9
	xs+RzZbz3vLfIPThxdyZUG3oXdYogWXrA75WzEeMS6kccRYw2kxDa8mBNR5Zf0r5AI3
	TpcWC6SImF93XY766EB8npTueOhymHNdRkG3nnDE=
Received: by mx.zohomail.com with SMTPS id 1732735864391797.9845788869264;
	Wed, 27 Nov 2024 11:31:04 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 18/35] rust: drm/kms: Add RawPlane and RawPlaneState
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-19-lyude@redhat.com>
Date: Wed, 27 Nov 2024 16:30:49 -0300
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
Message-Id: <FC63978F-BAC0-4294-999E-9BA31FA39490@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-19-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude

> On 30 Sep 2024, at 20:10, Lyude Paul <lyude@redhat.com> wrote:
>=20
> Same thing as RawCrtc and RawCrtcState, but for DRM planes now
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms/plane.rs | 35 +++++++++++++++++++++++++++++++++++
> 1 file changed, 35 insertions(+)
>=20
> diff --git a/rust/kernel/drm/kms/plane.rs =
b/rust/kernel/drm/kms/plane.rs
> index 3ace487316d46..1c151ae3b3dcc 100644
> --- a/rust/kernel/drm/kms/plane.rs
> +++ b/rust/kernel/drm/kms/plane.rs
> @@ -312,6 +312,27 @@ unsafe impl<T: DriverPlane> Send for Plane<T> {}
> // SAFETY: Our interface is thread-safe.
> unsafe impl<T: DriverPlane> Sync for Plane<T> {}
>=20
> +/// Common methods available on any type which implements =
[`AsRawPlane`].
> +///
> +/// This is implemented internally by DRM, and provides many of the =
basic methods for working with
> +/// planes.
> +pub trait RawPlane: AsRawPlane {
> +    /// Return the index of this DRM plane
> +    #[inline]
> +    fn index(&self) -> u32 {
> +        // SAFETY: The index is initialized by the time we expose =
`Plane` objects to users, and is
> +        // invariant throughout the lifetime of the `Plane`
> +        unsafe { (*self.as_raw()).index }
> +    }
> +
> +    /// Return the index of this DRM plane in the form of a bitmask
> +    #[inline]
> +    fn mask(&self) -> u32 {
> +        1 << self.index()
> +    }
> +}
> +impl<T: AsRawPlane> RawPlane for T {}
> +
> /// A [`struct drm_plane`] without a known [`DriverPlane`] =
implementation.
> ///
> /// This is mainly for situations where our bindings can't infer the =
[`DriverPlane`] implementation
> @@ -426,6 +447,20 @@ pub trait FromRawPlaneState: AsRawPlaneState {
>     unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_plane_state) -> =
&'a mut Self;
> }
>=20
> +/// Common methods available on any type which implements =
[`AsRawPlane`].
> +///
> +/// This is implemented internally by DRM, and provides many of the =
basic methods for working with
> +/// the atomic state of [`Plane`]s.
> +pub trait RawPlaneState: AsRawPlaneState {
> +    /// Return the plane that this plane state belongs to.
> +    fn plane(&self) -> &Self::Plane {
> +        // SAFETY: The index is initialized by the time we expose =
Plane objects to users, and is
> +        // invariant throughout the lifetime of the Plane
> +        unsafe { Self::Plane::from_raw(self.as_raw().plane) }
> +    }
> +}
> +impl<T: AsRawPlaneState + ?Sized> RawPlaneState for T {}
> +
> /// The main interface for a [`struct drm_plane_state`].
> ///
> /// This type is the main interface for dealing with the atomic state =
of DRM planes. In addition, it
> --=20
> 2.46.1
>=20

LGTM

=E2=80=94 Daniel


