Return-Path: <linux-kernel+bounces-209851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF5903BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90321283D98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01C17C213;
	Tue, 11 Jun 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3mv2TCWf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103D16F839;
	Tue, 11 Jun 2024 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108889; cv=none; b=Xw0eXn7yWcXuSGZ1xvstS460WVH4sCXt6cKK+uKWeiL6yQnURY0Luntz9FonX8FLqausmXMULw6mzM2fCVNHIclNqMF+05MkZktYRi2s3/HsezIuz0tBjCvolibSNSsR3jw+tgzyGA6ythZm6/ZjjVT5JONz6P2I4gMkfG3VCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108889; c=relaxed/simple;
	bh=MVhJd/IENmXCGf1wjGGZDAf+X3LDJ+2yYb11vSE6vbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koYxcjj/V8rRI1l3JFhelcQR1QPNgFKXBkn3ItXVDlbjl6iXWsN/GXd4zlTYR0w5ubTvd3zfWk7RasF2edSWMSpO4ruN3zWvAHIX/mEvloWJfFGN1X9+5Y5CORNKWG+tiAr+QRJdZrGMbX67uH94qlj2pZi6UbaT+dy5Xj5mN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3mv2TCWf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718108885;
	bh=MVhJd/IENmXCGf1wjGGZDAf+X3LDJ+2yYb11vSE6vbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3mv2TCWfFFFoA4aVNFbile1CCpI/1foRu2oCEMK8nxCxS1XSykZshhVjCZixM1K9z
	 PS51So12AEX7IXftLZZqK1rarIS7pEjdqJ+FCOvxTJmS8JyQIQpC2f74YfCgjtHJlz
	 8Gt5aNPjFE0XGuQWtQ7b8m9/d9JH8iXMPfVgMiFbaz4xXbkfyHufTiknNP+IjFiG8X
	 wKBoL8ltCh4Q96I0JIhn2AB/0nh0VQcSfCKmTDI9MgAbT5HtroqXZtQMqRCDpMP3y6
	 IrywMyLiOunRMybtHNZUM1fxvfCWFC9pNFa/s83W0FYET+P115JCLlPpUmUflFDo7y
	 rnlQKD6xJWzpQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 98D593780EC6;
	Tue, 11 Jun 2024 12:28:04 +0000 (UTC)
Message-ID: <58d8ddea-71cc-427a-94cc-a95f6bce61d2@collabora.com>
Date: Tue, 11 Jun 2024 14:28:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <1807a142-1534-4fa4-ad4b-d1c03af014c2@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 11/06/24 13:38, Arınç ÜNAL ha scritto:
> On 11/06/2024 14:30, Thorsten Leemhuis wrote:
>> On 07.06.24 16:15, Thorsten Leemhuis wrote:
>>> On 07.06.24 16:03, Paolo Abeni wrote:
>>>> On Thu, 2024-06-06 at 10:26 +0200, Thorsten Leemhuis wrote:
>>>>> On 31.05.24 08:10, Arınç ÜNAL wrote:
>>>>>> On 31/05/2024 08.40, Thorsten Leemhuis wrote:
>>>>>>> [adding Paolo, who committed the culprit]
>>>>>
>>>>> /me slowly wonders if the culprit should be reverted for now (see below)
>>>>> and should be reapplied later together with the matching changes from
>>>>> Arınç ÜNAL.
>>>>
>>>> FWIS I think a revert should be avoided, given that a fix is available
>>>> and nicely small.
>>>
>>> Yeah, on one hand I agree; but on the other it seems that the
>>> maintainers that would have to take care of the dt changes to fix this
>>> until now remained silent in this thread, apart from Rob who sent the
>>> mail regarding the warnings.
>>>
>>> I put those maintainers in the To: field of this mail, maybe that might
>>> lead to some reaction.
>>
>> Still no reply from the DRS folks or any other progress I noticed. Guess
>> that means I will soon have no other choice than to get Linus involved,
>> as this looks stuck. :-( #sigh
> 
> Does it have to be Linus that needs to apply "[PATCH 0/2] Set PHY address
> of MT7531 switch to 0x1f on MediaTek arm64 boards"? Aren't there any other
> ARM maintainers that can apply the fix to their tree?
> 
> Arınç

You have feedback from two people on the series that you mentioned, and noone
is going to apply something that needs to be fixed.

I'm giving you the possibility of addressing the comments in your patch, but
I don't want to see any mention of the driver previously ignoring this or that
as this is irrelevant for a hardware description. Devicetree only describes HW.

Adding up, in commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of 
switch from device tree"),
you have created a regression.

Regressions should be fixed - as in - if the driver did work before with the old
devicetrees, it shall still work. You can't break ABI. Any changes that you do
to your driver must not break functionality with old devicetrees.

So...

------> Fix the driver that you broke <------

After you've fixed it - and I repeat - only after, *and* after someone (Frank?)
validates that the old devicetrees do work with the fixed driver, I will take
the device tree fixes for that MDIO address (as those are, again, fixing a
description of the hardware on those boards, so I agree that those must be fixed
AS WELL).


Regards,
Angelo

