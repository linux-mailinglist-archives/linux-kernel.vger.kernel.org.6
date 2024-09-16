Return-Path: <linux-kernel+bounces-330284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2A979C11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3248B2247D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3AA40C15;
	Mon, 16 Sep 2024 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OqJXRrLs"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C61448E6;
	Mon, 16 Sep 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472032; cv=none; b=QsVyVOI/88UDiQb2WX7bXi9qNpB0iCHRsdTIG4eIFluJXzlGe0fltnKwsjnFrvkk2KAKYcTHOjv4U1z1myCjGE1GXi6xkzNXWzaRE/3GE4/DV6iz0hHK5ZFZGK9baCKx4+06hy099o9+o+BjYy6zt+RZD0bF2bm2qtf8KB7TLWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472032; c=relaxed/simple;
	bh=YJM/RHhVxD/Z6uahSj7EKxWM/sUD8ItHWL/+0DDDR7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyjWCvv2uwNXS+58F4LiTlE3V4iJNlDcqE10/wAIR6ajClvoAo/CPj0LltUddkbRdrL1Q8tDPnqbKSzRSG7Z23g5TUaNHiM4silTiXRaCVY2N1zqF+82yD8WGWgTyd9GZzMPTXyAAagK26CFOcBJCpbUuJsBvI7gxKoG1RoGOyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OqJXRrLs; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726472006; x=1727076806; i=markus.elfring@web.de;
	bh=vJA0ayj0ZO0Y3ilnz8ie5/rNWsE2ock+QweW58wW50s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OqJXRrLseDc4fmh4gKaaJqlX14wgX35v/vi4MRl7CRtwvho9vH/zodSYcOS5GR8g
	 A9Lz2twmsk0PCtkaRQulG+Pg4lrrYtgf/npxay4k/bVmF8RY94XXiEa+ypPG2Rr/v
	 VC17bAVHihhCiO5F6EKD5hfEB6x52FfKGwcXAFqHq8QVPl8MpbQPIwiR4F9JUdHW/
	 X7XSmN/ebe+9cHKj/Qh/OLsjcvvxN2Vi89opygp22l67Irc5Np5JKo6jlbhlJRBkw
	 BuTTKd2uoJ3OJjWlKsyS86UVQoQMfjKBd89eSIRJ+rIdSt06HAFoLGuSiK3k6+F+h
	 /q5dxhEeSCblK1v8aw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0Ix-1s4qJJ0bHf-00zoG7; Mon, 16
 Sep 2024 09:33:26 +0200
Message-ID: <d4dfd310-cf03-4b51-914f-34c46334005b@web.de>
Date: Mon, 16 Sep 2024 09:33:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: emu10k1: Refactor copy_to_user() usage in
 snd_emu10k1_fx8010_ioctl()
To: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Julia Lawall <julia.lawall@inria.fr>
References: <c288ff88-4bb2-4d51-8fd5-2c626c3963b7@web.de>
 <87zfo883p4.wl-tiwai@suse.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87zfo883p4.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wbTAl/MhkfS4lyBADI3da8gBU6qa6e4eG0UJmJlN+YV/rNugS9n
 VsvnpDUq58C/26/ZkqechiNx63b1bhx7gAw3IHa/4NAZF+xT+2VerOr0b+y+jlpK04wFE3y
 57OsGE1XtVDMjJWYO7IRfa6R5I3yclPspATEB2bV5Nej7QMJh32/VDVw1YHav3oPWqeJh6U
 5IErgz+d07IKmVW3KVoLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z4CeS53jz9w=;bycj38jifAK16/cq6nWXV6RSHZr
 hRcehvgO6Dppgji/NV7EnaD1O8vRE7uiQ8c5o75V50ECsILuuyqwV83hARtATDSKDeOiHgitC
 DdffEAbagOklFQI+f8bc7kvp+NE2Nh3JDgRSsbZ39aZok8mVWnjirhkp5g4XjAZjceTierV+w
 gP/IL+0J681F98XC75QJYySuh3cxVlI6qt493YDHdUMX69AEAprMexTqFRKMCnMzJvdQp517j
 5e21yVucjNVmiJL3C4pIrXsfZbz+Lhy50tviBGgWyh9f44Q1N8tM23wZ9cHnCPz15RJM5qPgM
 bDNNpedKjtS4Ut7xE3IP7QG/kMA12x5oT8Ndkco32NDKqggoNkR0SWDOuck/Xo2LYDzW0QZPu
 At7aUgxyGRqEgFnu6r6G5RfieqlnajGJ431L1AsJ4ZloEv/u8EQGGIYW3BAQWKJNXHJC9IHaB
 Fvom+chpfSA5IR1wEIMQzbpgMVdHpFbIqBB1nRUjqs1REx/fKFR3n904V8wPuNXfeEjZa/EDg
 jZbO22F/C4EnuZHk938TYg0n9c1cXke5jsn7RPYPf05xR632QQ44F2L3NLgNyHyX3o8hSoqDx
 I+ZWGQGn519Qo/RwVPfNhZdVd9W46A4qY/VLdQljA0SKDTIbitUkNZmWhPUZwK5lsSeiJOsWN
 sQ5NN1gh8uYGwL0W6h9X8L7+lX4q5Dx05kzU9MFQWUF8Wj6UM0jm+2GwZAE9ORV6ROyvuRnbm
 o9bopSjA/zlDVKZtrKNYDoxdLo/dc0lGiULwPyjQUU0vf62TGQ6XxFt/4yh/zCy8aJfCiEh5y
 dJxkLr5H5UJxqsemzhLGpb2w==

>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sun, 15 Sep 2024 16:16:45 +0200
>>
>> Assign values from selected expressions where copy_to_user() calls
>> are involved to additional local variables so that the number of
>> kfree() calls can be reduced accordingly.
>>
>> This issue was transformed by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>
> This doesn't look like an improvement.  With the refactoring, it's
> rather harder to read.
=E2=80=A6
>> ---
>>  sound/pci/emu10k1/emufx.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
>> index 03efc317e05f..2f20878a78c9 100644
>> --- a/sound/pci/emu10k1/emufx.c
>> +++ b/sound/pci/emu10k1/emufx.c
>> @@ -2496,12 +2496,12 @@ static int snd_emu10k1_fx8010_ioctl(struct snd_=
hwdep * hw, struct file *file, un
>>  		if (!info)
>>  			return -ENOMEM;
>>  		snd_emu10k1_fx8010_info(emu, info);
>> -		if (copy_to_user(argp, info, sizeof(*info))) {
>> +
>> +		{
>> +			unsigned long ctu =3D copy_to_user(argp, info, sizeof(*info));
>>  			kfree(info);
>> -			return -EFAULT;
>> +			return ctu ? -EFAULT : 0;
>>  		}
>> -		kfree(info);
>> -		return 0;
>>  	case SNDRV_EMU10K1_IOCTL_CODE_POKE:
>>  		if (!capable(CAP_SYS_ADMIN))
>>  			return -EPERM;
>> @@ -2517,12 +2517,12 @@ static int snd_emu10k1_fx8010_ioctl(struct snd_=
hwdep * hw, struct file *file, un
>>  		if (IS_ERR(icode))
>>  			return PTR_ERR(icode);
>>  		res =3D snd_emu10k1_icode_peek(emu, icode);
>> -		if (res =3D=3D 0 && copy_to_user(argp, icode, sizeof(*icode))) {
>> +
>> +		{
>> +			bool ctu =3D res =3D=3D 0 && copy_to_user(argp, icode, sizeof(*icod=
e));
>>  			kfree(icode);
>> -			return -EFAULT;
>> +			return ctu ? -EFAULT : res;
>>  		}
>> -		kfree(icode);
>> -		return res;
>>  	case SNDRV_EMU10K1_IOCTL_PCM_POKE:
>>  		ipcm =3D memdup_user(argp, sizeof(*ipcm));
>>  		if (IS_ERR(ipcm))
>> @@ -2535,12 +2535,12 @@ static int snd_emu10k1_fx8010_ioctl(struct snd_=
hwdep * hw, struct file *file, un
>>  		if (IS_ERR(ipcm))
>>  			return PTR_ERR(ipcm);
>>  		res =3D snd_emu10k1_ipcm_peek(emu, ipcm);
>> -		if (res =3D=3D 0 && copy_to_user(argp, ipcm, sizeof(*ipcm))) {
>> +
>> +		{
>> +			bool ctu =3D res =3D=3D 0 && copy_to_user(argp, ipcm, sizeof(*ipcm)=
);
>>  			kfree(ipcm);
>> -			return -EFAULT;
>> +			return ctu ? -EFAULT : res;
>>  		}
>> -		kfree(ipcm);
>> -		return res;
>>  	case SNDRV_EMU10K1_IOCTL_TRAM_SETUP:
>>  		if (!capable(CAP_SYS_ADMIN))
>>  			return -EPERM;
>> --
>> 2.46.0
>>

* Can three less kfree() calls matter here finally?

* Do you find the affected control flow really =E2=80=9Ctoo succinct=E2=80=
=9D now?

Regards,
Markus

