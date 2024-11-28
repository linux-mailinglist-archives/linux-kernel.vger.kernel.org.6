Return-Path: <linux-kernel+bounces-424961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F306D9DBBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9331EB21081
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D51C0DCB;
	Thu, 28 Nov 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsQN9bXw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67A2537F8;
	Thu, 28 Nov 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815215; cv=none; b=Guv7lcHK/4tX9NXklf67ywYwuz6KwD36b1QVNcSzMLA90uB5XgNsPxfzyKpRbKiuvdqb2OjDnYvjy6ITHnhrID7/BlLKoYfL/c59JThBzwPfa0EvevlEqGCmyo00uZsREmVCZWr3hGliI0R5sevuHTydgclfAiEGB8WbDVRbLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815215; c=relaxed/simple;
	bh=B2nYAoEIQoWi/DFs74I+a1xozDKaymnzpCVznyZhcjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPTQsAwzfe/FPeM1vgYpMsd9kJ4ibwoU7XnJRu56BpVwQsUAqPVEiBi/lgAm3z/GbirKMrsDKiyfARgH0S6+zJZWCDA932uHhZ4khLSS5p2V/Igf7Okvi8cBsoiCIkqCebPsRUWDotSU0ps9uqaZIgd+3octGY7nbdzEUiWmiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsQN9bXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A05C4CECE;
	Thu, 28 Nov 2024 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732815215;
	bh=B2nYAoEIQoWi/DFs74I+a1xozDKaymnzpCVznyZhcjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsQN9bXw4s/spD2Z5dQS0jLQfP/aM46YLuUjaE6hamAwckXy+ZdY+9fUPN92qxU+v
	 aQ24qgT0aeyVdYKUA1RCEvPDLH11dbJZ2DYKxZZeb7BhI9MtCGcpXnjm0p8pateNH+
	 eCuJRdCdkdSH6Z7WMIOBdW6LiWhQk6I6SXLXDEb/XiGiGBoam/FUnbXl5D+9mWEKxy
	 CuWkZK0pcKQtTxHmp407wZOXqpPIt0HNt0PsHbK0qq/gCNR16nEooKQuoNJzX3/Avz
	 bcL2+pt0njicj3mqfZGCZtPHnqIcrYFzbB6xr8WKYb7tyDfwTJ059p+FNZAzNZhGOu
	 6iE0YORmP7Ghw==
Date: Thu, 28 Nov 2024 17:33:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 03/11] dt-bindings: regulator: pca9450: Document
 nxp,sd-vsel-fixed-low property for LDO5
Message-ID: <20241128-endanger-envy-d1b19f650b38@spud>
References: <20241127164337.613915-1-frieder@fris.de>
 <20241127164337.613915-4-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g0GmbFduZp5Hkvg7"
Content-Disposition: inline
In-Reply-To: <20241127164337.613915-4-frieder@fris.de>


--g0GmbFduZp5Hkvg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 05:42:19PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> This new property can be used for boards which have the SD_VSEL tied
> to a fixed low level. The voltage of LDO5 is therefore only controlled
> by writing to the LDO5CTRL_L register.
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v2:
> * new patch
> ---
>  .../bindings/regulator/nxp,pca9450-regulator.yaml           | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regu=
lator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regula=
tor.yaml
> index 5d0d684186c96..0e19c54aa5f8a 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.y=
aml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.y=
aml
> @@ -49,6 +49,12 @@ properties:
>            Properties for single LDO5 regulator.
> =20
>          properties:
> +          nxp,sd-vsel-fixed-low:
> +            type: boolean
> +            description:
> +              Let the driver know that SD_VSEL is hardwired to low level=
 and
> +              there is no GPIO to get the actual value from.

Does this mean that if you don't provide the property or a GPIO it is tied
high or High-Z? If so, please mention it here. More likely, given the
context of this patch, no gpio and no tied low property means the driver
should handle things as they used to be - but you should call that out
in your commit message to be clear.

> +
>            sd-vsel-gpios:
>              description:
>                GPIO that can be used to read the current status of the SD=
_VSEL
> --=20
> 2.46.1
>=20

--g0GmbFduZp5Hkvg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0ipagAKCRB4tDGHoIJi
0kCrAP9N2emwE+htZGNB9lvu6CN6KHjIRKADtq875PoNHM6XiAEAsv0/3ontG5XF
9k8wV2+utMVxbd5jyPMTnNbdx/PzkwA=
=Uoob
-----END PGP SIGNATURE-----

--g0GmbFduZp5Hkvg7--

