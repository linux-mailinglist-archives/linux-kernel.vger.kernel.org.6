Return-Path: <linux-kernel+bounces-217184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2BB90AC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0030D1C213BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20621946C4;
	Mon, 17 Jun 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="JU8tmsmg"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182B381A1;
	Mon, 17 Jun 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622513; cv=none; b=W2UZWgzbxPIaV90Dv9hy7YMll3kl523hk0lRCUE0P/AV9SnREYmf1VhRDWv6CgicwIoMp6vtwyirVzbQ8sEWww5CfjTeoyMVJy+mNW99lEBI0qaCLoOQTYTW20jWuvezMfN7Ue2aAGOzIIYg5D1jYLxdgYVryhnyEbGOlUzq7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622513; c=relaxed/simple;
	bh=xpb8F0NU2qMoAB1VMnLthvj39UVOwMQxVa6fpK9+LdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZSdUihQ3H77e+VMFW8gmP4Cx6OXSxU2KNEmckgDsMWxX2LK5cpI1mmldqNhzO9wsnQNTNhgAZWY/j8F/gR/2Xfnfk1hf/b9rdMxeVzw3pH6eqzhVR1HaNYkSPie1S75eQouRucaLE8TJxRjyhVdX/n6kNwRoVo9H+gjZKE9/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=JU8tmsmg; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25E7B240002;
	Mon, 17 Jun 2024 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1718622504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OF6t87ZOTovWqD1drOj8KVeXWAvWWRQUUmrsihK6t5U=;
	b=JU8tmsmgpKGRObQmaZylENnbGAygRo5IuIquYGTP5DI7rNvxJ7vh4a9Vzf0OamJXgMww/e
	JOsJvcqO5RmFTT0Bz8kj6gYsg9Pv5PInw3t6CeZtS6BrvptHCDpdnggR3GGsBoWd9iMUXE
	cyvFPrRCqw+NPLObWzekiuX6nK1In0Q7WroisE1nJVIauZa2bGDYoUg72FB+OXLOa4Ygqa
	Z3giDWFp2ZLOruLiRPKNxIacya+//YtOsyDAZs3ZTaKaOqd+uOts2Y0nxGweOOeDDRY2ra
	zfT8vy72LqZYWgqCqqYrhqyW5fhBgtOpr5JXt+XimYT48opOSMRxQxtoftZBpw==
Message-ID: <af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com>
Date: Mon, 17 Jun 2024 14:08:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, Paolo Abeni <pabeni@redhat.com>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
 <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
 <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
 <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
 <2cac4cf68304e81abffbd9ff0387ee100323c2b7.camel@redhat.com>
 <b49c801c-6628-40a6-8294-0876d8871ba7@leemhuis.info>
 <e92c3ca0-c9be-44ac-a4fc-57ca5ebedbc5@leemhuis.info>
 <1807a142-1534-4fa4-ad4b-d1c03af014c2@arinc9.com>
 <58d8ddea-71cc-427a-94cc-a95f6bce61d2@collabora.com>
 <16e9c06e-9908-455d-a387-614fefe5bcf8@arinc9.com>
 <5e87d31c-b059-4f9a-93f7-dc87465ed14a@collabora.com>
 <4416ef22-78cc-4ce5-b61d-69ff0903811e@arinc9.com>
 <bd6b6929-d34d-4bd5-9cb0-bc8fe850ee46@leemhuis.info>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <bd6b6929-d34d-4bd5-9cb0-bc8fe850ee46@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis) wrote:
> This thread/fixing the regressions looks stalled again, let me jump in
> here with a further comment below.
> 
> On 11.06.24 20:15, Arınç ÜNAL wrote:
>> On 11/06/2024 16:03, AngeloGioacchino Del Regno wrote:
>>> Il 11/06/24 14:56, Arınç ÜNAL ha scritto:
>>>> On 11/06/2024 15:28, AngeloGioacchino Del Regno wrote:
>>>>> Il 11/06/24 13:38, Arınç ÜNAL ha scritto:
>>>>>> On 11/06/2024 14:30, Thorsten Leemhuis wrote:
>>>>>>> On 07.06.24 16:15, Thorsten Leemhuis wrote:
>>>>>>>> On 07.06.24 16:03, Paolo Abeni wrote:
>>>>>>>>> On Thu, 2024-06-06 at 10:26 +0200, Thorsten Leemhuis wrote:
>>>>>>>>>> On 31.05.24 08:10, Arınç ÜNAL wrote:
>>>>>>>>>>> On 31/05/2024 08.40, Thorsten Leemhuis wrote:
>>>>>>>>>>>> [adding Paolo, who committed the culprit]
>>>>>>>>>>
>>>>>>>>>> /me slowly wonders if the culprit should be reverted for now
>>>>>>>>>> (see below)
>>>>>>>>>> and should be reapplied later together with the matching
>>>>>>>>>> changes from
>>>>>>>>>> Arınç ÜNAL.
>>>>>>>>>
>>>>>>>>> FWIS I think a revert should be avoided, given that a fix is
>>>>>>>>> available
>>>>>>>>> and nicely small.
>>>>>>>>
>>>>>>>> Yeah, on one hand I agree; but on the other it seems that the
>>>>>>>> maintainers that would have to take care of the dt changes to fix
>>>>>>>> this
>>>>>>>> until now remained silent in this thread, apart from Rob who sent
>>>>>>>> the
>>>>>>>> mail regarding the warnings.
>>>>>>>>
>>>>>>>> I put those maintainers in the To: field of this mail, maybe that
>>>>>>>> might
>>>>>>>> lead to some reaction.
>>>>>>>
>>>>>>> Still no reply from the DRS folks or any other progress I noticed.
>>>>>>> Guess
>>>>>>> that means I will soon have no other choice than to get Linus
>>>>>>> involved,
>>>>>>> as this looks stuck. :-( #sigh
>>>>>>
>>>>>> Does it have to be Linus that needs to apply "[PATCH 0/2] Set PHY
>>>>>> address
>>>>>> of MT7531 switch to 0x1f on MediaTek arm64 boards"? Aren't there
>>>>>> any other
>>>>>> ARM maintainers that can apply the fix to their tree?
>>>>>>
>>>>>> Arınç
>>>>>
>>>>> You have feedback from two people on the series that you mentioned,
>>>>> and noone
>>>>> is going to apply something that needs to be fixed.
>>>>>
>>>>> I'm giving you the possibility of addressing the comments in your
>>>>> patch, but
>>>>> I don't want to see any mention of the driver previously ignoring
>>>>> this or that
>>>>> as this is irrelevant for a hardware description. Devicetree only
>>>>> describes HW.
>>>>>
>>>>> Adding up, in commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY
>>>>> address of switch from device tree"),
>>>>> you have created a regression.
>>>>>
>>>>> Regressions should be fixed - as in - if the driver did work before
>>>>> with the old
>>>>> devicetrees, it shall still work. You can't break ABI. Any changes
>>>>> that you do
>>>>> to your driver must not break functionality with old devicetrees.
>>>>>
>>>>> So...
>>>>>
>>>>> ------> Fix the driver that you broke <------
>>>>
>>>> The device tree ABI before the change on the driver:
>>>>
>>>> The reg value represents the PHY address of the switch.
>>>>
>>>> The device tree ABI after the change on the driver:
>>>>
>>>> The reg value represents the PHY address of the switch.
>>>>
>>>> I see no device tree ABI breakage. What I see instead is the driver
>>>> starting enforcing the device tree ABI. No change had been made on the
>>>> device tree ABI so any non-Linux driver that controls this switch
>>>> continues
>>>> to work.
>>>>
>>>> These old device tree source files in question did not abide by the
>>>> device
>>>> tree ABI in the first place, which is why they don't work anymore as the
>>>> Linux driver now enforces the ABI. Device tree source files not
>>>> conforming
>>>> to the ABI is not something to maintain but to fix. The patch series
>>>> that
>>>> fixes them are already submitted.
>>>
>>> As I said, the devicetree MUST describe the hardware correctly, and on
>>> that I do
>>> agree, and I, again, said that I want to take the devicetree fix.
>>>
>>> However, the driver regressed, and this broke functionality with old
>>> device trees.
>>> Old device trees might have been wrong (and they are, yes), but
>>> functionality was
>>> there and the switch was working.
>>>
>>> I repeat, driver changes MUST be retro-compatible with older device
>>> trees, and your
>>> driver changes ARE NOT; otherwise, this wouldn't be called *regression*.
>>
>> I'm going to argue that what caused the regression is the broken device
>> tree. The recent change on the driver only worked towards exposing the
>> broken device tree.
> 
> Well, for the kernel that does not matter much: due to our "no
> regressions" rule and how Linus handles it the author of that "recent
> change" (e.g. you) is responsible to fix regressions a change exposed --
> or that change is reverted (I might be wrong, but I think there are
> quotes from Linus in
> https://docs.kernel.org/process/handling-regressions.html to back this
> up). So in the end a revert in a week or two is likely the outcome,
> unless you or someone else fixes it in a way that pleases
> AngeloGioacchino et. at.

I've submitted a patch series that fixes the regression. Angelo argued
against the way the regression is fixed. I've very clearly argued back why
I find Angelo's approach wrong. There's been no response back. I don't
understand why reverting the patch is the likely outcome whilst the
standing argument points towards applying the said patch series. If a
revert happens before this discussion with Angelo finalises, this will set
a precedent that will tell maintainers that they can have their way by just
not replying to the ongoing discussions.

That said, the decision of resolving the regression by either reverting the
patch or applying the patch series shall not depend on whether or not
Angelo is pleased but rather there're no counter-arguments left on the
points brought, meaning the decision shall be made depending on the
argument that stands.

Therefore, I suggest that unless Angelo responds back with a
counter-argument in the window of a week or two, as you've described, my
patch series shall be applied.

Arınç

