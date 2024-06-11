Return-Path: <linux-kernel+bounces-209885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C857903C84
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805E91F23C21
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41017C7AD;
	Tue, 11 Jun 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="dCLceSUs"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D017C20E;
	Tue, 11 Jun 2024 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110577; cv=none; b=ScMtuYAMNKMK+2C78EwPuAap0MNkcnrXK7GE4d9jb8cJ28Wa3vqqjfzi9R4FDu+Ntaj//0UucXJ0fTRsaHFcBxbMuxyeYJOf89jtiWCqxGaU6TcGfQ46tYdKVyYUQ0zzWZd+qebLq/xDgdIAiwT9VqhHQWrzEHnrwag9uwYd4ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110577; c=relaxed/simple;
	bh=0xHND71O47luA8tSgp2PR2pGO/Wvc9q6sb8c6ONUlIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKZaF9Q03fhszfhTddW6bBDvgPkKGhmgAl8WlUp1WnSuYhWQcBoKn0uuoyl8QXuyARVbUPLkDPzhLan9mMySwYroKHIc09lElwvqDw3NaF2lig4wnmBl70vcuw8Hp33zKIgVx3j95WcDlVLe2fwa+S58dYL1bkIl9ZVTXtlI8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=dCLceSUs; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 593C51C0005;
	Tue, 11 Jun 2024 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1718110573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRBXuK79B6qtIkeZB4guCW1GEiypIyRuTLhk26GSAxw=;
	b=dCLceSUsIr4URAOuKTFnqrPKGy1Ub/ZCASu+Oa83xf4VOOzZmJO3X7kZ7BoC83jXbSttO3
	GrNLlVGK+4xXZF6+1mOasACZHEOnLVnCcRUf/dx2M28hqKwJWX8Y0kE4rSh80NrEknNu2b
	YHO1065rVkqvffAvNZTq2yrDobqOlSzgr30E9/nSoAP2W6iZ4XhsCf0J06T5c4Ay4IOtdk
	OUJPqAlNb5KveKsAYPSJG6bG2TCdqBd2sAf+xIUWxaIw62++ojG5UEJ0Dqjlm1bjIbq5mk
	2A4fEar7cQma0LNGWIa9jyBnAuDjpKHwsTRH/S30FcgYH/D3f3Uw2wwm5n+ozQ==
Message-ID: <16e9c06e-9908-455d-a387-614fefe5bcf8@arinc9.com>
Date: Tue, 11 Jun 2024 15:56:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <58d8ddea-71cc-427a-94cc-a95f6bce61d2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 11/06/2024 15:28, AngeloGioacchino Del Regno wrote:
> Il 11/06/24 13:38, Arınç ÜNAL ha scritto:
>> On 11/06/2024 14:30, Thorsten Leemhuis wrote:
>>> On 07.06.24 16:15, Thorsten Leemhuis wrote:
>>>> On 07.06.24 16:03, Paolo Abeni wrote:
>>>>> On Thu, 2024-06-06 at 10:26 +0200, Thorsten Leemhuis wrote:
>>>>>> On 31.05.24 08:10, Arınç ÜNAL wrote:
>>>>>>> On 31/05/2024 08.40, Thorsten Leemhuis wrote:
>>>>>>>> [adding Paolo, who committed the culprit]
>>>>>>
>>>>>> /me slowly wonders if the culprit should be reverted for now (see below)
>>>>>> and should be reapplied later together with the matching changes from
>>>>>> Arınç ÜNAL.
>>>>>
>>>>> FWIS I think a revert should be avoided, given that a fix is available
>>>>> and nicely small.
>>>>
>>>> Yeah, on one hand I agree; but on the other it seems that the
>>>> maintainers that would have to take care of the dt changes to fix this
>>>> until now remained silent in this thread, apart from Rob who sent the
>>>> mail regarding the warnings.
>>>>
>>>> I put those maintainers in the To: field of this mail, maybe that might
>>>> lead to some reaction.
>>>
>>> Still no reply from the DRS folks or any other progress I noticed. Guess
>>> that means I will soon have no other choice than to get Linus involved,
>>> as this looks stuck. :-( #sigh
>>
>> Does it have to be Linus that needs to apply "[PATCH 0/2] Set PHY address
>> of MT7531 switch to 0x1f on MediaTek arm64 boards"? Aren't there any other
>> ARM maintainers that can apply the fix to their tree?
>>
>> Arınç
> 
> You have feedback from two people on the series that you mentioned, and noone
> is going to apply something that needs to be fixed.
> 
> I'm giving you the possibility of addressing the comments in your patch, but
> I don't want to see any mention of the driver previously ignoring this or that
> as this is irrelevant for a hardware description. Devicetree only describes HW.
> 
> Adding up, in commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of switch from device tree"),
> you have created a regression.
> 
> Regressions should be fixed - as in - if the driver did work before with the old
> devicetrees, it shall still work. You can't break ABI. Any changes that you do
> to your driver must not break functionality with old devicetrees.
> 
> So...
> 
> ------> Fix the driver that you broke <------

The device tree ABI before the change on the driver:

The reg value represents the PHY address of the switch.

The device tree ABI after the change on the driver:

The reg value represents the PHY address of the switch.

I see no device tree ABI breakage. What I see instead is the driver
starting enforcing the device tree ABI. No change had been made on the
device tree ABI so any non-Linux driver that controls this switch continues
to work.

These old device tree source files in question did not abide by the device
tree ABI in the first place, which is why they don't work anymore as the
Linux driver now enforces the ABI. Device tree source files not conforming
to the ABI is not something to maintain but to fix. The patch series that
fixes them are already submitted.

> 
> After you've fixed it - and I repeat - only after, *and* after someone (Frank?)
> validates that the old devicetrees do work with the fixed driver, I will take
> the device tree fixes for that MDIO address (as those are, again, fixing a
> description of the hardware on those boards, so I agree that those must be fixed
> AS WELL).

Sorry, this approach makes no sense to me.

Arınç

