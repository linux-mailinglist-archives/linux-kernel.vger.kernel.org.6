Return-Path: <linux-kernel+bounces-530100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C1A42F00
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601411891E09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2021DE89E;
	Mon, 24 Feb 2025 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="F7hu11Ca"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0221DD874;
	Mon, 24 Feb 2025 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432206; cv=pass; b=UVmE4vl6/xz45DfxVfR51xXsZd5Gkdh6Eep4U1qHgOhcTpi2nPdIGcXoC9QuzXnOWfrr2xGfhWZkDC/nE1Z2UfttEhJsISJDTYoWjmQTLWpybOlgontpnCOxvupvE+LEcgaOHeTexk9b53YkbgxgXvdUN1quraKKxEPo54DRfkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432206; c=relaxed/simple;
	bh=CiQCFozHRMC5GSFLhzKvrkJ++OZ4CJ/yKjFd6Kp60Pc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NkwBD3jZRvi4+cpjlitSHezXY8IJielY7bUl9VtBhLTM9enRC5nMzZutpaDKN4DAYlo1SirWcJqXBZXEDDDNleRk1O+KBYQNroatO4h3aYcrR8oY35PPyVFxwynJcU4uZahbqRwC1kob0l9gvlRd1btHtAxwdjTUHH7cLUUA9rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=F7hu11Ca; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740432158; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ktye3AcPnFCS56IwjIoT21xG1YEXmvOV7hbyNP3D1EiFbiuklctz3VthmOL7GUpkECO3vnyJ/9CycbWAtWSUf3UMdXOcJzJcrnNpfoM5yvhaw6PUJiJe33bvFZfSXfONxVxZY/IhZ83kbPR7k5Lw76Y00xgnMwG1WOTA4SdC/ys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740432158; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Jwgy8EHw2ByXiT/plCbjBi2u1K3sOMpK7LJiWKz5MpI=; 
	b=aD7TC7JE5Q/VulEeFl2ZDdxHsZNgzFAv7bV3YuQ+XA62IvmetTyMFKfBqcgCVlQQBeGbzcOHkobUZ9F6jGEG21JffuCnXZPsMu1HjJRZrHTWwHcaPATx2RVj0GKGZKLC39UA43HCuvJJPM+m1mJ1RGP+v70YtA/GwEEIEoSIJo0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740432158;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Jwgy8EHw2ByXiT/plCbjBi2u1K3sOMpK7LJiWKz5MpI=;
	b=F7hu11CaCZwNU2vKsF/EJ0Xc7AATEwfyQxA+EN9PXrf8wQeoa7iSgpmwHQfuFafy
	CVeY0A34N02lXenQ9PKKznXT+a2gnZgCoUUW1bXjXFJ0UBU/xWyuO5oGMTwf31TDUZk
	5v8wVocIVw9MK7kdZ8Tvkfy7gB7NuPE6xoKzhHy0=
Received: by mx.zohomail.com with SMTPS id 1740432155442578.9933183629962;
	Mon, 24 Feb 2025 13:22:35 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v4 1/4] rust: sync: change `<Arc<T> as
 ForeignOwnable>::PointedTo` to `T`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250224-configfs-v4-1-9af9b5e611f6@kernel.org>
Date: Mon, 24 Feb 2025 18:22:16 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Fiona Behrens <me@kloenk.dev>,
 Charalampos Mitrodimas <charmitro@posteo.net>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B462F0CD-60F2-4494-B1DA-B19A54944EAE@collabora.com>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
 <20250224-configfs-v4-1-9af9b5e611f6@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Andreas,

> On 24 Feb 2025, at 10:21, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Using `ArcInner` as `PoinedTo` in the `ForeignOwnable` implementation =
for
> `Arc` is a bit unfortunate. Using `T` as `PointedTo` does not remove =
any
> functionality, but allows `ArcInner` to be private. Further, it allows
> downstream users to write code that is generic over `Box` and `Arc`, =
when
> downstream users need access to `T` after calling `into_foreign`.
>=20
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>=20
> This patch is a dependency for Rust `configfs` abstractions. It allows =
both
> `Box` and `Arc` to be used as pointer types in the `configfs` =
hierarchy.
> ---
> rust/kernel/sync/arc.rs | 21 ++++++++++++++++-----
> 1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index dfe4abf82c25..3d77a31e116f 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -143,7 +143,7 @@ pub struct Arc<T: ?Sized> {
> #[doc(hidden)]
> #[pin_data]
> #[repr(C)]
> -pub struct ArcInner<T: ?Sized> {
> +struct ArcInner<T: ?Sized> {
>     refcount: Opaque<bindings::refcount_t>,
>     data: T,
> }
> @@ -345,18 +345,25 @@ pub fn into_unique_or_drop(self) -> =
Option<Pin<UniqueArc<T>>> {
>=20
> // SAFETY: The `into_foreign` function returns a pointer that is =
well-aligned.
> unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
> -    type PointedTo =3D ArcInner<T>;
> +    type PointedTo =3D T;
>     type Borrowed<'a> =3D ArcBorrow<'a, T>;
>     type BorrowedMut<'a> =3D Self::Borrowed<'a>;
>=20
>     fn into_foreign(self) -> *mut Self::PointedTo {
> -        ManuallyDrop::new(self).ptr.as_ptr()
> +        let this =3D ManuallyDrop::new(self).ptr.as_ptr();
> +        // SAFETY: `x` is a valid pointer to `Self` so the projection =
below is
> +        // in bounds of the allocation.
> +        unsafe { core::ptr::addr_of_mut!((*this).data) }
>     }
>=20
>     unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
> +        // SAFETY: We did the reverse offset calculation in =
`into_foreign`, so
> +        // the offset calculation below is in bounds of the =
allocation.
> +        let inner_ptr =3D unsafe { kernel::container_of!(ptr, =
ArcInner<T>, data).cast_mut() };
> +
>         // SAFETY: The safety requirements of this function ensure =
that `ptr` comes from a previous
>         // call to `Self::into_foreign`.
> -        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
> +        let inner =3D unsafe { NonNull::new_unchecked(inner_ptr) };
>=20
>         // SAFETY: By the safety requirement of this function, we know =
that `ptr` came from
>         // a previous call to `Arc::into_foreign`, which guarantees =
that `ptr` is valid and
> @@ -365,9 +372,13 @@ unsafe fn from_foreign(ptr: *mut Self::PointedTo) =
-> Self {
>     }
>=20
>     unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, =
T> {
> +        // SAFETY: We did the reverse offset calculation in =
`into_foreign`, so
> +        // the offset calculation below is in bounds of the =
allocation.
> +        let inner_ptr =3D unsafe { kernel::container_of!(ptr, =
ArcInner<T>, data).cast_mut() };
> +
>         // SAFETY: The safety requirements of this function ensure =
that `ptr` comes from a previous
>         // call to `Self::into_foreign`.
> -        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
> +        let inner =3D unsafe { NonNull::new_unchecked(inner_ptr) };
>=20
>         // SAFETY: The safety requirements of `from_foreign` ensure =
that the object remains alive
>         // for the lifetime of the returned value.
>=20
> --=20
> 2.47.0
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

