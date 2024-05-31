Return-Path: <linux-kernel+bounces-196332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF7C8D5A56
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7005B221E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651127E774;
	Fri, 31 May 2024 06:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="P+sqDvaz"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD918756E;
	Fri, 31 May 2024 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135847; cv=none; b=r9DdjcpG0rmgKVo/Kq665LRs2kxSNeO8lWuHOsELzbyoNvYY5778Mr9zhz0Y+BqiRtkXJ3cj77TFNw3Jiw9Dq483CegtPEzb7QW2QeLJ5jOIfRxg+pexESj+7NKqXNwiobD1FjOI4wJQ39tSzAwlSUoH9ndFpNYdKFytrOTkW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135847; c=relaxed/simple;
	bh=qB0ppgM4QBM9DfYzNLcE/5J/iC0iPummqPWvs/1rtSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7T/6hVRgVMTYoKiV4zhzzKoqKa4BF7EnPnn2TJAgeucB0KiMWc0ORw3j05xosZqDL6TXw8By+Q2C4+hGcCDsLTpfQoE90vK9IX0DrSNP9Pc5A60IrjcSOmXBL/NO5zI1t7lB/yZYgc4JbM3M9ABakAZ4WOsdXpC1d0D+r5Iffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=P+sqDvaz; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79D5340006;
	Fri, 31 May 2024 06:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1717135843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRRofHQN+sZ3zin7XoMAEcDEOOv/eiLPcfVn0mruNPM=;
	b=P+sqDvazmpYhlGevEVypSVw8Pj094VUJ2WN0YqIf19IvIOFP3PX+uciDmOd8nSBrklIM7l
	+QM/YROYMmNiXG6JXSmCXDu060ENb3Px7vAUzyjVHfaNhxCb/A5Mn+c7yWnrZI7KfBgqzn
	f9KeYKpjgA4nMVvxCGrZjW3kIVgExJlJP3V3i0m19tD03rVukVBO6A6m8Y3m9RQsXLTx3C
	G56yQl/I/0oua7UVUfQzVcDytm5sTVb6Sxj/PhzAxKgzeZ9W/t8ZOFMM8TtKi25LydePc+
	IT6pqusy5gI14Tzgz5A56iLmcwdDtKRxYtOq786wEEcPT/zHTr381qbLqEqHAQ==
Message-ID: <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
Date: Fri, 31 May 2024 09:10:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Frank Wunderlich <linux@fw-web.de>, Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 frank-w@public-files.de, Rob Herring <robh@kernel.org>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
 <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 31/05/2024 08.40, Thorsten Leemhuis wrote:
> [adding Paolo, who committed the culprit]
> 
> On 23.05.24 12:44, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 17.05.24 08:27, Frank Wunderlich wrote:
>>> Am 17. Mai 2024 04:17:47 MESZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
>>>> On 16/05/2024 23:48, Frank Wunderlich wrote:
>>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>>>
>>>>> After commit 868ff5f4944a
>>>>> ("net: dsa: mt7530-mdio: read PHY address of switch from device tree")
>>>>> the mt7531 switch on Bananapi-R64 was not detected.
>>>>>
>>>>> mt7530-mdio mdio-bus:00: reset timeout
>>>>> mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -110
>>>>>
>>>>> Fix this by adding phy address in devicetree.
>>>>>
> 
> Frank, am I right assuming the regression is still present in mainline?
> As from here it looks like for two weeks now there was no progress at
> all to fix this (or I missed it, which is quite possible).
> 
> Makes me wonder if the maintainers should revert the culprit or if the
> arm64 dts folks should accept your fix despite Arınç ÜNAL's (who from a
> quick look on lore hasn't posted anything for two weeks now) comment.

I'm not against the patch. I'm against the logic it entails on the patch
log. I had already submitted a patch series that would've prevented this
issue back in 14 March 2024 [1]. I've asked numerous times for the patch
series to be applied [2][3][4][5].

Eventually Daniel asked for some changes [6]. But I won't have time to do
that anytime soon and I think the patch series is good enough to be applied
as is.

[1] https://lore.kernel.org/all/20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com/
[2] https://lore.kernel.org/all/ff196055-ecd8-4563-bc01-ff2533a07109@arinc9.com/
[3] https://lore.kernel.org/all/a60fc16d-4236-427c-b4a8-ec6fdf62d9f0@arinc9.com/
[4] https://lore.kernel.org/all/facb8204-c2b3-4084-a2e3-4fbf3a3fdc9d@arinc9.com/
[5] https://lore.kernel.org/all/44e366ea-964a-4515-9027-2a2edfe12512@arinc9.com/
[6] https://lore.kernel.org/all/ZixU287DdhvRyZBe@makrotopia.org/

Arınç

