Return-Path: <linux-kernel+bounces-262338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB493C440
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4A21C21774
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA319CD17;
	Thu, 25 Jul 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/5cTZXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDA13DDB8;
	Thu, 25 Jul 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918046; cv=none; b=IesbPMoNxkIIuc1245l05MWvKbAGX4Nn4yz6XmJUzwWoS8kMVtIQrj1fLUF/iVgm8JGKHr7WdiTdi//HTcaGTRKk9ZoYQBsMim4wmnfBmZ/L/p+5yyR01BfVHLnP3gBkdM/PMdf9IJOIjiwU07OHmOPwuRGBywkVgkWVl3CU+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918046; c=relaxed/simple;
	bh=lEZEpDvFTWSV2VSZIoUY/qg4sxnX6WaUiNUVms4Rh8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7Jzy/6CqCxxIE5KfVGik0JAhKaD4DOlC3Qgl1e3yLYw5cU5gZpzI02hWRAiOqsfgZ6pdVxf1FqCr1IkWeIkTeaFM8C/QbHy+3cTi506N6sI+3qG+CHYL+FsLM0NEnC2offFxsXQdKEVOYL9mrCEr3To2nYLpzspE4hWSN6C20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/5cTZXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EFEC116B1;
	Thu, 25 Jul 2024 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721918045;
	bh=lEZEpDvFTWSV2VSZIoUY/qg4sxnX6WaUiNUVms4Rh8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/5cTZXm0W/giFyipn0WT+M7ObbIv4K+DDS+TbjlBs0Zi3ydeR+Pm5BVk29d/VMBx
	 3AiT2q9mcnaEA/TXxinbxxGkJt0FYezj+ZZkw14GuYyAtPlR15xoWqgnPVNlqQJQdO
	 vGrpAdNLcRCf9TKg9l8MgxA/7C7O42tt0Is6jZgzPs1xxc1JCKAze9k/NaFdfCn/UW
	 C9QLYLpwgKMJ+OafwVf3bnl6bALPd4XKcmrH4wsIVIlqOGLTaooWXEkX+xJRtSf02d
	 C2jtty14cua2ffVnzI2001wn3Ye0P40KxzwrFyKKl5zzXma87KHdEsvfhaE7Qcw2mU
	 P4HHk5kyVTxrg==
Date: Thu, 25 Jul 2024 15:34:01 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/17] dt-bindings: soc: microchip: mpfs-sys-controller:
 Add PIC64GX compatibility
Message-ID: <20240725-jackpot-tapping-fae83673a04d@spud>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
 <20240725121609.13101-15-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QgTWijV28ZC96G3W"
Content-Disposition: inline
In-Reply-To: <20240725121609.13101-15-pierre-henry.moussay@microchip.com>


--QgTWijV28ZC96G3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 01:16:06PM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX is compatible with mpfs-sys-controller driver without additional
> feature

Bindings are about hardware, not drivers. Are you sure a fallback is
appropriate here? Does the system controller expose the same features as
it does on PolarFire SoC? For example, FPGA reprogramming: the driver
creates a platform device to which the auto update driver is bound - I
don't think that that is appropriate on a pic64gx.

Thanks,
Conor.

>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  .../soc/microchip/microchip,mpfs-sys-controller.yaml        | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mp=
fs-sys-controller.yaml b/Documentation/devicetree/bindings/soc/microchip/mi=
crochip,mpfs-sys-controller.yaml
> index a3fa04f3a1bd..af89d5959747 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-=
controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-=
controller.yaml
> @@ -24,7 +24,11 @@ properties:
>      maxItems: 1
> =20
>    compatible:
> -    const: microchip,mpfs-sys-controller
> +    oneOf:
> +      - items:
> +          - const: microchip,pic64gx-sys-controller
> +          - const: microchip,mpfs-sys-controller
> +      - const: microchip,mpfs-sys-controller
> =20
>    microchip,bitstream-flash:
>      $ref: /schemas/types.yaml#/definitions/phandle
> --=20
> 2.30.2
>=20
>=20

--QgTWijV28ZC96G3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqJiWQAKCRB4tDGHoIJi
0qO/AQDHS4tIeC40U53nkW2mvlvdDVc93b6zd9C2Ij8wPVc5XAD9FE5pgk2AkakY
f2Zrj4sp+eYAE9LaRofUTAh3pniqgAo=
=Ed3R
-----END PGP SIGNATURE-----

--QgTWijV28ZC96G3W--

