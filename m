Return-Path: <linux-kernel+bounces-394904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5429BB5BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7588A28345F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257BB2231C;
	Mon,  4 Nov 2024 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jdqx5P3z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A62AD5E;
	Mon,  4 Nov 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726353; cv=none; b=TH28NDzazq+6g9qly3/YZQNjldyeQutBQS0oWZ2O5qWt6ApqymKM3rS0wmwj9Zwx+TXUOzbfAuLWYJFQO2fF811mh0kOdXzlQXjFutH5e+zZqzBYyxB9mJPefnH8X72Wdi7taJ4wAGaTYUs3J+Q/fAA4iO0/df7e/LYX9uHF5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726353; c=relaxed/simple;
	bh=1PkamZZykZ77sMp0GI5lTUolLioO7jIOn5iTrhpoK+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVXW993pPk4ayay2Gh/rrrryt7tXlUqxJiuEEZZIaJRZDI8zYanS6KfdKtoESjkPZbNphHfDeWq71ROn1gb/iAOLIydSUdxVMad2/M+cB7pJ0S5KILV6gZ+aKAs5SKCYN9h8aGM0NUHLIWJgaxu99aDbtQZXF2m9jCmD7B65y0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jdqx5P3z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730726349;
	bh=1PkamZZykZ77sMp0GI5lTUolLioO7jIOn5iTrhpoK+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jdqx5P3z8eit/2sxGG3RKvQuELfZyqNVAmJ7fow9TZRN9AIX0RMG/E9y64pnky2kz
	 H9BPYhVUzu9yxTT9gD0Mmwi7kFvfSBVmHjFSYn/A5MaLdiwybosLQkNEPRVfiEvNSC
	 R0LJ9BmPla8JVosjXDLfoPIi+Z/sODWMcmZNYyHsb5llDoYdWITCoihpyGtafxo4yD
	 mKOA1yMsivY5G9X4wOiOcfCui9dtRPGalZn2aMYXUiuw2I+WHbyZRRmye9/QCWIS15
	 /C7ijWHXG/e6+mPTti8Zqy+EGF+pW3lzQYumh8S8GgojldzfQr1LRVEPf1RAHYPgn8
	 vhJFq/8IKXUlQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 642C217E3620;
	Mon,  4 Nov 2024 14:19:09 +0100 (CET)
Message-ID: <bbaa0c8f-9702-4252-a674-e46fb51f0a2a@collabora.com>
Date: Mon, 4 Nov 2024 14:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Drop
 pp3300_panel voltage settings
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241030070224.1006331-1-wenst@chromium.org>
 <20241030070224.1006331-2-wenst@chromium.org>
 <CAGXv+5HVy41qee6kwVUeLV_DfA0=wk2X77kv81rBKAZDGE6mww@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5HVy41qee6kwVUeLV_DfA0=wk2X77kv81rBKAZDGE6mww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/11/24 14:00, Chen-Yu Tsai ha scritto:
> On Wed, Oct 30, 2024 at 3:02 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> The pp3300_panel fixed regulator is just a load switch. It does not have
>> any regulating capabilities. Thus having voltage constraints on it is
>> wrong.
>>
>> Remove the voltage constraints.
>>
>> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> I see that the other three patches were merged and included in the pull
> request, but not this one. Were there any concerns?
> 

Sorry I forgot to actually provide an explanation for that - yes, I do have some
comment about this one.

Despite this being a load switch, it's still switching power from regulator A to
target device X, so this is technically still providing 3.3V to device X.

Think about how a "regular" full-fledged regulator works: you can (sometimes) set
a voltage, and then you can ENABLE the VOUT for said regulator (/rail): this kind
of "load switch" does exactly the same as the ENABLE switch for a full-fledged
regulator.

So, this is switching on and off a power rail that is derived from a source rail,
practically creating... well, a "new" rail, with...

  VIN=somewhere-3.3v,
  VOUT=somewhere-still-3.3v

Any objections/doubts/etc? :-)

P.S.: I'm writing fast, sorry if anything appears unclear, feel free to shoot more
       questions in case :-)

Cheers,
Angelo

> 
> ChenYu
> 
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
>> index 783c333107bc..7bbafe926558 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
>> @@ -35,8 +35,6 @@ pp1800_mipibrdg: pp1800-mipibrdg {
>>          pp3300_panel: pp3300-panel {
>>                  compatible = "regulator-fixed";
>>                  regulator-name = "pp3300_panel";
>> -               regulator-min-microvolt = <3300000>;
>> -               regulator-max-microvolt = <3300000>;
>>                  pinctrl-names = "default";
>>                  pinctrl-0 = <&pp3300_panel_pins>;
>>
>> --
>> 2.47.0.163.g1226f6d8fa-goog
>>


