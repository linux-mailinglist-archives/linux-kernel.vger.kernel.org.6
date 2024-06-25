Return-Path: <linux-kernel+bounces-228506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B509B9160EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82AF1C22F09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE5822313;
	Tue, 25 Jun 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="n7r9Qbig"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FBC145FFE;
	Tue, 25 Jun 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303444; cv=none; b=DnsNFPI5R1I5ZCUwTmCIxp0L7U44wVcDCE8P/+E9+gEIRog3LHwa69/lhFodfgGNJkRRIhfYUYT7w6ti4PysZS20wNbgY7iApYQRwXqfgZQ+JR729hEkEfu6ZJArGauSIaXxIiHsDgH9tgsvRUqHF6uSM2+2IbR6xHv9TDZL49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303444; c=relaxed/simple;
	bh=ahZ1IlNJOXPgTay/HQbIBcXi0SqZxQBnKXQRaaKDpsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjvpCc+DYjHRPl1hSUGKiXJMJ6ek76d17hij5bMHH/z8gWDl1gFpSqMtRQEnIVQgcBGXnOxL+ntnY9eSyFrYHn3U2THRp3iCUkrzv0bDNy9CWFNQ8Gm4d5S8dcwrtjDcvYW8YyhLX+gUg/g2tHH6D0FwW58I0k66fttjqGB8WtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=n7r9Qbig; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62B741BF207;
	Tue, 25 Jun 2024 08:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719303440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hE2xd4QxwpEy7QXL+lAVyTmTgN2X6yquzmQ2NM2E7EA=;
	b=n7r9QbigIrXH9yhC12MrdNMh8FOIviHrg/M7D7taN3J5qjffT7qhqfSij2fkEgaElePZR3
	71r0Xk6IOOK/8CuoSmrK9Y0yFTUowXl+b7Tqr4SSN+6AQbdIbEt+yYwYm8XLoSDLXuabgU
	zCmZWv7tPmeulD7/jT+hf+EUBp3Cf50uJA+kiihV4JVCf1o9oWkbQdFYTTk9AGQOSexuRg
	/4D9UWAVsbh8dgpmU2hwJWTcTzikN6MHMFN3khnQjmuNiw44LY1dox1njbN3L/vNXNyiwQ
	FLizrA4peUFyyotRF62XAfZDBigiWXY8HHecPFHSrAq1iLllTQU70zEiIJ5b4g==
Message-ID: <bb7e9cae-d627-4f38-9da2-b40fb3c349fe@arinc9.com>
Date: Tue, 25 Jun 2024 11:17:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20240516204847.171029-1-linux@fw-web.de>
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
 <af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com>
 <750a60a6-4585-4bd2-97be-cf944e51fbdb@leemhuis.info>
 <7a2ea06b-ae4e-4374-82c2-4de4184e06c3@arinc9.com>
 <40035548-c76b-4b0d-915f-c513eaadbc5d@leemhuis.info>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <40035548-c76b-4b0d-915f-c513eaadbc5d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 25/06/2024 09.57, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 25.06.24 08:17, Arınç ÜNAL wrote:
>> On 25/06/2024 08.56, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
>>>> wrote:
>>>> [...]
>>>> I've submitted a patch series that fixes the regression. Angelo argued
>>>> against the way the regression is fixed. I've very clearly argued
>>>> back why
>>>> I find Angelo's approach wrong. There's been no response back. I don't
>>>> understand why reverting the patch is the likely outcome
>>>
>>> Long story short: because that how things like that are handled in the
>>> Linux kernel project, as Linus wants it like that. See some of the
>>> quotes from https://docs.kernel.org/process/handling-regressions.html
>>> for details.
>>>
>>>> whilst the
>>>> standing argument points towards applying the said patch series. If a
>>>> revert happens before this discussion with Angelo finalises, this
>>>> will set
>>>> a precedent that will tell maintainers that they can have their way
>>>> by just
>>>> not replying to the ongoing discussions.
>>>>
>>>> That said, the decision of resolving the regression by either
>>>> reverting the
>>>> patch or applying the patch series shall not depend on whether or not
>>>> Angelo is pleased but rather there're no counter-arguments left on the
>>>> points brought, meaning the decision shall be made depending on the
>>>> argument that stands.
>>>>
>>>> Therefore, I suggest that unless Angelo responds back with a
>>>> counter-argument in the window of a week or two, as you've described, my
>>>> patch series shall be applied.
>>>
>>> It looks more and more like we are stuck here (or was there progress and
>>> I just missed it?) while the 6.10 final is slowly getting closer. Hence:
>>
>> There hasn't been progress at all. I believe I have clearly described the
>> way out of this issue.
>>
>>> AngeloGioacchino, should we ask the net maintainers to revert
>>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>>> device tree") for now to resolve this regression? Reminder, there is
>>> nothing wrong with that commit per se afaik, it just exposes a problem
>>> that needs to be fixed first before it can be reapplied.
>>
>> Are you suggesting the patch shall be reverted first, then the DT patch
>> applied, then the reverted patch applied back?
> 
> Yeah.
> 
>> If only one of the first two
>> steps were done, it would fix the regression so I don't understand why go
>> through this tedious process when we can quite simply apply the DT patch to
>> resolve the regression.
> 
> Which DT patch do you mean here? Your series or the one from Frank at
> the start of the thread (the one you seems to be unhappy about iirc, but
> I might be wrong there)?

My series, as arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts needs to be
addressed too to resolve the regression.

> 
> Anyway, to answer the statement: because the maintainers that would have
> to accept the DT patch to resolve the problem apparently are not happy
> with it -- and nobody seems to be working on providing patches that make
> them happy which are also acceptable at this point of the devel cycle;
> so as it looks like currently to prevent the regression from entering
> 6.10 reverting the net change is the only option left.

I've already made my case regarding the situation with the DT patch. I
can't provide new patches because Angelo did not acknowledge my points yet.
I maintain the net driver and I too won't be happy with a revert on the
driver.

> 
>> Keep in mind that I maintain the MT7530 DSA subdriver and the company I
>> work with has got boards that uses the functionality the commit
>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>> device tree") brings.
> 
> Don't see a revert as setback at all, that's just normal for the kernel.
> I'm not the one that will decide about this anyway. And everyone
> involved afaics would like to prevent a revert. But it seems more and
> more likely that we are not getting there in time for the 6.10 release
> (or ideally -rc6 or -rc7 to allow some testing, as last-minute reverts
> can cause new problems).

I am still calling for the simple procedure of applying the DT patch to
resolve the regression.

Arınç

