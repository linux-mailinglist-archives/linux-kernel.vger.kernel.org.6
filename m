Return-Path: <linux-kernel+bounces-177797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B542A8C44BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694C21F21FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A1B15539D;
	Mon, 13 May 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffg7e+m5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87815532C;
	Mon, 13 May 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616099; cv=none; b=WhGFb6rhO75lUFQO7le9x8Joo69/vfNqOhJC4fKGQFruAdzwDSjgpxYPI4RVP4mDNp4k8cKSuQL6TgoEyh7QmMBXIyOxHGiipyqJtHO+YqdkOMXcViugutMPu9HRVzvByjUBwneXisqq2DLMo9VJ8O2JJoueZ2bAHKUxXbkHXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616099; c=relaxed/simple;
	bh=VhYVty2acqcCBHONMhwvO6FK9j6wZBYyuF0dbi8giHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9HHooFoTFwy8ASlZVZiGkAd8snXIdB2bomjhmVT74SwBNL4SVzOIsZIOKg33qZxJc2/S4BWkVjnnK/ohGxzQi/sqUux/oMRg1EvOzHjpNBj/8PYattz++COUygzeU0Mq+Q/tQvFu7OWw6qmBPHUF1i7fz5BIaNsodQI56MDpbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffg7e+m5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C99C32786;
	Mon, 13 May 2024 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616098;
	bh=VhYVty2acqcCBHONMhwvO6FK9j6wZBYyuF0dbi8giHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffg7e+m5AIYyrukObG14BNxs6iZMIte+CF9XqtORl9+GcQRHlMyUiM/PgQiLOBqTo
	 NtIbLlBKyudR4ZUkA0qBEUs7xVbPdE2Z7rQOcndm+SBoWHt2TAnvXkcoaj0INd4xiw
	 VYl8NhPUWDcfc95/m2uPILl66Hyn6aDz6yJBoqEzo0F/SUJYZ4Gf75K32l/VRDMaHQ
	 eHxvu0o8/30zkXB55dgRdXv27xyqQ5cgZyv9flhveKWOa0+hjeb2lERC/ipOqXnTvT
	 i00yuKXLbU6clOF3YSyfoNzIibYIbIfilNS64jsgRrbQ21iDHR6sK4MBoe4uUBLh71
	 wHGf+Qmp2Ig7w==
Date: Mon, 13 May 2024 17:01:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, frank.li@nxp.com,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <20240513-antonym-flanking-5a812dd49920@spud>
References: <1715563324-6391-1-git-send-email-hongxing.zhu@nxp.com>
 <1715563324-6391-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ww9JUqbrd7gfrxGO"
Content-Disposition: inline
In-Reply-To: <1715563324-6391-2-git-send-email-hongxing.zhu@nxp.com>


--ww9JUqbrd7gfrxGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2024 at 09:22:03AM +0800, Richard Zhu wrote:

> +  fsl,hsio-cfg:
> +    description:
> +      Specifies the use case of the HSIO module in the hardware design.
> +      Because the HSIO module can be configure into three different use
> +      cases.
> +      Refer to macro HSIO_CFG* of include/dt-bindings/phy/phy-imx8-pcie.h.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 3

> +/*
> + * Regarding the design of i.MX8QM HSIO subsystem, HSIO module can be
> + * confiured as following three use cases.
> + *
> + * Define different configurations refer to the use cases, since it is
> + * mandatory required in the initialization.
> + *
> + * On i.MX8QXP, HSIO module only has PCIEB and one lane PHY.
> + * Define "IMX8Q_HSIO_CFG_PCIEB" for i.MX8QXP platforms.
> + *
> + * +----------------------------------------------------+----------+
> + * |                               | i.MX8QM            | i.MX8QXP |
> + * |-------------------------------|--------------------|----------|
> + * |                               | Lane0| Lane1| Lane2| Lane0    |
> + * |-------------------------------|------|------|------|----------|
> + * | IMX8Q_HSIO_CFG_PCIEAX2SATA    | PCIEA| PCIEA| SATA |          |
> + * |-------------------------------|------|------|------|----------|
> + * | IMX8Q_HSIO_CFG_PCIEAX2PCIEB   | PCIEA| PCIEA| PCIEB|          |
> + * |-------------------------------|------|------|------|----------|
> + * | IMX8Q_HSIO_CFG_PCIEAPCIEBSATA | PCIEA| PCIEB| SATA |          |
> + * |-------------------------------|------|------|------|----------|
> + * | IMX8Q_HSIO_CFG_PCIEB          | -    | -    | -    | PCIEB    |
> + * +----------------------------------------------------+----------+
> + */
> +#define IMX8Q_HSIO_CFG_PCIEAX2SATA	0x1
> +#define IMX8Q_HSIO_CFG_PCIEAX2PCIEB	0x2
> +#define IMX8Q_HSIO_CFG_PCIEAPCIEBSATA	(IMX8Q_HSIO_CFG_PCIEAX2SATA | IMX8Q_HSIO_CFG_PCIEAX2PCIEB)
> +#define IMX8Q_HSIO_CFG_PCIEB		IMX8Q_HSIO_CFG_PCIEAX2PCIEB

Rob may disagree with me, but I think this should be an enum of possible
strings with the table here moved into the property description. The QXP
only option should then be constrained per compatible.

> +
> +  fsl,refclk-pad-mode:
> +    description:
> +      Specifies the mode of the refclk pad used. INPUT(PHY refclock is
> +      provided externally via the refclk pad) or OUTPUT(PHY refclock is
> +      derived from SoC internal source and provided on the refclk pad).

> +      This property not exsit means unused(PHY refclock is derived from

Please run a spell checker on your patches.

> +      SoC internal source).

> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ input, output ]

enum: [input, output, unused]
default: unused

Cheers,
Conor.

--ww9JUqbrd7gfrxGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI5XQAKCRB4tDGHoIJi
0jqoAQCYD2YK1tmMPaNlI9amDiaAHYglL45y74OiDECRW83y9QEAhhjmKXQ4AoBA
7osBM/TWVCR/ttAnM0RjJm8MSwDcjQA=
=aM53
-----END PGP SIGNATURE-----

--ww9JUqbrd7gfrxGO--

