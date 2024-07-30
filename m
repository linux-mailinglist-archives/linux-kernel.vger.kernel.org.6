Return-Path: <linux-kernel+bounces-268010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D025941F57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB667B24403
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872218A6CD;
	Tue, 30 Jul 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G7dD2rog"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08854648
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363406; cv=none; b=ndKg6KHzKvn5PREjcsR3iEsVegwK2L22LTNRjZWyQgXQl3IXyT9CUEe9PhF+ekwbwyIBP3jJbCMQyR8Td2Xp1Kil7qvP0r5Enq6c+4dDnPb4JHxeYui32rAB09q5hjeGye+HfThgajhpX2KaPLp5LY2WLBaMr+WE/mTH09bvrWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363406; c=relaxed/simple;
	bh=xvaAnFf6R/yIs7ZuTACqMZYriKQLJKKfZREl3DH4mqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fwuj5X8tTLSwrxplI5grIlkxenPX6tVRN/s7e0avklh96CYV8dN51zj9FSQw68Nc0DeFr3606btBfK2tvXedCiWALjsmKj2irqiNpNQX1Ng4iE6FaOH8RJEhsNMWiVUgpSD078uhsrKjOo2HvPWkEJqoxfh9fdreR9dST3tvMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G7dD2rog; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722363386; x=1722968186; i=markus.elfring@web.de;
	bh=xvaAnFf6R/yIs7ZuTACqMZYriKQLJKKfZREl3DH4mqE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G7dD2rogPow9g9kNHtx+FatgXeLLjDSKqalVfu+HzQ/sUJeUWB0BvVnEllz1WSr2
	 zfskXbn02ej6IpQEQ9fn1E63nviQM8gkzFiRjidCf+akM70CokaymCBn4AHYfMCan
	 8rghg2N+x1NtmNNN38BiHxJLuyu4PU0zkp3kcrUhD30bG7ERv1BUKcFUuuBO2w73V
	 jz2pWzl/BIJcRL/E5iniMwddzLu2C+wmPUPgrKtBxgyDwx2VXAc7VEnr2oxEAIVIC
	 f4EtgtUeeLofhW9kso9/mHcFy+XdeQ8KAdykXmniHdHT23x40cEVQqs8OpxHR3pCR
	 8fuKz5deQLWNUNW3PA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgibY-1s36TW24dg-00d2Cu; Tue, 30
 Jul 2024 20:16:26 +0200
Message-ID: <5e96cb21-7b2b-4249-8be6-0822fb375808@web.de>
Date: Tue, 30 Jul 2024 20:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/loongson: Introduce component framework
 support
To: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240728152858.346211-1-sui.jingfeng@linux.dev>
 <20240728152858.346211-2-sui.jingfeng@linux.dev>
 <6dbe975a-59eb-4d4b-9fea-b930fa44e4ec@web.de>
 <7b34fb4c-abde-47e8-984b-3ea55d4475a7@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7b34fb4c-abde-47e8-984b-3ea55d4475a7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MYmOLp4dbwQVpqQg6VnHfEQ1GBInLKqV3JW0VHK+ykxkegfezWJ
 bQnlvSyPKJ5Br7vWJ7xzio64pzNimUg0UOBbpP6j+QIKIFtf2+4OHvLIHM3hdjLNaaamqRv
 cd8S55ECbTcc7nhwmlfVQXVGAD2xkfcyU6q7XLublLFiB12EsIBgQ/v+9CSQoY4npe9xdu7
 b3Pqf96XI9svT6uifc9Rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xtAwTzmaKeI=;Lk0GJjW97tsk5e68pLDDGoMUlHp
 YVaLA8fZjAL9MqrMaWJTZspoCu07tMkbolGkYaQcLb/dd34KfjUkzNWsGO4tRmS/f2ZaIc4DY
 PG50THGi79+6UV73PCK4zzrvGoPXin2Mx8Pn4/M+XkXMJYQOlIaHIHIAjJMnchOFtfZPTbSLg
 WO1Sj3IeNcQTgHB1dghC/Tk1b/y3i1w2rpWi7VZJLel2gdSxaGB0j5j6ljlpczh68B3CVoRhP
 askrMKy8chc5ZCeqC0OUFSurUY2yGEaC6O1yeag0xQo8CpoUlmsoKWjkUabhZEJJf4fNYRgGC
 ytMlpkiVG5RcGJSUDwdgvk3/31+dzRkvY3XW94QVerbJraDsIQ/59z6f5Bi38hwfg+Ps+DD2r
 X2HQnCp3JHxehMyRt3PUxXJZzw4SF8BbWnkQjbxauwunLfeHvqHxtg6yRKL3uaXhkKavMguSS
 tJ99wECGkMb2EyALKTyRWo+lrE9Vgr8SoZvAFz7yBcJBNFphfWe29V4yk6de07ijGeCXwW/Xw
 6ny+rR2mworM4zweh8ZHX86voA2Q1iQfrz3Feox+2DeSDkiH8zf+Zf5fPVkRcnffKZiU4mMt+
 yjtrrOubkJZtU1bzB5TisqMdw7stu12oOQaYjfKDF4jfqEB+Q+EfWdp4655f+d/FnDcVCxZXj
 e7e8FPS58+F7lrqll3HiIC8n5g42Ipl+S45d/3SNGYmUaRN+0u63BcwHppoOD+y4R4uRgL4pN
 qS5FldPNIH9a1OXvcOVSGMGBfW4BSTrSE0+Q54mXX9LT86swkKdIMyW39YuiZQA48DJzRCaQs
 fjZ/CbOe+4hXSL7Fyros7utA==

>> =E2=80=A6
>>> +++ b/drivers/gpu/drm/loongson/loongson_drv.h
>>> @@ -0,0 +1,108 @@
>> =E2=80=A6
>>> +#ifndef __LOONGSON_DRV_H__
>>> +#define __LOONGSON_DRV_H__
>> =E2=80=A6
>>
>> I suggest to omit leading underscores from such identifiers.
=E2=80=A6
> I suggest add this rules to the checkpatch.pl script,
=E2=80=A6

I hope that you would also like to reduce risks according to undefined beh=
aviour
another bit.
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier#DCL37C.Donotdeclareordefineareservedidentifier=
-AutomatedDetection

Regards,
Markus

