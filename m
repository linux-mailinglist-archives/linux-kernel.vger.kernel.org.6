Return-Path: <linux-kernel+bounces-424810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFFB9DB9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BDD281D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B41B0F28;
	Thu, 28 Nov 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Up6Zhs3/"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8F1E4BE;
	Thu, 28 Nov 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804735; cv=pass; b=PXtw/fi6hJhQQb4EK2OTmQJMGcU5bc9MNR7snNE7J471+OL/m/Efh16+EY72CcmjmZeydKUZojNZtgH0EX8DSK6/hSRWvWAV8d7WougGR61orzRpXrPmHjp5lgygKowWLZcaL5zRWoMDcZ3s//nAe8LlCufVkauhusS+kCuCP48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804735; c=relaxed/simple;
	bh=QiaFVH1levNKOMqYR7A/bBI1iztQ838KjddsXaS78HY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TtL2W9h9XA17Hws6xWmAqKbYTS2XasBFC+BSeLfcBwDyufnooxjlcynhlaaT0dVL9I+I78Dzumr6YeRR1TinrRqX7ss9rTGN0WQNfo7c1aYTknskp+19P9TcsaOMMqXiv5rkKZZ/M0vG2IJqypz2NN5bsurrYe1niQfLVyCHgVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Up6Zhs3/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732804701; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PNPm6J4ROq9whukacgT7+9UT2exuDRFBUTcQkLm7GJ4yeUqrRHpbjV4+I6eV2E924aEgFseVc6N6IeJLeaSPjydarQOrowqgNzYXLzGkSe+L+0KEhvhvNXxbpzkmPuXWsFFmdMxoWCaNltmheBFQKKQsiXp1kI/MppzkyQ0IcRM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732804701; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7ACJWAR3/hzu38sSyjvRPp2pAnrZOrJ+JEePA2xeb4c=; 
	b=kFZPTkFXVkd93J6LIcIYgVoRM6UYjLOo29RcqLTZH8NsnFzxi2RN5En32A8YYJQOsZfkCzkW/4w7oPQaZwKPFVYpQs/QSVXOB2odqM1DEsktmyn0KAdlGz3k3yyLPxEstXUUbP325oMQDqvk8sWCEOWT/64SXHbJc9ukRBr6hxg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732804701;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=7ACJWAR3/hzu38sSyjvRPp2pAnrZOrJ+JEePA2xeb4c=;
	b=Up6Zhs3/ZPqRJIckmu+9npxCARpLaVSRIGh6Vl5JxZSOsqMU21PSQDA63C8Q2xx+
	NJ6jt3i4LbXyYX6zjeMarIdHNwrjgYmY5il4qG9pPW9eLhxbjwFMMuZnLikTjEhe0ww
	3pocZjd7Jt2eSDlMzJUAaPpCPyjPSJkVxcuCP4aY=
Received: by mx.zohomail.com with SMTPS id 1732804698833742.5114955144861;
	Thu, 28 Nov 2024 06:38:18 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 32/35] rust: drm/kms: Add Device::num_crtcs()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-33-lyude@redhat.com>
Date: Thu, 28 Nov 2024 11:38:04 -0300
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
Message-Id: <E62F0077-DC6C-4D5E-941B-8C1130AFFB4B@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-33-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude,

> On 30 Sep 2024, at 20:10, Lyude Paul <lyude@redhat.com> wrote:
>=20
> A binding for checking drm_device.num_crtcs. We'll need this in a =
moment
> for vblank support, since setting it up requires knowing the number of
> CRTCs that a driver has initialized.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms.rs | 25 +++++++++++++++++++++----
> 1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
> index 3edd90bc0025a..d0745b44ba9b6 100644
> --- a/rust/kernel/drm/kms.rs
> +++ b/rust/kernel/drm/kms.rs
> @@ -253,10 +253,27 @@ pub fn mode_config_lock(&self) -> =
ModeConfigGuard<'_, T> {
>=20
>     /// Return the number of registered [`Plane`](plane::Plane) =
objects on this [`Device`].
>     #[inline]
> -    pub fn num_plane(&self) -> i32 {
> -        // SAFETY: The only context which this could change is before =
registration, which must be
> -        // single-threaded anyway - so it's safe to just read this =
value
> -        unsafe { (*self.as_raw()).mode_config.num_total_plane }
> +    pub fn num_plane(&self) -> u32 {
> +        // SAFETY:
> +        // * This can only be modified during the single-threaded =
context before registration, so
> +        //   this is safe
> +        // * num_total_plane could be >=3D 0, but no less - so =
casting to u32 is fine (and better to
> +        //   prevent errors)
> +        unsafe { (*self.as_raw()).mode_config.num_total_plane as u32 =
}
> +    }

Shouldn=E2=80=99t this be introduced by the patch that introduced =
`num_plane()` directly?

> +
> +    /// Return the number of registered CRTCs
> +    /// TODO: while `num_crtc` is of i32, that type actually makes =
literally no sense here and just
> +    /// causes problems and unecessary casts. Same for num_plane(). =
So, fix that at some point (we
> +    /// will never get n < 0 anyway)
> +    #[inline]
> +    pub fn num_crtcs(&self) -> u32 {
> +        // SAFETY:
> +        // * This can only be modified during the single-threaded =
context before registration, so
> +        //   this is safe
> +        // * num_crtc could be >=3D 0, but no less - so casting to =
u32 is fine (and better to prevent
> +        //   errors)
> +        unsafe { (*self.as_raw()).mode_config.num_crtc as u32 }
>     }
> }
>=20
> --=20
> 2.46.1
>=20
>=20

Barring the comment above, it overall LGTM.

=E2=80=94 Daniel


