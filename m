Return-Path: <linux-kernel+bounces-287172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB5495243E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377AF1F28AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E01C7B9B;
	Wed, 14 Aug 2024 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Os5M3DOC"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A101C4607;
	Wed, 14 Aug 2024 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668648; cv=none; b=QPgGJBB27cOpGB3CUm0CafRVmGhDDG2jHWWc8qcEbAhk9WXNj0Q5nwzpzxKYPAOmOGkKnqtEwGSrsulzJNA69Ezq4oJxlxvP907v8BzGeRCBtYsoHPxcSlgYqxDoWo7qXQEMqXckRMMFo0F5QLju2bCj0jJwFyyh4wXjmMapgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668648; c=relaxed/simple;
	bh=5QOrrcPWYL1MLiry8auoIsfq6qdWOapmxd4c18ijduo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHu45G5D1rwSE+knQ/rs3J1XxvpsiUIR014++/YeqFITA4IWxEHO6BoMA11WKAHWt7ij5a3+vR3qprGzCCebj9jNqyzFhz/Y0BFdELOBBxmhIq09mbNsPNMF1icDsM18uGWvAN8geP1vddhfZH8Kh+un0rtZOUPVFgw4VKkUYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Os5M3DOC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1723668625; x=1724273425; i=wahrenst@gmx.net;
	bh=5QOrrcPWYL1MLiry8auoIsfq6qdWOapmxd4c18ijduo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Os5M3DOCnaRvKSHlVHlQkl8Kk/Ks+br42UhApK5BGXmxp+e7C0tkjW9GoFqdyBUM
	 L9BqxWXHgYAAhUkOHM5ShWShE8vmHgpFMuAvv+aTWmytw0RdNBH0+R/vfG/9Q93Ax
	 t+HNfZvKScduQOLReKZabdFZ/MB+YMHr599KdrB3wTyVsvp5DyNxchyjzoojQZAo/
	 iOVmotqggWbN7kO0JAHcXVQEC5SFInbq7O4wcFYVciGBdn5SsQRpmkPbNKPxBoEXw
	 f5cy710U+ht75CNyUAv510fRjunspt0b60LvKR6mUXHZib5YQQsHB4oke3psmBJiM
	 YYcMoHfTPXeUnVO5Iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1srJWS2eun-00I4P1; Wed, 14
 Aug 2024 22:50:25 +0200
Message-ID: <07154679-42bc-43ba-8b72-62083ed78a4d@gmx.net>
Date: Wed, 14 Aug 2024 22:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20240814: bcm2711-rpi-4-b boot failed
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org, Linux Regressions
 <regressions@lists.linux.dev>, kernel-list@raspberrypi.com
Cc: krzk+dt@kernel.org, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYuncv0fuBSC0A1z1G_UOv_XuMQz=DsrLZDK-Wc=10ghag@mail.gmail.com>
 <CA+G9fYv2M8tqwXQF5At4KmG3PFJoiv3D-4Tn_q87MfBvAqLmag@mail.gmail.com>
 <da941b0e-8e29-4ff7-aff8-683da0aef8da@gmx.net>
 <03524012-0f88-4990-811e-1e76c2b8e7af@broadcom.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <03524012-0f88-4990-811e-1e76c2b8e7af@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7KfDGcsjaiNfH0s+oXJJG03yNgKFiQNyDJp/PCml8Gido0sNTS5
 SR/oHyTKC7tLMF+0i0xJ144yMQW1Qgs9k4eRI/tqlQupdjzi+T8p2J+raB14uA04Y2Sr4Go
 9CfhLmM+kj+iIsuMZ2KHy9sM60+GqatgEEzJkf008eEWPqxts9bnOXO2LLfGK+vAbDalqQo
 rxAWDz7fhnRcxSrR33aFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NRuN9n2Xjso=;KzqcaW7lg6nVLxuMsdzgDzB+3cg
 U1luxqpKL/vuCBOcg+c2x/OhFR/+5/evLFFPVMmxE8xyCXTTYIKVxQWQfsmqYBOudZVu+6CFv
 xbf9cgy5wvIcOboRgm1C1bOixF7YXaViCvwH8WtZEKi7m87Imk2c399z7EUNHhjZlnoKNOkD+
 /jczyYu+o2HZ8SNHaw+FPQ1B+OFMm5CPKxOnbXtw9z8nsMM9a7b68el/r0gcRf7Srmws5zEuR
 0yiR5r+pqT6NZxR7PZlwKOzyLI6hDVT69bXO5wderl7Gp8fhVJ3oQeAK6YwCuWktWIdujeEBw
 Bile+1335sytHTGOxH52/r58Ql1tI9wst1N1Zx8FVpHA3s+wVJ1VGxjF3YAgcqXkXhtnN48z8
 +etTLfUIf3y9mRlE3CZb5tPByxxmkY0XRTVnIrbky2wbPORsx1jjyH7H3H9Xkn0N1bWPyvGvc
 7oem4SZUnW8pKoIW8BGaolM1e0nT/UUIE4keAPUipjPDQt+bcllNsT6Qu/eAb5VNjGOxQ12SV
 lI8NsnWPmYhAyuYIWr5PODMDtZFzNCXhSslU8dEPPOYoUe9FO1J7hZ5RR4zBPqyKzOHqROOOX
 N9B/mms/vraOxww5m9yijv+ViBlb5rnbT9YdKaKpz3L3gW0K3yV2iAhQQZAvVNi7bchSQghnv
 vQrOnwLWQP7jE3X6d/2eptt2oNg6kosBfGbnIqA4mr9ogG9o6Yx5JW518Mv5Iz9tXKd5SZ3j1
 MX6rP717uTHygBIsmajbl9oEkaKOjorwA+Ro3N+7DV3AedV9h2KJ9R0A/r+pHyp/MYf/npcwJ
 +wn9ejJJrhBImck1msg911Wg==

Hi,

[add Raspberry Pi kernel list]

Am 14.08.24 um 21:48 schrieb Florian Fainelli:
> On 8/14/24 09:19, Stefan Wahren wrote:
>> Hi Naresh,
>>
>> Am 14.08.24 um 17:26 schrieb Naresh Kamboju:
>>> On Wed, 14 Aug 2024 at 20:54, Naresh Kamboju
>>> <naresh.kamboju@linaro.org> wrote:
>>>> The arm64 kernel booting on bcm2711-rpi-4-b boot failed with
>>>> today's Linux
>>>> next-20240814 tag. The boot failed with half boot log [1]
>>>>
>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>
>>>> =C2=A0 GOOD: next-20240813
>>>> =C2=A0 BAD:=C2=A0 next-20240814
>>>>
>>>> The first investigation show the following to changes and I have
>>>> reverted the
>>>> following two commits and the boot test is back to pass [2].
>>>>
>>>> $ git log --oneline=C2=A0 next-20240813..next-20240814
>>>> arch/arm64/boot/dts/broadcom/
>>>> =C2=A0=C2=A0 6e7b99d720da6 ARM: dts: bcm271x: add missing properties =
to
>>>> local_intc
>>>> =C2=A0=C2=A0 eb81f43c901ff ARM: dts: bcm2837/bcm2712: adjust local in=
tc node
>>>> names
>>>>
>>> Anders bisected down to first bad commit as,
>>> =C2=A0=C2=A0=C2=A0 6e7b99d720da ("ARM: dts: bcm271x: add missing prope=
rties to
>>> local_intc")
>> thank you for the report and sorry about that mess. I don't why i was
>> under the impression they were harmless DT properties. I look into this=
,
>> so a revert is the proper solution for now.
>
> Without the 'interrupt-controller' of_irq_init() would not be picking
> up the interrupt-controller@7cd00000 node and it would not attempt to
> register the driver. We can see that the GIC is still the primary
> interrupt controller for that system:
>
> [=C2=A0=C2=A0=C2=A0 0.000000] Root IRQ handler: gic_handle_irq
>
> my suspicion here is that irq-bcm2836.c still wants to own the inter
> processor operations and calls set_smp_ipi_range() which then replaces
> what the GIC has installed, thus diverting all interrupts towards
> itself, when it should not, and that won't work as there is no
> coordination with the ARM GIC driver. Stefan do you know how the VPU
> decides between one interrupt controller versus the other, assuming
> there is even a choice offered to users?
Unfortunately not, i hope someone from the Raspberry Pi guys can tell us.
> Is it via adding/removing the 'interrupt-controller' property, or is
> it via the more conventional 'status' property?
>
> FWIW, I did changes back in the days to support the 7211 sister chip
> of 2711:
>
> https://lore.kernel.org/lkml/20191015185919.GA26464@bogus/T/
Thanks for pointing out, now i better understand the complexity behind
it. So the missing properties were intended.
>
> Dropping the patch for now, thanks!


