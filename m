Return-Path: <linux-kernel+bounces-335109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E49497E11D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80C34B20D96
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA2D193090;
	Sun, 22 Sep 2024 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="OrivOjv+"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141361FCF;
	Sun, 22 Sep 2024 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004275; cv=none; b=HXiYc/Tx/y5wKtNChifWc+PL6CaYvljb6tw7Zuc5uw7uQQV4bm6zTR0YuWzUkzLByX6PehIC7iZ8H7+oZEJ/ZcCSCQh+SBtbbOI3FhLVpKclhi7NfwzoryFXIQyvG+mpAf+AmWFdSMXljzNrYXHl/e0Jkb5BZpN7KmSs/hH+FAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004275; c=relaxed/simple;
	bh=PdsQMQGmT7S3q7vRRbZgj/Q1BEDtZ7Zx9OcJloNKkBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpA+9eoJidh0WOemWww7zQkqXJVY25feBjFHq7iw8+jCKQ9UnriildIUIl+024olYAnS+Yad/2wHdnE0k1bY5sX26dlJMP44RuFEPZcF5fAqfY43d0xMPd2kBjlcref8WunohkGIl5xsdL8HqVY9NXwEZhrQHvt3NHsbRIJVlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=OrivOjv+; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
Date: Sun, 22 Sep 2024 14:24:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1727004269; bh=aE57zikAciRYqk7E2pLxdAkKeLP7zXYKYE2wvhY4tbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OrivOjv+IdY/elb73qwBqyr+8eP3hg15N81trSdorH0QcVIqUopN/c3OPsWOqqp1C
	 zfAHUX4bZS5qgyb/+DcpD4C4fniJcnEK2dOCbZ65LnnsJgP8jxbJ4mwZcw5oZBa8Lk
	 llJb8J6kWulBHU1I4BUd8wwWB2kR3xNHP4+Zp98Y=
From: Florian Klink <flokli@flokli.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Kever Yang <kever.yang@rock-chips.com>, =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>, 
	FUKAUMI Naoki <naoki@radxa.com>, Muhammed Efe Cetin <efectn@protonmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable automatic fan control on
 Orange Pi 5+
Message-ID: <2u67umujpui4w6b2aut6ugsuknigky2jahcyhslkzi3f2u4onh@epwsqmjnvmvp>
References: <20240921183810.225322-1-flokli@flokli.de>
 <d90eae7de77a77f023d995c4cc5d6c42@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d90eae7de77a77f023d995c4cc5d6c42@manjaro.org>

Thanks, addressed that in the v2.

On Sat, Sep 21, 2024 at 11:42:43PM GMT, Dragan Simic wrote:
>Hello Florian,
>
>Thanks for the patch.  Please, see a comment below.
>
>On 2024-09-21 20:38, Florian Klink wrote:
>>This links the PWM fan on Orange Pi 5+ as an active cooling device
>>managed automatically by the thermal subsystem, with a target SoC
>>temperature of 65C and a minimum-spin interval from 55C to 65C to
>>ensure airflow when the system gets warm.
>>
>>This is pretty much the same as '4a152231b050 ("arm64: dts: rockchip:
>>enable automatic fan control on Rock 5B")', except for the Orange Pi
>>5+ board.
>>
>>Signed-off-by: Florian Klink <flokli@flokli.de>
>>---
>> .../dts/rockchip/rk3588-orangepi-5-plus.dts   | 30 +++++++++++++++++++
>> 1 file changed, 30 insertions(+)
>>
>>diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
>>b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
>>index e74871491ef5..8569e862b6ee 100644
>>--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
>>+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
>>@@ -351,6 +351,36 @@ &i2s2m0_sdi
>> 	status = "okay";
>> };
>>
>>+&package_thermal {
>>+	polling-delay = <1000>;
>>+
>>+	trips {
>>+		package_fan0: package-fan0 {
>>+			temperature = <55000>;
>>+			hysteresis = <2000>;
>>+			type = "active";
>>+		};
>>+
>>+		package_fan1: package-fan1 {
>>+			temperature = <65000>;
>>+			hysteresis = <2000>;
>>+			type = "active";
>>+		};
>>+	};
>>+
>>+	cooling-maps {
>>+		map1 {
>>+			trip = <&package_fan0>;
>>+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
>>+		};
>>+
>>+		map2 {
>>+			trip = <&package_fan1>;
>>+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
>>+		};
>
>These two cooling maps should be named map0 and map1 instead, i.e.
>their numbering shoud start from zero, because there are no package
>cooling maps in the parent dtsi file(s).
>
>Having them named map1 and map2 in rk3588-rock-5b.dts was a small
>mistake that slipped by somehow, and I've already submitted a small
>patch [1] that fixes that mistake.
>
>[1] https://lore.kernel.org/linux-rockchip/335ecd5841ab55f333e17bb391d0e1264fac257b.1726954592.git.dsimic@manjaro.org/T/#u
>
>>+	};
>>+};
>>+
>> /* phy1 - M.KEY socket */
>> &pcie2x1l0 {
>> 	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;

-- 
Florian Klink

