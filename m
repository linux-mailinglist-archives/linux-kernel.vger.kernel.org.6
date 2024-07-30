Return-Path: <linux-kernel+bounces-266977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D5940A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA0AB249A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03DC187343;
	Tue, 30 Jul 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C708Uhm5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A581186E4F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326409; cv=none; b=oDW8B+HXzLby+5uZJuSxmvSjlqcGARuY9BJrMFYyz++5tRtxnyaFrOSVJ55v93nuV3TVillr34RZwhTQKkWmBVsQ696r8oBp3G42CESAdNTuUzEgQSQ2/uU1kYIJFRxOASTWhJxZP+mHoYNPitU1bgwKDjk5DSAXBs72ExzBcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326409; c=relaxed/simple;
	bh=CniaYDnRATpHlUBQAU6fUV84X3DZPceXVpYV08y62g4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=Kj70fwscYLg+npQ2TDx4ZCoh4j0ug3mdvEe0Xp08gV39SRYbw8vOiczGznDYobIsnIKRTb9vKfUJCiNdsd9BTggEDXrLqYq4/9BAQGYkAm1TttUmSN3mwuBL+04hEpUveZr+b562f0ZgW1Pf8Blon/5Ax+hnni3Qq+SKwlaZUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C708Uhm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DF5C4AF09;
	Tue, 30 Jul 2024 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722326407;
	bh=CniaYDnRATpHlUBQAU6fUV84X3DZPceXVpYV08y62g4=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=C708Uhm5+PEhyeLz+K6SvIsqQUqE+wrv8CE1GSljfy3RE8XNoWeC+F5vv6Drkw2cp
	 zsFSTYkSidoHQ/II+QsNZk3RGiwZtAQWHcSm7m6qtof/fdptSs8IcSZugln+aghpFq
	 S/7kXZFFKHelPcTjyuW755H5MRdFb/zptFpGFTgEbvnVmfPFCY12Do9hnwGYJHXe+F
	 8ZO4Pq4Fx2ZvTtQcsz+d9a4gLGYFDxqHz5THXGc/y95Gqvtc3oTVCN+pvlqiw051D0
	 0I7Q8/bdGnm3XwIPdKAj49yncZ/u4tI9gmdGzEFrTS7DFzVZzaunIcmu61dJee4lVt
	 VRAv3v744arSQ==
Content-Type: multipart/signed;
 boundary=95cb2f6b2372b8c8d1366bfc28389e4f6d080c4216470e4cd6558fd47f48;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 30 Jul 2024 10:00:03 +0200
Message-Id: <D32PR6R1LENM.3RUPQVJ1HRWG7@kernel.org>
Subject: Re: Subject: [PATCH] mtd: spi-nor: add support for MRAM Everspin
 EM008LXB
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: <claus.fabig@emerson.com>, <tudor.ambarus@linaro.org>,
 <pratyush@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <vigneshr@ti.com>
X-Mailer: aerc 0.16.0
References: <5bb5d445-e54c-48c3-b7f7-c07886af629e@usgdcecpmsgap03.emrsn.org>
In-Reply-To: <5bb5d445-e54c-48c3-b7f7-c07886af629e@usgdcecpmsgap03.emrsn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--95cb2f6b2372b8c8d1366bfc28389e4f6d080c4216470e4cd6558fd47f48
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Jul 26, 2024 at 2:04 PM CEST, claus.fabig wrote:
> > Hi,
> Hi Michael, thanks for your response resp. advices and apologies for the =
late response.
> >=20
> > There is something odd with your mail client, maybe have a look at
> > git send-email.
> Unfortunately I am only able to send/receive email from my windows machin=
e and=20
> therefore have some challenges within our company infrastructure.
> I still try to find the best way to get the formatting correct.

In that case you can also have a look at:
https://b4.docs.kernel.org/en/latest/contributor/send.html

> > Also we usually push back on the MRAM devices and refer the users to
> > the at25 driver. But as this doesn't use the NO_ERASE flag.. I'll
> > let Tudor and Pratyush decide.
> I am aware that using at25 driver works but have the task to integrate th=
at in mtd
> since another used MRAM Everspin flash MR25H10 on our board is also acces=
sed=20
> in that way and already part of the mainline. That will lead to confusion=
 on user side.

I suggest that you'll look into evaluating and converting your
existing boards to nvmem (which is the interface at25 exposes)
instead.

The MTD maintainers agreed that new fram/mram won't likely be added
anymore. As I said, this patch might be an exception, because you
are actually emulating a flash device (because you *don't* have the
NO_ERASE flag). Otherwise, the m/fram are more like an EEPROM and
thus should use the at25 driver.

> > > From: Claus Fabig <claus.fabig@emerson.com>
> > > Date: Thu, 18 Jul 2024 09:53:36 +0200
> > > Subject: [PATCH] mtd: spi-nor: add support for MRAM Everspin EM008LXB
> > >
> > > The Everspin EM008LXB MRAM has 8Mb and is populated on a custom
> > board
> > > using Microchip's PCI12000 spi host controller running on low 30MHz c=
lock.
> > > According to Everspin Read Fast (0xb) command below 60MHz is neither
> > > specified and nor tested. Test shows that using Read Fast (0xb) will
> > > result in reading inconsistent data in this setup but writing is fine=
, so
> > > only supporting Read (0x3) command should be acceptable for the momen=
t.
> >=20
> > This is really odd. Is there an explanation for that? Usually, fast
> > read will just add dummy cycles in between. Also the datasheet just
> > mentions a "maximum frequency" which actually makes sense. Do the
> > dummy cycles for our fast read operation match the number of dummy
> > cycles in your device?
> >=20
> Yes, at first I configured the chip with 8 dummy cycles to match with pla=
tform
> dummy cycles with the result of reading inconsistent data.=20
> The answer from Everspin product engineering was:
> "Read fast has only been tested down to 66 Mhz. If you are only running a=
t 30 Mhz,=20
> you should be using the Read command instead. Read Fast is designed for H=
igher=20
> speed operation". Unfortunately no more explanation.

I guess you cannot use it with at least 66MHz?

> > > The device is JEDEC compatible (JESD251 and JESD251-1) but not able t=
o
> > > provide SFDP information.
> >=20
> > There is no SFDP data for this chip is it? But it has a READ_ID
> > command.
> For my understanding reading SFDP works with command 0x5A which is not=20
> supported, reading ID is command 0x9F and supported. I don't understand y=
our point.
> Maybe you could give me a hint to better understand.

Please see my comments on the code in my first reply. You basically
don't probe the driver by the name, but by it's ID.

-michael

--95cb2f6b2372b8c8d1366bfc28389e4f6d080c4216470e4cd6558fd47f48
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZqidgxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jHRQF+O2Tp2yymNM81QCMqmznfxfBIfi6OjCWD
PXij072XPxSy0DLrC+I1IkoxaV4DXCemAYD4Bp6go3cilHA545XnLXyR0lfuaAIb
F2NuZbR818FQ8NdTvGVsKNSGifUHyahLzoU=
=3Ucz
-----END PGP SIGNATURE-----

--95cb2f6b2372b8c8d1366bfc28389e4f6d080c4216470e4cd6558fd47f48--

