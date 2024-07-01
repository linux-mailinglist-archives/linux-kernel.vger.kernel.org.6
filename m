Return-Path: <linux-kernel+bounces-235797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90F991D9C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EDE283A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30488248C;
	Mon,  1 Jul 2024 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="p1OdbpAW"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926E383AB;
	Mon,  1 Jul 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821768; cv=none; b=JZkkQQ4fkVo+3LmmN8MkuWI5Apkdc+tqk/hkanV/R/M08140T7NU60JTvP5a9QeXwimuVejhsCY+moAgkhvps5h/Ymr+MomNs3gAmoB9iviJ4FTKH/EAJ6DCVSjnG6yGp1XuaWF8wFcWPVdbhml1oSR/JE6cbOvBlX9WjzSPjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821768; c=relaxed/simple;
	bh=3+Oc77rWabR7TDJw9wxWEoPyVi2WK625Uc5pLr0UM3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Im58wU8kNogiSGNjCsp/iZ3liZlSH0sw/AJONa1u0443+H1nJomMiKJkPpGJt7hSesVFn4iqcFMRI+qkFCYjPIMaiuuJU97aFjUiJd33SvBJZxRbLfd5EiAI5+a4Rh6N4Xb0i6yNJ3F/FSZhNiCqQhS18szJSpwYv5UcCNaHpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=p1OdbpAW; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81A171C0005;
	Mon,  1 Jul 2024 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719821757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb3ioG46MVMhJrZ+bnRLqzojpFTF/kcuuAOnVgBs574=;
	b=p1OdbpAWa55TrDe7itSf8E4cr/iKBsUNY3rqFxY+IFGRyCdwWsaCMtQJrgm0JlBhqN1aKZ
	jnCsJRgcY0n2Fuzsg7Z+Inbwu5BolhaMKGk4U4IDL89uJ8T+qzp3TKY99vmHthy+BvMaBa
	LxDSLHq56Ei+K2/FuU1lhYS9ve5V8ShmyuL3OLNwKfW56DV0KSgCaAgplBrKM+lo6WfWq6
	MsJ5sKrs5ukMRpFMY2KYScoXbFhGOag6G7pcW3MqznWx78+371vX6Ek47spvyUeBxfv2AB
	dxIEzGGcW78tiWAxdskUOI71OhGuPVqnWyCfu29tSchrBEsp1cuY0TpdmvX2PA==
Message-ID: <aeb255ff-3755-4f76-a8f8-cda27a67f818@arinc9.com>
Date: Mon, 1 Jul 2024 11:15:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20240516204847.171029-1-linux@fw-web.de>
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
 <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
 <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
 <1aedb1d4-8dc3-4e17-aff1-7cc417465967@arinc9.com>
 <130518e2-d6dd-49ed-9cc2-ca9cdec93b98@leemhuis.info>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <130518e2-d6dd-49ed-9cc2-ca9cdec93b98@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 01/07/2024 11:04, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 01.07.24 09:44, Arınç ÜNAL wrote:
>> On 01/07/2024 09:16, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> [CCing the other net maintainers]
>>>
>>> On 25.06.24 10:51, AngeloGioacchino Del Regno wrote:
>>>> Il 25/06/24 07:56, Linux regression tracking (Thorsten Leemhuis) ha
>>>> scritto:
>>>>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>>>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
>>>>>> wrote:
>>>>>> [...]
>>>>> It looks more and more like we are stuck here (or was there progress
>>>>> and
>>>>> I just missed it?) while the 6.10 final is slowly getting closer.
>>>>> Hence:
>>>>>
>>>>> AngeloGioacchino, should we ask the net maintainers to revert
>>>>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>>>>> device tree") for now to resolve this regression? Reminder, there is
>>>>> nothing wrong with that commit per se afaik, it just exposes a problem
>>>>> that needs to be fixed first before it can be reapplied.
>>>>
>>>> To be clear on this: I asked for the commit to be fixed such that it
>>>> guarantees
>>>> backwards compatibility with older device trees.
>>>>
>>>> If no fix comes,
>>>
>>> I haven't see any since that mail, did you? If not, I think...
>>>
>>>> then I guess that we should ask them to revert this commit
>>>> until a fix is available.
>>>
>>> ...it's time to ask them for the revert to resolve this for -rc7 (and
>>> avoid a last minute revert), or what do you think?
>>
>> This is quite frustrating. I absolutely won't consent to a revert. [...]
> 
> Reminder: try to not see a revert as a bad thing. It's just means "not
> ready yet, revert and we'll try again later" -- that's actually
> something Linus wrote just a few hours ago:
> https://lore.kernel.org/lkml/CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com/

Except it is ready and trying again is my responsibility, which means
unnecessary work for me to do. I've already got a ton of things to do.
Applying the device tree patch resolves this regression; no reverts needed.
And then there's the patch in the works by Daniel that will address all the
remaining cases outside of the reported regression.

Arınç

