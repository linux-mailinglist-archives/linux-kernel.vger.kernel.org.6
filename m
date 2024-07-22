Return-Path: <linux-kernel+bounces-258707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA17938BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA15282C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1C169AD0;
	Mon, 22 Jul 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVkkRSrU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0D25763
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640058; cv=none; b=WBbZKElzM5JsDykDCqUFI3tWBdtbEz1cHw1TIrxmyd7h33iS1detxAELHPYcUeuExFmxuDFy4G8l8d9SFW5I+eFvStWcIdlBGQ4e0sYZSjsTOr6j8Io1i9U310L6+DDuOSmfR0F5nva4PeQWztHvl1iXqPP8LOopsntnyH7U8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640058; c=relaxed/simple;
	bh=NzV2bFXlWnEhT/15kfXo/PYSnGs6ztHxH0Dc8E/AehY=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=DEFtdsJE9UiJeN7iEDOfLpTyvTMp/pBRjLS0zdneByT/7lb8VFArp6/77QEipWrHfNSehr4hcxA+YJWnfpSVYldSzSM+MwNzARlU7wFY23FH3hg//1IFGxUZeaPeqOwYtewDTcVFyv7kFP98SfdSidMWvw3RqAxPAtRCKybfivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVkkRSrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4CAC4AF0A;
	Mon, 22 Jul 2024 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721640058;
	bh=NzV2bFXlWnEhT/15kfXo/PYSnGs6ztHxH0Dc8E/AehY=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=eVkkRSrU6Uj6LlMNJ8pICXJabjErDsmzGr8K8Fwt6nzo08PwjBVrrzyagVyJiEcbh
	 a/mAKGD10ZOh7H/H0M5grIRERPACajr1348UIFgvUzWDeJFeBI65nkfWgwPJj0ibgl
	 Aun97i8lEHEV7+F120hFiY+SaKCIk6t4gJgRDYZDCDKh+WJBS1ac2MooboyFeI0Gyz
	 SrMYtyEli+NtStw8hFVZCN7YzZ+nCj+9rCq+xvg7t+N08vEzBW7R5PH7HV8nfN22oI
	 zvXM9j7Pq3tmSX2/S8sSo3rNE1MLXwiqN/Fp0Pwj73BRswjc9LBXCOlAxOG5CZae6a
	 dKSASbMlTbmow==
Content-Type: multipart/signed;
 boundary=8f50d3893aae5a208315e8a73c8d0f14cd575a25f5cdbb72d2432c19fc45;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 22 Jul 2024 11:20:25 +0200
Message-Id: <D2VYGD0191M5.30VXXMSA7N267@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Cheng Ming Lin" <linchengming884@gmail.com>,
 <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: Add support for serial NOR
 flash
Cc: <leoyu@mxic.com.tw>, <alvinzhou@mxic.com.tw>, "Cheng Ming Lin"
 <chengminglin@mxic.com.tw>
X-Mailer: aerc 0.16.0
References: <20240722084952.608770-1-linchengming884@gmail.com>
In-Reply-To: <20240722084952.608770-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--8f50d3893aae5a208315e8a73c8d0f14cd575a25f5cdbb72d2432c19fc45
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 22, 2024 at 10:49 AM CEST, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> MX66U1G45G and MX66L2G45G are Macronix serial NOR flash.
>
> These flashes have been tested on Xilinx Zynq-picozed board
> using MXIC SPI controller.

I've asked for a changelog. Now, what you've sent is a v2 (of what
seems to be a split off of a split off). Before sending out another
version, please carefully read:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

To be clear, please explain why this is a split off of the larger
series, what has changed (or if nothing has changed then state so).
Why did you split it even more (before it were two patches).

Honestly, back when Jaime submitted these patches, I already spent
way too much time to review this stuff just to get it dropped or
handed over to another employee who then comes back very late.
Please align your workflow at Macronix and get an internal review
and some training how to submit patches upstream and don't put that
burden on maintainers.

Thanks,
-michael

--8f50d3893aae5a208315e8a73c8d0f14cd575a25f5cdbb72d2432c19fc45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZp4kWhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gjJQF+KExmXS2k3+LrXrGSsx/Alxwluts789FY
bUK8tOM+mIXZkCG80G3XpAtFDR8nnXCVAX9bpHVGPgIAGv9ssTh2Dal5t3o/eK+4
ODMYxCOemAmaIrPA3GdgbNU9FNkH96bf04s=
=+BrM
-----END PGP SIGNATURE-----

--8f50d3893aae5a208315e8a73c8d0f14cd575a25f5cdbb72d2432c19fc45--

