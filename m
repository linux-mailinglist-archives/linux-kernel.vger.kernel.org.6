Return-Path: <linux-kernel+bounces-209775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B5F903A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CA3B20F37
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1263C176222;
	Tue, 11 Jun 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="LVuCUskT"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BE17BB05;
	Tue, 11 Jun 2024 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105947; cv=none; b=qKBbnfZGEHxFhRmvzqV9VP8E6hHIlRdPS3Qex1tqfPsT8kQEKWymandL+gfrfXkiSXiWUSJ/X5M5HZ+cvjGbm7NuI1aj0pexrHc3Esnw/Q8U7bmOB+siR2HAUwq57A3KqapbYrx97qHgJcGaQHS9KCoyr5dEUZt+ZKS0oUNXoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105947; c=relaxed/simple;
	bh=Y2sDcAge7Bu3Wtz1t6V7WSD8HLdZvIUD8koGgmacsQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJc3Qy5HpRtVrEzgg7fuDvn9511dd2fw8dlQwGajyTY11n2pXXFtIXFbF8QX1KKdO8OndQ0TdegYh8yvnU0ov0Df0XnVu2kFBDxmlvL1T+sHiw9/QHwD5O73qPAecjM2jHkCAt8/Bux8JTuoWDC9cpOkDqdeaGlr9fOW2m6+p4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=LVuCUskT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E1451BF204;
	Tue, 11 Jun 2024 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1718105938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BV2L6/8bPOL7cOUoC1lbeRAI9Vo72rK02ENTNfh2Nps=;
	b=LVuCUskTc/h0Xz58HncRdqc4hXrgEo0ZCzMewq1unRwEoUAYEKDRyQSbu7BLzm7P2GOvsR
	omItKbet19uhCDXXv47KrbxNffGpvVq+ykHd359A5ZqA/Tt0K6mCOyVuA+asbRVzczytb8
	KhEJj4sGwftHFuuH/d1TbnyvxXDEwUrucAva0CRyiJdy4UAYdXft8hzqNvMvcvUOGycEX4
	tC3yeJRDnwjt3lJrWMlBs/KMRJXJvy2OA+lL2ONLjM3R3F3QCCgHh/XAW49NBGlABl7B47
	f3neQZguGFuRBAv1JiZW6WeOKDAZBeMJrqy6Od8R3tfBBBLNhYAIonv28+SqMw==
Message-ID: <1807a142-1534-4fa4-ad4b-d1c03af014c2@arinc9.com>
Date: Tue, 11 Jun 2024 14:38:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <e92c3ca0-c9be-44ac-a4fc-57ca5ebedbc5@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 11/06/2024 14:30, Thorsten Leemhuis wrote:
> On 07.06.24 16:15, Thorsten Leemhuis wrote:
>> On 07.06.24 16:03, Paolo Abeni wrote:
>>> On Thu, 2024-06-06 at 10:26 +0200, Thorsten Leemhuis wrote:
>>>> On 31.05.24 08:10, Arınç ÜNAL wrote:
>>>>> On 31/05/2024 08.40, Thorsten Leemhuis wrote:
>>>>>> [adding Paolo, who committed the culprit]
>>>>
>>>> /me slowly wonders if the culprit should be reverted for now (see below)
>>>> and should be reapplied later together with the matching changes from
>>>> Arınç ÜNAL.
>>>
>>> FWIS I think a revert should be avoided, given that a fix is available
>>> and nicely small.
>>
>> Yeah, on one hand I agree; but on the other it seems that the
>> maintainers that would have to take care of the dt changes to fix this
>> until now remained silent in this thread, apart from Rob who sent the
>> mail regarding the warnings.
>>
>> I put those maintainers in the To: field of this mail, maybe that might
>> lead to some reaction.
> 
> Still no reply from the DRS folks or any other progress I noticed. Guess
> that means I will soon have no other choice than to get Linus involved,
> as this looks stuck. :-( #sigh

Does it have to be Linus that needs to apply "[PATCH 0/2] Set PHY address
of MT7531 switch to 0x1f on MediaTek arm64 boards"? Aren't there any other
ARM maintainers that can apply the fix to their tree?

Arınç

