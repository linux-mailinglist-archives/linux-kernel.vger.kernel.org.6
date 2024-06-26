Return-Path: <linux-kernel+bounces-229965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA7291769F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553EF1F23B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077845C07;
	Wed, 26 Jun 2024 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="etL4M3jC"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15F1BF31;
	Wed, 26 Jun 2024 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371234; cv=none; b=FL22v4wCr2Fa92NJc+p5d/BbtmkJbrdlhQryHHzPHs46hiOfWRgvVpzBqNE2cJVvhoC9ULXl772GoWXgEZkIFr0i+5YA9fs7Yri4cfUt/GYX+UEtqfherxTsjbjA4p5NPboiJp54nJfEx65wiC0zQa89G51SywoaxurVFTlhuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371234; c=relaxed/simple;
	bh=LOCeZobGYXk8vuo4lDVp0pDi03DTdrwg74DCLcMVjRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gicnl6BR10WOnq2A91QHMQ37QFcUw21/mT8cWbUk8lO4hLSldwIA38Ci0u+eL0NWqS2e2MR3y0f6Xx5O2m5XfC0JSKgA4FJdswnvsx2LlxDcAzdW5rcyEXd/I/tw3FN64yUaQDvo2TSnO54AjXQGG5W7ejCAngpc9bLOpqCUwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=etL4M3jC; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B935840003;
	Wed, 26 Jun 2024 03:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719371229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qDoIFqHWKLMrP+v9EU5xxxCReh4uHlGU6sBI8d0nIE=;
	b=etL4M3jCTeRri7CqNc5cuJFVBzbxOz4bNo+wAbG9rnjM+a5VKbUknpdd/Y7j1KX/icVYyC
	SGko0OAFYO+1BY2SUnuORbFbFM8zzNEpAxnEjwkjKsSuRzBJrMMg6K3QIxSat9MvxGbvMR
	KZFuYK5fx0DCs0Vy4ljMGQu0u25iCqN5kszjsclzRkrkxwtsu3pi9E5L06qdzHFeDmaKeW
	ftwFi3x8/WIaDEnh6CEo5Yh6SVcZ+bznL1oZiKfvp+688t4jvwznLLmxSMGFMtnyfKqf95
	b7H0B242ywlr2ZvSdzFTekPQ6y+Hy0TnFDF6WJpZ8Xqv9laeALLhpBGyRg6+CA==
Message-ID: <d4009f46-618c-46c3-8f35-a8db9150862e@arinc9.com>
Date: Wed, 26 Jun 2024 06:07:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Paolo Abeni <pabeni@redhat.com>
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
 <7a2ea06b-ae4e-4374-82c2-4de4184e06c3@arinc9.com>
 <40035548-c76b-4b0d-915f-c513eaadbc5d@leemhuis.info>
 <bb7e9cae-d627-4f38-9da2-b40fb3c349fe@arinc9.com>
 <4647181b-e5a0-4f6e-9aba-1bcde763d678@collabora.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <4647181b-e5a0-4f6e-9aba-1bcde763d678@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 25/06/2024 11.49, AngeloGioacchino Del Regno wrote:
> Il 25/06/24 10:17, Arınç ÜNAL ha scritto:
>> On 25/06/2024 09.57, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 25.06.24 08:17, Arınç ÜNAL wrote:
>>>> On 25/06/2024 08.56, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>>>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
>>>>>> wrote:
>>>>>> [...]
>>>>>> I've submitted a patch series that fixes the regression. Angelo argued
>>>>>> against the way the regression is fixed. I've very clearly argued
>>>>>> back why
>>>>>> I find Angelo's approach wrong. There's been no response back. I don't
>>>>>> understand why reverting the patch is the likely outcome
>>>>>
>>>>> Long story short: because that how things like that are handled in the
>>>>> Linux kernel project, as Linus wants it like that. See some of the
>>>>> quotes from https://docs.kernel.org/process/handling-regressions.html
>>>>> for details.
>>>>>
>>>>>> whilst the
>>>>>> standing argument points towards applying the said patch series. If a
>>>>>> revert happens before this discussion with Angelo finalises, this
>>>>>> will set
>>>>>> a precedent that will tell maintainers that they can have their way
>>>>>> by just
>>>>>> not replying to the ongoing discussions.
>>>>>>
>>>>>> That said, the decision of resolving the regression by either
>>>>>> reverting the
>>>>>> patch or applying the patch series shall not depend on whether or not
>>>>>> Angelo is pleased but rather there're no counter-arguments left on the
>>>>>> points brought, meaning the decision shall be made depending on the
>>>>>> argument that stands.
>>>>>>
>>>>>> Therefore, I suggest that unless Angelo responds back with a
>>>>>> counter-argument in the window of a week or two, as you've described, my
>>>>>> patch series shall be applied.
>>>>>
>>>>> It looks more and more like we are stuck here (or was there progress and
>>>>> I just missed it?) while the 6.10 final is slowly getting closer. Hence:
>>>>
>>>> There hasn't been progress at all. I believe I have clearly described the
>>>> way out of this issue.
>>>>
>>>>> AngeloGioacchino, should we ask the net maintainers to revert
>>>>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>>>>> device tree") for now to resolve this regression? Reminder, there is
>>>>> nothing wrong with that commit per se afaik, it just exposes a problem
>>>>> that needs to be fixed first before it can be reapplied.
>>>>
>>>> Are you suggesting the patch shall be reverted first, then the DT patch
>>>> applied, then the reverted patch applied back?
>>>
>>> Yeah.
>>>
> 
> Sorry, I've lost your reply in the long stack of emails that I get every day.
> 
> I'm not suggesting to revert the patch, but to fix it such that it does not
> break devices using old devicetrees, as it was the case before.
> 
> Even though, in a way, when you update the kernel, you do also update the
> devicetrees with it just because it's almost effortless to do so, doing that
> is not mandatory.
> 
> ...and that's why the driver, which was - in a way - faulty before, getting
> the switch to work even though the devicetree node was wrong, must still be
> compatible.
> 
> I do want to apply the devicetree fix, but I also do *not* want to see *driver*
> changes that go against the backward compatibility rule of devicetree when this
> is not strictly necessary (when it is - it's okay to make an exception)...
> 
> ...and this is not one of the cases in which it's strictly necessary.

I understand that you receive emails often. It seems you've not read my
point of view in the previous emails because of it, so it is preventing us
from having a proper discussion to come to a mutual agreement. I don't
intend to repeat myself for it to be lost in your inbox again.

I'm hoping that you manage to read this; Daniel has been working on a patch
[1] to make old device trees not hosted on the Linux repository with PHY
address wrongfully described as "0" work.

As I see the extend of the reported regression is limited to the BPI-R64
board, fixing the device tree source file for it - and mt7622-rfb1.dts as
the only remaining DTS file with wrong PHY address described in the Linux
repository - is enough to resolve the regression. Then Daniel's patch can
come in to address the device tree source files I've described above.
Although I don't find that patch necessary, I won't stand against it.

So I suggest to apply my DT patch series [2] without taking any other steps
to resolve the reported regression.

[1] https://lore.kernel.org/all/11f5f127d0350e72569c36f9060b6e642dfaddbb.1714514208.git.daniel@makrotopia.org/
[2] https://lore.kernel.org/all/20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com/

Arınç

