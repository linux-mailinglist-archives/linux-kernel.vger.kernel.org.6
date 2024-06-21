Return-Path: <linux-kernel+bounces-225379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BE912FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C317E1F256D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89017B513;
	Fri, 21 Jun 2024 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KVDTa4Xj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625C15FA65;
	Fri, 21 Jun 2024 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007410; cv=none; b=Z5eVPDDpY1Bd2YHDMN8CYcy2VxOJXKyVeH1Gi1fsBA2WGVDavbsHIDOUySFZPC/M+eOpAxitEHmVFyr0W9iUPG6W0b5FiEidGk/kpgixUY43LWu1FjuQeU3cJ61NFRUwPFI2RzFaFqFLQHW18d2Z3WhyPQyTYXO4VTCi8HTsvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007410; c=relaxed/simple;
	bh=OpatgoMemBcpmRA/FW65De33x8DnuhU9voVS6rFiA8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1VrOfk6xeD+lgfa5VeIRJxqBBcZGiOPjLxTVZL4thnVnJN8CqEnqVy8SPeYK8HNGAM7ggJTlqcAnqQQf9qKoR2DYqEc/wqVk4IotvgFyahE7aeaBf+cHgqSomEhdKWRjnfyVIRoI6UQalnT+FF8JYS7TvQxtrAtVUYYlf/khTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KVDTa4Xj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719007407;
	bh=OpatgoMemBcpmRA/FW65De33x8DnuhU9voVS6rFiA8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KVDTa4XjSq99OaJ+7sjSQy0fhk+UD2vq3VujA9vFA+Za8e3uW9cXwLfZ8aCuReiXi
	 gBI61cM7DmLWKNbhDnyOvXY8jXl7N1AjXM3g0eSxwp/rRHj/WbroN9Dn8LAm+wdHrz
	 Tyaap8VXSYHyOoBGZRfKLrFCJanx+yjDFj7jVktW0+XJD3qBKDcSN9UH1O0SYWuPBM
	 3exUwEIgQC7WDjV9O5zLC2qUtK1qsjflvyumnH4Jp9rgcXxCHebZbeMJmq5+t6DAbI
	 KDS1t/QJaeO63iEfgNlqqtANNnMefuQn8FLtiYmrbeyHvzM+BbaULHNqaPFB0jGX8C
	 ZWkSdpFKE7/Hw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E617378203F;
	Fri, 21 Jun 2024 22:03:26 +0000 (UTC)
Message-ID: <5dc1fa74-c754-4875-b9c7-0defeaa44a3c@collabora.com>
Date: Sat, 22 Jun 2024 01:03:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: mfd: rk809: Add missing audio codec
 properties
To: Jonas Karlman <jonas@kwiboo.se>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Furkan Kardame <f.kardame@manjaro.org>,
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
 <20240619-rk809-fixes-v1-2-fa93bc5313f4@collabora.com>
 <dc71686e-a3fa-48f7-83a9-34d0f365ff07@kwiboo.se>
 <f6fcbca9-a5cd-42a6-a911-9515d131d992@collabora.com>
 <95b10d88-be5b-4fcb-a30b-414dc90d18fe@kwiboo.se>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <95b10d88-be5b-4fcb-a30b-414dc90d18fe@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 6:05 PM, Jonas Karlman wrote:
> Hi Cristian,
> 
> On 2024-06-19 14:53, Cristian Ciocaltea wrote:
>> Hi Jonas,
>>
>> On 6/19/24 3:20 PM, Jonas Karlman wrote:
>>> Hi Cristian,
>>>
>>> On 2024-06-19 13:23, Cristian Ciocaltea wrote:
>>>> The RK809 MFD provides a RK817 compatible audio codec, supported by the
>>>> rk817_codec driver.
>>>>
>>>> This has been already in use by several boards: rk3566-quartz64-b,
>>>> k3566-roc-pc, rk3568-evb1-v10, rk3568-lubancat-2, rk3568-odroid-m1,
>>>> rk3568-rock-3a.  However, dtbs_check fails for all of them:
>>>>
>>>>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
>>>>   rk3568-rock-3a.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks', 'codec' do not match any of the regexes: 'pinctrl-[0-9]+'
>>>>     from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
>>>>
>>>> Document the missing audio codec properties as found on the
>>>> rockchip,rk817 schema.
>>>
>>> This is duplicate of "dt-bindings: mfd: rk809: Add audio codec properties"
>>> part of "arm64: dts: rockchip: Add Radxa ROCK 3B" series.
>>>
>>> https://lore.kernel.org/all/20240505134120.2828885-3-jonas@kwiboo.se/
>>>
>>> A v2 of that series with fixes for reported issues is imminent.
>>> How do you want me to preceded with such v2 series?
>>
>> Oh, it seems both of us made the same mistake and wrongly assumed the
>> rockchip,rk817 schema is good enough to be used as a reference. :-)
> 
> Hehe, yeah :-)
> 
>>
>> Since both rockchip,rk817 and rockchip,rk809 files share most of the
>> content, I also think this might be a good opportunity to get them
>> merged into a single schema.
>>
>> I can do this in v2, unless you prefer to handle it as part of your series.
> 
> I was planning on sending the following, merging the schemas may also be
> an option.
> 
> https://github.com/Kwiboo/linux-rockchip/compare/619509e6c853...next-20240618-rock-3b-orangepi-3b/
> 
> Main purpose of my series was to add ROCK 3B and also Orange Pi 3B,
> fixing rockchip,rk809 binding is just a prerequisite.
> 
> If you want to merge the bindings, please do :-), I can wait a few more
> days to send out a ROCK 3B + Orange Pi 3B v2 series.
> 
> Please also include the vcc8/9 fix if you send a v2.

Thanks for the pointers, got this finally merged in v2:

https://lore.kernel.org/lkml/20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com/

Regards,
Cristian

