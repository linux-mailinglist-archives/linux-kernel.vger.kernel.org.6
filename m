Return-Path: <linux-kernel+bounces-440868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC649EC5A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B54E168A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959E1C5F00;
	Wed, 11 Dec 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AGNzhKLH"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E22451E2;
	Wed, 11 Dec 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902384; cv=none; b=VqpmElCTSKJAxPSA4NtEDpdeCVuCNAqkN+f3yJlLYwHXiT5fkEUufdxqKTZb/IeIuXkGchuNFEcyBOvJYQdkE+M6Rip6YrGHlJWdrMqlHA+ba1cjs2OixFMaBQYiZBEg4zcYK4qKwFQG2EnUuoXHIaNrbXZDlM93MdZQ3oCJl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902384; c=relaxed/simple;
	bh=jv1ykba7aAvYtqI7J1T1gzpTrUEZqie7aIx4CiLCR00=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lJH+G5n0HQ2pvfqaGVFcKRMJPojIthYFtc9Qa9mwWacLJGZxJ3NCWoTfBCiEPo9Ro57uA4FCZynKnXCtIyw92Q8IfUimDWHenjcg/Bp0NcIKBEDtH92Mgl2cao48VTr+4rbHrOhne2tR+JimmO53yVMrky5KUTBVgspc/LUw3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AGNzhKLH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733902380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gz2g2xIWCKvpFm2gjUfw/XeL0J0V+9S7un6UZm1EU7U=;
	b=AGNzhKLHPaRUqC8zvMa2lNnnBRGsufL9vRHOj2JBd+HHGLWgwbudx7p/s4W8CbwlrA/1sl
	oI27U/WZOQtaKal39CTZbi/YBfzcMrOxE/U8UHSNnbT6sQHX+qYIcgDjhPQtS21Gytn8V9
	H5JHgbyhH1jkOdEOKOpg8oeWRDvJ23VHTJfoZvp3vF97Xk7U+uXdz0UVJ/g2J8+Kutlr8y
	PfO4R5+xakcYmM4tNKkv/QOBTiFJkQyyy27T9YjOA++rqLiau5Y9uflW3fed2Kt6olmyvK
	Uc8qBcPvCiU0xnGyJjn3KyrpJ2XJIrX+gHO5iWkN3twWVVN4wDV4u3XQm0iVDw==
Date: Wed, 11 Dec 2024 08:33:00 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, Johan Jonker <jbx6244@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: dts: rockchip: Remove address aligned beats
 from rk3328-roc
In-Reply-To: <6453e714b2a48572ff1e57cd74b0f6d3@manjaro.org>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-7-pgwipeout@gmail.com>
 <2b68c2dd3618e5904a4eac1ec87d29a7@manjaro.org>
 <CAMdYzYpj3d7Rq0O0QjV4r6HEf_e07R0QAhPT2NheZdQV3TnQ6g@mail.gmail.com>
 <6453e714b2a48572ff1e57cd74b0f6d3@manjaro.org>
Message-ID: <e30217fec525af2a3b0e9752b0d1ea31@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-12-10 14:44, Dragan Simic wrote:
> On 2024-12-10 12:29, Peter Geis wrote:
>> On Tue, Dec 10, 2024 at 5:45 AM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>>> Thanks for the patch.  Please, see some comments below.
>>> 
>>> On 2024-12-10 02:30, Peter Geis wrote:
>>> > Since commit 8a469ee35606 ("arm64: dts: rockchip: Add txpbl node for
>>> > RK3399/RK3328"), the snps,aal, snps,txpbl, and snps,rxpbl nodes have
>>> > been unnecessary in the separate device trees. There is also a
>>> > performance loss to using snps,aal. Remove these from the rk3328-roc
>>> > device tree.
>>> >
>>> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>> >
>>> > ---
>>> >
>>> >  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 3 ---
>>> >  1 file changed, 3 deletions(-)
>>> >
>>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
>>> > b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
>>> > index 6984387ff8b3..0d476cc2144d 100644
>>> > --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
>>> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
>>> > @@ -155,12 +155,9 @@ &gmac2io {
>>> >       phy-mode = "rgmii";
>>> >       pinctrl-names = "default";
>>> >       pinctrl-0 = <&rgmiim1_pins>;
>>> > -     snps,aal;
>>> 
>>> Huh, I see that quite a few RK3328 board dts files specify
>>> the snps,aal node.  I wonder was it a "cargo cult" approach
>>> at play, :) or was there some real need for it?
>>> 
>>> Actually, I see now that you added snps,aal to rk3328-roc-
>>> cc.dts in the commit 393f3875c385 ("arm64: dts: rockchip:
>>> improve rk3328-roc-cc rgmii performance."), so I guess that
>>> your further research and testing showed that it actually
>>> isn't needed for Ethernet stability?
>>> 
>>> >       snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>>> >       snps,reset-active-low;
>>> >       snps,reset-delays-us = <0 10000 50000>;
>>> > -     snps,rxpbl = <0x4>;
>>> > -     snps,txpbl = <0x4>;
>>> 
>>> Unless I'm missing something, the commit 8a469ee35606 ("arm64:
>>> dts: rockchip: Add txpbl node for RK3399/RK3328") doesn't add
>>> the snps,rxpbl node to the RK3328 SoC dtsi, and the respective
>>> driver does nothing about it when the snps,txpbl node is found.
>>> 
>>> Though, I see that rk3328-rock-pi-e.dts is the only other
>>> RK3328 board dts file that specifies the snps,rxpbl node, so
>>> it seems that removing the snps,rxpbl node here should be safe,
>>> especially because it was you who added it in the same commit
>>> mentioned above.  If there were some SoC-level issues, all
>>> RK3328 boards would've needed it.
>> 
>> Good Morning,
>> 
>> You'll notice the author of that patch was me. Setting aal, txpbl, and
>> rxpbl was the original fix I came up with for the rk3328, which I
>> applied to the only board I had. Someone else later on isolated it
>> specifically isolated it to just the txpbl and applied it to both the
>> rk3328 and rk3399 directly.
>> 
>> This was just something that was left hanging after that result.
>> 
>> Looking at how rk356x was done, I suspect there's an even more elegant
>> solution. However I don't have the deep level knowledge nor
>> documentation to implement it.
> 
> Sure, I noticed that you authored the original Ethernet stability
> fix. :)  With all this in mind, please feel free to include
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
> and I'll prepare a patch or two that clean up any and all leftovers
> in other board dts(i) files.

For future reference, to help anyone going through the mailing-list
archive, here's a link to the above-mentioned cleanup patch:

https://lore.kernel.org/linux-rockchip/e00f08d2351e82d6acd56271a68c7ed05b3362e8.1733901896.git.dsimic@manjaro.org/T/#u

