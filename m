Return-Path: <linux-kernel+bounces-317646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC896E169
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC453B234FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3B15ADB4;
	Thu,  5 Sep 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="jjvBAqam"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1013D7464;
	Thu,  5 Sep 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559222; cv=none; b=uwZRkA2DnwJ/oSY7WyGqWDyAoIXYDFfx/aaPNYpnHJj4INBqU593dn+LiSZ8/SlFVpmKL5hG7PPicqPv3Ptuo1UmsJ4aMHGxZ41xvTzyFUMiaI5nn0MHE+Yn/hreDEaMlIRtFTYULBW6gI8TKXW8dAT5Bx3lVhYJNa8cv1Gc3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559222; c=relaxed/simple;
	bh=tcPJ3ojW634v/zUaVsG8PGOkuxZ+rC2Arp2kPscCRcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=hGH4OHoGoAkq3jkzBI569JZIYnrCmVn5SMKvMjqcTGGCZBMg1dWtwCiIYyvixJPjmB56rUgnP8rEEum2IME5ngCm1P2kEe0DLFozAlJtqBorSfpkpWwwFdl8AZ1cMW9c5iebFHn/CEL7PPBhnLvWHbpNjd5IWGpUCJrIlh07ZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=jjvBAqam; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 6073D789EF;
	Fri,  6 Sep 2024 02:00:11 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 6073D789EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725559213;
	bh=IehJ7vYaR/acTX/sHMWsvwZTff/S0qCnA1igWLTgxpU=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=jjvBAqamn4voe/zLDC5EjIJVOsceiErcyffHhgCuRpF1u+6nzqji1jwgcb22URs/2
	 24rLvCkbDxAenXtSkdUSH+bd49BV+/SOhirwrxNE++Sldkud0Q37NmSn83jQHKLrMk
	 eAotb02AjTReCEyIsSWcMrBfTKS8iY/ZakcEgSuc=
Message-ID: <fd4fc7a0-7def-4f91-a64c-71689ff71d1c@classfun.cn>
Date: Fri, 6 Sep 2024 02:01:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Andrew Lunn <andrew@lunn.ch>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
 <20240904111456.87089-4-bigfoot@classfun.cn>
 <6030542f-070d-4d76-9a5a-fbfc6bd433e6@lunn.ch>
 <1e189c70-e677-453d-9e31-6637196c2b5c@classfun.cn>
 <3f5bcc6c-5ee0-4fef-bb58-f7acf9551fc1@lunn.ch>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <3f5bcc6c-5ee0-4fef-bb58-f7acf9551fc1@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/5 20:53, Andrew Lunn wrote:
> On Thu, Sep 05, 2024 at 07:17:03PM +0800, Junhao Xie wrote:
>> On 2024/9/5 01:25, Andrew Lunn wrote:
>>>> +&gmac1 {
>> [...]
>>> This has been discussed a few times. You should be using phy-mode
>>> rgmii-id.
>>
>> After I changed phy-mode to rgmii-id, it seemed to work,
>> but it didn't transmit any data.
>> Maybe I made a mistake or should I continue to use phy-mode rgmii?
> 
> How did you change the rx_delay and tx_delay?
> 
> In general, we want the PHY to add the delay, not the MAC. Most boards
> in Linux do that. But boards using the motocomm PHY have got into a
> cargo cult copy/paste of using the MAC to add the delays.

I have tried rgmii-id with tx_delay/rx_delay 0x38/0x15, or 0x0/0x0,
or directly removed tx_delay/rx_delay, they all didn't transmit data.

I saw in dwmac-rk.c that when using rgmii-id, the tx_delay/rx_delay
properties in dt are ignored?

arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts also
uses YT8521. I added rx-internal-delay-ps and tx-internal-delay-ps
to rgmii_phy1 of mdio1 according to the prompts, and it now works
well using rgmii-id!

&mdio1 {
	rgmii_phy1: ethernet-phy@0 {
		compatible = "ethernet-phy-ieee802.3-c22";
		reg = <0x0>;
		rx-internal-delay-ps = <1500>;
		tx-internal-delay-ps = <1500>;
	};
};

&gmac1 {
	[...]
	phy-mode = "rgmii-id";
	[...]
	tx_delay = <0x0>;
	rx_delay = <0x0>;
	status = "okay";
	/* Motorcomm YT8521SC WAN port */
};

Best regards,
Junhao

