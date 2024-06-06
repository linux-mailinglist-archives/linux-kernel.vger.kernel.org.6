Return-Path: <linux-kernel+bounces-204273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2E8FE68E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A4DB22D17
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7752A195B15;
	Thu,  6 Jun 2024 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN2W7WBZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6543195981;
	Thu,  6 Jun 2024 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677230; cv=none; b=MQjRH0TYxLXQNzJ4AjYzByICQeNmhiG9veF/JqsW/tC5pU+taMqUbXrBBwNiq7bZMxG4g/sGJTdExquVMuPCSB9oGqOkVmFBGQN5EUaVfr4FRW3ZkfJBPbbEhKPUvwYe/wvXxAEqa8/qYcm1bcK49RcUTWfE3xWBBWetdUi/q8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677230; c=relaxed/simple;
	bh=S+qbvMG0BL+YaI5flrkXNhbh2Jah5zeZQOOyRZfywTo=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=ADVfEv+6C1X5Cvuu48vOW89CQpHCrBI58i3KPpPLXoZ3IEUls1l4WHC2ltDL8OgDKNuWV4lWgSViF9K1UKx+JZBsg6xfJTSFEqU68JQDgNqoeQ75zlMKRgVaZuwfvsL62EhNe6ZYGQqryKc1Vad+IXOR4Kw0FjwvjVPrmLeS3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN2W7WBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47AEC4AF09;
	Thu,  6 Jun 2024 12:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717677230;
	bh=S+qbvMG0BL+YaI5flrkXNhbh2Jah5zeZQOOyRZfywTo=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=UN2W7WBZWMtB8VjN+FitzjT/UejoSLC0Q4+NpYIgQTIpnNVIN7nVQr3kzOjICR7AE
	 VnOItjTFGCIZJ2YicQV0AOijXshcWI7Ulcb9JtCB97RumvgDEwdR/ATLP5bIiXx7CA
	 XCw3qfg5cKQiDSFODrSC21QfUpS96TxS+kolWUUXSFBM5Uc+2bSpsIktFo7gIEkB/r
	 IcNw2FVfm7N6wrqOhLJcEcTHRgecw09cKo7nZ+7aoIgq2VBRdNk+JTZyDQbXwlEopj
	 k99Di79HmE7KJMg2ycB+yfBkXW2V7dCEsrXVaYHVcJOr7su+BppMOI+KyyzLSIdgp+
	 8CAYAHzhezfZw==
Content-Type: multipart/signed;
 boundary=1cc637e5afad55ee26a7009fa07180f3ee198532ca034bcf93ed2a891362;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 06 Jun 2024 14:33:39 +0200
Message-Id: <D1SXR8ZVNR3F.2SNEOVX5ZC6G5@kernel.org>
Cc: "Pratyush Yadav" <pratyush@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Marek
 Vasut" <marex@denx.de>, "Imre Kaloz" <kaloz@openwrt.org>, "Andrew Lunn"
 <andrew@lunn.ch>, "Flavio Suligoi" <f.suligoi@asem.it>,
 <kernel@pengutronix.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Thorsten Scherer"
 <T.Scherer@eckelmann.de>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM
 devices
X-Mailer: aerc 0.16.0
References: <20240604074231.1874972-1-mwalle@kernel.org>
 <kl4ikwh4fpkhhlpneuujyk2j4a2byif7l27n7kgb4pm72hb4an@akhbc4jg6hyq>
 <1094fbfd-0ee7-430e-b62c-20764c1fbeec@linaro.org>
In-Reply-To: <1094fbfd-0ee7-430e-b62c-20764c1fbeec@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--1cc637e5afad55ee26a7009fa07180f3ee198532ca034bcf93ed2a891362
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Jun 6, 2024 at 2:14 PM CEST, Tudor Ambarus wrote:
> > The ci4x10 is still being used and sold.  Right now I do not have a cle=
ar
> > view on the implications of moving to that driver.  I'd like to invest =
some
> > time to sharpen my picture (or find the person that claims responsibili=
ty), but
> > this will propably not happen this week.
> >=20
>
> if it's used then we are forced to keep the entry in SPI NOR for
> backward compatibility. But we can still deprecate the use and forbid
> new support in SPI NOR while directing users to the other driver.

As mentioned, this is intended to be the first step towards removal.
And yes, we won't accept any new such devices, but at the same time,
new device trees should refrain from using this compatible, thus the
mark as deprecated.

How to handle boards which are actively using this device is a
different topic. I'm sure there is some kind of deprecation process.
I doubt we are forced to keep that support until the end of the
world :) Maybe some kind of grace period where we nag the user to
switch to a different interface, etc. Not sure.

Any ideas are welcome.

-michael

--1cc637e5afad55ee26a7009fa07180f3ee198532ca034bcf93ed2a891362
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZmGsoxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gn2AF8CcOTEM8x6BLUFvKR6+ekuxoYS/63p47G
6ph5zNQVYwJNufYOwBjvmv17D1kMUY12AYDDc/RYlTNDrJhQra9djygf5N8N0F5T
5mt2/Xrf/vrCDSAPxdcdb2vsF/O7tY28EA4=
=741n
-----END PGP SIGNATURE-----

--1cc637e5afad55ee26a7009fa07180f3ee198532ca034bcf93ed2a891362--

