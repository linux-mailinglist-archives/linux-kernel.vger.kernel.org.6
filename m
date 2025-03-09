Return-Path: <linux-kernel+bounces-553120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9627A5841F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F9516B601
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B331CC8B0;
	Sun,  9 Mar 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ckU2XYmo"
Received: from gecko.ash.relay.mailchannels.net (gecko.ash.relay.mailchannels.net [23.83.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E41ADC97;
	Sun,  9 Mar 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741524606; cv=pass; b=nY+WDkirsNTO/XB/xuaz3lhadVQwCPlenlUmeVf3UcdJwgmTLQ/gMl7o1EP565J5Z67GChzi3dhhIJ7zEIB+O/vCX/wdSfxjgdl/pyBZoTQNFyJ7IfvOb/034yqcKODgsrp0k9NgpH1/QM1XMnPPgxJW0rcXTNgYI3TF56XUxq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741524606; c=relaxed/simple;
	bh=O5RavmMzD5O4cCoSop955dJLdvyG/vJ59be/H+bsmy8=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=GbGhipDM3HRdrFNZQk3CID4nw5LtzUOOdTSrSCQ5YBoiTgaZXnujec1JyyzNvh3LkDmkoOcywC0pwdFKn0zDGqIr6b/v3bSAE0/L90Wxq91q7GiATig0HYG+3YfRcnx/iB6SLlw6pBNMXuLE1kIlAnvG8aLUZNh2YhhyNYDuk6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ckU2XYmo; arc=pass smtp.client-ip=23.83.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2DBC48A2FBA;
	Sun,  9 Mar 2025 12:42:05 +0000 (UTC)
Received: from uk-fast-smtpout9.hostinger.io (100-117-147-225.trex-nlb.outbound.svc.cluster.local [100.117.147.225])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 155D28A3A5F;
	Sun,  9 Mar 2025 12:42:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1741524124; a=rsa-sha256;
	cv=none;
	b=jte9FWxX/mgEyCAOo1NJprKdwyOol5genqh96fthBfBF8feEVH5RwFFfWWe6OhIxHOhe6P
	l0y1A/OAz4Ea8mP9Llas1yCaSMEXXtN6z4QGVAztCVwQmsL7btHs3SPL4UXo9zxlYCvCRs
	kgdRXj3KLcYOkDw7Gm8nA6kgn6BzjBVrsSR5NgotlSePLNDFWNQMglLvRHWa9fsvWlyxZS
	VEKzOmnazf3e4sqD14FKcjP/DHotnnWeQXTZZzlD2UgfRTxVaWYkvRuV21OtYh8zEsMm7a
	wWsieYEnbMQT+6oeiseynH1QjTGWW9zRiVXWMNZm7/4l2dFno6tDZj9IZpNNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1741524124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oeoNhLP5GOQcihJANIWAHqlFew/DRWiKX+Y4UhKcGh4=;
	b=6mqBhObZZ6ZKhXFvSAEOKioEDUs45Do1if+bAp19HVA2/DHEIfNbihdAOOAA+6CCPphp1D
	J7KuIh9X0ncU734JioX1CcxtorMji9mA7syHQs63mpWaXOu9fYQKWPejHE5977HJNOLg+d
	svKQ6m1bTIV5xuzTFpPaU9DaqZTYZ47J8niRVliRTJC4mHEviTDPtaKzf1LeWX4BN8T1QZ
	O9bzRBm2PoJEntwRoUCH2letALMd7Evmz9C6Won1DyxNkp+LJmv7dEpEjbKTQYK/APH5aa
	zjG8h6k2fGdpwpAPxUERUFJGEHFzhUW6Xn/uKVuMABdtrzrgH2jIwHc2UvpVZA==
ARC-Authentication-Results: i=1;
	rspamd-59568bb4b4-rd5w4;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Spicy-Lettuce: 3ee3d8f272ea4b70_1741524125061_850303384
X-MC-Loop-Signature: 1741524125061:3920609546
X-MC-Ingress-Time: 1741524125060
Received: from uk-fast-smtpout9.hostinger.io (uk-fast-smtpout9.hostinger.io
 [31.220.23.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.147.225 (trex/7.0.2);
	Sun, 09 Mar 2025 12:42:05 +0000
Received: from [10.10.10.229] (unknown [109.228.203.64])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4Z9fmR55b0zFwVTV;
	Sun, 09 Mar 2025 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1741524121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeoNhLP5GOQcihJANIWAHqlFew/DRWiKX+Y4UhKcGh4=;
	b=ckU2XYmo6NjetTQJRUZjNCDCQG9NMldHkm/IsOiRskLCoZy6023owitWecf0/LBoHOFLV8
	ex23JYhNqePe+A5KyJvR2DPBTqvz29br/IIQrZXIZrRx0c9Q1tsqJDbi4qhcJwJC9n3QKa
	WLsh6nT9KFFRN8L5bq38NXNnD8cqB4KclrWEkXlI1gjDZCnuFDXXU36Z07RLJcKXjHCYdG
	Z75DBUYSNNgyepW+0Dc1FcHqKzynwCKWCjVrjw+C+NGjcowdcmwSTSo5aFtBuLJDKmOk08
	VAP1bC2e/m2GsCBRcu0kw/nLGvj+B3qIQBI2wswcbYOcdyswzevZeUdjAwYLfw==
Message-ID: <9f86812e-f8c7-4dc0-9b8e-370ec3e77b68@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/realtek: Limit Internal Microphone boost for
 ALC3246
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kailang Yang <kailang@realtek.com>,
 Stefan Binding <sbinding@opensource.cirrus.com>,
 Simon Trimmer <simont@opensource.cirrus.com>,
 Joshua Grisham <josh@joshuagrisham.com>
Cc: alexander.scholten@xpedite-tech.com, dwayne.dupreez@xpedite-tech.com,
 zenon@xpedite-tech.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250309-for-sound-alc256-dell-v1-1-aacd84853907@arinc9.com>
Content-Language: en-US
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <20250309-for-sound-alc256-dell-v1-1-aacd84853907@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Mar 2025 12:41:59 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=e9hUSrp/ c=1 sm=1 tr=0 ts=67cd8c99 a=XXIZ3xsBfFRTIQWRK9Lfyw==:117 a=XXIZ3xsBfFRTIQWRK9Lfyw==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=GvHEsTVZAAAA:8 a=Sx0xOXs-rgXCBGLeGi0A:9 a=QEXdDO2ut3YA:10 a=aajZ2D0djhd3YR65f-bR:22
X-CM-Envelope: MS4xfOzAx6tKseOuDF203C1L3fXzaWCQYau2/y94OO8EQ84pNt60qmiFao2MPxkNyT2xHpBrKI3wStnbYe/EpUZFhyj6/VFhfhf1gkh1zkw0d4yEEJfVBAnX xGaId8YNzfDmt28s8ouA2rcu3G/1tMBg6RuaVHZvalmRulZX9yqA/R2PRgD6ljWjf9xf8IiPTjqTaN5LQyiC0hXFfPh1Sw+oe7Vw8uims1O3i3eH6Q5vUzTI hSFd0qekBiyKaWQHpGOC4YJ0yHzI+NArlT/+yhNgS4YKN/yV9nKNp516u9dPIuxGXu6FbSox4ypwKiT0VNHhf7MIHpsc1wxaObjnsAKpY9/xEJICE9e84zAY F+eoPCr2i76Cl0iqw5f2xG3DrQUwhMhKcoyfr2a+GStI8MrdtZtzDw6i98pFPWk9T1Cg3X603FkD5RLixteqeGQQk557uGBFp+GynmRjOD2CUjB0sI9MN/16 wiZ95kqXd9OjsXMijeRqSLRywVoQczQl3K8/MuXOHXqOjMqId9hb7kVSVjsPgveEkj4ZYFsf+/CLRSl5HBS3SdYbuIK9JLLdTopYXova6026lUj7RCS+E4Mo sJ0=
X-AuthUser: chester.a.unal@arinc9.com



On 09/03/2025 12:39, Chester A. Unal via B4 Relay wrote:
> From: "Chester A. Unal" <chester.a.unal@arinc9.com>
> 
> Internal Microphone is too loud on Dell Latitude 5490, Dell Device
> [1028:0816], which has got ALC3246. I suppose this is the case for all
> devices with ALC3246 which is ALC256 for Dell devices. Therefore, limit the
> Internal Microphone boost for ALC3246. Change
> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE to
> ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST which includes the former fixup.
> 
> Signed-off-by: Chester A. Unal <chester.a.unal@arinc9.com>
> ---
> I don't know ALSA or the Intel HDA specification very well so feel free to
> correct any incorrect information in the patch log.
> 
> I experience another issue with this laptop that is also there on ALC3204.
> Headphones output loops back to Headset Microphone. So if I record with
> this microphone, sysystem audio is recorded as well. I have tried a fair
> share of fixups by compiling snd-hda-codec-realtek.ko with different fixups
> applied for "0x10ec0256, 0x1028", replacing the existing module in
> /lib/modules, and then rebooting.
> 
> ALC2XX_FIXUP_HEADSET_MIC makes Headset Microphone appear unplugged. But I
> can see on the OS that it detects voice, so, it works. When it appears
> unplugged, Headphones output won't loop back to it. This fixup also makes
> Speakers appear unavailable and makes Microphone disappear, as
> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE won't apply anymore.
> 
> Another issue is when I toggle capture on Headphone Mic on alsamixer,
> physically no audio will be played on Headphone. Speaker is unaffected. If
> the capture is toggled on anything else, Headphone will play audio.
> 
> Tested on Debian Trixie Alpha, kernel 6.12.17. My headphones are
> Tip-Ring-Ring-Sleeve. Here's how I test both issues:
> 
> systemctl --user stop pipewire.socket && systemctl --user stop pipewire
> alsamixer -c 0
> 
> speaker-test -Dhw:0,0 -c2 -r48000 -FS16_LE -t sine
> 
> arecord -Dhw:0,0 -c2 -r48000 -fS16_LE -d30 test.wav
> aplay -Dhw:0,0 test.wav
> 
> Attached is test.wav. The timeline of the recording is:
> - I run speaker-test. Then I run arecord. After that I say: Speaker-test is
>    running. Capture is toggled on Headphone Mic.
> - After about five seconds I say: I am switching capture to Headset Mic.
> - I toggle capture on Headset Mic. After that I say: This is Headset Mic.
> - I kill speaker-test. After that I say: I have killed speaker-test.

Here's the link to the recording.

https://github.com/thesofproject/linux/issues/4292#issuecomment-2708834717

Chester A.

> 
> Maintainers, please let me know if you have an idea how to fix these two
> issues.
> 
> Chester A.
> ---
>   sound/pci/hda/patch_realtek.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index d2a1f836dbbf714c26be682133b44cc0bd173ad9..379a325e96641232485a2fc8e6de03798461f466 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -11799,7 +11799,7 @@ static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
>   	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET,
>   		{0x19, 0x40000000},
>   		{0x1b, 0x40000000}),
> -	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
> +	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
>   		{0x19, 0x40000000},
>   		{0x1a, 0x40000000}),
>   	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
> 
> ---
> base-commit: b7c90e3e717abff6fe06445b98be306b732bbd2b
> change-id: 20250308-for-sound-alc256-dell-61967f99ce45
> 
> Best regards,


