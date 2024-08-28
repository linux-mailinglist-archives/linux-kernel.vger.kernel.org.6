Return-Path: <linux-kernel+bounces-305352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57627962D54
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0811C2178C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A61A3BB3;
	Wed, 28 Aug 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guNWp2bD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288941760;
	Wed, 28 Aug 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861478; cv=none; b=Jepy5uggcns8qdmw+l1OZVsjKSADh8/+RiiP8BjM64X81e9j1mQa8mTmGSL0A0L0RMyd87NlqJNqKVJ5MBybo+zoxIaQVYOjd85bH0LS6heAbG6hwWJSfI+CoWecjglwhYVfWVsw92dqLJrR099/P5yhO1lcw+fs2QbFbemdDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861478; c=relaxed/simple;
	bh=9CtFrh3gKyelJvHQtwXVoL7gTTFZNFMEbrIHkpQX020=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/RzoCMQeOnGR2hpSG00hirfPoX/m+LJV/okOBi+y/BYnYLTDo/Vfz51NC3BEJVJcbUVSnxfsnShmuW3sIxU2gUH9FHKL+h8gub04IAFRiukabptMHRe2YRM9xUhd5NLvuKDVMWYHm51MYVmgdiIN6EF9mX+RFdVAoLbDVFMv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guNWp2bD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC89C4CABF;
	Wed, 28 Aug 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724861477;
	bh=9CtFrh3gKyelJvHQtwXVoL7gTTFZNFMEbrIHkpQX020=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guNWp2bD47/n92FQffLtDnx3F/38XLD7Q9FpHV2RCXj3jzotPNdPUO5BN+pHTfu69
	 EW4MmLD5CEf3UXMqKMeS6UDdhEH2v6vFNL0fsdGp1Iz+Qgb0+IIa0pfk2D4yuHTXFF
	 6LJhk6iD+rWsuaQ67bNl8uKCVi2ykNQLf9Ibmu5j9HqHq7/2aEvHeRRMphWNlobXkP
	 WkgcHxUTV+M2fC0FlDCqLN4IcEHUU2M5OCSaBiBuyYkx3NRAxMOjdvryiHPNYxtmy6
	 LDID3U86Onq4+mMmfPEqQRnguSDzZYjCBP8ugKTLsAktMs35GZMxKn9Ym3aygxWYij
	 C1I9T80hbocoQ==
Date: Wed, 28 Aug 2024 17:11:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v4 1/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
Message-ID: <20240828-handsfree-overarch-cd1af26cb0c5@spud>
References: <20240828143452.1407532-1-christian.bruel@foss.st.com>
 <20240828143452.1407532-2-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZqexDgeCbf5zKW3c"
Content-Disposition: inline
In-Reply-To: <20240828143452.1407532-2-christian.bruel@foss.st.com>


--ZqexDgeCbf5zKW3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 04:34:48PM +0200, Christian Bruel wrote:
> Document the bindings for STM32 COMBOPHY interface, used to support
> the PCIe and USB3 stm32mp25 drivers.
> Following entries can be used to tune caracterisation parameters
>  - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
> to tune the impedance and voltage swing using discrete simulation results
>  - st,rx-equalizer register to set the internal rx equalizer filter value.
>=20
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/phy/st,stm32mp25-combophy.yaml   | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/st,stm32mp25-co=
mbophy.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.=
yaml b/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
> new file mode 100644
> index 000000000000..8d4a40b94507
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/st,stm32mp25-combophy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32MP25 USB3/PCIe COMBOPHY
> +
> +maintainers:
> +  - Christian Bruel <christian.bruel@foss.st.com>
> +
> +description:
> +  Single lane PHY shared (exclusive) between the USB3 and PCIe controlle=
rs.
> +  Supports 5Gbit/s for USB3 and PCIe gen2 or 2.5Gbit/s for PCIe gen1.
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-combophy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 1
> +
> +  clocks:
> +    minItems: 2
> +    items:
> +      - description: apb Bus clock mandatory to access registers.
> +      - description: ker Internal RCC reference clock for USB3 or PCIe
> +      - description: pad Optional on board clock input for PCIe only. Ty=
pically an
> +                     external 100Mhz oscillator wired on dedicated CLKIN=
 pad. Used as reference
> +                     clock input instead of the ker
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: apb
> +      - const: ker
> +      - const: pad
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: phy
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt used for wakeup
> +
> +  access-controllers:
> +    minItems: 1
> +    maxItems: 2

Can you please describe the items here?

> +  st,syscfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the SYSCON entry required for configuring PC=
Ie
> +      or USB3.

Why is a phandle required for this lookup, rather than doing it by
compatible?

> +
> +  st,ssc-on:
> +    type: boolean

flag, not boolean, for presence based stuff. And in the driver,
s/of_property_read_bool/of_property_present/.

> +    description:
> +      A boolean property whose presence indicates that the SSC for commo=
n clock
> +      needs to be set.

And what, may I ask, does "SSC" mean? "Common clock" is also a bit of a
"linuxism", what does this actually do in the hardware block?

> +
> +  st,rx-equalizer:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    default: 2
> +    description:
> +      A 3 bit value to tune the RX fixed equalizer setting for optimal e=
ye compliance
> +
> +  st,output-micro-ohms:
> +    minimum: 3999000
> +    maximum: 6090000
> +    default: 4968000
> +    description:
> +      A value property to tune the Single Ended Output Impedance, simula=
tions results
> +      at 25C for a VDDP=3D0.8V. The hardware accepts discrete values in =
this range.
> +
> +  st,output-vswing-microvolt:
> +    minimum: 442000
> +    maximum: 803000
> +    default: 803000
> +    description:
> +      A value property in microvolt to tune the Single Ended Output Volt=
age Swing to change the
> +      Vlo, Vhi for a VDDP =3D 0.8V. The hardware accepts discrete values=
 in this range.
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - reg
> +  - resets
> +  - reset-names
> +  - st,syscfg

The order here should reflect the ordering in a node, so compatible and
reg first, rather than sorted alphanumerically.=20

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +
> +    combophy: phy@480c0000 {

You can drop the label here, it ain't used by anything.

Cheers,
Conor.

> +        compatible =3D "st,stm32mp25-combophy";
> +        reg =3D <0x480c0000 0x1000>;
> +        #phy-cells =3D <1>;
> +        clocks =3D <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>;
> +        clock-names =3D "apb", "ker";
> +        resets =3D <&rcc USB3PCIEPHY_R>;
> +        reset-names =3D "phy";
> +        st,syscfg =3D <&syscfg>;
> +        access-controllers =3D <&rifsc 67>;
> +        power-domains =3D <&CLUSTER_PD>;
> +        wakeup-source;
> +        interrupts-extended =3D <&exti1 45 IRQ_TYPE_EDGE_FALLING>;
> +    };
> +...
> --=20
> 2.34.1
>=20

--ZqexDgeCbf5zKW3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs9MIAAKCRB4tDGHoIJi
0rh1AQCPLBp07OqC6pb/M6pgsgJC3wD1Sth/EdmLd/aA+HbfbQD/UrdgsGoXy9Qq
CdxZUx/rJtHiFAP20+3XyjwVb1Gy1gU=
=onYf
-----END PGP SIGNATURE-----

--ZqexDgeCbf5zKW3c--

