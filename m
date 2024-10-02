Return-Path: <linux-kernel+bounces-346949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083FB98CB56
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E7F1C227C7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ADCC2F2;
	Wed,  2 Oct 2024 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jZ5Ityfj"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521B23CE;
	Wed,  2 Oct 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727837152; cv=none; b=aoXeWzOnEE7MBr7o/0AzMKQO8be79iK+8Lri4t/VtuOS7f+jytdfFo77hf5RCYn5NQRiB/V9RSjt4MSrpJPdTHn6/bHON1NmcwguWN3phuWgHYOcwSA7z1G7kO5DPbsa4+Ao7/oQHqaL0qnJ8OjOQ8IdhH/s/OMCJ58hiT6uM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727837152; c=relaxed/simple;
	bh=jWZ6RdC0I62902PjQu11rJ+CA5NZHRH00CZoAstycUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYGNV6RNV0pF0LXM8K4oKVc7Qvq98UcttSBmYAEylWxpvWSwqWcTNplrZ1g8BA0+/AYsFEuP8Ny5rJnb7GStkWY1FSyJcaQES4M2jaHOKIblLmTj/FE/hCY9Lt0ZPct+rJ2dCaNvx2Ff8QirSlnYFbfEYzMDrOvi/WGrOZebvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jZ5Ityfj; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727837144;
	bh=ZUn9UovPgHmeFFF+zpOHis/BLdKXh4bjjfAz3/zpkgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jZ5ItyfjzqHkHG4BJI0XaEm5VX2scMBhebfeXRkfxMNTrPj32sSp2GZq3PgfolvSJ
	 iLUeicqHmM4RE/mIeOjNwdHrJVoXM+DItiSnxU8F2M0Z+B0C8OwNsaiuBnMmaL8A4c
	 ht4M4PjWdlVEqc03BlIUbwf14Ohd8TwbcSnraWOTX49gx0X4aSeeVUUAjc98ag2Y4M
	 m1t/qZ3uJHJsdzE+jnIaTW1Kx633YCyMCPlse1XROs4TLTW4Brylmr5oFRMQTOUBq6
	 R+pW3ivP3sAhrMTdFwlbeymtepypAwbufkz3Lx1SfBbZQBS6iHNOaFqNiXB61tB/6u
	 ISKt5NCWru9tA==
Received: from [192.168.68.112] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F237964BDC;
	Wed,  2 Oct 2024 10:45:43 +0800 (AWST)
Message-ID: <965d0f005ed9a36eeaefe69d897cad44839d06cc.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: nuvoton: Add UDC nodes
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "William A. Kennington III" <william@wkennington.com>, Tomer Maimon
	 <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 02 Oct 2024 12:15:43 +0930
In-Reply-To: <20240925093956.2449119-1-william@wkennington.com>
References: <20240925093956.2449119-1-william@wkennington.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi William,

On Wed, 2024-09-25 at 02:39 -0700, William A. Kennington III wrote:
> The driver support was already added but we are missing the nodes in our
> common devicetree. This enables npcm7xx platforms to enable the udc
> nodes and expose USB devices endpoints.
>=20
> Signed-off-by: William A. Kennington III <william@wkennington.com>
> ---
>  .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   | 71 +++++++++++++++++++
>  .../arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi | 65 +++++++++++++++++
>  2 files changed, 136 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch=
/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> index 868454ae6bde..358b52894ac0 100644
> --- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> @@ -99,6 +99,11 @@ rst: rst@801000 {
>  		};
>  	};
> =20
> +	udc0_phy: usb-phy {
> +		compatible =3D "usb-nop-xceiv";
> +		#phy-cells =3D <0>;
> +	};
> +
>  	ahb {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <1>;
> @@ -179,6 +184,72 @@ fiux: spi@fb001000 {
>  			status =3D "disabled";
>  		};
> =20
> +		udc5: udc@f0835000 {

Testing this with `make CHECK_DTBS=3Dy nuvoton/nuvoton-npcm750-evb.dtb`
causes the following additional warning:

+/home/andrew/src/kernel.org/linux/origin/build.multi_v5/arch/arm/boot/dts/=
nuvoton/nuvoton-npcm750-evb.dtb: udc@f0835000: $nodename:0: 'udc@f0835000' =
does not match '^usb(@.*)?'
+       from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#

This is the same for all the other nodes added.

Can you please fix that up in a v2?

Andrew

> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0xf0835000 0x1000
> +			       0xfffd2800 0x800>;
> +			interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
> +
> +		udc6: udc@f0836000 {
> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0xf0836000 0x1000
> +			       0xfffd3000 0x800>;
> +			interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
> +
> +		udc7: udc@f0837000 {
> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0xf0837000 0x1000
> +			       0xfffd3800 0x800>;
> +			interrupts =3D <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
> +
> +		udc8: udc@f0838000 {
> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0xf0838000 0x1000
> +			       0xfffd4000 0x800>;
> +			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
> +
> +		udc9: udc@f0839000 {
> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0xf0839000 0x1000
> +			       0xfffd4800 0x800>;
> +			interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			nuvoton,sysgcr =3D <&gcr>;
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
> +
>  		apb {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi b/arch/arm/bo=
ot/dts/nuvoton/nuvoton-npcm750.dtsi
> index 30eed40b89b5..00615e7d1462 100644
> --- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
> +++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
> @@ -58,5 +58,70 @@ gmac1: eth@f0804000 {
>  					&rg2mdio_pins>;
>  			status =3D "disabled";
>  		};
> +
> +		udc0:udc@f0830000 {
> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0x0 0xf0830000 0x0 0x1000
> +			       0x0 0xfffeb000 0x0 0x800>;
> +			interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
> +
> +		udc1:udc@f0831000 {
> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0x0 0xf0831000 0x0 0x1000
> +			       0x0 0xfffeb800 0x0 0x800>;
> +			interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
> +
> +		udc2:udc@f0832000 {
> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0x0 0xf0832000 0x0 0x1000
> +			       0x0 0xfffec000 0x0 0x800>;
> +			interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
> +
> +		udc3:udc@f0833000 {
> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0x0 0xf0833000 0x0 0x1000
> +			       0x0 0xfffec800 0x0 0x800>;
> +			interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
> +
> +		udc4:udc@f0834000 {
> +			compatible =3D "nuvoton,npcm750-udc";
> +			reg =3D <0x0 0xf0834000 0x0 0x1000
> +			       0x0 0xfffed000 0x0 0x800>;
> +			interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk NPCM7XX_CLK_SU>;
> +			clock-names =3D "clk_usb_bridge";
> +			phys =3D <&udc0_phy>;
> +			phy_type =3D "utmi_wide";
> +			dr_mode =3D "peripheral";
> +			status =3D "disabled";
> +		};
>  	};
>  };


