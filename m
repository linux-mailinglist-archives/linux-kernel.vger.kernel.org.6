Return-Path: <linux-kernel+bounces-371412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BB69A3ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089501C2306B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE5017D378;
	Fri, 18 Oct 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="zARhtP6g"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1971D2709
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245703; cv=none; b=tlG9ECBl1WqnWekTvHhm/OJIhWShKoI7kCS8fI73db9dqOBjx+CJKvhJfPjRbwRs+RkUoIw7sxFJLSOfe+dY0Jx0hFMEnPmtVRytNB8jnojnX5YlQmm/H9DKjaVykGyEsgDf1S8gWiR/ObaSKKltC5GRXElCyuAIVYDIHuwIQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245703; c=relaxed/simple;
	bh=kpVs6QNuH4t46SoaItN6OY7yKe1EfynK3SlqSS5AI0w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=AWe7hxXTwTJLRpl9yasSkTIPXVl+IRxSZcitxGErGJSr9B4I1OSKADWDELuvOR3ULc1GZkKQcRnO/ckmqq/QLm0kVTOPxxZYTKwYapTn8dNVsnP/nx4lDCzPgcPrWCgxDcUCuLo0qKnCwghlbCjHGQCftT+UvmgBf8l3Iq04AZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=zARhtP6g; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729245699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vq44XNSVqgHa/XdP4NFnLGc5+igXGHK+t/VxbE7OtsE=;
	b=zARhtP6gRoKin5kG2ZnJBZbv96O3U2ZSa/PGkCLH/fcf5CX88L2gh5hWbFXPG77XIWSFFw
	5OkITriS7d0SQOWbZ1hVw8r8U7/7MtJeN1lirpHCADvF072HPESLQVtSKVm0PidTFpwwF3
	0/zQ302uM8dhMjS3TeFjIDyb6PGGbCwnGa0J2iXAXiirC5JG8DQeTOk/tQGtQhuzdMt8yN
	crX6WK3RoUmjPqQdgMp33lZgUIbQ5EdvZYHz1sQUC5QewlCqXqwdbK5nmjy/7wgPJJm1JT
	wuCyiQLqQyQGJISEoqWvihLAEhBQimw4vOAXoGyLG0WmmNSGsvydvVx6O2BsTw==
Content-Type: multipart/signed;
 boundary=257bc4f7e0a51fb6aba1bc06018e6c2e1bcf34f65203598562bde9d8737d;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 18 Oct 2024 12:01:29 +0200
Message-Id: <D4YUFQSAR6RX.LS5RY03XCV3J@cknow.org>
Subject: Re: (subset) [PATCH v2 0/4] rockchip: Fix several DT validation
 errors
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20241008113344.23957-1-didi.debian@cknow.org>
 <D4X8GJV0W6JL.32E469JSATFEP@cknow.org>
 <D4YTW4DVRT68.1Z97ZHDYWTKHT@cknow.org> <4604343.LvFx2qVVIh@diego>
In-Reply-To: <4604343.LvFx2qVVIh@diego>
X-Migadu-Flow: FLOW_OUT

--257bc4f7e0a51fb6aba1bc06018e6c2e1bcf34f65203598562bde9d8737d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Oct 18, 2024 at 11:37 AM CEST, Heiko St=C3=BCbner wrote:
> Am Freitag, 18. Oktober 2024, 11:35:51 CEST schrieb Diederik de Haas:
> > On Wed Oct 16, 2024 at 2:35 PM CEST, Diederik de Haas wrote:
> > > On Wed Oct 16, 2024 at 11:41 AM CEST, Diederik de Haas wrote:
> > > > Please revert the 4th patch.
> > > >
> > > > I must have messed up my testing previously, but BT does not work o=
n the
> > > > PineNote with the 4th patch applied and does work with it reverted.
> > >
> > > FWIW, I figured out what went wrong.
> > > My testing was correct, but redo-ing the implementation to make it re=
ady
> > > for submission wasn't very smart.
> > >
> > > With ``shutdown-gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;``
> > > it does work correctly, but I forgot to change GPIO_ACTIVE_LOW to
> > > GPIO_ACTIVE_HIGH before submitting.
> > >
> > > I'll first figure out a better procedure before making a new submissi=
on,
> > > so the revert is still the best approach IMO.
> >=20
> > I've now done a new submission:
> > https://lore.kernel.org/linux-rockchip/20241018092237.6774-1-didi.debia=
n@cknow.org/
> >=20
> > So please don't revert the 4th patch now.
>
> hehe ok :-) .
> I meant to ask if the fix wasn't simply toggling the gpio polarity, and
> I guess with your patch you were faster than my question.

I already knew that was the fix the moment I opened the other dts(i)
files with the same wireless+bt module.
While it was tempting to immediately sent the fix, I realized that
being (too) eager to sent it out would be a recipe for another screw up.

And I wanted to think through why it happened in the first place and
that's because my submission process is all manual with an 'insane' long
`git send-email` command, hand-crafted.
So I better learn `b4` (properly) so my focus can be on the patches and
less on the submission process.

Making a mistake/screw up sucks, but not learning from them is bad.

Cheers,
  Diederik

--257bc4f7e0a51fb6aba1bc06018e6c2e1bcf34f65203598562bde9d8737d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZxIx/AAKCRDXblvOeH7b
blibAQDCucJM71C9TwS9Yr98OdbZHEg1kv4+sXW9YlDFAfaGQwD/fYlIrQ8AxlTb
Om8V7JZLgB2t4JwXokIVFR1o0O06NwM=
=HJWw
-----END PGP SIGNATURE-----

--257bc4f7e0a51fb6aba1bc06018e6c2e1bcf34f65203598562bde9d8737d--

