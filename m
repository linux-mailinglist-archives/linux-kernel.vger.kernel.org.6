Return-Path: <linux-kernel+bounces-268732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C994286F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310D51C21918
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7531A7F70;
	Wed, 31 Jul 2024 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="IIiGcgyW"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B318C91D;
	Wed, 31 Jul 2024 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412554; cv=none; b=kyQYp+OODF9gCinWyJ8byc1EsH8bqOUPb7CMDxokrrj0ht8qO83eGG7cuSUFjW9fxzrtoX7ecGFiOsHQVOGW0usFYRoVdh5dWCm/cnk3hHsByerxomG7dJ4Hjr0apNDgja6KnRN0Mv4l9mUTUAbK5mRPix2bRlEC5b5yLyA975o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412554; c=relaxed/simple;
	bh=tt99L3qQEZSlmPhZEggYbDhQJG+ExvCJjahC6H5Ay0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhY/CE3lyLtdA2Axz9cwZicztj/3yhnWQclEuUZYT+bmev14nNbjyXi2b+ZcmAI3hTABhB94xcF+d+n888z//jxHN0Yf5nuTb9aLgmg4Gn7cPHji9wezXjQQBKGXK8hqkHbQ1OnKAPo+Pv9+T9N5xuzVbMmE3tNWFovAf3kW0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=IIiGcgyW; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2AD4240002;
	Wed, 31 Jul 2024 07:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1722412544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cuuYq4B4A2tJJ88qvDkr4pnPIMR7Qh0bCqjvCxUpLM=;
	b=IIiGcgyWSrvUnfZN1McrAfgoL2uGDkBB2gqXhFkPZdYNjfz/4DVKGhlj3GlkgDgQucKCdq
	MO+tOqjNrytj2uyKieU3ut5WHrLpkV07PpG0RqWgRONbcXWOKtJ8bL9ywRyt240fXLsUym
	RMopYc4XZHg0bhHMFRV3zFbSfHa6FTAHuxTSjWsx1TvZk0JGGkZ+20M0+VVnrVskrC9qje
	8M0d07KxNszNj1uIlLkT1TNTrpAwt1eAacBLlcQrt/havZ63mQgXc/fzXKt3qmhinY5q6c
	jq35KsMQzR20Hx1cesRubvoiSxOEAPVFKifurYwVfHoQKCygWnkbnTwP9kuRZA==
Message-ID: <8f2343cc-125c-4877-b7be-bfe4134870be@arinc9.com>
Date: Wed, 31 Jul 2024 10:55:38 +0300
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
 <0f417818-3009-4476-88fb-47a9ca15d525@arinc9.com>
 <cf031c05-4082-4cfe-9a4a-0c855764ee04@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <cf031c05-4082-4cfe-9a4a-0c855764ee04@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 31/07/2024 08:29, Krzysztof Kozlowski wrote:
> On 30/07/2024 18:38, Arınç ÜNAL wrote:
>> On 30/07/2024 19:04, Krzysztof Kozlowski wrote:
>>> On 30/07/2024 13:22, arinc.unal@arinc9.com wrote:
>>>>>>>
>>>>>>> Reminder: try to not see a revert as a bad thing. It's just means
>>>>>>> "not
>>>>>>> ready yet, revert and we'll try again later" -- that's actually
>>>>>>> something Linus wrote just a few hours ago:
>>>>>>> https://lore.kernel.org/lkml/CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com/
>>>>>>
>>>>>> Except it is ready and trying again is my responsibility, which means
>>>>>> unnecessary work for me to do. I've already got a ton of things to do.
>>>>>> Applying the device tree patch resolves this regression; no reverts
>>>>>> needed.
>>>>>> And then there's the patch in the works by Daniel that will address
>>>>>> all the
>>>>>> remaining cases outside of the reported regression.
>>>>>>
>>>>>
>>>>> The commit that fixes your breakage in a way that does *not* please me
>>>>> (because of older devicetrees being still broken with the new driver)
>>>>> was
>>>>> picked and it is in v6.11-rc1.
>>>>>
>>>>> I had to do this because I value the community (in this case, the
>>>>> users) much
>>>>> more than trying to make an arrogant developer to act in a
>>>>> community-friendly
>>>>> manner while leaving things completely broken.
>>>>>
>>>>> That said, remembering that we're humans and, as such, it's normal to
>>>>> get something
>>>>> wrong during the development process, I want to remind you that:
>>>>>
>>>>>    1. A series that creates regressions is *not* good and *not* ready to
>>>>> be
>>>>>       upstreamed; and
>>>>>    2. As a maintainer, you have the responsibility of not breaking the
>>>>> kernel,
>>>>>       not breaking devices and not breaking currently working
>>>>> functionality; and
>>>>>    3. Devicetrees being wrong (but working) since day 0 is not an excuse
>>>>> to break
>>>>>       functionality; and
>>>>>    4. Blaming the one who introduced the devicetree (you're doing that,
>>>>> since you
>>>>>       are blaming the devicetree being wrong) isn't solving anything and
>>>>> will not
>>>>>       magically make your code acceptable or good; and
>>>>>    5. If you push a wrong commit, there's nothing to be ashamed of; and
>>>>>    6. If you make a mistake, you should recognize that and find a way to
>>>>>       make things right, that should be done for the community, not for
>>>>>       yourself; and
>>>>>    7. You shall respect the community: in this case, with your arrogant
>>>>> behavior
>>>>>       you did *not* respect the users.
>>>>>
>>>>> P.S.: The right way of making such change is to:
>>>>>         1. Avoid breaking currently working devices by making sure that
>>>>> their DT
>>>>>            still works with the new driver; and
>>>>>         2. If breakage is unavoidable, make it so one kernel version has
>>>>> a fix that
>>>>>            works with both old and new driver, and the next version
>>>>> introduces the
>>>>>            breakage. N.2 should ideally never happen, anyway.
>>>>>
>>>>> Let's wrap up this matter now - I don't want to spend any more word,
>>>>> nor time,
>>>>> on this, as I really have nothing else to say.
>>>>>
>>>>> Best regards,
>>>>> Angelo
>>>>
>>>> To be clear, I only became aware that my patch was picked by reading
>>>> this
>>>> email. It is clear that we have different views. To that extend, all of
>>>> what you have written above can be answered to by reading what I have
>>>> already written in this thread. Therefore, I don't see any wrongdoing
>>>> from
>>>> my side and invite everyone to fully read this thread to draw their own
>>>> conclusions; something you seem not to have done. And I'm not the one,
>>>> calling people names here. I can only offer my respect for hard working
>>>> people.
>>>>
>>>> In my view, your behaviour of not applying a devicetree patch before a
>>>> Linux driver patch was applied, and then not replying to any arguments
>>>> whatsoever, was keeping the devicetree files hostage until your demands
>>>
>>> Hm, why ever DTS patch should be applied before driver patch is? This
>>> clearly suggests ABI break. You proposed to fix ABI issue by fixing DTS,
>>> which is not the way, because it literally fixes nothing. You got
>>> comments - fix the driver to be backwards compatible.
>>
>> As I argued in this thread, I see no ABI issue here. I proposed to fix
>> broken devicetrees, nothing more. Please read the full thread to understand
>> where I'm coming from.
> 
> I read most of it and it does suggest ABI break. But even if you do not
> focus on that aspect, your suggestion that DTS should be applied before
> driver patch is just wrong. It was never like this and it must not be
> like this.
> 
> Best regards,
> Krzysztof

I will use the ABI, bindings, and dt-bindings terms synonymously here.

Let's discuss the Devicetree Specification Releasev0.4. In 2.1, it is
stated that DTSpec specifies a construct called a devicetree to describe
system hardware. A boot program loads a devicetree into a client program’s
memory and passes a pointer to the devicetree to the client.

A devicetree is a tree data structure with nodes that describe the devices
in a system. Each node has property/value pairs that describe the
characteristics of the device being represented. Each node has exactly one
parent except for the root node, which has no parent. A device in this
context may be an actual hardware device, such as a UART. It may be part of
a hardware device, such as the random-number generator in a TPM. It may
also be a device provided through virtualisation, such as a protocol
providing access to an I2C device attached to a remote CPU. A device may
include functions implemented by firmware running in higher privilege
levels or remote processors. There is no requirement that nodes in a device
tree be a physical hardware device, but generally they have some
correlation to physical hardware devices. Nodes should not be designed for
OS- or project- specific purposes. They should describe something which can
be implemented by any OS or project.

As read here, devicetree design is not to be influenced by any project.
That would mean that bindings and devicetree source files are described
first, then the implementation is made by any OS or project. To be specific
to the case here, it makes no sense to hold a patch that fixes a devicetree
source file until a Linux driver patch is taken in.

I think the dt-bindings and the DT source files being hosted on the Linux
repository greatly contributes to this false impression that Linux drivers
have any influence over the design of bindings or fixing DT source files
that did not comply with the bindings. That is why I'm looking forward to
the efforts to take dt-bindings and DT source files out of the Linux
repository into its own, separate repository. This would be a great step in
addressing all the project-dependent bindings of Linux, U-Boot, OpenWrt,
and all other projects, to have a single, unified repository to describe
all the hardware that exists in the world.

One of the concepts of the devicetree architecture is that a boot program
can describe and communicate system hardware information to a client
program, thus eliminating the need for the client program to have
hard-coded descriptions of system hardware. Not only eliminate the need of
that, but allow hardware with a different value for the description than
what was hard-coded.

A driver change cannot possibly break ABI because it's the implementation
being changed, not the bindings. The implementation change can be so that
it breaks compliance with the bindings. Which is not the case with the
change made in the Linux driver in question. I have eliminated the
hard-coded description from the Linux driver. That did not break compliance
with the bindings. Instead, the implementation change made the driver
compliant with the bindings; specifically, the description where the reg
value represents the PHY address of the switch.

It is important to note that old devicetrees that abided to the bindings
still work after the Linux driver change. This is also, of course, the case
for any DT source files hosted out of the Linux repository.

Therefore, the correct path forward was to correct the DT source files that
include values for descriptions that do not reflect the hardware it
describes. Which is eventually what happened here. To be more specific, we
fixed the incorrect description of the switch's PHY address on the DT
source file as, on the hardware, the switch listens on PHY address 0x1f.

Arınç

