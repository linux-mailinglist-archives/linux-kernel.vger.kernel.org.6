Return-Path: <linux-kernel+bounces-272171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05688945816
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3784A1C23D00
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED6E481DB;
	Fri,  2 Aug 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MxtqBcEA"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99294134B6;
	Fri,  2 Aug 2024 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722580615; cv=none; b=D5Id/LEGoxPUr7D0ZEAUQ8c0NnqNe0LFHRhUxPXEF7ECaqO03TjaM4pX4xT3ZyJP9g1trOLElJJuC2+Xc05/SLLKu9a2odn4mJl3HX7XBEk0ousO2pFyIolMBX8la50786hbcGOquOxPvAoTFMnvKFpVpvcphXMa6KrfUeycTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722580615; c=relaxed/simple;
	bh=kSS14MYRKNfUcQXgALz3pJHNOCn7+YfGkQK3nekdriI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UaJvf2IixPm4y7a2HfVQ+E0uqF+MFW2GztHy0akeO2TBcXopxOTpkBPNPAcRSi5LkPmIWeXR5Wz96j4fg56JBB+HAmkrGTInINDIz51zL02GNFdpnF+QzYCIUTyuFSQDeTwunYZ/mHadDMopWmcQ2nmFTaszLU1IkiCauC6LRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MxtqBcEA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722580611;
	bh=Of1XQj/7J9HzKpXSbYLjUaisLnBd/UQhz1by2QoX/5c=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=MxtqBcEATo0dGOTgctGcB6bOQvpEkAMPyBrwIu6xtPH9/21QZTVJbdkqAEWgE9EuT
	 d5cyH/eAhSTka6Y49yPXuH+uWDNhIYrYm1i2RmSVLHsYXWHY+8TLpZ4XN36EF0NfX/
	 zZtyjTPSZ5Zc/MuxmfM2ob7YSYBszFARDBfFboUbA+YfpNd8IoFABDaUYldr4btgAM
	 9zLeK+1LuLBoOmyFrFt7WRbqW2Jnv2G1av0XmYe0Fi6tLyTqBP8gCj1sQvREnJAJBm
	 h/k4AciM7MwmQz+7RLOB0tpL312Zpdzpn01JezLMe+qsV8M8ktUS4hev83ch4ZIsTO
	 KgplzLHHIvG7A==
Received: from [192.168.68.112] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1638D65665;
	Fri,  2 Aug 2024 14:36:49 +0800 (AWST)
Message-ID: <7bf4cb57f2b0b41c79f2efea3e0b0211988c0896.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 02/11] ARM: dts: aspeed: Harma: add VR device
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 02 Aug 2024 16:06:47 +0930
In-Reply-To: <20240801160136.1281291-3-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
	 <20240801160136.1281291-3-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-02 at 00:01 +0800, Peter Yin wrote:
> Add isl69260, xdpe152c4 device
>=20
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arc=
h/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> index d99fba321379..8fb30029e46c 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -398,6 +398,30 @@ imux28: i2c@0 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0>;
> +			power-monitor@61 {
> +				compatible =3D "isil,isl69260";
> +				reg =3D <0x61>;
> +			};
> +			power-monitor@62 {
> +				compatible =3D "isil,isl69260";
> +				reg =3D <0x62>;
> +			};
> +			power-monitor@63 {
> +				compatible =3D "isil,isl69260";
> +				reg =3D <0x63>;
> +			};

As of v6.11-rc1 this gives me:

```
$ ./scripts/checkpatch.pl --strict -g HEAD
...
WARNING: DT compatible string "isil,isl69260" appears un-documented -- chec=
k ./Documentation/devicetree/bindings/
#24: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:402:
+                               compatible =3D "isil,isl69260";

WARNING: DT compatible string "isil,isl69260" appears un-documented -- chec=
k ./Documentation/devicetree/bindings/
#28: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:406:
+                               compatible =3D "isil,isl69260";

WARNING: DT compatible string "isil,isl69260" appears un-documented -- chec=
k ./Documentation/devicetree/bindings/
#32: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:410:
+                               compatible =3D "isil,isl69260";

total: 0 errors, 3 warnings, 0 checks, 30 lines checked
```

and

```
$ make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-harma.dtb 2>&1 | grep isil
...
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a0=
00/i2c@700/i2c-mux@70/i2c@0/power-monitor@61: failed to match any schema wi=
th compatible: ['isil,isl69260']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a0=
00/i2c@700/i2c-mux@70/i2c@0/power-monitor@62: failed to match any schema wi=
th compatible: ['isil,isl69260']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a0=
00/i2c@700/i2c-mux@70/i2c@0/power-monitor@63: failed to match any schema wi=
th compatible: ['isil,isl69260']
```

While there's already an Aspeed-based Quanta platform that also
specifies this device, let's not add to the problems of the Aspeed
devicetrees.

Please make sure to run `make dtbs_check ...` and checkpatch on your
changes. Regarding `make dtbs_check` and related tests, this blog post
is helpful:

https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sourc=
es-with-the-devicetree-schema/

Andrew

