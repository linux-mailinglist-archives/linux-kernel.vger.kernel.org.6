Return-Path: <linux-kernel+bounces-262308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE4793C3E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066E51F216D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650019D065;
	Thu, 25 Jul 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AssPocB4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9853FB3B;
	Thu, 25 Jul 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917090; cv=none; b=Rq9RMuXpUL+yhLj7Xc/X5hG2OCXZT56Gc6D/OBNEDwxYumkJaML+ONBrLBGxhtRY7C1FWN3yTlA55JWU9E3rE6tKvMjL/WNPa8xPmY2e+uB6QrIhxeKV5y3Vdazm8dBoUfBa+tXgRDEJrT/Nb/0mAS/1178kww8LPpNJBXcSiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917090; c=relaxed/simple;
	bh=xohQ7cDuAKj+ikn3oE3Ik1T9hii6xf2b9qOnKgl2kbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjQR9x4j/RnGvPztMqMDZu/Fh/+TPGYIiUc9ooK/7xG9H/WIYk8vknzGBRDTRyYFQwdUjBYGWVry3OSf6LlvXem+/mypac9YjnGERgA72oD7CLFOssh4bCZch7dKmI5vmigOP7ULMCCCXbJ+JMPsBuDtNBk/Sjk0UldPFP2HnQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AssPocB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD588C116B1;
	Thu, 25 Jul 2024 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721917089;
	bh=xohQ7cDuAKj+ikn3oE3Ik1T9hii6xf2b9qOnKgl2kbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AssPocB4NBvzq7PSK5vxvc7KFhsWTp73nvTNBrcL2zizy2hzSECf+jgQ4Gsf+D58s
	 ef6jx20+giw/Sq/tUM8ka6eSDVCiEh+LBi4h6f0BvDX6V2/dKpJI07T7aeW6n8wnzb
	 aAt1gTxWDwJeEOF1ADGR8znCHOrW/KN+V9OL5EEaRG4hCX3CBt/Q18ivpWKXCrZQWW
	 9os8FjevcEBsXyC8Ndj2IkcvM62kkynz4iVMU9Wv5s6n+EGUHUYOFOEV3ZVl7nLBQj
	 H2ERWqsks4gnbyk0HTIxncmcm2nFetz8cacUjFkwmLuWwHA8kOpZa622q1+vTC7Ev6
	 DZQgbdioPAAmw==
Date: Thu, 25 Jul 2024 15:18:05 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 15/17] dt-bindings: clk: microchip: Add Microchip PIC64GX
 host binding
Message-ID: <20240725-dwelled-uniformly-d0a5dd6e3b2c@spud>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
 <20240725121609.13101-16-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaUAIgZApWKgpdYt"
Content-Disposition: inline
In-Reply-To: <20240725121609.13101-16-pierre-henry.moussay@microchip.com>


--jaUAIgZApWKgpdYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 01:16:07PM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> Add device tree bindings for the Microchip PIC64GX system
> clock controller
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

I don't see a point in duplicating this header from mpfs. The defines
are all identical.

Cheers,
Conor.

> ---
>  .../clock/microchip,pic64gx-clock.h           | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 include/dt-bindings/clock/microchip,pic64gx-clock.h
>=20
> diff --git a/include/dt-bindings/clock/microchip,pic64gx-clock.h b/includ=
e/dt-bindings/clock/microchip,pic64gx-clock.h
> new file mode 100644
> index 000000000000..91687c9da516
> --- /dev/null
> +++ b/include/dt-bindings/clock/microchip,pic64gx-clock.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Daire McNamara,<daire.mcnamara@microchip.com>
> + * Copyright (C) 2024 Microchip Technology Inc.  All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_MICROCHIP_PIC64GX_H_
> +#define _DT_BINDINGS_CLK_MICROCHIP_PIC64GX_H_
> +
> +#define CLK_CPU		0
> +#define CLK_AXI		1
> +#define CLK_AHB		2
> +
> +#define CLK_ENVM	3
> +#define CLK_MAC0	4
> +#define CLK_MAC1	5
> +#define CLK_MMC		6
> +#define CLK_TIMER	7
> +#define CLK_MMUART0	8
> +#define CLK_MMUART1	9
> +#define CLK_MMUART2	10
> +#define CLK_MMUART3	11
> +#define CLK_MMUART4	12
> +#define CLK_SPI0	13
> +#define CLK_SPI1	14
> +#define CLK_I2C0	15
> +#define CLK_I2C1	16
> +#define CLK_CAN0	17
> +#define CLK_CAN1	18
> +#define CLK_USB		19
> +#define CLK_RESERVED	20
> +#define CLK_RTC		21
> +#define CLK_QSPI	22
> +#define CLK_GPIO0	23
> +#define CLK_GPIO1	24
> +#define CLK_GPIO2	25
> +#define CLK_DDRC	26
> +#define CLK_FIC0	27
> +#define CLK_FIC1	28
> +#define CLK_FIC2	29
> +#define CLK_FIC3	30
> +#define CLK_ATHENA	31
> +#define CLK_CFM		32
> +
> +#define CLK_RTCREF	33
> +#define CLK_MSSPLL	34
> +#define CLK_MSSPLL0	34
> +#define CLK_MSSPLL1	35
> +#define CLK_MSSPLL2	36
> +#define CLK_MSSPLL3	37
> +/* 38 is reserved for MSS PLL internals */
> +
> +/* Clock Conditioning Circuitry Clock IDs */
> +
> +#define CLK_CCC_PLL0		0
> +#define CLK_CCC_PLL1		1
> +#define CLK_CCC_DLL0		2
> +#define CLK_CCC_DLL1		3
> +
> +#define CLK_CCC_PLL0_OUT0	4
> +#define CLK_CCC_PLL0_OUT1	5
> +#define CLK_CCC_PLL0_OUT2	6
> +#define CLK_CCC_PLL0_OUT3	7
> +
> +#define CLK_CCC_PLL1_OUT0	8
> +#define CLK_CCC_PLL1_OUT1	9
> +#define CLK_CCC_PLL1_OUT2	10
> +#define CLK_CCC_PLL1_OUT3	11
> +
> +#define CLK_CCC_DLL0_OUT0	12
> +#define CLK_CCC_DLL0_OUT1	13
> +
> +#define CLK_CCC_DLL1_OUT0	14
> +#define CLK_CCC_DLL1_OUT1	15
> +
> +#endif	/* _DT_BINDINGS_CLK_MICROCHIP_PIC64GX_H_ */
> --=20
> 2.30.2
>=20

--jaUAIgZApWKgpdYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqJenQAKCRB4tDGHoIJi
0uXrAP9TEC6A2EiOOJUy5P8d7wW8OKPiLzm50dwko1Fs5X6XpwD+JPRt1F2TPE9P
UuFSE4d91tuqi+PAwwMMru0UJjnAcgM=
=oSHR
-----END PGP SIGNATURE-----

--jaUAIgZApWKgpdYt--

