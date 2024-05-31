Return-Path: <linux-kernel+bounces-196298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC698D59EF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807731C21B06
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1637A702;
	Fri, 31 May 2024 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SwNdzfte"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE04208B0;
	Fri, 31 May 2024 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717134068; cv=none; b=hv+q0uVuZUK+2AYoz20cQYFWdtkYE1JjneWX2yjF159P7itEgNut2N62Kpa2F5GvY7NxIlWtEsoPRfDGoYOwvNPQQlTtMmnTrcfwxfRn+q/xcyMmJ6dddOI0gANFifEIvnUtqWNm5Kk/Z7pI4EnUyUeLK5SdvolmCWq6AzyitDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717134068; c=relaxed/simple;
	bh=dMsidw6clAn8vGm5sxSj3ijTF5lMXrs10lmxk44JCf0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZqSFnVkfehdzmDVfODSGk9kYxKpKHp4Il2r7W1BvulRK1T3+Uqw2/R78+p9sCaPmt/5u3eEZIUdmCziJ+0cgFnIjKAIVTBMsDBK8mcjwR1J0ChAFyRaSNXeP2yuvviOpcOypghROowT2VnkLtzxbC87lAHNpKObgVEWnnTVDTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SwNdzfte; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=q7kb86slOnjl1TVZjvP8hxkOyssEP3QytYVnpBoDrB8=;
	t=1717134066; x=1717566066; b=SwNdzfte2+7uy1YCUIbks/Im+xGf4gCLBwG1ilx2NuGLfn2
	0pAMWj1/uuc1kv5NHk8i0mxLju3gULRGnyZt8d8SzElKHYYBawiD1ZLQiVc1ZVRszB9OzhQOI+h4U
	Fq94IWuyTlC+mEFOnfy7BQxfnFIPso0L9g2+hxv5abcYy+CdPzRKgK7sIPMfSBcZ5lvIiGV3ZsdtO
	YgMAotYoCHMnEkm3jU5+TAn7b2XSydX9iejcea/kxG6adPyyqS6DGLT2lzbiTZEdkouZbaJaehDH4
	3lEeERnCS6ZZZsBePuRvpYY4RGuG73GJ6ZiD+/1UR5TwnhP9e/EvIdqh0wcn4SEQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCv0b-0003Vc-RI; Fri, 31 May 2024 07:40:57 +0200
Message-ID: <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
Date: Fri, 31 May 2024 07:40:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Frank Wunderlich <linux@fw-web.de>, Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 frank-w@public-files.de, Rob Herring <robh@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717134066;06036c9c;
X-HE-SMSGID: 1sCv0b-0003Vc-RI

[adding Paolo, who committed the culprit]

On 23.05.24 12:44, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 17.05.24 08:27, Frank Wunderlich wrote:
>> Am 17. Mai 2024 04:17:47 MESZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
>>> On 16/05/2024 23:48, Frank Wunderlich wrote:
>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>>
>>>> After commit 868ff5f4944a
>>>> ("net: dsa: mt7530-mdio: read PHY address of switch from device tree")
>>>> the mt7531 switch on Bananapi-R64 was not detected.
>>>>
>>>> mt7530-mdio mdio-bus:00: reset timeout
>>>> mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -110
>>>>
>>>> Fix this by adding phy address in devicetree.
>>>>

Frank, am I right assuming the regression is still present in mainline?
As from here it looks like for two weeks now there was no progress at
all to fix this (or I missed it, which is quite possible).

Makes me wonder if the maintainers should revert the culprit or if the
arm64 dts folks should accept your fix despite Arınç ÜNAL's (who from a
quick look on lore hasn't posted anything for two weeks now) comment.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>>> I don't like the mention of the Linux kernel driver on the patch log. What
>>> you're fixing is the incorrect description of the switch's PHY address on
>>> the DTS file. Whether or not any driver from any project is actually
>>> reading it from the DTS file is irrelevant to this patch. That said, I
>>> already have a patch series I've been meaning to send the next version of
>>> that already addresses this. Please wait for that.
> 
> Did you sent this? Because from what I see with my limited experience in
> this subsystem...
> 
>> From my PoV it is a regression in next/6.10
> 
> ...I have to agree with Frank here. So it would be good to get this
> fixed before -rc1 is out to prevent more people from running into this.
> 
>> because the driver change was merged (without "broadcast" fallback) and the dts patch [1] is not.
>>
>> I agree that my patch can be dropped because there was already one.
>>
>> regards Frank
>>
>> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240314-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9.com/
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 

