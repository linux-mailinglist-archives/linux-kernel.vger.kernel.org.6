Return-Path: <linux-kernel+bounces-194392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A598D3B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1881C285293
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83121181D19;
	Wed, 29 May 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b="sujywOMX"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56453180A92;
	Wed, 29 May 2024 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998062; cv=none; b=TgWH2cZbu7oUA8QnUksX1U1GxBsRDXBOsJ3auj+V3ITEZ/7/1qS7TDcf3EM1q9i4JEI6EjZlyMyNkL7QC7SJ3wOZEc6Jhnrtg58NQy1ZAkwdHBpRFccRtTaRYn5eY99mzpkJc5+J/no7+22bHuOHxzcz6IA/Cz/EAysBRv/hRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998062; c=relaxed/simple;
	bh=BwQ6jFYFSm5YXR9F4jT81ILzJR+Bob5bCKyl95jkkwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5VHQPVNfDrJj44TdV23ipAbJlBKV3q4LAocfU99N4TspKEfBiv/yXsSXmSbwLAkJkgwLlDFSgrXmTpkOZiFiMbLoWBOkZLRF/BCoRODlkU93DyOLvLtia8qCV73HTfxxwbYoKetS8jxR1QvAG2gcE9BxNd5rp0/CSsczFVTnL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=seb-dev@web.de header.b=sujywOMX; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716998026; x=1717602826; i=seb-dev@web.de;
	bh=NdpXoN7gd6gckT3kE2kPt3f4pPV+FQNiHt6ex8F98aM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sujywOMX+mDCs2u8SNIGcI4oqWbUoH6AbosQw93PF/O8Su4hULl0jNcsKdkW+CKK
	 7Tl4poWXi+o5wI7D7bGDwGoW6n/1VKncGZLyG1Iu8a9NQKz8pDyTkQbpNdlPDYDCR
	 GfL3S+oRyg/wfFuXcRWSrk1JG/2fHzaUhfHWmWcOF9T84U15LUa0jqemGpoUCXcrB
	 Cpm+CSd3bxv66DMQ+8iRwBl2cEkzYb22aswq57sAoI8UdEC7VzEg6+BtFIVd2rqBl
	 XVIkrSVJDhf3r2q0HRoDHK3Ykw6qMGtKS0qetLPn2cbg0amm4FD/vAFX+uw2u/9ok
	 9aSAfHMxT8owxfi4lg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.24] ([84.155.184.248]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUbo-1skZuY312S-00aKOb; Wed, 29
 May 2024 17:53:46 +0200
Message-ID: <806767aa-8fa5-4ece-9d6d-5976d6da2624@web.de>
Date: Wed, 29 May 2024 17:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add CM3588 NAS board
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240526214340.8459-1-seb-dev@web.de> <3609340.LM0AJKV5NW@diego>
 <ac376b42-a52f-4fef-8543-b961becd5f4d@web.de> <2693701.q0ZmV6gNhb@diego>
From: Sebastian Kropatsch <seb-dev@web.de>
In-Reply-To: <2693701.q0ZmV6gNhb@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VGFwx3IBU2Xxk9L1STIyxZTGGpMljm5iE3oDEp8Rhb86OcNr9zw
 K5NvlB3JOaOByqaILevJuFpkB+Z7OjRY4yxUI0i3Uf3jN+sFhOtGcvd1aphShSUjw4S4G2S
 DDGcwnK1AAvEDlCmS79XqLhEKn7DL7g7tH7J7GQHHMGCEbJvnVlW+xC2LWv63JhoAGtuzzV
 9hns2WEZ0vMcBaCzLK+Gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/Jlz+TETw+8=;t7PnjlXPTRAA24lAiPrMp2Iwo8o
 N+q5sSTuv1GuNKIVGDbsuGk2YFS1xgr2T76GQ+1ZB173DklTiWiI4+Jj5jNTrGoA2vz+eOzEj
 9ES+xyJtU0ObuMHwmxOjCki4D/31hB7CnHM58kY711oLo1ixWcKjx/Zs4Q3CVlHwm3jJUjUhr
 1T70TJ8tzH3aXRaRUON7Y+rleMrOLC3CCQiZpBoS5CH/WsPG3hqKkVdDoem0QCbwG1pJmULRL
 0MvjYTQ9cBSzXo0oqZqgQvz3bsD+3/ZIZ3vN+ipMmSf9sLOyCL35zPLTZw/FTieLYxnkg9DR/
 V9Ht0xzo4kwSbIKgSjslpq3zMo6d0QvCb0phdLZLsIfyzLeCH90CNuasVcU4tV32nUgSF0Fc8
 aaD067c+MGF253d24KZCRmQUsib2+SBud+jo2Li3o0qb0IyaFZD0P1yVT11GITTA7Qaimbg1P
 lSI068wyXgAT77HAgZ6YnHsjjIfZJUtC20niRLBPVk4lT0zhxonfkwlwJK5nugDi2liUh8tgi
 UTQ5869HvJUmQWETBuvsZXevn1q49MPsoPpWHDKLOaRPuO4kWZArkB7nnOhDj8pDaLErBkyy6
 ltlvRfD8auPQm4HObd2dGk24LvPoAfGe9fM0oGlJiTpgnVfsecdaoo0THXHGZ74FP1oLQwrj/
 jpblUMtrjtm67DDRytFByUrhJxSIzwWMUMdhMblKkudI5QgNsiuajzEJCoe/49XR8PtDZraCd
 wjDgVagEIDUUk13XUs1vMicg3eDVz/eFXAa++q7gm/68WiQ/aczSYXKxIKqkGlr+D3YnUmXKJ
 O5ArMWrZTfFBSLdniZHH/QfrkRFG33c7zESHB5jnLcvis=

Hello Heiko,

Am 29.05.2024 um 09:57 schrieb Heiko St=C3=BCbner:
> Hi Sebastian,
>
> Am Dienstag, 28. Mai 2024, 17:55:55 CEST schrieb Sebastian Kropatsch:
>> Am 27.05.2024 um 22:54 schrieb Heiko St=C3=BCbner:
>>> Am Montag, 27. Mai 2024, 21:02:02 CEST schrieb Jonas Karlman:
>>>> On 2024-05-26 23:48, Sebastian Kropatsch wrote:
>>>>> The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, base=
d on
>>>>> the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
>>>>>
>>>>> Hardware features:
>>>>>       - Rockchip RK3588 SoC
>>>>>       - 4GB/8GB/16GB LPDDR4x RAM
>>>>>       - 64GB eMMC
>>>>>       - MicroSD card slot
>>>>>       - 1x RTL8125B 2.5G Ethernet
>>>>>       - 4x M.2 M-Key with PCIe 3.0 x1 (via bifurcation) for NVMe SSD=
s
>>>>>       - 2x USB 3.0 (USB 3.1 Gen1) Type-A, 1x USB 2.0 Type-A
>>>>>       - 1x USB 3.0 Type-C with DP AltMode support
>>>>>       - 2x HDMI 2.1 out, 1x HDMI in
>>>>>       - MIPI-CSI Connector, MIPI-DSI Connector
>>>>>       - 40-pin GPIO header
>>>>>       - 4 buttons: power, reset, recovery, MASK, user button
>>>>>       - 3.5mm Headphone out, 2.0mm PH-2A Mic in
>>>>>       - 5V Fan connector, PWM buzzer, IR receiver, RTC battery conne=
ctor
>>>>>
>>>>> PCIe bifurcation is used to handle all four M.2 sockets at PCIe 3.0 =
x1
>>>>> speed. Data lane mapping in the DT is done like described in commit
>>>>> f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588")=
.
>>>>>
>>>>> This device tree includes support for eMMC, SD card, ethernet, all U=
SB2
>>>>> and USB3 ports, all four M.2 slots, GPU, RTC, buzzer, UART debugging=
 as
>>>>> well as the buttons and LEDs.
>>>>> The GPIOs are labeled according to the schematics.
>>>>>
>>>>> Signed-off-by: Sebastian Kropatsch <seb-dev@web.de>
>>>>> ---
>>>>>    arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>>>>>    .../boot/dts/rockchip/rk3588-cm3588-nas.dts   | 1269 ++++++++++++=
+++++
>>>>>    2 files changed, 1270 insertions(+)
>>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas=
dts
>>>>
>>>> Because the CM3588 is a SoM and the NAS is a carrier board this shoul=
d
>>>> probably be split in two, cm3588.dtsi and cm3588-nas.dts.
>>>
>>> also, because of that way too generic name "cm", please incorporate th=
e
>>> company name in the filename as well. For the same reason we named
>>> the rk3568-wolfvision-pf5.dts that way ;-) [Wolfvision being the compa=
ny]
>>>
>>> So maybe:
>>> rk3588-friendlyelec-cm3588.dtsi and rk3588-friendlyelec-cm3588-nas.dts
>>>
>>
>> Yes, I agree that the name is very generic. I struggled with this as
>> well, but your suggestion sounds good!
>>
>> In this case, is it also preferred to change the commit message to
>> include the company name event though the commit message subject exceed=
s
>> 50 characters this way?
>> ("arm64: dts: rockchip: Add FriendlyElec CM3588 NAS board")
>
> Were does a 50 character limit even come from?
> In other words, the subject should be meaningful and with the needed
> prefixes adhering to a 50 chars maxlen would cause pretty unreadable
> subject in a lot of cases.
>
> So the proposed subject is absolutely fine :-) .
>
The 50 character limit is actually recommended in the Git docs:
   "Though not required, it=E2=80=99s a good idea to begin the commit mess=
age
   with a single short (no more than 50 characters) line summarizing
   the change, followed by a blank line and then a more thorough
   description." [1]

VS Code also has vertical lines in the commit editor indicating if your
line has more than 50 (first line) or 72 (other lines) chars.
And other outlets have mentioned the "50/72 rule" [2,3] as well. The
rule of word-wrapping at 72 characters was even mentioned by Linus,
albeit in 2012:
   "[...] the rule is simple: we use 72-character columns for word
   wrapping, except for quoted material that has a specific line
   format." [4]

But yeah as you're saying, while a subject should be short but
meaningful, such a limit probbaly doesn't make a lot of sense in this
current age.
I likely read too much into those rules trying to learn about all the
things on how to make a good contribution to the kernel, with mailing
lists, formatting and so on.
I won't try to stay on 50 chars too rigorously in the future :)

Thanks,
Sebastian

[1] https://git-scm.com/docs/git-commit#_discussion
[2] https://www.baeldung.com/ops/git-commit-messages#3-the-5072-rule
[3] https://preslav.me/2015/02/21/what-s-with-the-50-72-rule/
[4] https://github.com/torvalds/linux/pull/17#issuecomment-5661185


