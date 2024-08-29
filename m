Return-Path: <linux-kernel+bounces-307274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C89964B32
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452892821F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965571B5819;
	Thu, 29 Aug 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0o6GpUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17C1B5800;
	Thu, 29 Aug 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948002; cv=none; b=A+QlJJgOYG8pOc1k8q+m3OqLBvZGYZjrMdLfjmMgrxv7ddxVOnNCSert1wpYN//oSfBi/BwDln3Cl/AIpuo1rU66T68hlyJZXPuZ+QeCZlXd9mdVg2N725eTNxNHgpQQ41vEyCqDzGMqR+a1RbqInzMub87UD4qJcjuApfP38v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948002; c=relaxed/simple;
	bh=VGs68PfNrarA1kIV4Q3+GneWz66NTWvS2Qg0QV3mnCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2LZFqJHB9uUPNAKOl6fLV1iNYQB1s144RzraUA25MvAAKywOSoT2ZoefPjmmkXAvO7pvdmZ74bxvXcGIVwMXQjru6o4kokzfj1qWqgK1gvh3gvF9UbNY+ddyMmO+atUMV+dSN/IhdbH7DRL0NLnBqw2PZeorXr3CxxNu7rCLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0o6GpUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A34C4CEC9;
	Thu, 29 Aug 2024 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724948002;
	bh=VGs68PfNrarA1kIV4Q3+GneWz66NTWvS2Qg0QV3mnCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P0o6GpUbGD8sx9Ok+rGfmiYrhBg1C8TXmFjhyjkMA7w11yo0dbTIMwgb2dvsXVEDN
	 fI/uAwfcMRI3Af0V1SVibi1nfGb/mwmuuJ5T7vF++fwmcOzejd7qBdP/daQof3hDPy
	 cHNOzX4rvs5YwCxM3iPJxZt+Y/ojAbgPu/bdXrmOT6btLM4V0NY8s4kVgcv1jAYefT
	 896z7BUQjUHsXIeqBwfh24UViZxlNTw3JzQBKETcC42qhZpf3Uml5sdzMNWAxK2I80
	 eqErcgTGwbSyYMlYfaN8YTWKOia+4GDEPyn/1vt6aiFwxAu8XzkFM7BS0tHPKRFGNe
	 1ck9tWIH71Ktw==
Date: Thu, 29 Aug 2024 17:13:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: dt-bindings: Convert mxs-saif.txt to
 fsl,imx28-saif.yaml (imx28 saif)
Message-ID: <20240829-power-traction-01344edc5fed@spud>
References: <20240829102625.3128645-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="flucLSha+vknQX0y"
Content-Disposition: inline
In-Reply-To: <20240829102625.3128645-1-lukma@denx.de>


--flucLSha+vknQX0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 12:26:25PM +0200, Lukasz Majewski wrote:
> The 'fsl,imx28-saif' compatible has already the mxs-saif.txt description.
> This patch converts (and removes it) this file to fsl,imx28-saif.yaml.
>=20
> Changes for the mxs-saif.txt:
> - Adds 'clocks', '#clock-cells' and '#sound-dai-cells' properties
> - Provide device description
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>=20
> ---
> Changes for v4:
> - Change file name to match compatible (fsl,imx28-saif.yaml)
> - Remove 'saif0' and 'saif1' labels as those are not needed in the
>   example node

Hmm, what you've done is not quite what I was suggesting. I was saying
that either you should remove one of the examples entirely, or merge the
two examples retaining the only saif0 label.

With that sorted,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


> +examples:
> +  - |
> +    saif@80042000 {
> +        compatible =3D "fsl,imx28-saif";
> +        reg =3D <0x80042000 2000>;
> +        #sound-dai-cells =3D <0>;
> +        interrupts =3D <59>;
> +        dmas =3D <&dma_apbx 4>;
> +        dma-names =3D "rx-tx";
> +        #clock-cells =3D <0>;
> +        clocks =3D <&clks 53>;
> +    };
> +    saif@80046000 {
> +        compatible =3D "fsl,imx28-saif";
> +        reg =3D <0x80046000 2000>;
> +        #sound-dai-cells =3D <0>;
> +        interrupts =3D <58>;
> +        dmas =3D <&dma_apbx 5>;
> +        dma-names =3D "rx-tx";
> +        clocks =3D <&clks 53>;
> +        fsl,saif-master =3D <&saif0>;
> +    };

--flucLSha+vknQX0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtCeHQAKCRB4tDGHoIJi
0rbiAP9Y7W5F+NPN2JmNH/14k5YrCbeB7Ma9GtGh5Mu/5AE86wD/bYJfDPmUwzxq
VnrDiy27sjxu9PeSf8eyLVHCH6mTRgA=
=Ftps
-----END PGP SIGNATURE-----

--flucLSha+vknQX0y--

