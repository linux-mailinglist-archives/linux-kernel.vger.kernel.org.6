Return-Path: <linux-kernel+bounces-229211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C04916CED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B7C28B006
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A870178383;
	Tue, 25 Jun 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MVECx75F"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCE16EBF5;
	Tue, 25 Jun 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328856; cv=none; b=ljyzOIuXi7j5fkZuqM09eNTTAllyusQ21FoH6ZdtIF7rGp1g3StMm8bHdMzFC6Uc+OosQhqSgZlmXMFPhqHb+UpNDxYDJi0kTFsg0kQ/uls1wToc0iRPWT6t3MqmlWeD4XlOLNCXKvM46RS1zcFQjdrrf4/WAK/4+W2XvYZpmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328856; c=relaxed/simple;
	bh=GaqeeluCDzxgG97kwSNBxAr1a962XBnV49RFQmhG90I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjW4QGiHxO0yWi5Na6KDReaLLfnsk/ou+zv1EbvhLDGGtBof/k2UUC+5gG889DNdyRGAidmGmQjd/AdjkYe8oilXjnZjguBy3HlLlAVOOx8DT7Zur964+GX7DyZjHLHSqODM7HPBHYubKjVsvVvAZ3/uof8UMrpezC51j1nECJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MVECx75F; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719328812; x=1719933612; i=markus.elfring@web.de;
	bh=YVD/tJNvGbYivDfpDiivk2bEEs6GBmCeIdOyyXsf5u8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MVECx75F0X3d1N8GDmuYHco2iBYYP25lTijAqHV+rQHmWrwwvl+AtuYPc+ao1yKm
	 qT7uHx5CW3svQ5Na82hwZzx/iqTpdoYJ40q0WAUWM5z7b6r4m4GwbsG2aRLIolUdo
	 JLP7CW1HXY6sm7FsL9EHwxDKO9W3Q7YWH7ljWeMYT7VUym/JVZFeeK4TNsJSe7t95
	 bSGcdx++g9gYhkL+t2uS5+Rfv6TYLc0zKtFqJYgLSIcxE4VRIA32K9KHnMBWzoCcv
	 8OgUYlmH4oUwweRhnt7V/iKq7WUx1QCXWfRI6d+r6tsCDQKCdoxhWlZ5pfJjOierE
	 Ci5rnrDu4aYNR6Csaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl0p-1shA252rWv-00eio5; Tue, 25
 Jun 2024 17:20:12 +0200
Message-ID: <5fa430f5-3e18-4c20-93d4-6733afd6bdcf@web.de>
Date: Tue, 25 Jun 2024 17:20:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ma Ke <make24@iscas.ac.cn>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@inria.fr>,
 Neal Liu <neal_liu@aspeedtech.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
 <2024062556-ladder-canister-1ab1@gregkh>
 <ff2aaf0d-5456-43d1-af52-78986b3401f9@web.de>
 <2024062532-strep-president-44d7@gregkh>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2024062532-strep-president-44d7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n7N8SoQuEumAxkKN67/A45ARqVyO0jTW3y4tbOJ0enxIUT/JB4Z
 jwc527Jhth5DLaABBIzU1LevsZcydRwgmMCp2WAH6SLBe/wRgO3S4+pBGx/IXkus3J39PrZ
 lYX4/DkzpmLPK2X5k/RWPu53aTPmDKKrmBqtV++d+fWmJKH+KwfYXEz9G8XH9yQmn1rLAMD
 dLrVgGrfxVyUt7lTcM6Cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OqfYbzbqvxk=;5Z3b8yRWNTSCO8osebXlPRAScJk
 a6d2G9e3ovbjDa6NlBzZytC5inZUrWz8TFvm8ExHuZOmV9k/Qo9KDt3t/N4C4Y1dLP3WKJTN3
 lQLRoJc4g8GiU/RvhJ9wKqsudHr42nS1H4t02s9ILLfRby0tKZk7n1a9lDIvxx8xUqBM4cSgk
 L9MY4vVxXvy4UOmEOjkAWpetIfj8MA7iIDhzGfzMScq8vW4EZRaKqrzzVvStkY9w+xG43fJMu
 a1TEQcT2JlfLhEsepHPafSB9NRQgttA0lYJ/Yr4ycJo5L/xT23MFGChhZ1jR9MQDQeYT25/NJ
 LJF9A1pJFbw5EwBYV1PMc8si9EUqWe6yu1Jf7F6NcwRfhWaBUq2OlHS1Wra7A/8q+j5R+qugN
 z2yDA7VSEG06fxvrUvxpyxxT2gaYtun6oEzY58o7a1nwoXArSJ8d2KyVN2htOFFnWDtKO9uef
 BE28Z6PXSCqMBZGbXA70O4LPHSTbtzclAmBAKFxAe4IwPveyOoyn+rVsuR+Z6C6i3+7viI4pA
 EYP3HyUHHJlwfImnv4oSYuEMGj0oImE24zXZVJDRvihVTx8GJY6QbMJYQ4LMpItlSQBrRao0C
 UtyYjBVlH2578wHM/jpVq1LWG8IuokpBx8X1ZbpjcIH4n/Y+jTfj3QAfgP+PQSsq+8r1ZS67k
 xW1pKBBZNj9vbIP8B/npY484BIaLzluT01bKzY/uDIsbwk6xaXHPexs/ioLrNvvHIg/03itTZ
 uILgTfV7KnjfSFxqPfJCnwwnb2xz+MH09Bgfjnb9cE6MoAKs8KbL3xkrsa5FMCufDmbKgdGK1
 zoFl7KDoEuK1bo78nDTuK2k3BdP9s0ekGCutzcNk004so=

>>>>> We should verify the bound of the array to assure that host
>>>>> may not manipulate the index to point past endpoint array.
>>>>
>>>> Why did you not choose an imperative wording for your change descript=
ion?
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n94
>>>
>>> Markus, please stop reviewing USB patches.  This is not helpful at all=
,
>>> and causes new developers extra work for no reason at all.
>>
>> How does this feedback fit to the linked information source?
>
> That is not what I wrote.

You indicated concerns according to patch review processes,
didn't you?

See also:
* Patch submission notes
  https://elixir.bootlin.com/linux/v6.10-rc5/source/Documentation/process/=
maintainer-tip.rst#L100

* Contributor Covenant Code of Conduct
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/code-of-conduct.rst?h=3Dv6.10-rc5#n3


> I wrote, "Please stop reviewing USB patches."
>
> Please stop now.

I might be going to influence evolution of this software area in other way=
s
under other circumstances.

Regards,
Markus

