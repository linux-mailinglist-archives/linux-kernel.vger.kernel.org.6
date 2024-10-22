Return-Path: <linux-kernel+bounces-376659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA319AB48B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3931EB22B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603001BCA0E;
	Tue, 22 Oct 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jasQQh/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D11BC07E;
	Tue, 22 Oct 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616355; cv=none; b=RzmPhWvuJM9fjNJOB+G+ow3VPc5XdCKbpoFO9lo4/GRcPSUoQ9SBP6T54UcJSJCnSLKLQV3jg4FvgaTswmNGhVhz4/j+VsI9qW0/fVMsUrcUNlCDMl5dCxbrUt83rW28orlcp7PjG8YfhQo6ccMMoYZro0DiLKIW0bJp+rztP+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616355; c=relaxed/simple;
	bh=YqZhDxZgCTX5lmrumDd1xi5UtwbdIoTELpTi9zP3OFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIZBgnqxWrV2bFnupSl9vBl3vNpMppAhhC2T9z1rIJ9yGfvvt30q/ytx/L4WjxGUuLriJmfktOXiwlX5eWZT7iE9RegfMJCS/ePuaaynVN8sf1keE/wZsFJ1Nbumv5nCUG+3OsozO4Wxug9poWcefJik7IeKC18GyMjv/pZzsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jasQQh/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77D9C4CEC7;
	Tue, 22 Oct 2024 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729616355;
	bh=YqZhDxZgCTX5lmrumDd1xi5UtwbdIoTELpTi9zP3OFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jasQQh/FWlLI5n2qfBhrKk4I1LOVbZHQZ7dcQxBjV/9jMgadJUUpZKRGtaFVesgja
	 Cgl+wulvRmah3Rh15y6e+d9lnlttdgmR3cO5MQqz1hH8/9WkUTDwr5DE7gaDCaywUd
	 u1c456Sx9UoFIqJERRdn/n6sbodfZydSOv3szNI10H9afDxuocb1KPTSGxszZ0GNNC
	 YPXlV4c+3tchkoxtcCulPiCp5Y6VqwkIVGqaLjGGJ1zLEo07LmX4vA5ArO4DXZOZqi
	 aqL/4KOMjEGNI3++rzTxpnn5Ak9ve6tR4FCUzzbxcdOKRDv/TFsEFp0aOyss/ZG+y2
	 GN0nKv9L6Csow==
Date: Tue, 22 Oct 2024 17:59:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] ARM: dts: imx: Add devicetree for Kobo Clara 2E
Message-ID: <20241022-refurbish-laborious-e7cc067966dc@spud>
References: <20241021173631.299143-1-andreas@kemnade.info>
 <20241021173631.299143-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1QUDuvcwqVe7Q8G9"
Content-Disposition: inline
In-Reply-To: <20241021173631.299143-3-andreas@kemnade.info>


--1QUDuvcwqVe7Q8G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 07:36:30PM +0200, Andreas Kemnade wrote:
> Adds a devicetree for the Kobo Clara 2E Ebook reader. It is based
> on boards marked with "37NB-E60K2M+4A2" or "37NB-E60K2M+4B0". It is
> equipped with an i.MX6SLL SoC.
>=20
> Expected to work:
>   - Buttons
>   - Wifi
>   - Bluetooth
>     (if Wifi is initialized first, driver does not handle regulators
>      yet)
>   - LED
>   - uSD
>   - USB
>   - RTC
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
>  .../dts/nxp/imx/imx6sll-kobo-clara2e-a.dts    |  23 +
>  .../dts/nxp/imx/imx6sll-kobo-clara2e-b.dts    |  23 +
>  .../nxp/imx/imx6sll-kobo-clara2e-common.dtsi  | 514 ++++++++++++++++++
>  4 files changed, 562 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-common=
=2Edtsi
>=20
> diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/i=
mx/Makefile
> index 92e291603ea13..58db45352b666 100644
> --- a/arch/arm/boot/dts/nxp/imx/Makefile
> +++ b/arch/arm/boot/dts/nxp/imx/Makefile
> @@ -290,6 +290,8 @@ dtb-$(CONFIG_SOC_IMX6SL) +=3D \
>  dtb-$(CONFIG_SOC_IMX6SLL) +=3D \
>  	imx6sll-evk.dtb \
>  	imx6sll-kobo-clarahd.dtb \
> +	imx6sll-kobo-clara2e-a.dtb \
> +	imx6sll-kobo-clara2e-b.dtb \
>  	imx6sll-kobo-librah2o.dtb
>  dtb-$(CONFIG_SOC_IMX6SX) +=3D \
>  	imx6sx-nitrogen6sx.dtb \
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts b/arch/=
arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
> new file mode 100644
> index 0000000000000..33756d6de7aa0
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Device tree for the Kobo Clara 2E rev A ebook reader
> + *
> + * Name on mainboard is: 37NB-E60K2M+4A2
> + * Serials start with: E60K2M (a number also seen in
> + * vendor kernel sources)
> + *
> + * Copyright 2024 Andreas Kemnade
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6sll-kobo-clara2e-common.dtsi"
> +
> +/ {
> +	model =3D "Kobo Clara 2E";
> +	compatible =3D "kobo,clara2e-b", "kobo,clara2e", "fsl,imx6sll";
> +};
> +
> +&i2c2 {
> +	/* EPD PMIC SY7636 at 0x62 */

Could you explain what you're doing here, please?

> +};

--1QUDuvcwqVe7Q8G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfZ3gAKCRB4tDGHoIJi
0tvKAQCHnhjHfQY9W5RU94mbICkvhkP0EJHMGj24Tuvl9nzczQEAhfyrow3JGNlT
Z15gU3gvhGz8CsgZos5joeyqJLK7swM=
=y+oV
-----END PGP SIGNATURE-----

--1QUDuvcwqVe7Q8G9--

