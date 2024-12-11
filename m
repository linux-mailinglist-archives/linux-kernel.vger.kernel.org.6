Return-Path: <linux-kernel+bounces-441516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659429ECF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4DD28671D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44251A7ADD;
	Wed, 11 Dec 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gNCgA/hy"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F6618A6B8;
	Wed, 11 Dec 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930566; cv=none; b=sztXzADfO/hA7DrQxeezIhEajOqII1dDJFypTe4cFy7mSr7CbPbggmdu8VOVRqmm1W0ADcBgx66UUPBiI7uhIdmTwmJGHsAi7OMEY7Ijmp+DYE7qVxjmarD/6H2yFbB6bVbyNCh5PVvZ21ThDNUQtMSq5jxb5Sd1tc2gjmxDhsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930566; c=relaxed/simple;
	bh=zuioce9RBN2eCqpRjrFSu/lIfm6co24bgGHCzcFumxw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NVG+6tcFmhwAXnzdMvL0/t5lwG4rWfoDtxfvF+2Ky1T8E4sHDt4tP/oLL5KRBxzKXwrsaFKNTZua8ufo3LQmZQ00vD50x98lGEojI3XJKuFXxSCOwW1VU2eAs/zJTjKO2VzOnmoEnc+JC9MyfGiCO3ja8o8BbeK1WkeRQhlWPWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gNCgA/hy; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733930561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Uz3RBCjW4hTXkTqvJiMamrdz2U3hXjJKipJRlE2Pho=;
	b=gNCgA/hy7bBhuOnxGoWwdf7jTRf+7S40WV/lIzIe9dEO8PvQN08nZJyGZ6pwKzb+G77zp/
	AQHh2jf/b1NUzIT9XrcxXhP3DuB7gpOzsARZ0aPSfjFO78q2M4uJ13vYeZ576zae0huxSK
	kAgSwa+V/SpGVRtipim8PdjrXpiA2A12T08Uks+iVSQ4P6rdaHuIvjngoF9daQrQUHn8TA
	WGXZ6fydRQEFWDjH/aTfpOl3VRCS5cjs6BaCKqZQuzrbfIZAwk8BO1BCKPL7EodglZTRQ2
	IZ5r9dHTzapqitKboIck7M8q7PIoopUX4OEKvmIhI7xW17SLQIrS7TuT8GLWDQ==
Date: Wed, 11 Dec 2024 16:22:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Delete redundant RK3328 GMAC
 stability fixes
In-Reply-To: <CAMdYzYpnx=pHJ+oqshgfZFp=Mfqp3TcMmEForqJ+s9KuhkgnqA@mail.gmail.com>
References: <e00f08d2351e82d6acd56271a68c7ed05b3362e8.1733901896.git.dsimic@manjaro.org>
 <CAMdYzYpnx=pHJ+oqshgfZFp=Mfqp3TcMmEForqJ+s9KuhkgnqA@mail.gmail.com>
Message-ID: <eb3ab82527b8c5bfa746894837661b1a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

On 2024-12-11 12:26, Peter Geis wrote:
> On Wed, Dec 11, 2024 at 2:29 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Since the commit 8a469ee35606 ("arm64: dts: rockchip: Add txpbl node 
>> for
>> RK3399/RK3328"), having "snps,txpbl" properties defined as Ethernet 
>> stability
>> fixes in RK3328-based board dts(i) files is redundant, because that 
>> commit
>> added the required fix to the RK3328 SoC dtsi, so let's delete them.
>> 
>> It has been determined that the Ethernet stability fixes no longer 
>> require
>> the "snps,rxpbl" and "snps,aal" properties, [1] out of which the 
>> latter also
>> induces performance penalties, so let's delete these properties from 
>> the
>> relevant RK3328-based board dts(i) files.
> 
> You may want to include snps,force_thresh_dma_mode in this group such
> as on the rock64. It's even more limiting than snps,aal.
> 
> Otherwise,
> Acked-by: Peter Geis <pgwipeout@gmail.com>

Thanks for your suggestion and review!

I'll add "snps,force_thresh_dma_mode" to the set of redundant DT
properties deleted from RK3328-based board dts(i) files in the v2
of this patch.

>> This commit completes the removal of these redundant "snps,*" 
>> properties
>> that was started by a patch from Peter Geis. [2]
>> 
>> [1] 
>> https://lore.kernel.org/linux-rockchip/CAMdYzYpj3d7Rq0O0QjV4r6HEf_e07R0QAhPT2NheZdQV3TnQ6g@mail.gmail.com/
>> [2] 
>> https://lore.kernel.org/linux-rockchip/20241210013010.81257-7-pgwipeout@gmail.com/
>> 
>> Cc: Peter Geis <pgwipeout@gmail.com>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3328-a1.dts                | 1 -
>>  arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi        | 1 -
>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi | 1 -
>>  arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts         | 3 ---
>>  4 files changed, 6 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
>> index 824183e515da..24baaa7f1d8c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
>> @@ -110,7 +110,6 @@ &gmac2io {
>>         phy-supply = <&vcc_io>;
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&rgmiim1_pins>;
>> -       snps,aal;
>>         snps,pbl = <0x4>;
>>         tx_delay = <0x26>;
>>         rx_delay = <0x11>;
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
>> index f9fab35aed23..d5f129e304e5 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
>> @@ -142,7 +142,6 @@ &gmac2io {
>>         phy-supply = <&vcc_io_33>;
>>         pinctrl-0 = <&rgmiim1_pins>;
>>         pinctrl-names = "default";
>> -       snps,aal;
>> 
>>         mdio {
>>                 compatible = "snps,dwmac-mdio";
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>> index 181ec6de0019..9ec93f61433e 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi
>> @@ -113,7 +113,6 @@ &gmac2io {
>>         phy-supply = <&vcc_io>;
>>         pinctrl-0 = <&rgmiim1_pins>;
>>         pinctrl-names = "default";
>> -       snps,aal;
>> 
>>         mdio {
>>                 compatible = "snps,dwmac-mdio";
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
>> index 3e08e2fd0a78..59dead1cc503 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
>> @@ -153,9 +153,6 @@ &gmac2io {
>>         phy-supply = <&vcc_io>;
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&rgmiim1_pins>;
>> -       snps,aal;
>> -       snps,rxpbl = <0x4>;
>> -       snps,txpbl = <0x4>;
>>         tx_delay = <0x26>;
>>         rx_delay = <0x11>;
>>         status = "okay";

