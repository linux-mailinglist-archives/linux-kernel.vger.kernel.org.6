Return-Path: <linux-kernel+bounces-267334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5FA941064
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777781C22A19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB08719DF7A;
	Tue, 30 Jul 2024 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="H/HBDECl"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E761993B0;
	Tue, 30 Jul 2024 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338569; cv=none; b=KLCbiJ56S24TIIzsLcr06lax1mk8QT1Za/J0OxDqsIpVa5XMAqSPEpx/l5wtN6isuNF745nO7L1OAmWYVJMrncTrPZ9OZjSlTsnV/1ETkjqc+yXfXsZoMtz9nphhopJYDsmPxmZ2C3S2PYXo2ilWAEI6RFOkhvaen0Sqn5Ulz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338569; c=relaxed/simple;
	bh=btvD72VMf28f4JF1iiQKodEMlXAnBnvUhO4SSPsC4/0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LbXnY4UFjKle0q1HnuPEaODdhLSr5SxlXLUvyKJb8cWdxrsCh4kxjkAZOxTJLyvhuefA/GSo2eh1QNptrK0IpsHdDLFFbLmWJBnvljqnGUdFuWbVRaBN7UAVmOG4IX9x/dDjxJI/cd6t8wNOSphUhirNQ1tpAIO7fECPGnfPIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=H/HBDECl; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6ADFF240011;
	Tue, 30 Jul 2024 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1722338564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP/aZvi4J4ACsG3LNnAx3Id3SUazT49L+SvSO08XIr4=;
	b=H/HBDEClYQq3xqPGa+ABJv4b/avijVZDQhtiSYi9VtJsCQhuTYC5HodiXiHmXH5A5ts/nf
	q5H2BI5FOwYH7waBvP+wsbv7cdfgr9AMDQTVaBlqAwcUSGN9S+UP4YQI8vG8+ccR9J9f8n
	46BuwDUr97QMIPOw+iTlGslDBEyiSrqjBbQYqZxhjRTC7CrcKJONyabeil1WUBma1JY1rf
	EsIPkAiq86qe+OuOGM4L2Lj9KrfXoOfVWPgG3dl+zpcxBNBc9dkwfAtuWgf8WlXq4QdsVW
	HHWqNgdjd75pmO4L2HE8X4U/fOVR78iMPn9OBIQkmrSql1RHBAXdwKzEc05kTw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 14:22:42 +0300
From: arinc.unal@arinc9.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Paolo
 Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>,
 frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
In-Reply-To: <b3fa66cc-516b-4d78-aee5-62a47b52a3b1@collabora.com>
References: <20240516204847.171029-1-linux@fw-web.de>
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
 <af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com>
 <750a60a6-4585-4bd2-97be-cf944e51fbdb@leemhuis.info>
 <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
 <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
 <1aedb1d4-8dc3-4e17-aff1-7cc417465967@arinc9.com>
 <130518e2-d6dd-49ed-9cc2-ca9cdec93b98@leemhuis.info>
 <aeb255ff-3755-4f76-a8f8-cda27a67f818@arinc9.com>
 <b3fa66cc-516b-4d78-aee5-62a47b52a3b1@collabora.com>
Message-ID: <2076f699540c3c9d10effdb8b55d3f89@arinc9.com>
X-Sender: arinc.unal@arinc9.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 2024-07-30 12:41, AngeloGioacchino Del Regno wrote:
> Il 01/07/24 10:15, Arınç ÜNAL ha scritto:
>> On 01/07/2024 11:04, Linux regression tracking (Thorsten Leemhuis) 
>> wrote:
>>> On 01.07.24 09:44, Arınç ÜNAL wrote:
>>>> On 01/07/2024 09:16, Linux regression tracking (Thorsten Leemhuis) 
>>>> wrote:
>>>>> [CCing the other net maintainers]
>>>>> 
>>>>> On 25.06.24 10:51, AngeloGioacchino Del Regno wrote:
>>>>>> Il 25/06/24 07:56, Linux regression tracking (Thorsten Leemhuis) 
>>>>>> ha
>>>>>> scritto:
>>>>>>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>>>>>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten 
>>>>>>>> Leemhuis)
>>>>>>>> wrote:
>>>>>>>> [...]
>>>>>>> It looks more and more like we are stuck here (or was there 
>>>>>>> progress
>>>>>>> and
>>>>>>> I just missed it?) while the 6.10 final is slowly getting closer.
>>>>>>> Hence:
>>>>>>> 
>>>>>>> AngeloGioacchino, should we ask the net maintainers to revert
>>>>>>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of 
>>>>>>> switch from
>>>>>>> device tree") for now to resolve this regression? Reminder, there 
>>>>>>> is
>>>>>>> nothing wrong with that commit per se afaik, it just exposes a 
>>>>>>> problem
>>>>>>> that needs to be fixed first before it can be reapplied.
>>>>>> 
>>>>>> To be clear on this: I asked for the commit to be fixed such that 
>>>>>> it
>>>>>> guarantees
>>>>>> backwards compatibility with older device trees.
>>>>>> 
>>>>>> If no fix comes,
>>>>> 
>>>>> I haven't see any since that mail, did you? If not, I think...
>>>>> 
>>>>>> then I guess that we should ask them to revert this commit
>>>>>> until a fix is available.
>>>>> 
>>>>> ...it's time to ask them for the revert to resolve this for -rc7 
>>>>> (and
>>>>> avoid a last minute revert), or what do you think?
>>>> 
>>>> This is quite frustrating. I absolutely won't consent to a revert. 
>>>> [...]
>>> 
>>> Reminder: try to not see a revert as a bad thing. It's just means 
>>> "not
>>> ready yet, revert and we'll try again later" -- that's actually
>>> something Linus wrote just a few hours ago:
>>> https://lore.kernel.org/lkml/CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com/
>> 
>> Except it is ready and trying again is my responsibility, which means
>> unnecessary work for me to do. I've already got a ton of things to do.
>> Applying the device tree patch resolves this regression; no reverts 
>> needed.
>> And then there's the patch in the works by Daniel that will address 
>> all the
>> remaining cases outside of the reported regression.
>> 
> 
> The commit that fixes your breakage in a way that does *not* please me
> (because of older devicetrees being still broken with the new driver) 
> was
> picked and it is in v6.11-rc1.
> 
> I had to do this because I value the community (in this case, the 
> users) much
> more than trying to make an arrogant developer to act in a 
> community-friendly
> manner while leaving things completely broken.
> 
> That said, remembering that we're humans and, as such, it's normal to 
> get something
> wrong during the development process, I want to remind you that:
> 
>  1. A series that creates regressions is *not* good and *not* ready to 
> be
>     upstreamed; and
>  2. As a maintainer, you have the responsibility of not breaking the 
> kernel,
>     not breaking devices and not breaking currently working 
> functionality; and
>  3. Devicetrees being wrong (but working) since day 0 is not an excuse 
> to break
>     functionality; and
>  4. Blaming the one who introduced the devicetree (you're doing that, 
> since you
>     are blaming the devicetree being wrong) isn't solving anything and 
> will not
>     magically make your code acceptable or good; and
>  5. If you push a wrong commit, there's nothing to be ashamed of; and
>  6. If you make a mistake, you should recognize that and find a way to
>     make things right, that should be done for the community, not for
>     yourself; and
>  7. You shall respect the community: in this case, with your arrogant 
> behavior
>     you did *not* respect the users.
> 
> P.S.: The right way of making such change is to:
>       1. Avoid breaking currently working devices by making sure that 
> their DT
>          still works with the new driver; and
>       2. If breakage is unavoidable, make it so one kernel version has 
> a fix that
>          works with both old and new driver, and the next version 
> introduces the
>          breakage. N.2 should ideally never happen, anyway.
> 
> Let's wrap up this matter now - I don't want to spend any more word, 
> nor time,
> on this, as I really have nothing else to say.
> 
> Best regards,
> Angelo

To be clear, I only became aware that my patch was picked by reading 
this
email. It is clear that we have different views. To that extend, all of
what you have written above can be answered to by reading what I have
already written in this thread. Therefore, I don't see any wrongdoing 
from
my side and invite everyone to fully read this thread to draw their own
conclusions; something you seem not to have done. And I'm not the one,
calling people names here. I can only offer my respect for hard working
people.

In my view, your behaviour of not applying a devicetree patch before a
Linux driver patch was applied, and then not replying to any arguments
whatsoever, was keeping the devicetree files hostage until your demands
were met. What I see is that, you failed as a maintainer to attend to my
points against this practice. It's no surprise that, after not having 
heard
back from you with an argument against my points, my patch was 
eventually
taken in by someone else.

Arınç

