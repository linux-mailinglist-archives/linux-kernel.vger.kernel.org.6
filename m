Return-Path: <linux-kernel+bounces-277860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F11394A767
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103941C221D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DDD1E4EF8;
	Wed,  7 Aug 2024 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="nKvkCsU9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DrPBJIj+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33448170A3C;
	Wed,  7 Aug 2024 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032166; cv=none; b=qK/wJDTHtbW2iQe2q6zxKNi+dkS2oH8/Ckysg1EYUeOO5HME6u+6QyQn7b0EuDfEZr03R7tp//SfgLbrTSpHrR+mH0w3I2878sgkPg7kNVUra00xnhGpaZ1o4MEESMBASShik5EVQcySbrbARreMfk0yIPjkyCwQxR5fF9qdd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032166; c=relaxed/simple;
	bh=yQLljePOq0ZeNtDR82G0GP/1YaGQzLG7Ca+MWIA2vbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S46OA2EYKiR9w3bG7zkmoiUJwsI0qDcQIV6C/mhh1LXPMzNbMBmKKZkm8axURCNFgSr7OhFJGyYdKMJFsfauBmzb/dJKt7xCrTeMDHz8yjOrRUwbmzavtZLUsA0qkadQtXuXOXk1u+fCyaePj4XjNqa7w4Jj9TTQSvLjoEeIeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=nKvkCsU9; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DrPBJIj+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723032162; x=1754568162;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0dGVeIdnZcM/ava6YXX97/p5JKL+8vDWt/yvdqWWqbY=;
  b=nKvkCsU9tKL+gi7BxDyFBEJBLiNqZ/gxaS/HBfbKoXuDVEWOfJYrDTR9
   otyRFHXelYh9kc8YpZsJL8J/KlT8vs5TMb/GwSi11m9SuJ357uJAlxz2+
   U1hM5kxejb2grrIXgmRbDoQIh3hMrLTrTgvz3GlZQtMlp+t0Y4c9g3xzT
   4rsBvkWWksCAqDYvcGZXamEAg0vTV0ys+fwmIUtt+3AqHaArYGCXK9JT4
   eRMdzC/cNolEzU/VMcPuL2EQpVDwJaU+9B9b4fDOUCoF6rHyh5twV/uHM
   /KWoUq2+7YuOII887ikSHp0sF94xJvCOsOIaEACaLiY5tAx7lFTSLCviF
   g==;
X-CSE-ConnectionGUID: 0G0zU+/AQjyxyQuTkKR5jA==
X-CSE-MsgGUID: rcIyTL/WRsSizLlTFtuJzQ==
X-IronPort-AV: E=Sophos;i="6.09,269,1716242400"; 
   d="scan'208";a="38292389"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Aug 2024 14:02:39 +0200
X-CheckPoint: {66B3625F-17-19675C26-FC5C2C95}
X-MAIL-CPID: 56EB0EF9813749536DB1D636FA9CF9AB_3
X-Control-Analysis: str=0001.0A782F21.66B3625F.0182,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5EFE167653;
	Wed,  7 Aug 2024 14:02:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723032155;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0dGVeIdnZcM/ava6YXX97/p5JKL+8vDWt/yvdqWWqbY=;
	b=DrPBJIj+MnNVgOtfHP+sUqMexfUZTRvzz6tsX0EcENHRatbscDgl5df2bNDjU5JRQB2WdH
	WGYfjJPgpTur4holInSdw4Ttp08LTDNEQDejL/VCJ9om5YdDA5N6Wb2Wz+Qu5XmxvrNpno
	4wZV2xR96j//3PCaGLFbHTTtl4QURWdiZwpalc3JN8lLRobkc5aEm/LtTl7SbpeuOQ0uSB
	0hmHwJSBDlkfOZpCqCVEbFgx6IaAHo7IX4LDjGyDiy6SbEp0nr5dUxBE50lCpReFPWmz9a
	j0p5CQ6sugVzWUPS2bf7zOlWvbqSB/UFfh0rkzZ/Z/CxcqsA4kbxVNRhoGoptw==
Message-ID: <3bce26bc327b4d1c63bf0ef32caae854893969a0.camel@ew.tq-group.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-tqma64xxl-mbax4xxl: add PRU
 Ethernet support
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
	Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com
Date: Wed, 07 Aug 2024 14:02:34 +0200
In-Reply-To: <20240624134235.202243-1-matthias.schiffer@ew.tq-group.com>
References: <20240624134235.202243-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 2024-06-24 at 15:42 +0200, Matthias Schiffer wrote:
> Add PRU Ethernet controller and PHY nodes, as it was previously done for
> the AM64x EVM Device Trees.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>=20
> v2:
> - Dropped binding change patch
> - Moved prueth device node to DTS toplevel, matching the AM64x EVM
> - Update firmware filenames to match EVM

Hi, are there any issues remaining with this patch?

Best,
Matthias


>=20
>  .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arc=
h/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> index 1f4dc5ad1696a..204f5e48a9c63 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> @@ -24,6 +24,8 @@ / {
> =20
>  	aliases {
>  		ethernet0 =3D &cpsw_port1;
> +		ethernet1 =3D &icssg1_emac0;
> +		ethernet2 =3D &icssg1_emac1;
>  		i2c1 =3D &mcu_i2c0;
>  		mmc1 =3D &sdhci1;
>  		serial0 =3D &mcu_uart0;
> @@ -71,6 +73,66 @@ led-1 {
>  		};
>  	};
> =20
> +	icssg1_eth: icssg1-eth {
> +		compatible =3D "ti,am642-icssg-prueth";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pru_icssg1_rgmii1_pins>, <&pru_icssg1_rgmii2_pins>;
> +		interrupt-parent =3D <&icssg1_intc>;
> +		interrupts =3D <24 0 2>, <25 1 3>;
> +		interrupt-names =3D "tx_ts0", "tx_ts1";
> +		dmas =3D <&main_pktdma 0xc200 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
> +		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
> +		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
> +		dma-names =3D "tx0-0", "tx0-1", "tx0-2", "tx0-3",
> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
> +			    "rx0", "rx1";
> +		sram =3D <&oc_sram>;
> +		firmware-name =3D "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
> +		ti,prus =3D <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, =
<&tx_pru1_1>;
> +		ti,pruss-gp-mux-sel =3D <2>,	/* MII mode */
> +				      <2>,
> +				      <2>,
> +				      <2>,	/* MII mode */
> +				      <2>,
> +				      <2>;
> +		ti,mii-g-rt =3D <&icssg1_mii_g_rt>;
> +		ti,mii-rt =3D <&icssg1_mii_rt>;
> +		ti,iep =3D <&icssg1_iep0>,  <&icssg1_iep1>;
> +
> +		ethernet-ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			icssg1_emac0: port@0 {
> +				reg =3D <0>;
> +				phy-handle =3D <&icssg1_phy0c>;
> +				phy-mode =3D "rgmii-id";
> +				/* Filled in by bootloader */
> +				local-mac-address =3D [00 00 00 00 00 00];
> +			};
> +
> +			icssg1_emac1: port@1 {
> +				reg =3D <1>;
> +				phy-handle =3D <&icssg1_phy03>;
> +				phy-mode =3D "rgmii-id";
> +				/* Filled in by bootloader */
> +				local-mac-address =3D [00 00 00 00 00 00];
> +			};
> +		};
> +	};
> +
>  	fan0: pwm-fan {
>  		compatible =3D "pwm-fan";
>  		pinctrl-names =3D "default";
> @@ -154,6 +216,42 @@ &epwm5 {
>  	status =3D "okay";
>  };
> =20
> +&icssg1_mdio {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pru_icssg1_mdio_pins>;
> +	status =3D "okay";
> +
> +	/* phy-mode is fixed up to rgmii-rxid by prueth driver to account for
> +	 * the SoC integration, so the only rx-internal-delay and no
> +	 * tx-internal-delay is set for the PHYs.
> +	 */
> +
> +	icssg1_phy03: ethernet-phy@3 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <0x3>;
> +		reset-gpios =3D <&main_gpio1 47 GPIO_ACTIVE_LOW>;
> +		reset-assert-us =3D <1000>;
> +		reset-deassert-us =3D <1000>;
> +		ti,rx-fifo-depth =3D <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,tx-fifo-depth =3D <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,rx-internal-delay =3D <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,clk-output-sel =3D <DP83867_CLK_O_SEL_OFF>;
> +	};
> +
> +	icssg1_phy0c: ethernet-phy@c {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <0xc>;
> +		reset-gpios =3D <&main_gpio1 51 GPIO_ACTIVE_LOW>;
> +		reset-assert-us =3D <1000>;
> +		reset-deassert-us =3D <1000>;
> +		ti,rx-fifo-depth =3D <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,tx-fifo-depth =3D <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,rx-internal-delay =3D <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,clk-output-sel =3D <DP83867_CLK_O_SEL_OFF>;
> +	};
> +};
> +
> +
>  &main_gpio0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&main_gpio0_digital_pins>,

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

