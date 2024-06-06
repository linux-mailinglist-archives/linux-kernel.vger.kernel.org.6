Return-Path: <linux-kernel+bounces-203822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBC48FE0EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C63B21950
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6978713C692;
	Thu,  6 Jun 2024 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wMvx3o2V"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E5199A2;
	Thu,  6 Jun 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662420; cv=none; b=crwiOijNUtFckmKPEMda87SFRDizV+CzOy/OO7HQBNTlskuwT0OK82QfDUrq+Pn5menRPqWtIR8B1OPiqyyT3KCwu0D+UpzwuvvfKeFbfRuEaMXqlgGHgxEUSHzpPbGjDjicqCDNbUaEfGUEPyXijxb9uH6ytp+VWAX6wGLrch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662420; c=relaxed/simple;
	bh=pwoHibVp0BN/9IvJseN1aG9FN8TSfYTChAmdkUilT/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZmoKAqI/tjpdVEMZxdthZUtGq+Mvt/hbIQkf2xDcPCIngwwmJ07KPrFWsPvCnzTY7wucEOUYVW9zDKRmVk+uNHep+9HDOL/XYx7zWwOup9v6kaPsir3mum2uKP3q1u56G3//+mbW75ss4f78Sgh1EC/kFXHWcMmO8FdUVVqN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wMvx3o2V; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=TAJBf2B8gbT67nqhACvm4EgH00WGKM6/1lZ+DcslpsE=; t=1717662418;
	x=1718094418; b=wMvx3o2VimOEXwXq5Kmo9sczP9U60CFXQ0cJGJVNMz8OZdVbSRzMUbcwuDYSx
	yoV/RfNWRb++sI6Y2Zs3v6fkJEzF4FTXvkxDzMbEmwJiLi7dUuo8i7Uq90jtFQEY/LIBRsTGddni/
	G846CsEm5ALwh7RVObCvGxTKG9YVY/fp2aacnmiRV0QXK3ic4aVm84Z5NKps4VZTIsVrvJhWwmGZr
	xvY+KsKmfaXDHCRCDeuz4ZMGmW7PZtSXDAroXoE4a5siQHpIW4IrR8zKOboYPtZHEtBi1kKsJeXr2
	zcKRv1TyTIJyYbPGgI31ubrKIrxF/zWzCxlkxWtx9FfXmKqzVQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sF8SQ-0006mK-P3; Thu, 06 Jun 2024 10:26:50 +0200
Message-ID: <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
Date: Thu, 6 Jun 2024 10:26:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
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
 <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717662418;e7046d08;
X-HE-SMSGID: 1sF8SQ-0006mK-P3

On 31.05.24 08:10, Arınç ÜNAL wrote:
> On 31/05/2024 08.40, Thorsten Leemhuis wrote:
>> [adding Paolo, who committed the culprit]

/me slowly wonders if the culprit should be reverted for now (see below)
and should be reapplied later together with the matching changes from
Arınç ÜNAL.

>> On 23.05.24 12:44, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 17.05.24 08:27, Frank Wunderlich wrote:
>>>> Am 17. Mai 2024 04:17:47 MESZ schrieb "Arınç ÜNAL"
>>>> <arinc.unal@arinc9.com>:
>>>>> On 16/05/2024 23:48, Frank Wunderlich wrote:
>>>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>>>>
>>>>>> After commit 868ff5f4944a
>>>>>> ("net: dsa: mt7530-mdio: read PHY address of switch from device
>>>>>> tree")
>>>>>> the mt7531 switch on Bananapi-R64 was not detected.
>>>>>>
>>>>>> mt7530-mdio mdio-bus:00: reset timeout
>>>>>> mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with
>>>>>> error -110
>>>>>>
>>>>>> Fix this by adding phy address in devicetree.
>>
>> Frank, am I right assuming the regression is still present in mainline?
>> As from here it looks like for two weeks now there was no progress at
>> all to fix this (or I missed it, which is quite possible).
>>
>> Makes me wonder if the maintainers should revert the culprit or if the
>> arm64 dts folks should accept your fix despite Arınç ÜNAL's (who from a
>> quick look on lore hasn't posted anything for two weeks now) comment.
> 
> I'm not against the patch. I'm against the logic it entails on the patch
> log.

In that case: can you maybe help Frank with writing something better or
submit something based on this patch to resolve this and make everyone
happy?

> I had already submitted a patch series that would've prevented this
> issue back in 14 March 2024 [1]. I've asked numerous times for the patch
> series to be applied [2][3][4][5].
>> Eventually Daniel asked for some changes [6]. But I won't have time to do
> that anytime soon and I think the patch series is good enough to be applied
> as is.

Then I guess we need some other way to resolve this in mainline to unfix
Frank's device. The two obvious options are afaics:

* revert the culprit (868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY
address of switch from device tree")) and reapply it in a later cycle
* apply Frank's patch (or an improved one) in this thread (and if needed
revert it when some better changes emerge.

Arınç ÜNAL, could you please comment on that and ideally handle the
necessary tasks, as it's your patch that causes the regression.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> [1]
> https://lore.kernel.org/all/20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com/
> [2]
> https://lore.kernel.org/all/ff196055-ecd8-4563-bc01-ff2533a07109@arinc9.com/
> [3]
> https://lore.kernel.org/all/a60fc16d-4236-427c-b4a8-ec6fdf62d9f0@arinc9.com/
> [4]
> https://lore.kernel.org/all/facb8204-c2b3-4084-a2e3-4fbf3a3fdc9d@arinc9.com/
> [5]
> https://lore.kernel.org/all/44e366ea-964a-4515-9027-2a2edfe12512@arinc9.com/
> [6] https://lore.kernel.org/all/ZixU287DdhvRyZBe@makrotopia.org/
> 
> Arınç
> 
> 

