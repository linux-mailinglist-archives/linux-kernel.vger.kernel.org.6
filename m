Return-Path: <linux-kernel+bounces-267899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D19419F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D461C239D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80157146D6B;
	Tue, 30 Jul 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="bgtL+o52"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373011898ED;
	Tue, 30 Jul 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357498; cv=none; b=hHPPJjewCrfBtTcNyaNfevJ/FakUCEcxczvIrEblqw9V4kl4fP66Qeu1M/nuFaHc/g3REsjVTrmEz8b3dTix+zQYFfvgYk3nTJohgLVa3Zq70XX0rFU7tlltkrmvuCnaoL/ALSOmCsNIGmYeYuEtXwK/8l3hJsPT4NzUkFFdWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357498; c=relaxed/simple;
	bh=62xIos+Gvt2zovnHW3Alk6oI02ztwSKcZ3tqrlGrKRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dm/qmZPAjGBV5V0rZHc6+qxJxFcbWHa8oKeUiMupfDGkBLCuSItPUAx/DA5s2OhvHJPljrz9/ajOZUysnyi84Hz1DpgyEUHdX7pIZ3uHGx7dvQtIY9C1PDfkDBomm75VzCdtgt7fsOg13eP5nTxPDH2TqLK3WHx+PXaesaptBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=bgtL+o52; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 637C21BF20A;
	Tue, 30 Jul 2024 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1722357494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnbvuVHDbWwwk4Gu5lDCFcSTqlVTHWq0eITAVsUoCWs=;
	b=bgtL+o521SArrgfKSvfoEAiRDSauzSciKRX0MiCGm7uZHQ0VvHfkT5DM4HFQfOs4LS5fpe
	kH2d8Xz7McJ1R5oGUh9Y8IWUpLqFY9LQUH5IBo9pmXhmq12Nyd/XvSwG1JDq8B8X4lU/FL
	K3yvuvLDN2MO3ov16KEt3ccYKkEi8CWAiJ4JITftWR2obwzPZGE6wKNp98O75EIm1+Dxmr
	0GPAYiB3HnutGj9FyISXLYBVrFUaEW71tSe/lyyl6xixbdA9iZlgnzBgJ0FzZtxzkHBMB1
	MdXANQsMMVvUnjKmUS1/xfwOzYcClkc5YTr8aR+CB8KlvUg338xwTqWTwJpm8Q==
Message-ID: <0f417818-3009-4476-88fb-47a9ca15d525@arinc9.com>
Date: Tue, 30 Jul 2024 19:38:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Krzysztof Kozlowski <krzk@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>,
 frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20240516204847.171029-1-linux@fw-web.de>
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
 <2076f699540c3c9d10effdb8b55d3f89@arinc9.com>
 <921f448b-4085-4c8d-85f8-478318d9c054@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <921f448b-4085-4c8d-85f8-478318d9c054@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 30/07/2024 19:04, Krzysztof Kozlowski wrote:
> On 30/07/2024 13:22, arinc.unal@arinc9.com wrote:
>>>>>
>>>>> Reminder: try to not see a revert as a bad thing. It's just means
>>>>> "not
>>>>> ready yet, revert and we'll try again later" -- that's actually
>>>>> something Linus wrote just a few hours ago:
>>>>> https://lore.kernel.org/lkml/CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com/
>>>>
>>>> Except it is ready and trying again is my responsibility, which means
>>>> unnecessary work for me to do. I've already got a ton of things to do.
>>>> Applying the device tree patch resolves this regression; no reverts
>>>> needed.
>>>> And then there's the patch in the works by Daniel that will address
>>>> all the
>>>> remaining cases outside of the reported regression.
>>>>
>>>
>>> The commit that fixes your breakage in a way that does *not* please me
>>> (because of older devicetrees being still broken with the new driver)
>>> was
>>> picked and it is in v6.11-rc1.
>>>
>>> I had to do this because I value the community (in this case, the
>>> users) much
>>> more than trying to make an arrogant developer to act in a
>>> community-friendly
>>> manner while leaving things completely broken.
>>>
>>> That said, remembering that we're humans and, as such, it's normal to
>>> get something
>>> wrong during the development process, I want to remind you that:
>>>
>>>   1. A series that creates regressions is *not* good and *not* ready to
>>> be
>>>      upstreamed; and
>>>   2. As a maintainer, you have the responsibility of not breaking the
>>> kernel,
>>>      not breaking devices and not breaking currently working
>>> functionality; and
>>>   3. Devicetrees being wrong (but working) since day 0 is not an excuse
>>> to break
>>>      functionality; and
>>>   4. Blaming the one who introduced the devicetree (you're doing that,
>>> since you
>>>      are blaming the devicetree being wrong) isn't solving anything and
>>> will not
>>>      magically make your code acceptable or good; and
>>>   5. If you push a wrong commit, there's nothing to be ashamed of; and
>>>   6. If you make a mistake, you should recognize that and find a way to
>>>      make things right, that should be done for the community, not for
>>>      yourself; and
>>>   7. You shall respect the community: in this case, with your arrogant
>>> behavior
>>>      you did *not* respect the users.
>>>
>>> P.S.: The right way of making such change is to:
>>>        1. Avoid breaking currently working devices by making sure that
>>> their DT
>>>           still works with the new driver; and
>>>        2. If breakage is unavoidable, make it so one kernel version has
>>> a fix that
>>>           works with both old and new driver, and the next version
>>> introduces the
>>>           breakage. N.2 should ideally never happen, anyway.
>>>
>>> Let's wrap up this matter now - I don't want to spend any more word,
>>> nor time,
>>> on this, as I really have nothing else to say.
>>>
>>> Best regards,
>>> Angelo
>>
>> To be clear, I only became aware that my patch was picked by reading
>> this
>> email. It is clear that we have different views. To that extend, all of
>> what you have written above can be answered to by reading what I have
>> already written in this thread. Therefore, I don't see any wrongdoing
>> from
>> my side and invite everyone to fully read this thread to draw their own
>> conclusions; something you seem not to have done. And I'm not the one,
>> calling people names here. I can only offer my respect for hard working
>> people.
>>
>> In my view, your behaviour of not applying a devicetree patch before a
>> Linux driver patch was applied, and then not replying to any arguments
>> whatsoever, was keeping the devicetree files hostage until your demands
> 
> Hm, why ever DTS patch should be applied before driver patch is? This
> clearly suggests ABI break. You proposed to fix ABI issue by fixing DTS,
> which is not the way, because it literally fixes nothing. You got
> comments - fix the driver to be backwards compatible.

As I argued in this thread, I see no ABI issue here. I proposed to fix
broken devicetrees, nothing more. Please read the full thread to understand
where I'm coming from.

Arınç

