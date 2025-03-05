Return-Path: <linux-kernel+bounces-547216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FF1A50456
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872DB16FEA8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88D1419A9;
	Wed,  5 Mar 2025 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="R2KFyiqY"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD6567D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191334; cv=none; b=rpTKANaj7U7sX8ma0TYDUixkM1Jm1j3Vm6+6bV4RN0I6vDXp1Lk6ved9rHu6zNLzoy5c3CeGGGFMh4wRvqaPwl6oA9mpe/JzgdXvu0+WRe58qyJisCRQ81Y4pyPhyuK5ogCM/Ptz0HDDOtdrMcOnCpv3h/HoWIbsQVXB+zAwbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191334; c=relaxed/simple;
	bh=IdZ3nf7VAZ660GL9R/aTibYxlcwVB9z84VmLqX3uZ8Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkOk0vTPa1LqoCYjTWfLk21KJyiNLJT1ToxPrXsRN/vTIGsMwNplFltx8/pQnBdnN3Rc6Z2qHqJxAvuUhK6zh8dUFXZaaM13b9eFBxeIH+pNCpX+hMYmJHM630Q4rb9OvC1JRjCpTKGHmyX+Sul0NOs+xoADslLOglbAKDLhUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=R2KFyiqY; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741191329; x=1741450529;
	bh=IdZ3nf7VAZ660GL9R/aTibYxlcwVB9z84VmLqX3uZ8Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=R2KFyiqY6ILC7LUVMFzJFULQ628oVdFGBUO20rzGIbq1H/sxUKdM5Kl2NaTW9ZNEX
	 m0Qv0tlvqBG3yTQoRQUgahPHsQYtxiP/XKUR7x/Mwdk1TXf04mmruze1UBLAt1hvfy
	 VkscpVZrWGMpF0OPa39ka/HmkKHi0gjz0NWLW+rXYow8wzl9G2fNs1A+Gbt9LZ0WVr
	 g0DbxBnztWRFz+5jlGKMBEh+fQgs3+lSzj1qq5WdiXdFP+2W917jvk+JXUCtxzxdO1
	 Mo/Z9wiUlhKmt721SuLWGOwoMX0LYwANvFpqQYhQFPkOfPnKSj0RpvvApRzK0peNPx
	 fR+II4Wka2YEg==
Date: Wed, 05 Mar 2025 16:15:24 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8h4mO_deAi_V3mf@laptop>
In-Reply-To: <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
References: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me> <Z8hUIPtE_9P60fAf@google.com> <Z8hmCkeZGPwc5MuU@mango> <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 8e5a2126ce62b3025aa6befed3ce0e4e2d6cc60d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250305 1613, Alice Ryhl wrote:
> On Wed, Mar 5, 2025 at 3:56=E2=80=AFPM Oliver Mangold <oliver.mangold@pm.=
me> wrote:
> > >
> > > What stops people from doing this?
> > >
> > > let my_unique: UniqueRef<T> =3D ...;
> > > let my_ref: &T =3D &*my_unique;
> > > let my_shared: ARef<T> =3D ARef::from(my_ref);
> > >
> > > Now it is no longer unique.
> > >
> > Oh, indeed. That's a serious problem. I see 2 options to deal with that=
:
> >
> > 1. remove ARef::From<&T>
> >
> > I checked the users of this, and it looks to me like there is rather
> > a limited number and they are easy to fix by replacing the &T with ARef=
<T>.
> > But I assume that wouldn't be welcome as it is intrusive nonetheless
> > and of course there is ergonomic value in having the function around.
>=20
> Definitely not an option. There are many users of this function that
> are in the process of being upstreamed. The ability to go &T ->
> ARef<T> is pretty fundamental for ARef.

Ok. Suspected something like that.
>=20
> I do think that you essentially need two structs to use this at all -
> one for the shared and one for the unique case. Sounds pretty
> unergonomic.
>
Sorry, but can you explain? Why does one need structs?

> What is the use-case for these abstractions?
>
It came up in the block subsystem. For mq::Request it is rather essential
to be able to ensure that one has a unique reference.

Maybe Andreas can explain a bit more.

We can work around that there, with special wrappers specific for block,
sure.

But are you sure it isn't much more widely useful? Correct me if I'm wrong,
but as I understand, currently for AlwaysRefCounted objects you can never
safely obtain an &mut. So you cannot use the static safety checks
that come with '&' vs. '&mut'. This means you have to rely on interior
mutability, requiring runtime checks in the wrapper functions, no?

Isn't that, for example, the reason that Page is not AlwaysRefCounted,
as write access is protected by requiring an '&mut'?

Best,

Oliver


