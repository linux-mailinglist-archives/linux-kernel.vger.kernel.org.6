Return-Path: <linux-kernel+bounces-216919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2242E90A88D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F991F21025
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62840191479;
	Mon, 17 Jun 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="MWyS7qU/"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A20717F5;
	Mon, 17 Jun 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613240; cv=none; b=B/QOwqRFHIXfqjM3cpePV0qAdiCoCV/5MhX/3vGCAj1NnX0EaMfn84gU/a+b73RSESKT+M/Om9eqMEVOVbnbnGtnzUVKPE7FYGv8B5jEGItuFKCJE0h/6QKgaY06/LzMpngrfGPXTP2UWI1cvRMqpOBBW0HxR+b1cGU8/E4KPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613240; c=relaxed/simple;
	bh=+6wl04oLhPpSDJmE7ASj9/nNTOu1MjHLRoHDOiR7cTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvnvkNlLeP8d/vB46pBLr4Fb9+vHmqRwGV77NiDxVF4LHmqDLF74jKDh7Leq0yZqBeDaaENtzdTeCXEKl64lLXqbbT+EbkoiImtEMD9h8Iw1BJsLsgza5Fw1G/8vfCDUeQmuQKtLW4jufMzCjgDdOGXfMIXjXix5Wg+xhe5jjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=MWyS7qU/; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=rgwoDle0VCjUgkksnE/DxlmcEtuf5f9KQBQjSoWR2uI=;
	t=1718613238; x=1719045238; b=MWyS7qU/vMPj7MQgM+W/z10GYMFJ9jvjXQEBOcjTEmeR4l6
	zVRFELDvEKDmCba2if94kP9aUXOmAGbEjFdEQq3q+JRJZcXacdvH3CnAUwg5z4LhWhobem+/3rR+B
	omq2lEqJBzE9IYeprhOgacWAgCqQEyeg/AQ3FG6u3KcGEaR8BMSol6yuHkKyLpymDYGanfUNsmdAr
	c9sXzAGmWiNhPDS2S9GTceoWHRarAN3Sm4Jp+OIudZ1cCqrVL+kLNl+cnUVsGprhwlyaj9FhjLcoZ
	KEZnO+TXqHTB/9HaBdjPa7mtBQnmQ+Fm7GTuSp12vNqpS39o6A5jJn91o/apHBUA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJ7oF-0004hN-11; Mon, 17 Jun 2024 10:33:51 +0200
Message-ID: <bd6b6929-d34d-4bd5-9cb0-bc8fe850ee46@leemhuis.info>
Date: Mon, 17 Jun 2024 10:33:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Linux regressions mailing list <regressions@lists.linux.dev>,
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
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4416ef22-78cc-4ce5-b61d-69ff0903811e@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718613238;e08520a9;
X-HE-SMSGID: 1sJ7oF-0004hN-11

This thread/fixing the regressions looks stalled again, let me jump in
here with a further comment below.

On 11.06.24 20:15, Arınç ÜNAL wrote:
> On 11/06/2024 16:03, AngeloGioacchino Del Regno wrote:
>> Il 11/06/24 14:56, Arınç ÜNAL ha scritto:
>>> On 11/06/2024 15:28, AngeloGioacchino Del Regno wrote:
>>>> Il 11/06/24 13:38, Arınç ÜNAL ha scritto:
>>>>> On 11/06/2024 14:30, Thorsten Leemhuis wrote:
>>>>>> On 07.06.24 16:15, Thorsten Leemhuis wrote:
>>>>>>> On 07.06.24 16:03, Paolo Abeni wrote:
>>>>>>>> On Thu, 2024-06-06 at 10:26 +0200, Thorsten Leemhuis wrote:
>>>>>>>>> On 31.05.24 08:10, Arınç ÜNAL wrote:
>>>>>>>>>> On 31/05/2024 08.40, Thorsten Leemhuis wrote:
>>>>>>>>>>> [adding Paolo, who committed the culprit]
>>>>>>>>>
>>>>>>>>> /me slowly wonders if the culprit should be reverted for now
>>>>>>>>> (see below)
>>>>>>>>> and should be reapplied later together with the matching
>>>>>>>>> changes from
>>>>>>>>> Arınç ÜNAL.
>>>>>>>>
>>>>>>>> FWIS I think a revert should be avoided, given that a fix is
>>>>>>>> available
>>>>>>>> and nicely small.
>>>>>>>
>>>>>>> Yeah, on one hand I agree; but on the other it seems that the
>>>>>>> maintainers that would have to take care of the dt changes to fix
>>>>>>> this
>>>>>>> until now remained silent in this thread, apart from Rob who sent
>>>>>>> the
>>>>>>> mail regarding the warnings.
>>>>>>>
>>>>>>> I put those maintainers in the To: field of this mail, maybe that
>>>>>>> might
>>>>>>> lead to some reaction.
>>>>>>
>>>>>> Still no reply from the DRS folks or any other progress I noticed.
>>>>>> Guess
>>>>>> that means I will soon have no other choice than to get Linus
>>>>>> involved,
>>>>>> as this looks stuck. :-( #sigh
>>>>>
>>>>> Does it have to be Linus that needs to apply "[PATCH 0/2] Set PHY
>>>>> address
>>>>> of MT7531 switch to 0x1f on MediaTek arm64 boards"? Aren't there
>>>>> any other
>>>>> ARM maintainers that can apply the fix to their tree?
>>>>>
>>>>> Arınç
>>>>
>>>> You have feedback from two people on the series that you mentioned,
>>>> and noone
>>>> is going to apply something that needs to be fixed.
>>>>
>>>> I'm giving you the possibility of addressing the comments in your
>>>> patch, but
>>>> I don't want to see any mention of the driver previously ignoring
>>>> this or that
>>>> as this is irrelevant for a hardware description. Devicetree only
>>>> describes HW.
>>>>
>>>> Adding up, in commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY
>>>> address of switch from device tree"),
>>>> you have created a regression.
>>>>
>>>> Regressions should be fixed - as in - if the driver did work before
>>>> with the old
>>>> devicetrees, it shall still work. You can't break ABI. Any changes
>>>> that you do
>>>> to your driver must not break functionality with old devicetrees.
>>>>
>>>> So...
>>>>
>>>> ------> Fix the driver that you broke <------
>>>
>>> The device tree ABI before the change on the driver:
>>>
>>> The reg value represents the PHY address of the switch.
>>>
>>> The device tree ABI after the change on the driver:
>>>
>>> The reg value represents the PHY address of the switch.
>>>
>>> I see no device tree ABI breakage. What I see instead is the driver
>>> starting enforcing the device tree ABI. No change had been made on the
>>> device tree ABI so any non-Linux driver that controls this switch
>>> continues
>>> to work.
>>>
>>> These old device tree source files in question did not abide by the
>>> device
>>> tree ABI in the first place, which is why they don't work anymore as the
>>> Linux driver now enforces the ABI. Device tree source files not
>>> conforming
>>> to the ABI is not something to maintain but to fix. The patch series
>>> that
>>> fixes them are already submitted.
>>
>> As I said, the devicetree MUST describe the hardware correctly, and on
>> that I do
>> agree, and I, again, said that I want to take the devicetree fix.
>>
>> However, the driver regressed, and this broke functionality with old
>> device trees.
>> Old device trees might have been wrong (and they are, yes), but
>> functionality was
>> there and the switch was working.
>>
>> I repeat, driver changes MUST be retro-compatible with older device
>> trees, and your
>> driver changes ARE NOT; otherwise, this wouldn't be called *regression*.
> 
> I'm going to argue that what caused the regression is the broken device
> tree. The recent change on the driver only worked towards exposing the
> broken device tree.

Well, for the kernel that does not matter much: due to our "no
regressions" rule and how Linus handles it the author of that "recent
change" (e.g. you) is responsible to fix regressions a change exposed --
or that change is reverted (I might be wrong, but I think there are
quotes from Linus in
https://docs.kernel.org/process/handling-regressions.html to back this
up). So in the end a revert in a week or two is likely the outcome,
unless you or someone else fixes it in a way that pleases
AngeloGioacchino et. at.

Ciao, Thorsten

