Return-Path: <linux-kernel+bounces-316374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D3F96CEB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398832886F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E4188A2E;
	Thu,  5 Sep 2024 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="pOSwJcGU"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A0621;
	Thu,  5 Sep 2024 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515182; cv=none; b=kvzz5sHdyssj5l720vC0IZr4HeDn3o7IboWALLJUVDXvPAoChsUJkAh/Gpl4nJzxS7oceknuaxlTLuH2sfA0GK4wmqCgdM72WZmB1Dg2Af0diJnxIJONV/lX5uwLcZ/BQtsO2uEuimISh8A1yAB7QAtzPXQbibJoIAiEM/X0L3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515182; c=relaxed/simple;
	bh=gkFqSe+yBFPGJXWtoklPb7SbaLVqLrf51WcVPND+b7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MvGpxuH9uv6u8D+CsANbcjewntKHkTS8xLq9sbOMRrFedaKNz+Mr3f+lM8fBlg7vgjLkIyYRT3wORo5RfhSFH/ArpftVW/rxE6hNfVr2/cGiIcZsF6WmmJslBPyqYzmtk6ElCnO8yy0iLyiCZDmzmQqCnxr4sf2TvQXrshylJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=pOSwJcGU; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 6A515789E8;
	Thu,  5 Sep 2024 13:46:16 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 6A515789E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725515177;
	bh=OomeZ9C2cFgTv1cxVJuJnlf6/kevrKyeiis7TxIKY9E=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=pOSwJcGUoHKIga3h/dzUVuC7Hlob0YbYxP2libUjLtR7gccsntnxeclKTQXqLTlt0
	 x8Ts+NgEq7Nh4GSzZTneHc6iw1lYV0311U86Bn9HbLd+HjI2ZKX1hW0KV2Epxe4Ipg
	 +opWaUEe8X731Hx5/z4lNmxfAHUCVwQioi2XSU58=
Message-ID: <a39de56d-07d3-4554-8c37-c28b1654f717@classfun.cn>
Date: Thu, 5 Sep 2024 13:47:42 +0800
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
Content-Language: en-US
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <6030542f-070d-4d76-9a5a-fbfc6bd433e6@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/5 01:25, Andrew Lunn wrote:
>> +&gmac1 {
>> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
>> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
>> +	assigned-clock-rates = <0>, <125000000>;
>> +	clock_in_out = "output";
>> +	phy-handle = <&rgmii_phy1>;
>> +	phy-mode = "rgmii";
>> +	phy-supply = <&vcc_3v3>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&gmac1m1_miim
>> +		     &gmac1m1_tx_bus2
>> +		     &gmac1m1_rx_bus2
>> +		     &gmac1m1_rgmii_clk
>> +		     &gmac1m1_rgmii_bus>;
>> +	snps,reset-gpio = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
>> +	snps,reset-active-low;
>> +	snps,reset-delays-us = <0 20000 100000>;
>> +	tx_delay = <0x38>;
>> +	rx_delay = <0x15>;
>> +	status = "okay";
> 
> This has been discussed a few times. You should be using phy-mode
> rgmii-id.
> 
> arch/arm/boot/dts/rockchip/rk3288-phycore-som.dtsi is i think also a
> YT8521SC.
> 
> 	Andrew

Thanks, I changed phy-mode to rgmii-id and it seems to work fine.

Best regards,
Junhao

