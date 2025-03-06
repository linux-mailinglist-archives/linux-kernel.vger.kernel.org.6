Return-Path: <linux-kernel+bounces-550044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2817A55AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D6B7A8C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B327E1A5;
	Thu,  6 Mar 2025 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="WA/pWion"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36704202F7C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302325; cv=none; b=hLIAcVrVtcfIyJR8vNRNtfgFdTu2WYw7uxXfQtVA4Ew4kvnzJfpotVEQ3+BkgsN68LisgjPuTyI2orvUg4BsgPr+U5Gsvjgdv8SW5KTU8OR2ihoxVvOUtbrSLgOnGVq4tTAL2FbNRJZZ7U8sCfmHba1mbv5fRXW9N9fGzQnWx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302325; c=relaxed/simple;
	bh=EZGzd3T+RgSTpfJaTVDNflKItXooQ8kT+ZR71uJB8Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9bJ3wOdwtG75cq801lNvyVmq7DPTVKAiQhdAMnNZCqD77iXQoyCvjRNsnXX3RzE6Yia/HuJ30aD98vgYWJ7sX1Z34zzNXoS3aQRXhshtCULXhvx0OVe9ULaLw3XZFnbgRDBoHaSo58xUNGAyKXCf1HfNfxZaVYlcmSEU9N17XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=WA/pWion; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741302323;
 bh=KZTIdA/6vSHu0RdazPPShQ5lrtgQuHNfhrr/whN+ZAg=;
 b=WA/pWionz1F1FHSIz+dfv7jmomL1Y/AkWtp9mh/gaPWC/H40hwFc9SHWJ2NYRDAiSE78r5Sja
 +k5qhHCuW2UUoOiGSzbxOAWymtkA7UQ9mjC3rLzXNZwBHtQEtgUZAb1NQdJd3/qkwqAAm6XoB+5
 b4gr/lkJsOeLm19ckvAMBiaDEBctShvkiW9ih7pkggq+1ycTFlsG9Gyj4D+XC8eJGb9mGA9U/eO
 UrgTH7A1djoAsVHfzmfKkJA7qm7jwnm4mUxPrH4LoFCR7PwzdoRlEIDbb5SIz01N8rF3932nl9o
 Tt67MpJa58qTK6JPVm5Lu5rFBBJPwUgPGwwqzkZlaOfQ==
X-Forward-Email-ID: 67ca2a31c1763851c065cd4d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3d3db030-26e6-4fe1-9158-85f8cebef89c@kwiboo.se>
Date: Fri, 7 Mar 2025 00:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers
 for RK3528
To: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
 detlev.casanova@collabora.com, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20250305194612.47171-1-ziyao@disroot.org>
 <20250306140009.384469-1-amadeus@jmu.edu.cn> <Z8nPjjbZvpRJ2R5B@pie.lan>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <Z8nPjjbZvpRJ2R5B@pie.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-06 17:43, Yao Zi wrote:
> On Thu, Mar 06, 2025 at 10:00:09PM +0800, Chukun Pan wrote:
>> Hi,
>>
>>> +		sdio0: mmc@ffc10000 {
>>> +			compatible = "rockchip,rk3528-dw-mshc",
>>> +				     "rockchip,rk3288-dw-mshc";
>>> +			reg = <0x0 0xffc10000 0x0 0x4000>;
>>> +			clocks = <&cru HCLK_SDIO0>,
>>> +				 <&cru CCLK_SRC_SDIO0>,
>>> +				 <&cru SCLK_SDIO0_DRV>,
>>> +				 <&cru SCLK_SDIO0_SAMPLE>;
>>> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>>> +			fifo-depth = <0x100>;
>>> +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
>>> +			max-frequency = <150000000>;
>>> +			pinctrl-names = "default";
>>> +			pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>,
>>> +				    <&sdio0_det>, <&sdio0_pwren>;
>>
>> The sdio module is usually "non-removable", no need det,
>> and pwren may be other gpio (use mmc-pwrseq). So it should
>> be `pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>;`
> 
> This doesn't affect the fact that these two pins are assigned as
> functional pins for SDIO0, as pointed out by the datasheet[1].
> 
> But with more digging, I found the reference design[2] of Rockchip
> actually uses the two pins as normal GPIOs. This is more obvious in
> downstream devicetree of an EVB[3]. Most of the existing boards (Radxa
> 2A, ArmSOM Sige 1) follow the reference design.
> 
> For me, it's kind of surprising that the SDIO IP functions with two
> functional pins assigned as different modes. I'm not sure whether we
> should apply pin configuration for these two pins in the SoC devicetree.
> Jonas, what do you think about it?

I think it make sense to match the pins used by reference boards, i.e.
the pinconf most likely to be used by majority of boards that will use
the sdio interface.

Of my RK3528 boards, only ArmSoM Sige1 use sdio for onboard wifi and
there I currently have following in my work-in-progress board DT [4]:

  pinctrl-names = "default";
  pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>, <&clkm1_32k_out>;

The Radxa ROCK 2A/2F seem to use USB for wifi/bt.

[4] https://github.com/Kwiboo/linux-rockchip/blob/next-20250305-rk3528/arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts

Regards,
Jonas

> 
>>> +			resets = <&cru SRST_H_SDIO0>;
>>> +			reset-names = "reset";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		sdio1: mmc@ffc20000 {
>>> +			compatible = "rockchip,rk3528-dw-mshc",
>>> +				     "rockchip,rk3288-dw-mshc";
>>> +			reg = <0x0 0xffc20000 0x0 0x4000>;
>>> +			clocks = <&cru HCLK_SDIO1>,
>>> +				 <&cru CCLK_SRC_SDIO1>,
>>> +				 <&cru SCLK_SDIO1_DRV>,
>>> +				 <&cru SCLK_SDIO1_SAMPLE>;
>>> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>>> +			fifo-depth = <0x100>;
>>> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>>> +			max-frequency = <150000000>;
>>> +			pinctrl-names = "default";
>>> +			pinctrl-0 = <&sdio1_bus4>, <&sdio1_clk>, <&sdio1_cmd>,
>>> +				    <&sdio1_det>, <&sdio1_pwren>;
>>
>> Same here.
>>
>>> +			resets = <&cru SRST_H_SDIO1>;
>>> +			reset-names = "reset";
>>> +			status = "disabled";
>>> +		};
>>
>> Thanks,
>> Chukun
>>
>> -- 
>> 2.25.1
>>
> 
> Best regards,
> Yao Zi
> 
> [1]: https://github.com/DeciHD/rockchip_docs/blob/main/rk3528/Rockchip%C2%A0RK3528%C2%A0Datasheet%C2%A0V1.0-20230522.pdf
> [2]: https://github.com/DeciHD/rockchip_docs/blob/main/rk3528/RK3528_BOX_REF_V10_20230525.pdf
> [3]: https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3528-evb1-ddr4-v10.dtsi#L128


