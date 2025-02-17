Return-Path: <linux-kernel+bounces-517363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D7A37FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01D23A3F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD67216E33;
	Mon, 17 Feb 2025 10:17:48 +0000 (UTC)
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B71A2380;
	Mon, 17 Feb 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787467; cv=none; b=CJa2cAiIFwWuQSKSJ48qLEuwUyHpe4sm6TZVB8Rts4RSau32uhCP0YWo8cs5wH9OyKPpFIx1DdPie7H3o02NdYnNvjtlxvGs7ow9W88AVvDyXpG8tva1DLH0cWhw0AbMIouJmpy2uKSWPqkgYiw0R6H/wj8d1jYBrcOZjN6dIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787467; c=relaxed/simple;
	bh=vLwT+F3+Cf00ZQEgeC2ZGeJvMpzsht9EwjYBf0j07WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBo3y7ueCOHu9VSnbJ8W0geiu5UHC6tQorbaT/3890GICj84wvKqodCFlof09Wpk+SLCbtfhvwrLPtcaDvltPhv+4KR8o7By23p4xdu/zZpZHNtFsV+nya1KIqHAusxdJo7kWNsFD4Naz+RQ7D5/P7IC6F05TSn1VcU0Kr8IuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1tjyC0-00000007OKX-12Qf;
	Mon, 17 Feb 2025 11:17:36 +0100
Message-ID: <a02344f2-3b99-41ea-af64-8d2bcb01e435@maciej.szmigiero.name>
Date: Mon, 17 Feb 2025 11:17:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP
 EliteBook 855 G7
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kailang Yang <kailang@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
 Shuming Fan <shumingf@realtek.com>, Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
 <87jz9o99ef.wl-tiwai@suse.de>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
Disposition-Notification-To: "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
In-Reply-To: <87jz9o99ef.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mhej@vps-ovh.mhejs.net

On 17.02.2025 11:02, Takashi Iwai wrote:
> On Sun, 16 Feb 2025 22:31:03 +0100,
> Maciej S. Szmigiero wrote:
>>
>> PC speaker works well on this platform in BIOS and in Linux until sound
>> card drivers are loaded. Then it stops working.
>>
>> There seems to be a beep generator node at 0x1a in this CODEC
>> (ALC269_TYPE_ALC215) but it seems to be only connected to capture mixers
>> at nodes 0x22 and 0x23.
>> If I unmute the mixer input for 0x1a at node 0x23 and start recording
>> from its "ALC285 Analog" capture device I can clearly hear beeps in that
>> recording.
>>
>> So the beep generator is indeed working properly, however I wasn't able to
>> figure out any way to connect it to speakers.
>>
>> However, the bits in the "Passthrough Control" register (0x36) seems to
>> work at least partially: by zeroing "B" and "h" and setting "S" I can at
>> least make the PIT PC speaker output appear either in this laptop speakers
>> or headphones (depending on whether they are connected or not).
>>
>>
>> There are some caveats, however:
>> * If the CODEC gets runtime-suspended the beeps stop so it needs HDA beep
>> device for keeping it awake during beeping.
>>
>> * If the beep generator node is generating any beep the PC beep passthrough
>> seems to be temporarily inhibited, so the HDA beep device has to be
>> prevented from using the actual beep generator node - but the beep device
>> is still necessary due to the previous point.
>>
>> * In contrast with other platforms here beep amplification has to be
>> disabled otherwise the beeps output are WAY louder than they were on pure
>> BIOS setup.
>>
>>
>> Unless someone (from Realtek probably) knows how to make the beep generator
>> node output appear in speakers / headphones using PC beep passthrough seems
>> to be the only way to make PC speaker beeping actually work on this
>> platform.
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> ---
>>
>> Since more than 6 weeks has now passed since the previous version of this
>> patch was posted, yet no better or other solution was provided I'm
>> re-submitting an updated version of the original patch.
>>      
>> This solution has been working fine for me on this platform all that time,
>> without any obvious issues.
>>      
>> Changes from v1:
>> * Correct the typo in !IS_ENABLED(CONFIG_INPUT_PCSPKR) code that the
>> kernel test robot found.
>>      
>> * Change codec_warn() into dev_warn_once(hda_codec_dev(codec))
>> to avoid spamming the kernel log at runtime PM CODEC re-init.
> 
> This is really a thing to be checked by Realtek people at first, as
> it's very vendor-specific thing.
> 
> Kailang, please check this.

Realtek people has been asked to comment/provide alternative solution
3 times in last 6 weeks:
On the original v1 submission, by your message from Jan 12, by my
message on Feb 2.

Looking at https://lore.kernel.org/linux-sound/?q=f%3Arealtek
it seems Kailang sent two e-mails about unrelated cases to linux-sound
during that time.

To be honest, I don't understand why Realtek people don't comment
on this since I would think that's a rather simple matter without any
truly confidential aspects but on the other hand this fact should *not*
permanently block fixing PC beep on this platform.

So I think there should be some deadline here for the vendor response -
like 1 month more or so?

> And, except for that, I'm still concerned by the behavior change.

AFAIK most sound card drivers in ALSA were developed without any docs,
and the register that's being changed is unofficially documented in ALSA:
https://docs.kernel.org/sound/hd-audio/realtek-pc-beep.html

Also, the behavior change is clearly limited to this single laptop
platform (HP EliteBook 855 G7) so the "blast radius" is very limited.

> Also the caveat you mentioned about the runtime PM raises some doubt,
> too.

I think it's simply because the CODEC get re-initialized when it comes
out of runtime PM sleep so if we print a message there then it would
be printed each time the CODEC resumed from runtime PM sleep.

That's why I changed to print this hint about CONFIG_INPUT_PCSPKR
just once per CODEC device.

> 
> thanks,
> 
> Takashi
> 

Thanks,
Maciej


