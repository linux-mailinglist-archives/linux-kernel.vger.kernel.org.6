Return-Path: <linux-kernel+bounces-423591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D4E9DAA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B32166795
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F21FF7BE;
	Wed, 27 Nov 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aa+V5kB2"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC591FF7A7;
	Wed, 27 Nov 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718654; cv=pass; b=cul+bRLezV5cw+H2catJhQ92Tsp+Cox0SNgKX6fYiKn7xP+buMpl68d+KFPRAwYVC3W8eFT6O0jD1+zqXn1uyiMHDpYdFg1ZYHeLa32FOUP1Nsv05ORJx9+WwzPlokv3de/X34rY/IZyX3zYCTxQ5c8NfINHUour7PFvh7ZsEsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718654; c=relaxed/simple;
	bh=hNWRyfA0hLuS9z4M0IomGat40IOMJ0NtjlYCGwg2kHE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=limJbh5t9id5ghNlkRaS767b00o8dOG3JOWQfOM0P3gyasLCzQT6OQcTVrUma24pddyO6AYzSuh72HNsMEf7l9RAlRfwuEjYXhS/ymnXDvQAMfP9AOWGCwwHQ2mylDBwFlN561cnsoJQ4KUx8vVHyzty7CeO2gjKiKCSNVj++Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aa+V5kB2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732718613; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NOI6dDP3D2TjL1boOmDGAU+aw0ARWRV9GO8H5F/7MMrWrS7SyaNakYH0kpFBcstUia9aJDkK31p5OI1b6LZCBFxfrvL+JHUuQMZET/rNOGSa3E8/tg4T8jtjgLAhi8P37YUhANfgFNnQ1SxAw8us76Nq2Dfg4FOmUESt7qvie3k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732718613; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oTwTz0AGCDwSgvoHUUyLYZrH4mlX58t6JryU8TBBMTY=; 
	b=YX4h1nFwzjRIFl3ucnw7h9kxVgwaLIMswS5MnShdnXzkQG+RNLQ1QC3e9NsoxXtvmZEm66gllSU1mK4kEEkHGbivFPYNNddOtRpzOglPYA5fxpHL/1rdHl3DJTKe8oxs5i2loFmzc3e/89I0ijmihIvaZi+zhXtKgl7r8q4nyQA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732718613;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=oTwTz0AGCDwSgvoHUUyLYZrH4mlX58t6JryU8TBBMTY=;
	b=aa+V5kB2LKz3uonZgIzaptffnNhXkFYrrjFOXUumxp4/bWbEfYsoDK5RRNXCWUT2
	yW+P8viqvYoU5KK9UA9cdyi4OuL42IgUokcPpeF4b0QMZVOLfwXEHP4vVSd9tTcEI2+
	COrW1Atp5V+erePZPxJfnxmbjd7LCsIdXTzxQJJc=
Received: by mx.zohomail.com with SMTPS id 1732718613236384.9475704770982;
	Wed, 27 Nov 2024 06:43:33 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 09/35] WIP: rust: drm/kms: Add
 Connector.attach_encoder()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-10-lyude@redhat.com>
Date: Wed, 27 Nov 2024 11:43:18 -0300
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
Message-Id: <5C141885-C8D3-4CD9-8919-683D1DFE4AB3@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-10-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude

> On 30 Sep 2024, at 20:09, Lyude Paul <lyude@redhat.com> wrote:
>=20
> This adds a simple binding for completing the last step of creating a =
DRM
> connector - attaching its encoder. This function should only be called
> before the connector is registered, and DRM should enforce this itself =
by
> returning an error if a driver tries to add an encoder to an
> already-registered DRM connector.
>=20
> Note that unlike most of the methods we'll be adding to DRM mode =
objects,
> this is directly implemented on the Connector<T> type since I don't =
really
> think it would make sense for us to allow this operation on an
> OpaqueConnector (a DRM connector without a known DriverConnector
> implementation, something we'll be adding in the next few commits).
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
>=20
> TODO:
> * Figure out a solution for making sure that this can only be called =
when a
>  Connector is unregistered, probably via an UnregisteredConnector =
type.
>=20

Either that, or via the typestate pattern. But I think a =
UnregisteredConnector type
will work fine based on your previous UnregisteredKmsDevice.

> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms/connector.rs | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>=20
> diff --git a/rust/kernel/drm/kms/connector.rs =
b/rust/kernel/drm/kms/connector.rs
> index 0fa927a3743b2..54457b327c365 100644
> --- a/rust/kernel/drm/kms/connector.rs
> +++ b/rust/kernel/drm/kms/connector.rs
> @@ -28,6 +28,7 @@
> use super::{
>     ModeObject,
>     RcModeObject,
> +    encoder::*,
>     KmsDriver,
> };
> use macros::pin_data;
> @@ -227,6 +228,20 @@ pub fn new(
>             =
ARef::from_raw(NonNull::new_unchecked(Box::into_raw(Pin::into_inner_unchec=
ked(new))))
>         })
>     }
> +
> +    /// Attach an encoder to this [`Connector`].
> +    ///
> +    /// TODO: Move this to an `UnregisteredConnector` interface =
somehow=E2=80=A6
> +    #[must_use]
> +    pub fn attach_encoder<E>(&self, encoder: &Encoder<E>) -> Result
> +    where
> +        E: DriverEncoder<Driver =3D T::Driver>
> +    {
> +        // SAFETY: FFI call with no special requirements
> +        to_result(unsafe {
> +            bindings::drm_connector_attach_encoder(self.as_raw(), =
encoder.as_raw())
> +        })
> +    }
> }
>=20
> /// A trait implemented by any type that acts as a [`struct =
drm_connector`] interface.
> --=20
> 2.46.1
>=20
>=20

LGTM.

=E2=80=94 Daniel


