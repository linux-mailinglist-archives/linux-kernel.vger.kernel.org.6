Return-Path: <linux-kernel+bounces-286854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F74951FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F621C22A10
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7941C1BB68F;
	Wed, 14 Aug 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tRSNjNt6"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F81B8EA3;
	Wed, 14 Aug 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652414; cv=none; b=CMLompSr3FW26XGWqrzPPgKrXqlj37+v9NYDruvUMnbZXLsYOCIAb3AP/Rn0DMojziH4ODGSHL6L6Flw2qbpj1soOo8idOatf6VKYLuDFMP4rAFCXkwn4AUw/DFJEuNQuyHQH/Rzx/1BBEH5NtZX/BbHzmAMVXrf1A9DQgee1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652414; c=relaxed/simple;
	bh=VXiYQYW56dc1WuzNWrZC5w5JZm2UFMALypsJ26n7j7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oo5Uw7p9Pg2LmTDxrDETXj+nIwFG++kaxOuYWaq8TDPrr3ATJsGULkNa+u5dcYMNe6K5nP7l6Tn48tlnXc+JmWca45+peDrAUnaZ2gppOlHV2sPmw9jhzsxCUVfeIwraNjTLD6OTjTDsCn9RDmlZhYCLyMkPkJFtNCAetWeP0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=tRSNjNt6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1723652392; x=1724257192; i=wahrenst@gmx.net;
	bh=fhv16sAFZtiVB6MEuR24ksCEmVo3hs4EEJychzW9vXQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tRSNjNt6B+3a+h0Vl3BPLciPR3jiSwuS0mcjxJ4CX8lR+k62BFpqsGf8rUofV70j
	 hTy/Qm8g21k50quHTYC7zguO4/7TFROxl9SVExep8miPzNWQVGPdTg6sWZbsg56AZ
	 oKYUhoDhINLI1dKWbaaHM7ercj+e3UjpOVKtpQp68mb/s+PF9aRyOYexALuESw62K
	 ihv9fgT3ZK8GBEMBQsaAX85dR6Q6DpfOCvGAQ4rxplxI4SQBjGlHX7FPjI7fRoQ6J
	 O5C0KHbgOLyElwBDYoDrCQKCe0w9EC7YC/MXisukO33xOw0ZYU41tWIjzPx6qRwEo
	 VQeLqOKGFKa7sz2EDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1scc1y0MFG-007OGa; Wed, 14
 Aug 2024 18:19:52 +0200
Message-ID: <da941b0e-8e29-4ff7-aff8-683da0aef8da@gmx.net>
Date: Wed, 14 Aug 2024 18:19:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20240814: bcm2711-rpi-4-b boot failed
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, krzk+dt@kernel.org,
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYuncv0fuBSC0A1z1G_UOv_XuMQz=DsrLZDK-Wc=10ghag@mail.gmail.com>
 <CA+G9fYv2M8tqwXQF5At4KmG3PFJoiv3D-4Tn_q87MfBvAqLmag@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CA+G9fYv2M8tqwXQF5At4KmG3PFJoiv3D-4Tn_q87MfBvAqLmag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IeOG4wCqf/I7ymjxrQPF+8blCRLHHx+GB+X2mnKoMgayFr756xQ
 AUBHwVCJilhu/e0W6C7GUSRomlnhs1QLn0eBfHZth7mpR3J43Zvns+V4mxvdGGOkuqo+3Dl
 cyjYEgXFzwtK/rpL32r2qgm7OJWN2mg0e/6SEcT3jYFqBKwHWXrjCpI1mcVUnd5D/duvQ7X
 ZJLn99g1zlMCPYZwa8e6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MJIlye475sk=;XABxdiC7P8vifFQyBUK9264GLmw
 qfQXpPXaG+VapmRVWuuI610qcYm5DZJLNB4ByzyCsZBgaINBd+N9Je1aaa9SozSp6yt//L4nM
 9CSippfLor2W5vayApOCTfJj+bN4CKHePv/OWJV4HOF0pMYbod3s6Owk11P9mTgunMLSsHVhd
 gJnCJ5khCCnulKIhxocqB1Oh6D0eoYwimQLpd329CLeCgG4XV8SdfhswxUoT1H95oBGm8geCh
 EbrlhoKTd7geG9SDwzXxgDhzLwCDxGf+2+sGca3a+7+lS0mGLCxSnsHpHgbaTYVOK+l2QVgnK
 WYcpj24NZ33Z/muGeXpf71/0GKqj888Oz/XzCjJ6kaA/JsMxOw9/20uaK/Li+/KmtFSNsBZTf
 JKPmn/wFYLixyAOBRPhSW9qMx0OQbSRoWjVzmeFeKEgdKhCj4t9T1kEMolTOcH6VY9SlN0+wo
 4sNCkPLXjbhGidZNFC8P9ORvkV7h3rU/j3sQpi6dQibs+NDFlzvJo5vxlwnq7dtmUdFBehjLM
 SFRWufYDh4uXaKCGL5ICgZd9zpvNjG8GthDhm4oTfnbLdZX/VPWV8aEoJvayBlPphUpmGrJJ3
 fn26VXme0HHOaQfvIliPhusGPZxJEakyshbbDNPbApBJBunmUZ5tvBRp/zxvoQC9mKw4/W4B/
 C+BjT0WFjbUZC9hwnrqLP3xjHyfSfvoQ5M4cdhKW/gm9DZd+sasZVjEzTBuB5zTxrxgfDHOwi
 xq3Y3jRSplgKpJGqN1CQnN5Xuzvc8u0xxU2vtKpxr589ITwpcgeq8/cMU4t0qKcXFr2WMyG8I
 nAC1KlFxjgkKpsDrCXT0Aisw==

Hi Naresh,

Am 14.08.24 um 17:26 schrieb Naresh Kamboju:
> On Wed, 14 Aug 2024 at 20:54, Naresh Kamboju <naresh.kamboju@linaro.org>=
 wrote:
>> The arm64 kernel booting on bcm2711-rpi-4-b boot failed with today's Li=
nux
>> next-20240814 tag. The boot failed with half boot log [1]
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>>   GOOD: next-20240813
>>   BAD:  next-20240814
>>
>> The first investigation show the following to changes and I have revert=
ed the
>> following two commits and the boot test is back to pass [2].
>>
>> $ git log --oneline  next-20240813..next-20240814
>> arch/arm64/boot/dts/broadcom/
>>    6e7b99d720da6 ARM: dts: bcm271x: add missing properties to local_int=
c
>>    eb81f43c901ff ARM: dts: bcm2837/bcm2712: adjust local intc node name=
s
>>
> Anders bisected down to first bad commit as,
>     6e7b99d720da ("ARM: dts: bcm271x: add missing properties to local_in=
tc")
thank you for the report and sorry about that mess. I don't why i was
under the impression they were harmless DT properties. I look into this,
so a revert is the proper solution for now.

Regards

