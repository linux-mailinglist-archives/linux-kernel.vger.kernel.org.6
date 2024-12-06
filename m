Return-Path: <linux-kernel+bounces-435714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2229E7B54
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D340281B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D81BFE06;
	Fri,  6 Dec 2024 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Lku9mo2Y"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393EA22C6D1;
	Fri,  6 Dec 2024 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522565; cv=none; b=ROkjmB5oxtCjMt0URlRialdvMy74yLBWF2IJbHbEQYUxcDj+sR3qWMnnqkbnIvRXuX7VBCxtgkHsQYz6ZTpqqu2OpZtIBMNQWLsrfifQsfZWH7bCSuSTp3Vmz8TL8zgo2tpKM9KTIGH/IkbiHLrhuTwbMD3VN6q4NWflmt94tpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522565; c=relaxed/simple;
	bh=4X935N0oxWWz1ukJT9s+jNSeaCMgBhqdCh2wNJQkshs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFuMNYwZFylPj1bN6TwAgHC4z/Ir66heOI84yaJeMGXj00XmrvZn0D2a9roX5LoLjj/1/9OSuOWdVU4mtqlWwPT9ftKWs/cqu08SPTUk5gEAEeJ57uo8qidgyAesSc4Xkwd6/HuB/H6InamNVA5M8rnOLEV0zmsMWuAcJDHecys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Lku9mo2Y; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733522560; x=1734127360; i=w_armin@gmx.de;
	bh=4X935N0oxWWz1ukJT9s+jNSeaCMgBhqdCh2wNJQkshs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Lku9mo2Y/PR6uoPIC5iAW1ExyZnpWaV7Jjsj27z7mJXIjweWohPfBfkovUKK6VE0
	 rmEhNF8BamwENN7MCoRH7GiioaL12oei1jcXsSp8ZieK0JhSl1x36YHADtgBeFeR1
	 QCpXwZvKvHDDDnbdje+jcotpMaW5P1IjIugB6NXBpKmvZIFCrEZXaneBuaCCio4PP
	 vc92XqKjxv55KiET+D4A3DivZlT1lG7pb6qyMTzfPlfCipV8Ne9O2XiCH/OgIXeAp
	 zofWY57D2cCUNbqzs6PYvXIwtrcJkfohuxREgm3GStrmVG5T33LCcDoNPjFB3uoEF
	 SmlcCgnfFQSh469t3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvY2-1t6Md61MwK-00NEDT; Fri, 06
 Dec 2024 23:02:40 +0100
Message-ID: <9a3b1797-d978-4e46-abbd-e4e62a9fcdd2@gmx.de>
Date: Fri, 6 Dec 2024 23:02:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] asus-wmi driver fails on my laptop
To: Yurii Strilets <yurastr100@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <33bfcda8-3d3d-46b9-84f0-44e0e9f44230@gmail.com>
 <bf3b9efd-6700-485a-bd0e-f81de1e11fcf@gmx.de>
 <78eb0efb-bbaf-4cba-840a-9aa507798075@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <78eb0efb-bbaf-4cba-840a-9aa507798075@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wGrki7D3sUn8tpO4E/PodOKa3bhj678JNctpuqBJ8anGintRVh/
 o2xf6sjoJVFPzGz3Cp9OD1l/lHZy69CkRsOOVvMEiTq3x2NbY6XYa4O1D9eBgQW9Cgx4A/8
 i6LkGPsJ29Innk/N+kvwHkiXiyh9qEpkp0QRh/xWGO34sn9VKuRLoebAt5KwQz+6jGbtD8N
 OlK018yfvAxhhh1iMMaMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uMWPUruiFwQ=;7f4p2zOLOwRgYZn0ncG0htKeAki
 qGAjkt50AOHorcDl1Uq2jaCxn69WL2cdxYfy07DT49stBu3+8XxuHZIDOds5ixwi3UtNH7EDa
 1FwcKEnke2N2ZfogtRQvEpPMckGXGjv8O0ao9zUMWvmTc24bbmK8kt/Q12MEJuHgDZ7j2Kyro
 UktZOTs/aUiBc2ddM/77udrm71bW/sCnSwCJKaq9iaqkT5GciRlP4wID5qQ4Qj+WHWNz38T2f
 PNThAtFv1+aavtgyE9oraAsBevKodozSKtOkWYjJ95gwSX6d9XsaRQX+Je4eeLxwlnpsz/XgC
 MSJTT/lgYeHMC4OKaRAk6KU6ChSvybjJG/qFP1kNVn5tGL9jbR9mdR5Yd7MxT0us/njgo4v/d
 fVB4T9BR6tPES1drCP50o5UbeP2geC80HhKXRQPm7Za9noCMF8vcQMauEWDh409klHD3VBMgk
 UXphhwysp49ix35ifPBEM3jASw4siKO8N0z6urprsXjCgBjQgE1DKIRme0OA8xNAOuKyca/KZ
 zY972gc05kqb0rPFw/KWxyjRT0VAC+yNw2SsXhkXgvgLFWlKIFpgoEsyeUXruA+Ehlc2wiJZg
 6CGRV6ZaSXyycWGbAZUQvaNPn64NGCSmh1C5TDXE920WAEEWdJP9hwJc1ncjd6TGEcPThV7jz
 mHHZwc8vs1Evhsjy251PwiKjs3sEuH4PXF4AuSRCHPYDrR+1kmIAInON2GAs2p6h4xDf1y1v3
 6MmFGQRo7b6icHCS5rt3a2aI4JWHoQEhTxXcoZzzW0LBp+oI5ydcTGVXYR7YFQhCDmziJ4xFn
 Y0ShUkveGccDD9xM+k/izRw8BuGcJQGFlcgPsySKsuSP+q4icwAiFynXxQb2FfIXl40gKM8z6
 tufpH5AlqtLuZ6i6dVBMqH12QbNjSHeQ+uvko4LcdOXUqU5kTMj9LdclRjimk0uVtEhpKJWt2
 mi2m2zN5cPnB68AnI1RYRtrTsT1EHTZ1aHBXvux3ObYq5b8fmanz4zJfPO5dozyX6aXh2tLx8
 FvFZf4qeI8oZUygSB/IjRBfAoRda5LgCbjdCgQPTQv8qceChEYOzrrQya+d55tCkpROM9mjz+
 RY3NE7kJXkGBJNLs33DyJMQKNHD8eR

Am 06.12.24 um 22:18 schrieb Yurii Strilets:

> Thank you very much for the fix!
> I am terribly sorry about a faulty report, I did just find out I had an =
issue during the mainline build.

There is nothing faulty about your report, the necessary fix is still not =
available in any stable kernels.
On the contrary i am happy that so many users are reporting this issue, be=
cause otherwise we would have
never heard of it :)

Thanks,
Armin Wolf

> Dec 6, 2024 20:15:05 Armin Wolf <W_Armin@gmx.de>:
>
>> Am 06.12.24 um 14:33 schrieb Yura Strilets:
>>
>>> Hello,
>>>
>>> After upgrading from 6.11 to 6.12 a bunch of Fn+Fx buttons(touchpad,
>>> mic, kb backlight, my asus) stopped working and the
>>> /sys/(...)/asus::kbd_backlight interface is missing, which,
>>> considering the dmesg, looks like an asus-wmi driver issue.
>>>
>>> I've been able to bisect the issue to the commit
>>> [b012170fed282151f7ba8988a347670c299f5ab3] "platform/x86: asus-wmi:
>>> Fix thermal profile initialization"
>>>
>>> Additionally, here's some maybe-helpful information:
>>> my laptop's model -- ASUS Zenbook UX3402VA
>>> linux distro -- Arch Linux
>>> .config for bisection -- was taken from /proc/config.gz at 6.12.1 arch
>>> kernel(attached in [1]) and missing options are default
>>> dmesg logs -- The "grep asus" parts of both good and bad scenarios can
>>> be seen below and full logs are at [2] and [3]
>>>
>>> =3D=3D bad.log =3D=3D
>>> [=C2=A0=C2=A0=C2=A0 3.664546] asus_wmi: ASUS WMI generic driver loaded
>>> [=C2=A0=C2=A0=C2=A0 3.713358] asus_wmi: Initialization: 0x1
>>> [=C2=A0=C2=A0=C2=A0 3.714126] asus_wmi: SFUN value: 0x21
>>> [=C2=A0=C2=A0=C2=A0 3.714131] asus-nb-wmi asus-nb-wmi: Detected ATK, n=
ot ASUSWMI, use
>>> DSTS
>>> [=C2=A0=C2=A0=C2=A0 3.757420] asus_wmi: Failed to set throttle thermal=
 policy
>>> (retval): 0x0
>>> [=C2=A0=C2=A0=C2=A0 3.757425] asus_wmi: Failed to set default thermal =
profile
>>> [=C2=A0=C2=A0=C2=A0 3.757429] asus-nb-wmi asus-nb-wmi: probe with driv=
er asus-nb-wmi
>>> failed with error -5
>>> =3D=3D end =3D=3D
>>>
>>> =3D=3D good.log =3D=3D
>>> [=C2=A0=C2=A0=C2=A0 4.557898] asus_wmi: ASUS WMI generic driver loaded
>>> [=C2=A0=C2=A0=C2=A0 4.776587] asus_wmi: Initialization: 0x1
>>> [=C2=A0=C2=A0=C2=A0 4.777253] asus_wmi: SFUN value: 0x21
>>> [=C2=A0=C2=A0=C2=A0 4.777256] asus-nb-wmi asus-nb-wmi: Detected ATK, n=
ot ASUSWMI, use
>>> DSTS
>>> [=C2=A0=C2=A0=C2=A0 4.777258] asus-nb-wmi asus-nb-wmi: Detected ATK, e=
nable event queue
>>> [=C2=A0=C2=A0=C2=A0 4.805497] input: Asus WMI hotkeys as
>>> /devices/platform/asus-nb-wmi/input/input15
>>> =3D=3D end =3D=3D
>>>
>>> [1] .config - https://pastebin.com/raw/3nDSV8Sm
>>> [2] bad.log - https://pastebin.com/raw/fvR5Sjzt
>>> [3] good.log - https://pastebin.com/raw/EazfLAWA
>>>
>>> Thanks,
>>> Yurii
>>>
>> I am aware of this issue, the necessary fix (commit 25fb5f47f34d) was a=
lready submitted upstream and will likely
>> show up in the stable kernels soon.
>>
>> Thanks,
>> Armin Wolf

