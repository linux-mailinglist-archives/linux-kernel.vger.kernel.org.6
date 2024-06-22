Return-Path: <linux-kernel+bounces-225672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63E913389
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B511C211B0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28A9156227;
	Sat, 22 Jun 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOua7w1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22418155A4E;
	Sat, 22 Jun 2024 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719056937; cv=none; b=PnF9qXrbDJH0dPFLJcGf3j1YBiAAtqIx3g8BL5nik1Ztzd4d3kkmTm2+NTOo3WOwvXdkia85wdILbBgKXuWEQX6I1PPLtBtgTtcW4Dr9NkMcgNPToaPMb68X4r2ef+u8APIxzs0XOmlUTplkm7QMJdK68Wlf9B3AoJrhBDqnvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719056937; c=relaxed/simple;
	bh=ycYR6RgvC3MBo4/lPj6Mic3f9+6aISTwD7s1PJyIcIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOybyetXnR4Pv9EWOd9L5SxU1cqIHP5JF7cFhrpIbizJiaH2/RoxMZTcynwYqCD1AwQbtV+OCbTCKV8iNxdnnTbYfi6yexjZevtnWVkBfWuYBdo4a6x5LoxzZ34kfMHc2ANhBhdoBpwaF6Snumipz45p4t1OxOduP8HpeQbWA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOua7w1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BAFC4AF07;
	Sat, 22 Jun 2024 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719056936;
	bh=ycYR6RgvC3MBo4/lPj6Mic3f9+6aISTwD7s1PJyIcIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOua7w1rGbD4pNxk2rr4aTjZ4Iazzkai0LNh2cgtOa6iKBKSfe0IEp9nKQuHP0P44
	 vtHfYV1m/Q7CVs2zGEY9HpL58ltLYyebnwmzLuK49dit+MpP/XWJSg1ubZ3zzCedBv
	 NXaOQUQeQdzmTUzdcAvW0d58LOXdh0a7TcSmztXWhb9L75HxXMCLc2qinO8KDHT41a
	 sLceQRYbIMLcsyEReUU0HgSD8a15mqk5heCmdFXNIWOAPfZR+73IOr7QXLxi6QvsU0
	 9DFnCdRRwAgBLn2PMqjYBESfOApjibeFt8QS+Z/Ha06QblrOxkX1Zr2nNlDrMnYA8X
	 9bZXfLB6EgCbw==
Date: Sat, 22 Jun 2024 12:48:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: nvmem: sfp: add child node unique-id
Message-ID: <20240622-tux-jelly-b71418bfb210@spud>
References: <20240621165637.2283864-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nlKWlZIIeVfxKBNc"
Content-Disposition: inline
In-Reply-To: <20240621165637.2283864-1-Frank.Li@nxp.com>


--nlKWlZIIeVfxKBNc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:56:37PM -0400, Frank Li wrote:
> Add child node unique-id to fix below CHECK_DTBS warning.
> efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was=
 unexpected)

That's not sufficient justification. Why is this even needed? What can't
it be determined from a compatible etc? Just because it slipped into a
dts doesn't mean you get to avoid the usual requirements for justifying
new properties.

Thanks,
Conor.

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/nvmem/fsl,layerscape-sfp.yaml      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.y=
aml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> index 70fb2ad251037..8c0bdaab711a7 100644
> --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> @@ -42,6 +42,23 @@ properties:
>        The regulator for the TA_PROG_SFP pin. It will be enabled for prog=
ramming
>        and disabled for reading.
> =20
> +patternProperties:
> +  '^unique-id@[0-9a-f]*$':
> +    type: object
> +    description:
> +      Chip unique id.
> +
> +    properties:
> +      reg:
> +        description:
> +          Byte offset where the unique id is stored
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.34.1
>=20

--nlKWlZIIeVfxKBNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZna6JAAKCRB4tDGHoIJi
0s7IAP9R3xEkVEPGfGoOEMr7n0RGOe6Yivcz12l5u1R86e/AugEAqdenStzGWNQH
jaislPaIQUR/rfvJGkVEDuU8mDI7/Q4=
=s6aX
-----END PGP SIGNATURE-----

--nlKWlZIIeVfxKBNc--

