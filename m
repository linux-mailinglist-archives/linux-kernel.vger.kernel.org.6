Return-Path: <linux-kernel+bounces-255973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EF5934744
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E991F226BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3F3FBB3;
	Thu, 18 Jul 2024 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KDxGFgBL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB8D8C04;
	Thu, 18 Jul 2024 04:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277998; cv=none; b=eG0ONGtpqFhae3zJnrRfJ64q/6+thqEnneJHYJaUgSnye4IUfp8OHPASvdX43fYLPcmkePy5bitaYzv4SL0kP/2ZSogX+15OIZ5pNEOxbHnb+AoC68Syrtqo3ArvStf5MnkzNCEJw21s4NQmEGb5UOWALyZfO49Ls76ikKX7290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277998; c=relaxed/simple;
	bh=QP4D3BX1OnkIHvOYI5T3eOGiV1AR7OFCUdrV3V75iYI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uBaxT9frYgsMqMbU0bBpXhcjcZMEySK+iGuDsWscwCPXKhVokdv7PWbqjw3D0wf3Y5Xrd3NMMY8sTvXO0+VgsDrrrkbwVMoDqiwli9xYpcW1eKfINcigounBiyDG/YU9cdeP/y0gCiWf1/8blrUCoVaJPeydfYEGsKhRsgPgTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KDxGFgBL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721277993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qd3uHQf3ElXbQbEOOq3qPy+xGLH85gFnWLBiiNOzwi0=;
	b=KDxGFgBLIktO9TmU0MLoT1Yqxmgp6n858buuI5q1lkjj+dtBQzBAUitCnF/9JYqsLsP5nh
	w0Bz1Kl81ntxf0XZMFbymfgj39Y23K4CBaF7xxaQ5XOKWAuxfpVfAJaZUtaiNKq7q5e8kG
	Brkwxshj99m8NYBdzeXPxLXr1BCmEjwA0D5bxytrTNf/tSSV1THDKQdG4+SI8zIjZegI1C
	sbHchyLT3mKlQTyIyrCiTrIb9VNqATBUHtnUggMGhmABh1RjysshnavvKSxze50GIKHFhy
	iJc/hzHak6lFk13RpBEwzM1gRKdMSr9mTW9GxiTUeVLxUNllH5j//pctkCLYAg==
Date: Thu, 18 Jul 2024 06:46:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 imx@lists.linux.dev, loongarch@lists.linux.dev
Subject: Re: [PATCH v1 2/4] ARM: dts: rockchip: remove unlikly-to-exist DAC
 from elgin-r1
In-Reply-To: <9a492f785e0851a828e0864c33204920@manjaro.org>
References: <20240717-anvil-ashy-544e80a1317c@spud>
 <20240717-parrot-malt-83cc04bf6b36@spud>
 <9a492f785e0851a828e0864c33204920@manjaro.org>
Message-ID: <b63ca795e5155dff13b3afa571869ea8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-18 06:20, Dragan Simic wrote:
> Hello Conor,
> 
> On 2024-07-17 11:37, Conor Dooley wrote:
>> From: Conor Dooley <conor.dooley@microchip.com>
>> 
>> The Rohm dh2228fv (really the bh2228fv, the compatible in the kernel 
>> has
>> a typo) does not support frequencies above 10 MHz, nor per the
>> datasheet appear to use either CPOL or CPHA. I suspect that this
>> devicetree is abusing the compatible in order to bind the spidev 
>> driver
>> in Linux. Pretending to have devices on a board for this purpose is 
>> not
>> acceptable, so remove it.
>> 
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> There's a small typo in the patch subject:
> s/unlikly/unlikely/

Ah, sorry for the noise, I see now it's been pointed out already.

>> ---
>> I could not find any documentation for this board online, and it does
>> not blatantly say that the device is a "spidev" like other [ab]users, 
>> so
>> it is possible there's actually a DAC here - but I doubt it is a
>> bh2228fv given the other incompatibilities.
>> ---
>>  arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts | 8 --------
>>  1 file changed, 8 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
>> b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
>> index 2d9994379eb2..9df1cef406c5 100644
>> --- a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
>> +++ b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
>> @@ -167,14 +167,6 @@ &spi {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&spim1_clk &spim1_cs0 &spim1_tx &spim1_rx>;
>>  	status = "okay";
>> -
>> -	dh2228fv: dac@0 {
>> -		compatible = "rohm,dh2228fv";
>> -		reg = <0>;
>> -		spi-max-frequency = <24000000>;
>> -		spi-cpha;
>> -		spi-cpol;
>> -	};
>>  };
>> 
>>  &u2phy {
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

