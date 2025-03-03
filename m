Return-Path: <linux-kernel+bounces-541953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29007A4C3C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874B2170E24
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A5D212FA7;
	Mon,  3 Mar 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iPeLLtCh"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B012FF69;
	Mon,  3 Mar 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013217; cv=none; b=eds85E/Zf3fJC32xxUjamYhaPaCfraHOrK/sLlLeN/XhQ0+vAq1tBceVBvtq+cDP5KxdPj1pIDjKAe8vyv/QD0N/EV3q1aAIM7sBlHbury7hvUD1xWAGMVHpQ4x2ZrVBGQKn52m+WBRvqKYh/kKjZHNorQeShsGl6YILv7na3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013217; c=relaxed/simple;
	bh=uOkNJShwAnnQjzv5uTkb6RbGAT1W+BW1BZGlsBZodTQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=A+KIKzdhoj3QbqEADSljTLiUBh59nq2uWA8H7V5VRgNni+YjNfU0YEVMa2LDP8om9nAntbQiwdxRt1HsW+Kn8R3oYnhcBaiLSfPRrTkCpfUU7xY4LM+6MBkTUL81yqcfLEj3fPwQAi1CH8JsoRrGiix6tYSacJUs+QwQuqdZOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iPeLLtCh; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53A77441B6;
	Mon,  3 Mar 2025 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741013214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDbYOoICs0kyLksCA3nSrPEKG2UdDgw1p8IdLbEdbwc=;
	b=iPeLLtChV/otssqNfOVqg/51Ax+8DPi61GCdSSCQbbagWxWJzYEBg3l40sx0HR8vL/FcjN
	YPIEIj6U1vkI4upDHidgNQ8e9Km2WBlAReRsXPJxC6DxRxONNNmoAjW2I8Nj6LwQeuTNOC
	Wp7lHluAeJ1lNWyGcUxejLyptqDRAs0cf6rFgciBihlwxe93sVob+FFtyJKPLOQ03LmlMT
	KYqihn5tiLeSwsYURXSt8/wjPhVCWBBFSAtZ3uiGZDGFeDKhl9lH91V5qHQBHpwEazfZiT
	JLeeuw63SVObqVR4c3RoHvK63HYEZuxBeTemjsouNPpS75JnLjMVgF3p2R7DCA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Mar 2025 15:46:52 +0100
Message-Id: <D86POCANGF07.3HE2LVK396FGX@bootlin.com>
To: "Shawn Guo" <shawnguo2@yeah.net>
Subject: Re: [PATCH v2 2/3] ARM: dts: imx6ul: Add Variscite VAR-SOM-MX6UL
 SoM support
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Shawn Guo"
 <shawnguo@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250127-varsom6ul-concerto-dts-v2-0-4dac29256989@bootlin.com>
 <20250127-varsom6ul-concerto-dts-v2-2-4dac29256989@bootlin.com>
 <Z7njGg4Hhc4wcZHU@dragon>
In-Reply-To: <Z7njGg4Hhc4wcZHU@dragon>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffvufevhffofhgjsehtqhertdertdejnecuhfhrohhmpedftehnthhonhhinhcuifhouggrrhgufdcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjedtteejveetjedtgfektddvvdduueevffetieejteegfeeitdekjeeufeduheejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehledphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehshhgrfihnghhuohdvseihvggrhhdrnhgvthdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgp
 dhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshdrhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com

Hi Shawn,

On Sat Feb 22, 2025 at 3:45 PM CET, Shawn Guo wrote:
[...]
>> +	reg_gpio_dvfs: reg-gpio-dvfs {
>> +		compatible =3D "regulator-gpio";
>> +		regulator-min-microvolt =3D <1300000>;
>> +		regulator-max-microvolt =3D <1400000>;
>> +		regulator-name =3D "gpio_dvfs";
>> +		regulator-type =3D "voltage";
>> +		gpios =3D <&gpio4 13 GPIO_ACTIVE_HIGH>;
>
> Don't we need 'enable-active-high'?

I am not specifying 'enable-gpios' but 'gpios' here so from my understandin=
g of
gpio-regulator.yaml and examples from other device trees I don't think so.

>> +		states =3D <1300000 0x1 1400000 0x0>;
>> +	};
>> +
>> +	rmii_ref_clk: rmii-ref-clk-grp {
>
> What does "-grp" in node name mean?

A mistake on my side, I will rename the label to "rmii-ref-clk".

>> +		compatible =3D "fixed-clock";
>> +		clock-output-names =3D "rmii-ref";
>> +	};
>> +};
>> +
>> +&cpu0 {
>> +	dc-supply =3D <&reg_gpio_dvfs>;
>> +};
>> +
>> +&clks {
>> +	assigned-clocks =3D <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
>> +	assigned-clock-rates =3D <786432000>;
>> +};
>> +
>> +&fec1 {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&pinctrl_enet1>, <&pinctrl_enet1_gpio>, <&pinctrl_enet1=
_mdio>;
>> +	phy-mode =3D "rmii";
>> +	phy-reset-gpios =3D <&gpio5 0 GPIO_ACTIVE_LOW>;
>> +	phy-reset-duration =3D <100>;
>> +	phy-handle =3D <&ethphy0>;
>> +	status =3D "okay";
>> +
>> +	mdio {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +
>> +		ethphy0: ethernet-phy@1 {
>> +			compatible =3D "ethernet-phy-ieee802.3-c22";
>> +			micrel,rmii-reference-clock-select-25-mhz =3D <1>;
>> +			micrel,led-mode =3D <1>;
>> +			clocks =3D <&rmii_ref_clk>;
>> +			clock-names =3D "rmii-ref";
>> +			reg =3D <1>;
>
> We generally sort properties like:
>
>   - compatible
>   - reg
>   - generic ones
>   - vendor prefixed ones
>
> So in this case, we will get:
>
> 	compatible =3D "ethernet-phy-ieee802.3-c22";
> 	reg =3D <1>;
> 	clocks =3D <&rmii_ref_clk>;
> 	clock-names =3D "rmii-ref";
> 	micrel,rmii-reference-clock-select-25-mhz =3D <1>;
> 	micrel,led-mode =3D <1>;

Thanks for clarifying that! I will revise this for the next version.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

