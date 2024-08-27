Return-Path: <linux-kernel+bounces-302955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A55960584
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79795B20DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE7D19D8BC;
	Tue, 27 Aug 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="IOctj9bc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="n2hg5nkM"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41A19D08C;
	Tue, 27 Aug 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750809; cv=none; b=DxM63PR1nF/D1HlA46C6pqH/CzYoXJUCWEPCP5klblElANmZErl6P3qrsQW0yHSZCH/HmdnZ6c8LCtYrOPGyzSxZVv/cKjnu88dJ4o9Edc5YlZdNgH7Qj/1aHhryWuU0NIC+Iz9Fl25V4gSli+3weTAD8BXTsXpp0jAO7+X4oQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750809; c=relaxed/simple;
	bh=UDRP4r33WtAS3KsxOcMqryONWSRC5BkeVu8ptDjKkck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0VZtoCsCK/6MSSANg2sYoETZ8A8ZnHBRyl7U92MbSei+F2vbIZQUk2nCJKdsWoyG5Y+qo5JRYzZ3ScDScBxjd90uu8rhlZ52zqF9N2pgH0Nnuyl9azVCJlipqi8vI+/GVHmELJciwFvf4SJqyjgidmAJYRJflD8zOKgfJisIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=IOctj9bc; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=n2hg5nkM reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724750806; x=1756286806;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HbHMnhmSfCRd88c0KjBICB/dfGqR3IKQq27lrb2HhHs=;
  b=IOctj9bcBMRd0ecia58EMqAvmbpQ4LoVANeXQHiMymRYiYywalbr+sJh
   ps0UjIsEF6V+dUF0HoyHP05HzXz9DX/SLtV8R3Lk/zgjdbmzhUsKgWSzt
   6UZ+xOD4Uko3RjRG/VkmksJDJXMBj8Tp5ec7/CaWqNmZoDJXBIpbhJZ2y
   vVUQfSKhjgo37NghetFsGaretKL3yiEXb2Jk9nKSu/guvKS9SL1SwLiYK
   tMNimS2FO2jgGJVrnnkFbmtbEAXbypUz2lkzP4CVarYdPZZEmqeo2tiSA
   xluVAHFUpVedyA5DVd2aaO2j5bSbhVry34hVwt6AVO4XTpK/L1tFIsRkN
   g==;
X-CSE-ConnectionGUID: QeZSJHYeQxCYyBkPMBHAnQ==
X-CSE-MsgGUID: zp4VRWHZTwqpksyLMxqTZw==
X-IronPort-AV: E=Sophos;i="6.10,180,1719871200"; 
   d="scan'208";a="38606643"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 Aug 2024 11:26:43 +0200
X-CheckPoint: {66CD9BD3-21-C661815F-E221238E}
X-MAIL-CPID: F2D5354ACF64A8CE6E7F8487621163CB_1
X-Control-Analysis: str=0001.0A782F21.66CD9BD3.008A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26E80160BFB;
	Tue, 27 Aug 2024 11:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724750799;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HbHMnhmSfCRd88c0KjBICB/dfGqR3IKQq27lrb2HhHs=;
	b=n2hg5nkMugkVEP4dJ3OoBmlXS1Re8qCU7rpAyXXwRE32w5nBA+3w5kZOxF9p4EKqXu38QB
	7wP2kvpdb+RG7K3m+v8bLYPmH+YQA/YEuaMu0XDCbFu26tDN1KxQsUwlEsP9qJIKy59612
	65lwTnl2UF1OeUnS/klsEieYS5kt0gZIvBU2yZ626moZ0cIY8pjfLLAAjMl6Uqgbh1aCNJ
	KXTn+OZn72e2UW/sxjjI7d37BRYn1bDPhQGjUj5w570lyqZOxqm+Mpli1YIKRau1rGglJX
	GyzZsuuBbkrCVZfH2kZ4fHqXWZyUYTxvgv/dRmPCZVIaT7hR5SFl1yvbi9tb0A==
Message-ID: <cecf4ff63f440b41fda3b7302be8ccc4e39436e1.camel@ew.tq-group.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default
 at SoC level
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Logan Bristol <logan.bristol@utexas.edu>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Josua Mayer <josua@solid-run.com>, Matt McKee <mmckee@phytec.com>, Wadim
 Egorov <w.egorov@phytec.de>, linux@ew.tq-group.com,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 27 Aug 2024 11:26:36 +0200
In-Reply-To: <20240809135753.1186-1-logan.bristol@utexas.edu>
References: <20240809135753.1186-1-logan.bristol@utexas.edu>
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

On Fri, 2024-08-09 at 08:57 -0500, Logan Bristol wrote:
>=20
> External interfaces should be disabled at the SoC DTSI level, since
> the node is incomplete. Disable Ethernet switch and ports in SoC DTSI=20
> and enable them in the board DTS. If the board DTS includes a SoM DTSI=
=20
> that completes the node description, enable the Ethernet switch and ports=
=20
> in SoM DTSI.
>=20
> Reflect this change in SoM DTSIs by removing ethernet port disable.
>=20
> Signed-off-by: Logan Bristol <logan.bristol@utexas.edu>

For the TQMa64xxL:

Acked-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>


> ---
> Changes since v1:
> - Enabled cpsw3g and cpsw_port1 in SoM DTSI instead of board DTS
> if board DTS included SoM DTSI
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 3 +++
>  arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi        | 6 ++----
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts                | 3 +++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts                 | 3 +++
>  arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi            | 6 ++----
>  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts | 6 ++----
>  6 files changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/d=
ts/ti/k3-am64-main.dtsi
> index f8370dd03350..69c5af58b727 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -677,6 +677,7 @@ cpsw3g: ethernet@8000000 {
>  		assigned-clock-parents =3D <&k3_clks 13 9>;
>  		clock-names =3D "fck";
>  		power-domains =3D <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
> +		status =3D "disabled";
> =20
>  		dmas =3D <&main_pktdma 0xC500 15>,
>  		       <&main_pktdma 0xC501 15>,
> @@ -701,6 +702,7 @@ cpsw_port1: port@1 {
>  				phys =3D <&phy_gmii_sel 1>;
>  				mac-address =3D [00 00 00 00 00 00];
>  				ti,syscon-efuse =3D <&main_conf 0x200>;
> +				status =3D "disabled";
>  			};
> =20
>  			cpsw_port2: port@2 {
> @@ -709,6 +711,7 @@ cpsw_port2: port@2 {
>  				label =3D "port2";
>  				phys =3D <&phy_gmii_sel 2>;
>  				mac-address =3D [00 00 00 00 00 00];
> +				status =3D "disabled";
>  			};
>  		};
> =20
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64=
/boot/dts/ti/k3-am64-phycore-som.dtsi
> index ea7c58fb67e2..6bece2fb4e95 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -185,6 +185,7 @@ AM64X_IOPAD(0x0278, PIN_INPUT, 7)	/* (C19) EXTINTn.GP=
IO1_70 */
>  &cpsw3g {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&cpsw_rgmii1_pins_default>;
> +	status =3D "okay";
>  };
> =20
>  &cpsw3g_mdio {
> @@ -208,10 +209,7 @@ cpsw3g_phy1: ethernet-phy@1 {
>  &cpsw_port1 {
>  	phy-mode =3D "rgmii-rxid";
>  	phy-handle =3D <&cpsw3g_phy1>;
> -};
> -
> -&cpsw_port2 {
> -	status =3D "disabled";
> +	status =3D "okay";
>  };
> =20
>  &mailbox0_cluster2 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dt=
s/ti/k3-am642-evm.dts
> index 6bb1ad2e56ec..82da21bd9aea 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -616,17 +616,20 @@ &cpsw3g {
>  	bootph-all;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&rgmii1_pins_default>, <&rgmii2_pins_default>;
> +	status =3D "okay";
>  };
> =20
>  &cpsw_port1 {
>  	bootph-all;
>  	phy-mode =3D "rgmii-rxid";
>  	phy-handle =3D <&cpsw3g_phy0>;
> +	status =3D "okay";
>  };
> =20
>  &cpsw_port2 {
>  	phy-mode =3D "rgmii-rxid";
>  	phy-handle =3D <&cpsw3g_phy3>;
> +	status =3D "okay";
>  };
> =20
>  &cpsw3g_mdio {
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts=
/ti/k3-am642-sk.dts
> index 44ecbcf1c844..86369525259c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -527,16 +527,19 @@ &usb0 {
>  &cpsw3g {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&rgmii1_pins_default>, <&rgmii2_pins_default>;
> +	status =3D "okay";
>  };
> =20
>  &cpsw_port1 {
>  	phy-mode =3D "rgmii-rxid";
>  	phy-handle =3D <&cpsw3g_phy0>;
> +	status =3D "okay";
>  };
> =20
>  &cpsw_port2 {
>  	phy-mode =3D "rgmii-rxid";
>  	phy-handle =3D <&cpsw3g_phy1>;
> +	status =3D "okay";
>  };
> =20
>  &cpsw3g_mdio {
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boo=
t/dts/ti/k3-am642-sr-som.dtsi
> index c19d0b8bbf0f..a5cec9a07510 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> @@ -177,6 +177,7 @@ vdd_mmc0: regulator-vdd-mmc0 {
>  &cpsw3g {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&rgmii1_default_pins>;
> +	status =3D "okay";
>  };
> =20
>  &cpsw3g_mdio {
> @@ -210,10 +211,7 @@ ethernet_phy0: ethernet-phy@0 {
>  &cpsw_port1 {
>  	phy-mode =3D "rgmii-id";
>  	phy-handle =3D <&ethernet_phy0>;
> -};
> -
> -&cpsw_port2 {
> -	status =3D "disabled";
> +	status =3D "okay";
>  };
> =20
>  &icssg1_mdio {
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arc=
h/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> index c40ad67cee01..8d7a0283c391 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> @@ -119,15 +119,13 @@ reg_sd: regulator-sd {
>  &cpsw3g {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&cpsw_pins>;
> +	status =3D "okay";
>  };
> =20
>  &cpsw_port1 {
>  	phy-mode =3D "rgmii-rxid";
>  	phy-handle =3D <&cpsw3g_phy0>;
> -};
> -
> -&cpsw_port2 {
> -	status =3D "disabled";
> +	status =3D "okay";
>  };
> =20
>  &cpsw3g_mdio {

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

