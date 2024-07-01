Return-Path: <linux-kernel+bounces-235756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E25F91D94A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A41C20D3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0249F81AB6;
	Mon,  1 Jul 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="oy8uYNN0"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975E41C72;
	Mon,  1 Jul 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819914; cv=none; b=bZVfH/AuVTLwfchcEQ37rOzOZAaiDVLvaD0rBFtW2T7bg+sID/HQhpRcRWi2ivRNnqgBbvpbx6PPSyfGgmZXLObpLrvbtkhkkrsu+2KFPk49L3P9DYRcF142C0CtqTLiHR/D0Y8QdQdjMUdyaCLvQwQOQ0+JGXriyvfn/T43TpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819914; c=relaxed/simple;
	bh=pM4fo0B/lBcGsyDRZEHKBJ2Wk10SlUarm53yhRWsqx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UF9smuh2b4dbTogUPVJdJs8xQekZJCxWDyup5/ZBp4p9ijnoSM3vr5HreL/XeetgaVr0W0Jp3lDK/UZqftlXEbzEFpvj8hxQawqHbxm/JEJRTk2hnFO1R3RM8jd2un3qO4TCH87/LQKmCGBHcg/AZh64JNPDwTIrRHbVAkLrlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=oy8uYNN0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B38BD20003;
	Mon,  1 Jul 2024 07:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719819905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0njT9GeW+qtVIoQRbIG2iSr4/dZ0hcpto7iZSwPc20I=;
	b=oy8uYNN03/5jhWS0cYVP9KpgYFosPXAFBHe3bL18XfjHPY/hf/DRKSYstZRPyjZ2H4cV42
	PIa6PpENwk95OxqOTdxlou4BfBRPAgW1kOVs17TzzkLzOeL53F1RBjdH987AmwdLm55xHA
	mPv0+BrP4HWstn5w44CBEHcVFQzYRQJP3QUvi/EbUJgT8ZYplqq59rerElzhsMH/YICscr
	ocVAw8sM0Bum59vRiz3XIFpfZdHPjvyd56o8H94ON/GBz7IFS5BhspoR2Idsm7oraArUoz
	h4WkFIPlWRqcQnKeMyzmw8+tUJlTIARgJe5kP0A8CqYKPvRwAyvJONHyN6JZIw==
Message-ID: <1aedb1d4-8dc3-4e17-aff1-7cc417465967@arinc9.com>
Date: Mon, 1 Jul 2024 10:44:54 +0300
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
 <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
 <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 01/07/2024 09:16, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing the other net maintainers]
> 
> On 25.06.24 10:51, AngeloGioacchino Del Regno wrote:
>> Il 25/06/24 07:56, Linux regression tracking (Thorsten Leemhuis) ha
>> scritto:
>>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
>>>> wrote:
>>>> [...]
>>> It looks more and more like we are stuck here (or was there progress and
>>> I just missed it?) while the 6.10 final is slowly getting closer. Hence:
>>>
>>> AngeloGioacchino, should we ask the net maintainers to revert
>>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>>> device tree") for now to resolve this regression? Reminder, there is
>>> nothing wrong with that commit per se afaik, it just exposes a problem
>>> that needs to be fixed first before it can be reapplied.
>>
>> To be clear on this: I asked for the commit to be fixed such that it
>> guarantees
>> backwards compatibility with older device trees.
>>
>> If no fix comes,
> 
> I haven't see any since that mail, did you? If not, I think...
> 
>> then I guess that we should ask them to revert this commit
>> until a fix is available.
> 
> ...it's time to ask them for the revert to resolve this for -rc7 (and
> avoid a last minute revert), or what do you think?

This is quite frustrating. I absolutely won't consent to a revert. I've
spent a great amount of time and effort explaining why this is neither
necessary nor a good approach in this email thread. I'm not going to accept
a revert due to the other side's failure to communicate, which will create
unnecessary work for me to do. It is ridiculous to demand a change in a
Linux driver before accepting a device tree patch.

Arınç

