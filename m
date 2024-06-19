Return-Path: <linux-kernel+bounces-221073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250F490EB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDC11F221C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2524143C45;
	Wed, 19 Jun 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SFpKWLv/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72181FC1F;
	Wed, 19 Jun 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801629; cv=none; b=ugrOa6as7ZbsGqyB12zUcGKnD/eYkSRegPN7hQmZOe/TUDpRj0zHcNlvK07rSeykPzGeDdqEA6dzWX/QfsYariBPoyacmSak0dIPb63BlAMx3QLcucDHcyH9v+KyDp4TnmHcbTe18cLQ+RtfBOnZpRh8r6XdyJd2KNANWK6VXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801629; c=relaxed/simple;
	bh=lD62iizMar9i2A5WdIk3Mt84R3BsDRplqxsUenKolds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZ6HwuCa5gmDuPhmCCJz/EeJaDcC7m91va/wDuXX7yprjz8t/PV/yZN6EbugFHtE5KygzwLgWeSJV4gMVo5chR9fRbIU863iJStIJlbt/3bw5k2Qee0k8NF+a2GJiRVoh+vYEeYzsOCbqcPc1KKAq5y+9sluxFOum7Dtjw+S51E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SFpKWLv/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718801625;
	bh=lD62iizMar9i2A5WdIk3Mt84R3BsDRplqxsUenKolds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SFpKWLv//Welw3dMliy5cQLiOOwJERVpjfB7lU0MV9VpxlR4xx/W1h8CJ1j6Pb1Si
	 cVzi+6P9+Z+L8b4BDZC1UxSJ91Y0wW6nzjO06n8Us24i160m6qCFIolDSN4sowuFte
	 1G54mE7p3wmA/ONG2QzllX3jG3ZPbwmcAROPhEMFlxnaxEi6JZ4YyPlmSUvKudUcPg
	 pXQEL5ImN3Ir3sGpAw7/MITaP2r3pRsD7VLbGhtl5uGirG7jyoNKMk7ra+ar03hMY3
	 +Cwz7UX9aW7KsAofYk38ckIF9Vjqozil8YC8y2EYTyHs36XT9/j9/IsW5wsUhxGKhN
	 koMh3M5vvOk3w==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 62DA73782159;
	Wed, 19 Jun 2024 12:53:44 +0000 (UTC)
Message-ID: <f6fcbca9-a5cd-42a6-a911-9515d131d992@collabora.com>
Date: Wed, 19 Jun 2024 15:53:43 +0300
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
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <dc71686e-a3fa-48f7-83a9-34d0f365ff07@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonas,

On 6/19/24 3:20 PM, Jonas Karlman wrote:
> Hi Cristian,
> 
> On 2024-06-19 13:23, Cristian Ciocaltea wrote:
>> The RK809 MFD provides a RK817 compatible audio codec, supported by the
>> rk817_codec driver.
>>
>> This has been already in use by several boards: rk3566-quartz64-b,
>> k3566-roc-pc, rk3568-evb1-v10, rk3568-lubancat-2, rk3568-odroid-m1,
>> rk3568-rock-3a.  However, dtbs_check fails for all of them:
>>
>>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
>>   rk3568-rock-3a.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks', 'codec' do not match any of the regexes: 'pinctrl-[0-9]+'
>>     from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
>>
>> Document the missing audio codec properties as found on the
>> rockchip,rk817 schema.
> 
> This is duplicate of "dt-bindings: mfd: rk809: Add audio codec properties"
> part of "arm64: dts: rockchip: Add Radxa ROCK 3B" series.
> 
> https://lore.kernel.org/all/20240505134120.2828885-3-jonas@kwiboo.se/
> 
> A v2 of that series with fixes for reported issues is imminent.
> How do you want me to preceded with such v2 series?

Oh, it seems both of us made the same mistake and wrongly assumed the
rockchip,rk817 schema is good enough to be used as a reference. :-)

Since both rockchip,rk817 and rockchip,rk809 files share most of the
content, I also think this might be a good opportunity to get them
merged into a single schema.

I can do this in v2, unless you prefer to handle it as part of your series.

Thanks,
Cristian

