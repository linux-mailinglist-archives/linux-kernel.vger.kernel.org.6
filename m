Return-Path: <linux-kernel+bounces-547100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE4A50309
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68249188A5AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A524EF73;
	Wed,  5 Mar 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="RE7qFyrB"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F81924E4B5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186586; cv=none; b=BkZ2J9npYhnVcxAHJ88x0gfOnXM8MLs2IyXmIOKiVjWnGnkWR4Ml9twv6Mr2gkX/OxiSv6mnr/F0pv3NcuNLOX6lXiEzTaXu8LTFhJvA+/ZeqIge5ILlxJGKYId/fk1xq9p4J+R2XDL/fnyvHeP4+rF2myyAzO4pvz4xg/w60UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186586; c=relaxed/simple;
	bh=eCzs6z/1ZaCc9kZkxUuGSc2H1XvV4MIOgYBJbjL04NU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpEGoAeJXlkitALd4xwl32Y/v7FML1MdRJmv/rlvSd5Lt3oVCiK/wA8Sfi3+utRT8N66ypQ3P/yoS+XLSUiwSh/hHfZcQ5d/m9PMrHY2EAJo4UPn2vT51lNG78sNlrfXGPKhXCTlsUrVbthUVdxlko4O4QuCsmFqHk9zUGJrVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=RE7qFyrB; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741186582; x=1741445782;
	bh=lNsOywLr42ifpKIYbHm0FRmw4MVYLujGcEk8RLbJlYg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RE7qFyrBqjco0UkDuwTf/31sqOEGMwi5fVniTj5VVCpoHVPGUuV1Ow7XlTo0HsFRz
	 9YSb1M1Cu9NrdEwikTjKKQ+cWX1KxRF4i963UxwecIr3jQooJ/Eh0ELVmVqouqtnZP
	 1n37eVbq9KLCkaKhYCmZwp84m4DBS7sve7KqlCfebxUbf/ZXOFgvi1jb50iVTiK6ol
	 tQjOGBdB3eHUtO0iWY4URiOBMMXgkEUgNUpGgiS1Z4vma6QUv2noSoIJJee6JWJQ0z
	 kdgw9U7aV+PCBGtNtFLt9wBS9UA8MIjlFzvGLzfEuy6qTRRCTOQS3IrLleBBt40+Wd
	 I4XYbwlUy61aw==
Date: Wed, 05 Mar 2025 14:56:15 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8hmCkeZGPwc5MuU@mango>
In-Reply-To: <Z8hUIPtE_9P60fAf@google.com>
References: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me> <Z8hUIPtE_9P60fAf@google.com>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 375abdb427c4e02d70ff4548d076416d6c4e46a7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alice,

On 250305 1339, Alice Ryhl wrote:
> On Wed, Mar 05, 2025 at 11:31:44AM +0000, Oliver Mangold wrote:
>=20
> > +impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
> > +    type Target =3D T;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY: The type invariants guarantee that the object is va=
lid.
> > +        unsafe { self.ptr.as_ref() }
> > +    }
> > +}
>=20
> What stops people from doing this?
>=20
> let my_unique: UniqueRef<T> =3D ...;
> let my_ref: &T =3D &*my_unique;
> let my_shared: ARef<T> =3D ARef::from(my_ref);
>=20
> Now it is no longer unique.
>
Oh, indeed. That's a serious problem. I see 2 options to deal with that:

1. remove ARef::From<&T>

I checked the users of this, and it looks to me like there is rather
a limited number and they are easy to fix by replacing the &T with ARef<T>.
But I assume that wouldn't be welcome as it is intrusive nonetheless
and of course there is ergonomic value in having the function around.

2. add some new traits so implementers can opt in/out of that function.

Basically one would have to pick if one wants to ARef::From<&T> or
UniqueRef<T> for one's type.

> > +impl<T: UniqueRefCounted> DerefMut for UniqueRef<T> {
> > +    fn deref_mut(&mut self) -> &mut Self::Target {
> > +        // SAFETY: The type invariants guarantee that the object is va=
lid.
> > +        unsafe { self.ptr.as_mut() }
> > +    }
> > +}
>=20
> This DerefMut will make it almost impossible for C types to implement
> UniqueRefCounted because it is incompatible with pinning. You probably
> want `T: UniqueRefCounted + Unpin` here.
>=20
> For `T: !Unpin` (i.e. almost all C types), you can at most produce an
> `Pin<&mut Self>`.

I think I only understand 70% of that incompatiblity, but I will do a
bit more reading.

In any case I think I can work around that, but doing as you say,
and maybe adding an extra method deref_pin() to get a pinned reference.

Best,

Oliver


