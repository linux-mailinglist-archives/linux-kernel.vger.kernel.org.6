Return-Path: <linux-kernel+bounces-517354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F79AA37F95
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7307E3A907A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCACF216394;
	Mon, 17 Feb 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="XPi01MKp"
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6CC81E;
	Mon, 17 Feb 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787122; cv=none; b=HQvvok0WaqcmOS1tM2gaI1fZC3YqsGc7W2Ohqh2cs8CQa+kkTiFmw4P2spEXr0hbpe4t2bmpTlnpwZodUT4TgEW0yfGRO624mIiCl2zSSuqwAwYjEFdjOSkhqHtX0QhHF6+JXFE0coI16yWKFQbSs85jYsFfn9pWA5RrDvxVsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787122; c=relaxed/simple;
	bh=KIG+slLeKzead4aD5YTJdvh+CHRJ6og0qlTWXlC+76M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8hsgt4aT6tVk/MjqjfLXmL/Z0b3VNGO+DCsoNdiwsQEBDgGQq56Q3PjDPAH5HIORV/Y44ba8LfcM5DYGJ7NojqTV+wCo+F99inVmeqIYSkliEc3C8IOmps3KyghFkHXvO0fkTfxMhBCfIaKFPYwEtiIC5pB7c3TVWMqdTIkZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=XPi01MKp; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 280CC36291;
	Mon, 17 Feb 2025 11:11:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 280CC36291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1739787108; bh=AMF7NaGwj93Lf1JLvP1kuJSvDaUJ4atT2i/5SY7OddY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XPi01MKpPOh1i9Gi8bK81jcgiOnQ/LwD1ZPo9S43Ma0ssN3gPB1cVOJcVj1RmomXk
	 nBnqadSvYnGmyW2wVhTbzVw0HJCAzPU8MpTtp1j3DdHWXoUYldqWOAeIBHmZyBFRqJ
	 ZnrsX2L2M/XaplO5xLMNsT0R+510sfX+c2uIRB0w=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 17 Feb 2025 11:11:39 +0100 (CET)
Message-ID: <beb7bb41-fb5b-4b6b-86c3-509e97a30614@perex.cz>
Date: Mon, 17 Feb 2025 11:11:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP
 EliteBook 855 G7
To: Takashi Iwai <tiwai@suse.de>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>,
 Oder Chiou <oder_chiou@realtek.com>, Shuming Fan <shumingf@realtek.com>,
 Qiu Wenbo <qiuwenbo@kylinos.com.cn>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
 <87jz9o99ef.wl-tiwai@suse.de>
Content-Language: en-US
From: Jaroslav Kysela <perex@perex.cz>
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <87jz9o99ef.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17. 02. 25 11:02, Takashi Iwai wrote:
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

The primary issue seems to be with the beep signal routing to the analog 
outputs. The hidden codec registers accessed through the coefficient nodes may 
play a role for this setup. Only Realtek can give a solid answer for this 
(lack of public codec documentation).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

