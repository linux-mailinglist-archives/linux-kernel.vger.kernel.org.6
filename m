Return-Path: <linux-kernel+bounces-428015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B479E0AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82703BA36A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573B1D9A41;
	Mon,  2 Dec 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="uNa44y8e"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9C1D86F1;
	Mon,  2 Dec 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157334; cv=none; b=q4dMfgyw57ZUMY/dFJWL8MLhZA1m334Y3zVSyqJDaZY+x923oBjmqjC/IfKusDcGP7AqjUvh5/kjBQnDCO0dBMLd31zJQjvjFgn41SoGK8raBCsmVfRdJTMZMU8phOFN3kbCBpw44UgjQqKTlRThdL+GMv4vZ5jyE01i48DqDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157334; c=relaxed/simple;
	bh=rqLWHJoqbXwBud3iZ12ryxcStG26mli7RlZe0IFxupE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxV5WtJNQ+/hv1PE1NRpRm4SQCqIcqBKaB9kMq2M/NJJjtGrtYjS/SXt9nHGdznUzrx6JndbJ44WYpEwzFPeFk07bpSBMdZEsnEQUm+Hj7li1vP2wfrTVdDcQF0WTAUc/bSqINL05+jC4Gy10Y6AEypjcXixoDiU4e2sCKCaDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=uNa44y8e; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733157307; x=1733762107; i=deller@gmx.de;
	bh=Dj91ll67ElveFpcW+Hm4Mdx6SmKZj7T9NBvZF7zx1gg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uNa44y8ev+lbRdvFREIQLNOWv8tkCdnMX5XPPsmV23RiRBpBPE8WE/7rUAub6ZHn
	 Y9Uux/pxTZvB5J4NvzZsWEdmsTMRmQiK4aadE8hWxez6FibQ7/luUOBUb5WHFeGcg
	 k030tPLhM3zD3FTexkxne1+OUc3mNwj+s+sL7+Kkd7oMrnOaE9KNVAnytrAVegHIG
	 X/kg7S52K+3zuOgNrg+jFCzpkvTO5J2qNmLz8gOfqbN5MxUBiLwd3R0VbM4QwPZkz
	 4hpbqBdkowaRKTCI2W22gDhKTV9bznbStsnPevv9tR5owQXMKc/P28bSiTTxVDnhn
	 UO6jS4fN6NlnUZRg3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1tVblw0Vud-007wFC; Mon, 02
 Dec 2024 17:35:07 +0100
Message-ID: <ca241957-389b-471d-a450-36b5e00ebe5a@gmx.de>
Date: Mon, 2 Dec 2024 17:35:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected] ext4 corruption on parisc since 6.12
To: matoro <matoro_mailinglist_kernel@matoro.tk>,
 John David Anglin <dave.anglin@bell.net>
Cc: Magnus Lindholm <linmag7@gmail.com>,
 Linux Parisc <linux-parisc@vger.kernel.org>, deller@kernel.org,
 Sam James <sam@gentoo.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <84d7b3e1053b2a8397bcc7fc8eee8106@matoro.tk>
 <31c884b9-77c8-48dc-b84c-20e52cdc4d44@bell.net>
 <71fae3d3a9bd816ea268eb73c152b564@matoro.tk>
 <CA+=Fv5Qy0818xS3uW2bh2nVpy-3COUzbq5X0JPY6=YzbfYgNOA@mail.gmail.com>
 <03978220-0153-417c-8479-09239d19c9ba@bell.net>
 <9bdbf64bd63ab7eef2f5ead467f3c8c4@matoro.tk>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <9bdbf64bd63ab7eef2f5ead467f3c8c4@matoro.tk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LyV0BsNxb95wyJxIF7xIN4NP/EPxXLvKCJQmRXPEDT8tx1H0IQj
 GyxnbZiiGQ0uvYIxCQZWiWMeqHQTcoERXxG52B2zd9HnfmHRnPWe89l3S/rlbJzL4PbT782
 VDmILXVcK5CKOoITOWh56J5Eq3fQZcH+/yy2N9bGXg6zwLrCA9F6q3Rc/o8bMBedyIujHc1
 lYO/GP1VDYyXgL7kQJljQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SCYb21TSSVE=;xFyq6elFw8EjmB3/H1/XUaI0umQ
 fp4CsR/kse5ZnbdYFGuWVMPJdSMZ6Rg4DbthTmUfajlbL4vjKPXdG105d5jlzzG3bRX3yjdmB
 /wZimjwUKj22gxZVTKH7anBpyhWLlgLFmI8VDzkfAKGqsI6bJCMawhnmonkRHaHONY9DbZi8P
 tw5BST5K+UHZdnei2hbEZLIPuXIWzCC64BtvP5qADzvLCWeELVsd/FrmTP0/zZAUyajnGr5Sd
 bpqOBDMm8MYIsS3pSW+9g1Mfb7x08459wOxEH+1nPMaJWkIcYNu8kdMJXX8uBAiCCI8MSao/+
 9/AoisC7I9kwof50UQfoOYgiCTviyOuxbqb7beR9xYmdokK6TLFy1Xz59EtYQ4ins55ges88m
 UBwFaP/LQhIcJb3C0F88x+pILlpyXs6x2U14uWUzfd4MGzqdA79hnTox64DWYtnGKPZQJ9Fu3
 QuCHLOTVmxJnUe80qFdKnHpkKV012PpMB/9cjvfOvcGGAgN7894wrDMZDFjTTWMA/PrjjRIfw
 Bg0IkgF38pD2uXTklL3MU3BBcjzNULSlYD+ZML6oAeoAJrVgLk9ugIwRAGq1Lisssr0SuB9os
 4OXGOyFcp/aj4GJRnsp723yHGasArvC9mvclJOPRFIfxEUVkDMEnf65xBXfdsdHxypVEc48F8
 Pte6Idw/tP1bxO3rccpqZAZmBiz2SxzavlKXM2gWwBdp4RrKMA/hfx4nNjKNVNxT7t+n/xxog
 mMT6ixwx7mRf69IDjvrOpIP3AvHJzR0zlRtVIsMZEscUUjtQaFd24+VSaNYgiqBASTwVdUxjw
 DFAbLoHNdqJUSm/RMIApGrk1g7oWzBPN2GcKwXo4n3WOT91D1e9klr4aScLpk0NTgqc+dQ2KE
 UJODuwSIkR2hVysVIY3i8d+IRJ8zPPQSjIGQpzm4uCv7GSqo5RpbUJOB8IUhpGMdJ++emj/AG
 4Y1VCpbQyS3A9WCOLYfhk7nPIukr01e5StwpC+dA5j5QbD3jwwJTF7pY1ZJXR71MH8nSEKOuj
 HqPwoyt+TAqaS0nltwwYSKyHgWLbc2yNFmxyYHlDJSr25Ox6rbd4uhWcVXxkFd/qQ6CxYLPWA
 XmtfA3mso=

Hi Matoro,

On 12/2/24 4:31 PM, matoro wrote:
> On 2024-12-02 09:54, John David Anglin wrote:
>> On 2024-12-02 1:30 a.m., Magnus Lindholm wrote:
>>> On Mon, Dec 2, 2024 at 5:55=E2=80=AFAM matoro
>>> <matoro_mailinglist_kernel@matoro.tk> wrote:
>>>> Hmm, this is my config, also on an rp3440:
>>>>
>>>> #
>>>> # Timers subsystem
>>>> #
>>>> CONFIG_HZ_PERIODIC=3Dy
>>>> # CONFIG_NO_HZ_IDLE is not set
>>>> # CONFIG_NO_HZ is not set
>>>> # CONFIG_HIGH_RES_TIMERS is not set
>>>> # end of Timers subsystem
>>>>
>>>> lindholm can confirm on their hardware/config.=C2=A0 Maybe you can tr=
y that and
>>>> see if you can reproduce?=C2=A0 I will try your config as well.
>>> Hi, I'm on a HPC8000 "parisc64 PA8800 (Mako) 9000/785/C8000". I can co=
nfirm
>>> that building a kernel CONFIG_SMP=3Dn will mitigate this problem.
>>> I haven't messed around with the config in the Timer subsystem so in m=
y case the
>>> parameters suggested are unset. (my config looks like matoros)
>> The clockevent driver was tested on both rp3440 and c8000, and some oth=
er SMP machines.
>> Helge knows details.=C2=A0 I have used it on rp3440 and c8000.
>>
>> I would try my settings.=C2=A0 The primary reason in switching to the c=
lockevent drivers was to
>> improve clock resolution.=C2=A0 The best resolution with the old driver=
s was 1 ms at 1000 HZ.
>> This caused problems with various package tests.=C2=A0 If config is the=
 issue, probably
>> CONFIG_HIGH_RES_TIMERS needs to be forced when clockevent drivers are u=
sed.
>>
>> Almost every other system uses the clockevent drivers.=C2=A0 So, there =
was a risk that parisc would
>> become unsupported.
>>
>> I wonder if this could be caused by dead RTC battery.=C2=A0 Did you che=
ck output of date command?
>> Maybe a dead RTC battery interacts badly with clockevent drivers.
>>
>> I run ntp on all my machines.
>>
>> What files have bad dates (i.e., is this really a ext4 file system issu=
e) or is it just that system has
>> a bad clock?
>>
>> Dave
>
> The files that have bad dates seem to be the ones /init on this system t=
ouches at early boot.=C2=A0 See the output here:=C2=A0 https://paste.mator=
o.tk/8cq8omg
>
> When booted into the bad kernel, date(1) works and displays the correct =
time. =C2=A0I'm using chrony for time syncing as well.
>
> After switching to the config specified above, boot hangs before even ge=
tting to userspace with the following output:
>
> [=C2=A0=C2=A0 12.473410] 0000:e0:01.1: ttyS2 at MMIO 0xfffffffff4050038 =
(irq =3D 73, base_baud =3D 115200) is a 16550A
> [=C2=A0=C2=A0 12.757386] sym0: <1010-66> rev 0x1 at pci 0000:20:01.0 irq=
 70
> [=C2=A0=C2=A0 12.761419] sym0: PA-RISC Firmware, ID 7, Fast-80, LVD, par=
ity checking
> [=C2=A0=C2=A0 12.885367] sym0: SCSI BUS has been reset.
> [=C2=A0=C2=A0 12.889389] scsi host0: sym-2.2.3
> [=C2=A0=C2=A0 13.053380] sym1: <1010-66> rev 0x1 at pci 0000:20:01.1 irq=
 71
> [=C2=A0=C2=A0 13.055515] sym1: PA-RISC Firmware, ID 7, Fast-80, LVD, par=
ity checking
> [=C2=A0=C2=A0 13.165367] sym1: SCSI BUS has been reset.
> [=C2=A0=C2=A0 13.169388] scsi host1: sym-2.2.3
> [=C2=A0=C2=A0 13.208927] rtc-generic rtc-generic: registered as rtc0
> [=C2=A0=C2=A0 13.281367] rtc-generic rtc-generic: setting system clock t=
o 2024-12-02T07:17:02 UTC (1733123822)
> [=C2=A0=C2=A0 13.281367] NET: Registered PF_INET6 protocol family
> [=C2=A0=C2=A0 13.281367] Segment Routing with IPv6
> [=C2=A0=C2=A0 13.281367] In-situ OAM (IOAM) with IPv6
> [=C2=A0=C2=A0 13.281367] registered taskstats version 1

this message...:

> [=C2=A0=C2=A0 13.281367] Unstable clock detected, switching default trac=
ing clock to "global"
> [=C2=A0=C2=A0 13.281367] If you want to keep using the local clock, then=
 add:
> [=C2=A0=C2=A0 13.281367]=C2=A0=C2=A0 "trace_clock=3Dlocal"
> [=C2=A0=C2=A0 13.281367] on the kernel command line

is very misleading and has nothing to do with the parisc system clock from=
 my commit.
You will find this message in all older kernels you had booted as well.
It refers to the tracing clock, which isn't used here.

> > At the end there the clock seems to stop progressing forward, as
> there are several real-time seconds that elapse in between messages
> with the same timestamp.  So I'm completely unable to boot with this
> config at all.

I think the problems you see are manifold, as it's probably not just
triggered by the kernel clock patch itself.
I've seen various issues on debian in the past, as long as we hadn't built=
 glibc
with 64-bit time64_t enabled.
One such issue is what you see now: your system fails to bring up userspac=
e
because the file date stamps are a lot in the future (even if the dates
are wrong, it should be able to boot).

So, the kernel patch might trigger some time inconsistencies, but
having non-time64_t enabled glibc is probably the main reason why your boo=
t fails.

Both Dave and myself did test this commit:
  commit b5ff52be891347f8847872c49d7a5c2fa29400a7
  parisc: Convert to generic clockevents

Nevertheless, maybe on your system one of the SMP CPUs returned an invalid
time (e.g. outside of 32-bit range) and thus your glibc seems to have gone=
 crazy.
That's currently the only idea I have right now which somehow might explai=
n your situation.

I think we need more testing.

Helge

