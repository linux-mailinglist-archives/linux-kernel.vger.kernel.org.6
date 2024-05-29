Return-Path: <linux-kernel+bounces-194509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91428D3D59
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F82871EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA61A38F4;
	Wed, 29 May 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b="kna8nhGa"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7C15B12C;
	Wed, 29 May 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003262; cv=none; b=KVrga4yFXPeCEP0UG0sgZdmC4/ErAbvnRZ/ubiV7nUcpmehjAu2Imad8GZZBDBdoKrlU8MLxa0wn6KogY/9GpUY9rQ+61Z+v9VqJCBOQKb9cqMsSddAMYoChsdefou78gm5mDqhdRgHsu4CtCbR6N7ccIK1hLSULj6GFLiCJcWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003262; c=relaxed/simple;
	bh=LnvUL3j+FhUIYu1ECockb+0k/yEHuOso9bE/McckZ2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYYw2II3CxO/HAeaXAPvep6wURdAYBbFNpIeyWlwSPnFATiyxSn4JYM84VrJn1loZXGJHlL4WwVdN9/g6XmMS9wpFURx7D+m/i/wUrmvPMpyinVdnClMx9oGDB2A/iKFVXp4E2/HkuVQEgelZ4BYijCeKbLTo+St4rOfqX22XbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b=kna8nhGa; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717003228; x=1717608028; i=seb-dev@web.de;
	bh=LnvUL3j+FhUIYu1ECockb+0k/yEHuOso9bE/McckZ2Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kna8nhGaGMg6V5WETmO60PwrliEoYDpnqxoaCkZ31vDdwRTxJ3w0yyuXeZyqV0ZI
	 CSuLJBOeWHES8ndKvBpjU3VbXb9UMiGc5cAOp2Bksbd72ZnvxeU2FZc9stCm0Mf1W
	 I7m2/xPMyT39eabhSTIb7bJUTru259PwC/5k5XrFxloM4DtxgO/7tpc5gVKKXyakh
	 p0sG8FulGevW3yJ9h6Ar13ogmIR1R2TnlG/hhFZ0gYlKDXYOMHVc1khKwprh3qDDw
	 4/1fTtDZbiN3mKoCPWkfQmlM3d9svSzy//+jLVh3iql0cOJBrRqxZZxrfbmEUwR6f
	 lcTbmwL5i7ibH/S0GQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.24] ([84.155.184.248]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUl9B-1s3BtN2SfJ-00QwGU; Wed, 29
 May 2024 19:20:28 +0200
Message-ID: <ebd69de8-5c97-487e-b86a-8afdcde49a6d@web.de>
Date: Wed, 29 May 2024 19:20:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add CM3588 NAS board
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240526214340.8459-1-seb-dev@web.de>
 <20240526214820.9381-1-seb-dev@web.de>
 <9f40c748-691b-4a03-bbd6-54870f46bf05@kwiboo.se>
 <29e5cf31-3d9a-469a-befa-41a5aa2fe8b3@web.de>
 <bccd8879a19ceacfd92a41e7533b324c@manjaro.org>
From: Sebastian Kropatsch <seb-dev@web.de>
In-Reply-To: <bccd8879a19ceacfd92a41e7533b324c@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hOpgXAHojh64+byf+dXx6/yojN2mCvobytSvKX4N1UvJOQJ3bWi
 5QmnxAI1ZQ3Mqy07BGdu6CuZa4ovU721gwe7yKEHSqZxfnkF9YGvvaevEOAS8xrBuAijeoD
 Pe33+pj2nIoPaCOxgUv4bAslZlOBFWc4oObksZ2jV6f3jJbV6cvI2AaHVZOG+0ifeJ29vu7
 XnyVJf3e+FGCQZ8aOhAxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AWu6vFBFlaM=;iS1IlLJHaAyDKPqsIyiWaZlG9iZ
 thspF47GX2usRA858C/sGhaax0Uygs+xMCeaKF0ehVcSpam+FvfJlJY8TkJCtKF8hR4mGDUtc
 /4LMkbGQ7gpRmjF9sDoKtqxfp0yfvjVJQFsHKQhINcxtFVpXu71BVJc17NvyGxZH6M6HsUxiM
 E9jqU+pJAOInJd0BOutE8UyzDY3FRV5bKAI7cDGjjIofsB+nek+37JOAEoI8faGZDgbHB+f8E
 Bq51n4wWDbg0/98OhjZBpfwhcVlsxQnZBz0uJLNgg+EFHXLf1fgsC5/eOR7d20nOSOo7q6Utq
 5E3ibIASn/yJX3cZvFOxniVPpD3wG1kOKRHBs/0bwnZbZKWIexs4C1XoA2ZUZ2THKtAIo6ipL
 PQvwQ41pT8KX6PAN9YEV7CkSkh1DcgQTMVDYymiP/qbo/BPP8Ng+4ZPqgwLMwFZRaUFbsIPDv
 U84gguIDvIB4YXw3LE+SsJ9L9vZTrXn614Fi/0JauA8lo5FaSE7DlJLmKgj17y6undLOaOHqv
 NNTQH7w6eiABoJ9cwOoX3o1FqdNByEkKt0jVfPTnjKAmXmVuZkLMkvUFlFpr6ezIwGXpKqRE6
 jswOT7vlTjB00g8BziSoQKAouLS8MBahgykDqDuNgirocupdV4g0zwhwrpd8ldMKTIqqrgHeu
 bCIVRjT3CoLzc3g8+x6Ko2WlW4Cwq9A3H4jAhd/zVwn7pkiImvsFuQWYlAWkYXY7nNjXP+F/N
 aP0i6ktWYbELG/G8oDqH+USmlqFOKWnuGOd916BfjJILxeggarbY+Lmu2JPaUN1dHrZhw5mqV
 LxKxYt++K6JXOVcfWYqgSsV+v2sz1Rq8qj6WwAbtsVwoY=

Hi Dragan,

Am 29.05.2024 um 02:10 schrieb Dragan Simic:
> Hello Sebastian,
>
> On 2024-05-28 19:22, Sebastian Kropatsch wrote:
>> Am 27.05.2024 um 21:02 schrieb Jonas Karlman:
>>> On 2024-05-26 23:48, Sebastian Kropatsch wrote:
>>>> The CM3588 NAS by FriendlyElec pairs the CM3588 compute module,
>>>> based on
>>>> the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
>>>>
>>>> [...]
>>>>
>>>> PCIe bifurcation is used to handle all four M.2 sockets at PCIe 3.0 x=
1
>>>> speed. Data lane mapping in the DT is done like described in commit
>>>> f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588").
>>>>
>>>> This device tree includes support for eMMC, SD card, ethernet, all US=
B2
>>>> and USB3 ports, all four M.2 slots, GPU, RTC, buzzer, UART debugging =
as
>>>> well as the buttons and LEDs.
>>>> The GPIOs are labeled according to the schematics.
>>>>
>>>> Signed-off-by: Sebastian Kropatsch <seb-dev@web.de>
>>>> ---
>>>> =C2=A0 arch/arm64/boot/dts/rockchip/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>>>> =C2=A0 .../boot/dts/rockchip/rk3588-cm3588-nas.dts=C2=A0=C2=A0 | 1269
>>>> +++++++++++++++++
>>>> =C2=A0 2 files changed, 1270 insertions(+)
>>>> =C2=A0 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-cm3588-=
nas.dts
>>>
>>> Because the CM3588 is a SoM and the NAS is a carrier board this should
>>> probably be split in two, cm3588.dtsi and cm3588-nas.dts.
>>
>> I thought about this before submitting. My reason for not splitting thi=
s
>> into two files for now was that as far as I know this board is the only
>> combination for the CM, maybe no other daughter board will ever get
>> released. If another carrier board compatible with the CM3588 is
>> released, the splitting could be done at that point in time.
>>
>> But since both you and Heiko prefer to have it split, I will figure out
>> a way how and which parts will have to split up to the CM so we can
>> have two files in the end. I guess most things will go into the NAS dts
>> anyway.
>>
>> I'll have a look how other Rockchip compute modules with split device
>> trees were done in the past and orient myself by that.
>
> I also support the DT split between the SoM and the carrier board,
> even if there are currently no more carrier boards available for
> the particular SoM.=C2=A0 That may seem redundant, but it reflects the
> nature of the hardware setup, in which the SoM plugs into the carrier
> board.=C2=A0 This follows the principle of the DT describing hardware.

Following the principle of the DT describing the hardware does make
sense, that's a very good explanation!
I'll try to follow up with this in a v2 in the next few days.

Thank you,
Sebastian

