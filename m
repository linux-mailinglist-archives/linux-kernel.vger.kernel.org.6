Return-Path: <linux-kernel+bounces-398350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEBD9BEFEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90365281E77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72251DEFC7;
	Wed,  6 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="u+LcAaXy"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68C1DE4CA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902641; cv=none; b=HNAdtIZa6UZi7NvEk4mlhxoJDZfwJrSDfdprMSvGOUkV1dGBuAJuM8f7Gb8kouH/wYdXywITK8KUIkjStWrDWfv/7k0jvOYTNJIxi9RHXtCe7atAG5XOXTHMhnUIwxSG+5IyZYJdqJG+8/E3l8kOPxE6w0ss83dKoc9+MoB8Ujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902641; c=relaxed/simple;
	bh=NpkgZ3AmQShEAKcBqcYm6Dkv8MKwesgkNU5p3i63HsU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b0E7/9E0UA9xpQvK5fiKDVRe581MAxyG45eqXDWvldSuyznv0RjtSCGF+8XKzbyhp4Vw7LTlORfIqzsIlZYvS8MCl4VDsgd2WR+o7KWB0V6i3Y6HTM5/jXw3NwspBhFRgrsR4HHre0ysPWdrHOGghulV9jJ5Hx4fvP9xjWJHKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=u+LcAaXy; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1730902636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdmqNqqp4Bk7buEsWzjxk7mkEA62rn6czo4XC8c0f/Q=;
	b=u+LcAaXyxYZ1m5RiP1Q6G4WEQS06mhDv0LvBxdrkpeyfdAWqHbev4lfFLZhV3OrmnQC9vo
	qf3VfilxFSAJEFs3p2N9BlbKWXtgG2PCOUkgkBaj/Fy2fAYk0RyhKT3EYgyN1w6y0Ur9FA
	ht7w0lw1sg8wv2Bl4XQu+kToVM3pK2lYfeaHXZSh1WGj6973fbCUoLLBH3YTZVRx/0WCkq
	rFOYgk8eicCxYfCL5y8xGko3wWZtD8wLtwSkNJdQ28QYRtxfFOKoQK44n592ptKmBnNIM+
	duIlk1CHEAOqUnC3KtcSYxifGZ4qw2Rvl5C9JGfJm+AMeEAc2PpP8QAbb2ddsQ==
Content-Type: multipart/signed;
 boundary=621d1a8e6e304e3c77a7347e6f41048798e325c45aa75fa6ab48b67fb5d0;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 06 Nov 2024 15:17:02 +0100
Message-Id: <D5F5RRFVMP7R.19G82R4S878IL@cknow.org>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <quentin.schulz@cherry.de>, <linux-phy@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Heiko Stuebner" <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY
 schema
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>, <vkoul@kernel.org>,
 <kishon@kernel.org>
References: <20241104111121.99274-1-heiko@sntech.de>
 <20241104111121.99274-2-heiko@sntech.de>
In-Reply-To: <20241104111121.99274-2-heiko@sntech.de>
X-Migadu-Flow: FLOW_OUT

--621d1a8e6e304e3c77a7347e6f41048798e325c45aa75fa6ab48b67fb5d0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Nov 4, 2024 at 12:11 PM CET, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> Add dt-binding schema for the MIPI CSI/DSI PHY found on
> Rockchip RK3588 SoCs.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588=
-mipi-dcphy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-d=
cphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcph=
y.yaml
> new file mode 100644
> index 000000000000..5ee8d7246fa0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.ya=
ml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,rk3588-mipi-dcphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip MIPI CSI/DSI PHY with Samsung IP block
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
> +    const: 0
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

Should this dt-binding have a power-domains property?
RK3588 TRM v1.0 part 1 page 1097 has ALIVE(PD_BUS) for
MIPI_DC_PHY0~MIPI_DC_PHY1

FTR: I made a similar remark on another patch sent by Heiko today. While
that was incorrect, I do think it's appropriate for this binding after
which it could also be added to the respective phy nodes in the dts(i)
file(s).

Cheers,
  Diederik

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
> +        #phy-cells =3D <0>;
> +      };
> +    };


--621d1a8e6e304e3c77a7347e6f41048798e325c45aa75fa6ab48b67fb5d0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZyt6YwAKCRDXblvOeH7b
bi/sAPkBV9EJ6lxI2snofBThwqWbOjtpT4jPd/NnpQy6YWvmEQEAoUUz2gsMxZzy
NTI0fYtiF0lrdWJnjQbXBvaGYJy3jww=
=aVJh
-----END PGP SIGNATURE-----

--621d1a8e6e304e3c77a7347e6f41048798e325c45aa75fa6ab48b67fb5d0--

