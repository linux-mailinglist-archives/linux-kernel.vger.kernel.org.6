Return-Path: <linux-kernel+bounces-338192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689A598548F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120151F24AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9BC157492;
	Wed, 25 Sep 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqjWPFOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4A1514FB;
	Wed, 25 Sep 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250654; cv=none; b=cH9PNkJlBQ6MHaMrqZy5XMcWPzSmYJwixVltzGGWwfg8qJbdVrlQvY9B5HF8mVCNE4eqCwGbyPCsrLwHQfs68I/sru1Vj/sfIDyGke+UtNfrNy2Csdo/UYXT9MReUKk0K0Yjg3c9XK5WKxQna9JLzs60g4FxumxxuFstTEYnnd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250654; c=relaxed/simple;
	bh=nxxHaanGdEKogTdB9FIAntly8bVc3L9IFt63TQjpzQo=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=TuP51jBH5Ipgf71C5HFXHUr6fSDW2ZudCW05KJpPL3lH8BncFksnryCDo9YcUuyRO9ooZZ7oJYdRsorq0gCYkxKpKCiv/us4sjZaVJyGiMbspc6Z+8EQJE9YXZPR8D7scHV8R8xTcBnfIdy2mlQMGOvgM4NStGgMgbfa0IFGqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqjWPFOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7345AC4CEC3;
	Wed, 25 Sep 2024 07:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727250654;
	bh=nxxHaanGdEKogTdB9FIAntly8bVc3L9IFt63TQjpzQo=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=uqjWPFOEDimRXD2VswrjL3FReC/PLCDYqsdOf0tEbMzGoSb49T3BxZ+aNfyVuIPNr
	 zwj7VzlVOxkZMshIyFkAJW0ZAbTSKbOog8d65DRt1qMVB+lnB1BSigKvB+Do2oyOK+
	 6Bv0dIg53Rf9A6zBWcvT16pSF/BFeWG8SBKlBRpvwlkLyPVVf9xisgpFuZntalK67I
	 J7zxXk38/tEW7UVpu1ltIpuwGTralqeAxijfF74HEHIGLhOUNr22bTPc3spWFsSbt2
	 TjOwMb9Hq92yJ5SPtI6E5kqEy3uEpr6QGqqlI7fFrIjVYbRf5jjMDKIj32dzfnBLzk
	 jl5junbyVtJBQ==
Content-Type: multipart/signed;
 boundary=5f64a94d3cc6264df8dcbd44d202fcc8e6751e4c0113c74b5379b5495cbb;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 25 Sep 2024 09:50:49 +0200
Message-Id: <D4F79677N5I8.2AWKV1VNY66I9@kernel.org>
Cc: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, "Peng Fan" <peng.fan@nxp.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Shawn Guo" <shawnguo@kernel.org>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: jedec,spi-nor: add optional
 vcc-supply
X-Mailer: aerc 0.16.0
References: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
 <20240920-spi-v1-1-97f220c2e10c@nxp.com>
In-Reply-To: <20240920-spi-v1-1-97f220c2e10c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--5f64a94d3cc6264df8dcbd44d202fcc8e6751e4c0113c74b5379b5495cbb
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

since you respin anyway.

On Fri Sep 20, 2024 at 10:54 AM CEST, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Introduce optional vcc-supply property, spi nor flash needs power supply

SPI NOR flashes

> to work properly. The power supply maybe software controlable per board
> design.

-michael

--5f64a94d3cc6264df8dcbd44d202fcc8e6751e4c0113c74b5379b5495cbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZvPA2hIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gBdgF/Ze5wcLf/bJ9ZbddGfrY4S4tcaieVwkWq
eCjlDbkGpkZS6NGXbNfClc/9ulCS7yRmAX9v2Q9vYw6VgR+Voh8/neZZl6UDfe7w
KLbD3jiQOWpYIo1LcAZ91jDRTIxkSVNNVGw=
=8Uvm
-----END PGP SIGNATURE-----

--5f64a94d3cc6264df8dcbd44d202fcc8e6751e4c0113c74b5379b5495cbb--

