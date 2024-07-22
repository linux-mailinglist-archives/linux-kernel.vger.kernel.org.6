Return-Path: <linux-kernel+bounces-258546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF0938978
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69416282F54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8412B73;
	Mon, 22 Jul 2024 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3lGhCJu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8332F41
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631670; cv=none; b=budUm7mVKNeRj8Ik7vidxxKIKIE3J8umaMbwHTKxj5JaS+O1DAGj3AG3XyDH7p1YtNF+aF5wH+PSm+jbtoUzAkgdS03D7ExF7PSyCfoaIm8B6CWjwxPFffPmqG0Ef1Po2G5jj7tCVoH3NmNPQE+o8myoGCxQzg+0eF8NNEi2CRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631670; c=relaxed/simple;
	bh=leuPpGiqOfrJf60CNoIBnX9WfHQpps/3Pu235DgCdcQ=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=Ejzj4sS38jLEJn8vufTeOW0BKYFvW5rl0uQxen1PsZjGMkFOIkBMtZcFcHyHFesM4JluV29EyUmu0UH+6IY1mUST8fZWBaRUzyqDbcviprPonbK/CnYt1h0wYBEIBRfOvALwMJCIpUW0chezDAeasDDW8P6BskSuAju+9FgJNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3lGhCJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CD9C32782;
	Mon, 22 Jul 2024 07:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721631670;
	bh=leuPpGiqOfrJf60CNoIBnX9WfHQpps/3Pu235DgCdcQ=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=n3lGhCJu0agX39bWygdp/WFfUno2MdzchtvHjchVpCRPAD9yaxjdwK5XBWjak5xu0
	 9xzF4O8VNZ/LBBnZbNFJ/mOpRje5YizORumaoSlz6W09/wCuCewPkZPTJw1T0KA8E2
	 wjqLz3um1L+mLI9f0dwtsN0iG8OAadBhTgE0m/U8bMtbBpYVaGRkPnW6hAfOCIA+NJ
	 heeryolEWDGv0RTfsRowttg1CeOxTmXku/vx/xB86LiHsY8POZgypIsb+0CN5mXpy3
	 +Aww5Ydy5vGyHc3MVFhBAiJr4jjQMQsWi99g57JrTaDhQtHMC0NPyVKBzwtFn3Tqxq
	 LMt1VxNNl2Mpg==
Content-Type: multipart/signed;
 boundary=61a37f4b0793f854f1fc5fc70386d52121ee25dcf8f7bb8b2f28a4a8105a;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 22 Jul 2024 09:01:02 +0200
Message-Id: <D2VVHMYC8IJ0.FSRXHH7HTH2O@kernel.org>
Cc: <leoyu@mxic.com.tw>, <alvinzhou@mxic.com.tw>, "Cheng Ming Lin"
 <chengminglin@mxic.com.tw>
From: "Michael Walle" <mwalle@kernel.org>
To: "Cheng Ming Lin" <linchengming884@gmail.com>,
 <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Add support for Macronix serial NOR flash
X-Mailer: aerc 0.16.0
References: <20240722064922.606172-1-linchengming884@gmail.com>
In-Reply-To: <20240722064922.606172-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--61a37f4b0793f854f1fc5fc70386d52121ee25dcf8f7bb8b2f28a4a8105a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 22, 2024 at 8:49 AM CEST, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> Add support for Macronix serial NOR flash.

There was already a v9 of this series. Please provide a changelog
and resend with the correct version.

Also please provide a more elaborated cover letter as this seems to
be a split off the original series. Note that, the last submission
from Macronix was almost half a year ago. So please help jog our
memories.

-michael

>
> Cheng Ming Lin (3):
>   mtd: spi-nor: macronix: Add support for serial NOR flash
>   mtd: spi-nor: macronix: Add support for Macronix Octal flash MX25
>     series with RWW feature
>   mtd: spi-nor: macronix: Add support for Macronix Octal flash MX66
>     series with RWW feature
>
>  drivers/mtd/spi-nor/macronix.c | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)


--61a37f4b0793f854f1fc5fc70386d52121ee25dcf8f7bb8b2f28a4a8105a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZp4DrhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iCHgF/fPRq5N0qKV+7TBQ3MCrDzJ2rAnqy5CwJ
3aeeBlyS8sordJqIZJJozvunoD+CP9HIAYDf1Abxg/c0DtCnHhS5bFhRAnVZva/E
m0AvPOTs9wKA+GdcWTsXMWJzDJKKq4oUCP0=
=kX0+
-----END PGP SIGNATURE-----

--61a37f4b0793f854f1fc5fc70386d52121ee25dcf8f7bb8b2f28a4a8105a--

