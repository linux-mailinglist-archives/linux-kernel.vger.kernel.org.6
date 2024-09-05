Return-Path: <linux-kernel+bounces-316853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2796D63A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEEA1F22038
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C6D1957FC;
	Thu,  5 Sep 2024 10:37:48 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A91990C2;
	Thu,  5 Sep 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532667; cv=none; b=DIp7myBjxvqoQ3jht+XQAjoAc33SpNVu1xN9nmiaQAUcDukkMLaFZ0fJ3MRa2Pxim74x0AJ3IsTTixgC+a8iQkXrXpTRJz/Fx4oYpR7/rTqhtGuX6UT76u3sCWVtmfmal4OkhfZxIHb7KllrccJBfZRGVxFirN/c7ygslPXn68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532667; c=relaxed/simple;
	bh=UKdFntwj2tZYLkndUiE61WGUx3Ut1uVqOBsBQZ/zs+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0aiGjMxb2cX17P+67QsNGUW5hw2robn2c64jbn+SdrG9O7UBpszfPB5xVjxJ6RlDdQOcWfAGBgT6hQYLofAi5k1qZ4wS7u26wwHavU1BCQ6+ZxOtnz7TDcKVVOf88NWdF1KF5i2tHBpginrsVEdIJFCTRPHfbeOC5YXaCU4uqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.212.181])
	by smtp.qiye.163.com (Hmail) with ESMTPA id CD08A7E01C6;
	Thu,  5 Sep 2024 18:01:03 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: bigfoot@classfun.cn
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
Date: Thu,  5 Sep 2024 18:01:00 +0800
Message-Id: <20240905100100.348444-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <010a9c5e-205b-40b9-9655-9e168b2def97@classfun.cn>
References: <010a9c5e-205b-40b9-9655-9e168b2def97@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSExCVkNJGExPSk8dTU5IT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSEpMTElVSktLVU
	pCS0tZBg++
X-HM-Tid: 0a91c1a15f7303a2kunmcd08a7e01c6
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6ASo5DDIxSjopQzQMFxVN
	GEwKCS9VSlVKTElOTkhLT01PTk5LVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpJVUpDSllXWQgBWUFJSU5DNwY+

Hi Junhao,

>>> +	vcc5v0_usb_modem: regulator-5v0-vcc-usb-modem {
>> 
>> Are you sure this regulator is 5v?
>> 
>
> It should actually be 3.3V, I will fix it and rename
> to vcc3v3_usb_modem

I prefer vcc3v3_rf or vcc3v3_ngff,
this is closer to the schematics.

>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pcie30x2m1_pins>;
>> 
>> These are actually pcie30x1m0_pins.
>
> pcie30x1m0_pins seems to conflict with sdmmc0,
> I changed it to pcie30x1m1_pins

This is obviously incorrect. I didn't notice that
your pinctrl for sdmmc0 is wrong.
(Because the cd pin are different)
The sdmmc0 node should be like this:

&sdmmc0 {
	bus-width = <4>;
	cap-sd-highspeed;
	cd-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
	disable-wp;
	no-1-8-v;
	pinctrl-names = "default";
	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
	vmmc-supply = <&vcc3v3_sd>;
	vqmmc-supply = <&vcc_3v3>;
	status = "okay";
};

-- 
2.25.1


