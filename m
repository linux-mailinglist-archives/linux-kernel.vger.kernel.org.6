Return-Path: <linux-kernel+bounces-439642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E69EB21E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF7616740F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA11AA1E4;
	Tue, 10 Dec 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XFWjja7y"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39023DE8D;
	Tue, 10 Dec 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838259; cv=none; b=J9uBlspRA43xbGTHmmnDwbXViJP1iel/slWPNI+phDXFNbMso8FqZHtm7mf19OFw/2bBAd5rOaGAlQ6s5gwPUpr42lxMUxKQHYkGbdGst0wHX3M2i0HPlCgqpAHmLzn8cPKoY2NEOZCD4kLJFFpkF0JGUAY4QxUT0J0/ubUwYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838259; c=relaxed/simple;
	bh=2i+Wqaw+wIIX5MFAaDkQu6D44GalB4H+uB+VfiJ0IHw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QJBoA8MAtQE7kSEXPvZXlFYxKZSz3dNpkX/iOqi4WSp6gxhkATgmwCTMmf8dvJNst+f8WVuA+389paQ8zUzFSWC9OOJVbELkOzHpO92izzSOnj0vmXzpaBi75K5N7iOyVFpeOIy/u/jad7Iqy8iNsKh/VSg/jod8wSDlKgdMyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XFWjja7y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733838255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HR985HiE65wAXM9O8QvXvTA1gJ8FNQIGOl/hU7K0iww=;
	b=XFWjja7yGGHwKBg/bK2+h1h7SVh2fqrDrWxnE+tVJmxaRVJsqLZ3mtiwtJY3S2u7Z6nKni
	bROXKcLWiD3kioD0yKVuF2TCPoCBR9+cXomUeftaxuwCex6/Y/dgyuAi8TeqGax9dwu438
	rG6imA1HJIVtI7w/34QtStg9qUmod9UIuXm0LRhyS4NB8lE3OdlYk5U0MhYBvn93AReZnI
	oZyJGqmJuQ6eEHbVQ/hplsYZz3OWa6Zt/GoaYA/ImRmI2sNDZIsjGjPoaS4ds1gu56WQTz
	nsERVgGNpU2+SLEOWl468F+JYzPjJzuBxgZ1P/ycA6PDNX/FRoUqg+d9tJ+cqw==
Date: Tue, 10 Dec 2024 14:44:14 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, Johan Jonker <jbx6244@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: dts: rockchip: Remove address aligned beats
 from rk3328-roc
In-Reply-To: <CAMdYzYpj3d7Rq0O0QjV4r6HEf_e07R0QAhPT2NheZdQV3TnQ6g@mail.gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-7-pgwipeout@gmail.com>
 <2b68c2dd3618e5904a4eac1ec87d29a7@manjaro.org>
 <CAMdYzYpj3d7Rq0O0QjV4r6HEf_e07R0QAhPT2NheZdQV3TnQ6g@mail.gmail.com>
Message-ID: <6453e714b2a48572ff1e57cd74b0f6d3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

On 2024-12-10 12:29, Peter Geis wrote:
> On Tue, Dec 10, 2024 at 5:45 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Thanks for the patch.  Please, see some comments below.
>> 
>> On 2024-12-10 02:30, Peter Geis wrote:
>> > Since commit 8a469ee35606 ("arm64: dts: rockchip: Add txpbl node for
>> > RK3399/RK3328"), the snps,aal, snps,txpbl, and snps,rxpbl nodes have
>> > been unnecessary in the separate device trees. There is also a
>> > performance loss to using snps,aal. Remove these from the rk3328-roc
>> > device tree.
>> >
>> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>> >
>> > ---
>> >
>> >  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 3 ---
>> >  1 file changed, 3 deletions(-)
>> >
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
>> > b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
>> > index 6984387ff8b3..0d476cc2144d 100644
>> > --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
>> > @@ -155,12 +155,9 @@ &gmac2io {
>> >       phy-mode = "rgmii";
>> >       pinctrl-names = "default";
>> >       pinctrl-0 = <&rgmiim1_pins>;
>> > -     snps,aal;
>> 
>> Huh, I see that quite a few RK3328 board dts files specify
>> the snps,aal node.  I wonder was it a "cargo cult" approach
>> at play, :) or was there some real need for it?
>> 
>> Actually, I see now that you added snps,aal to rk3328-roc-
>> cc.dts in the commit 393f3875c385 ("arm64: dts: rockchip:
>> improve rk3328-roc-cc rgmii performance."), so I guess that
>> your further research and testing showed that it actually
>> isn't needed for Ethernet stability?
>> 
>> >       snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
>> >       snps,reset-active-low;
>> >       snps,reset-delays-us = <0 10000 50000>;
>> > -     snps,rxpbl = <0x4>;
>> > -     snps,txpbl = <0x4>;
>> 
>> Unless I'm missing something, the commit 8a469ee35606 ("arm64:
>> dts: rockchip: Add txpbl node for RK3399/RK3328") doesn't add
>> the snps,rxpbl node to the RK3328 SoC dtsi, and the respective
>> driver does nothing about it when the snps,txpbl node is found.
>> 
>> Though, I see that rk3328-rock-pi-e.dts is the only other
>> RK3328 board dts file that specifies the snps,rxpbl node, so
>> it seems that removing the snps,rxpbl node here should be safe,
>> especially because it was you who added it in the same commit
>> mentioned above.  If there were some SoC-level issues, all
>> RK3328 boards would've needed it.
> 
> Good Morning,
> 
> You'll notice the author of that patch was me. Setting aal, txpbl, and
> rxpbl was the original fix I came up with for the rk3328, which I
> applied to the only board I had. Someone else later on isolated it
> specifically isolated it to just the txpbl and applied it to both the
> rk3328 and rk3399 directly.
> 
> This was just something that was left hanging after that result.
> 
> Looking at how rk356x was done, I suspect there's an even more elegant
> solution. However I don't have the deep level knowledge nor
> documentation to implement it.

Sure, I noticed that you authored the original Ethernet stability
fix. :)  With all this in mind, please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

and I'll prepare a patch or two that clean up any and all leftovers
in other board dts(i) files.

