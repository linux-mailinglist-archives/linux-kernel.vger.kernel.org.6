Return-Path: <linux-kernel+bounces-422543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218709D9AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4E31631B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512361D47BB;
	Tue, 26 Nov 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="e+WAFqvs"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37E11187;
	Tue, 26 Nov 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636999; cv=pass; b=cd1UAZ713ZxKx+Ry9XzSodf8E6tlg+cuvorffJO0JUmx7rs/kyM3BxnvX8ZZR5HiFkeUDY+F7Jsg4ljQ1r9yhVR8XrSNZY+96bL9OqkwnJmcxz+XAYsWGDxzlEttHi8eXP7jwXC5THMPeYvQ+O1PahpHcZNppE/Eb9kp1dAg6OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636999; c=relaxed/simple;
	bh=gfn2aJFLh3a4OafyAS1STIKKUMdoKYrs7NXZp23KsEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQMFCHIeGpt4IN7xs2AmFjYDjSK+n/v9EZKk47+WFJzJ70Y/GIh/qe5WlswZ91erR7N20nqpDB6TdMldq0vpnWnXxt2+Gw+pJKYEnyqUhOr9rc6rpi9u/Fp8sT9ScJEgvym5eA9cUXdhkndVzbuL3h9X9DfzdVJVHPg/reHyc4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=e+WAFqvs; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732636971; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fCOspcaM6yPhqjz+SUYSQNLVR26xd+MDfVEMYHbQPrvFJqj5ArPA18mc9Am32b0EoavUTncyV3DLeOB9h0+imz/rscXStXAkTrZeD/6PfLdxKb7r4QqGYVlV+JbN3Zuzbl/09boqNhURkGND5ALrB69jWNY4Nl5i0lHuEs6R3EI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732636971; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+1lCcqDhc3X+5+dzLAMIuYRu0uvJ2mKqZGK05+8cj1Y=; 
	b=fRMWjASLzECAYcReNbRC++32kh2tLRGuNrerhw4hgiG0KbeBjCBQPgNr+t08xQ8z7rF5dlX05RsgjTN3QWthBKy9SotjShlrBnpwP7tP5wOW/SaJIP2evUO15hwKP5rWKzjW6HnWNDX6Q/9IqQXZvNEEY5V3jy7VkSnkKDjovUI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732636971;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+1lCcqDhc3X+5+dzLAMIuYRu0uvJ2mKqZGK05+8cj1Y=;
	b=e+WAFqvsZ+dszmLc48V3Bt9fuXyQ/uDZc0Piz/AlfVMeNvzMjaL4Wje/xYYokQSW
	7oPAU1Mdpaxl7QXzRq0Cr85MCMsF3+jBBZ0+SGlFb+nj9myQd93o1NOBEKXGnB36+PN
	148BNtHb44nKdh9mLDXEXJTdbSp/kbFcIN4/zTlo=
Received: by mx.zohomail.com with SMTPS id 1732636967514808.6210011319688;
	Tue, 26 Nov 2024 08:02:47 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 061E910604CF; Tue, 26 Nov 2024 17:02:43 +0100 (CET)
Date: Tue, 26 Nov 2024 17:02:43 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, dse@thaumatec.com, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: Add Rockchip MIPI C-/D-PHY
 schema
Message-ID: <kalgqphp4qdlzlb43rpxu3o2d7vrnej5xjhe7hgp3zwrbl6gfa@jheymyqgw4ny>
References: <20241126131736.465111-1-heiko@sntech.de>
 <20241126131736.465111-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tnibaswrlt7ffbwn"
Content-Disposition: inline
In-Reply-To: <20241126131736.465111-2-heiko@sntech.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.1/232.605.28
X-ZohoMailClient: External


--tnibaswrlt7ffbwn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: Add Rockchip MIPI C-/D-PHY
 schema
MIME-Version: 1.0

Hi,

On Tue, Nov 26, 2024 at 02:17:34PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> Add dt-binding schema for the MIPI C-/D-PHY found on
> Rockchip RK3588 SoCs.
>=20
> Tested-by: Daniel Semkowicz <dse@thaumatec.com>
> Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588=
-mipi-dcphy.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-d=
cphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcph=
y.yaml
> new file mode 100644
> index 000000000000..c8ff5ba22a86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.ya=
ml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,rk3588-mipi-dcphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip MIPI D-/C-PHY with Samsung IP block
> +
> +maintainers:
> +  - Guochun Huang <hero.huang@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3576-mipi-dcphy
> +      - rockchip,rk3588-mipi-dcphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 1
> +    description: |
> +      Argument is mode to operate in. Supported modes are:
> +        - PHY_TYPE_DPHY
> +        - PHY_TYPE_CPHY
> +      See include/dt-bindings/phy/phy.h for constants.
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: ref
> +
> +  resets:
> +    maxItems: 4
> +
> +  reset-names:
> +    items:
> +      - const: m_phy
> +      - const: apb
> +      - const: grf
> +      - const: s_phy
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the 'mipi dcphy general register fi=
les'.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> +
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      phy@feda0000 {
> +        compatible =3D "rockchip,rk3588-mipi-dcphy";
> +        reg =3D <0x0 0xfeda0000 0x0 0x10000>;
> +        clocks =3D <&cru PCLK_MIPI_DCPHY0>,
> +                 <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>;
> +        clock-names =3D "pclk", "ref";
> +        resets =3D <&cru SRST_M_MIPI_DCPHY0>,
> +                 <&cru SRST_P_MIPI_DCPHY0>,
> +                 <&cru SRST_P_MIPI_DCPHY0_GRF>,
> +                 <&cru SRST_S_MIPI_DCPHY0>;
> +        reset-names =3D "m_phy", "apb", "grf", "s_phy";
> +        rockchip,grf =3D <&mipidcphy0_grf>;
> +        #phy-cells =3D <1>;
> +      };
> +    };
> --=20
> 2.45.2
>=20

--tnibaswrlt7ffbwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdF8R8ACgkQ2O7X88g7
+pocUg/+L8hx7vrrT2ksTCtr5qRsbq1rVu6ecj6wcJsN2PdTrqb146EXfib8wS1r
YFEdEr+oDlFwqQOYFF2eSh4YSaVk9fTuq6QsR+FGCWXxQ+zy11eOteBl4qWDe0f1
dN9MMo+DMUbqTOVdzTO/rW79N7LukovKDNR6R5dnrY6PIvdiJ4GsggMCw9OOE1xB
igc5nWfOjoTmDj3+8LpwCXd5fZt4hj/CJW/ogjKa8Z+pJ6Y/jzb83H8mE6qQb4QT
t+KFiIvR2lcUrWm+wL3fprpIm8B0txUESsw+F4pfm2+2l+IUa/+I4A3/ik9CqQb3
rPK/+Wny6moI2L5XfhG+xSsrUXocGBIkZRal2qpvJhvabgA1mXyeowMT922OazmQ
3w8G82u1A9k76Q992HmBxLFwHmDpQqI1LwaNk9gSrr9WecA65P28yFuUFa4dcF/o
x55W3CdZTVnJBW0MC3mAmHiaUVkFCgOChT+TUPt9T0xbZgLacMEqXGI0sibpL0IK
/u34tb12bdUrmHqUO2XWec1a08+xaJGWrx4z4Cqq9P9eywFTTf0Od2Ft7zFFgkMC
6O06mK4aUXzoyDBsSYslLakfj9jR/RN7KbB4qTr23a8L+AvxbyMVXi+wBfGDA03a
C7oL2vemx22RGx9yH5Bu7GfpfttdpFg+wa4t+0tBjXRln+duCSc=
=+KwH
-----END PGP SIGNATURE-----

--tnibaswrlt7ffbwn--

