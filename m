Return-Path: <linux-kernel+bounces-295668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81080959FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150B41F241D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8EB1B2516;
	Wed, 21 Aug 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="paV6vydz"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C21AD5F4;
	Wed, 21 Aug 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250473; cv=none; b=OIjXPHS9vQVt5JWx1Kl76dyyFs6fW3hT8zGcWJXQAGpttYbFln7C7epZlH8pq4KZyllTY3FmAnUQkMZAH6Tftzy7e9k0rlXTWGJMqw1OKYerwXntfcE5O6KWg8nSKJ83UCGKAQWNfYqfnFmk8tU0nyztnMuSUJEKQbROgea8mv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250473; c=relaxed/simple;
	bh=pnOQL1D7K8TVvmBECCK/t7EGytLa+Lcoi+VmJ/M/FgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6aES7xNMs7pQwg8BdzXTejHzgzzBzWCAMXRsumVEkkttycQKrG+UysWKx7con0GaNnrGfw8L0ej0wz99jJacyyn72LaP96wQh1w8FAjnyiRZZyechvRr+7g0aonhYzLctPQP6iLvrkAZ/sZsBpkYVDWkKD6RskIwp7iH9GDh08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=paV6vydz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WppZp4ZQdz9sSy;
	Wed, 21 Aug 2024 16:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1724250466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3IQmOLaYpcWL/qVCH0NmrwOrFv0XwHYQSVYjsl6E8c=;
	b=paV6vydzGWBz2pyH7DT9us9s5SZvO5/0Pt998P+KYgeX82yT4Gg64YZBjcUCLlk9mvrZTO
	15fQD233RTyRpJYkgWICxYlrpf3y9YngzLj1f/yQrCir6YJhIVKHfxQsDVWTvhvefwBsUo
	2igp9GxbzKJjQvceuTRNeIFm3FOiax5uwSfNmZ6YiiOEdJWvykRTYvemYJ7DXXqFe7FAGc
	loqCztzFchpnTDk1lcCdZqLhPZwuZ4B0fHMfJaJT0zVMXCWS9xkKnuC6cft23j76nuyNj7
	OgHwS13GiGx7C44j9+jyzAEXrow4/949OHuyhfxLQY2Yl+2GgAmEnwg0wPaNeQ==
Message-ID: <aa308e18-f9e0-4b1a-b548-fcc61e641c6f@mailbox.org>
Date: Wed, 21 Aug 2024 16:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Christian Brauner <brauner@kernel.org>, Mark Brown <broonie@kernel.org>,
 Pavel Hofman <pavel.hofman@ivitera.com>, David Howells
 <dhowells@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20240812142029.46608-1-zeno.endemann@mailbox.org>
 <dec71400-81f1-4ca6-9010-94b55ecdaafa@linux.intel.com>
 <3e9cd14b-7355-4fde-b0c1-39d40467e63c@mailbox.org>
 <8c71ea3d-5c97-423e-a270-3184c16e1603@linux.intel.com>
 <c2a46079-b9fa-46fb-8d2d-e01e5d620ea7@mailbox.org>
 <878qx0mtfe.wl-tiwai@suse.de>
 <f41762a1-048c-4ab6-86ae-f364753210c7@mailbox.org>
 <874j7omsap.wl-tiwai@suse.de>
Content-Language: en-US
From: Zeno Endemann <zeno.endemann@mailbox.org>
In-Reply-To: <874j7omsap.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bd7240f87b718c4f792
X-MBO-RS-META: wmuk5ysmfs5xdcj9muorr7mfbp9dinxi

Takashi Iwai wrote on 13.08.24 16:05:
> On Tue, 13 Aug 2024 15:58:13 +0200,
> Zeno Endemann wrote:
>>
>> Takashi Iwai wrote on 13.08.24 15:41:
>>> On Tue, 13 Aug 2024 14:54:42 +0200,
>>> Zeno Endemann wrote:
>>>>
>>>> Pierre-Louis Bossart wrote on 13.08.24 10:04:
>>>>> by focusing on the trigger timestamp I think you're looking at the wrong
>>>>> side of the problem. The timestamping is improved by using the same
>>>>> hardware counter for the trigger AND regular timestamp during
>>>>> playback/capture. If you look at a hardware counter during
>>>>> playback/capture but the start position is recorded with another method,
>>>>> would you agree that there's a systematic non-reproducible offset at
>>>>> each run? You want the trigger and regular timestamps to be measured in
>>>>> the same way to avoid measurement differences.
>>>>
>>>> I am not sure what you are talking about. I have not seen any place in the
>>>> code where the trigger timestamp is taken in any other more sophisticated
>>>> way than what the default is doing, i.e. calling snd_pcm_gettime. So I do
>>>> not see how your custom *trigger* timestamps are done "with another method".
>>>>
>>>>> I will not disagree that most applications do not need precise
>>>>> timestamping, but if you want to try to enable time-of-flight
>>>>> measurements for presence or gesture detection you will need higher
>>>>> sampling rates and micro-second level accuracy.
>>>>
>>>> I don't know, this sounds very theoretical at best to me. However I do not
>>>> have the desire to try to further argue and convince you otherwise.
>>>>
>>>> Do you want to propose a different solution for the stop trigger timestamp
>>>> bug? That is my main goal after all.
>>>
>>> Ah, I guess that the discussion drifted because of misunderstanding.
>>>
>>> This isn't about the accuracy of the audio timestamp, but rather the
>>> timing of trigger tstamp.  The commit 2b79d7a6bf34 ("ALSA: pcm: allow
>>> for trigger_tstamp snapshot in .trigger") allowed the trigger_tstamp
>>> taken in the driver's trigger callback.  But, the effectiveness of
>>> this change is dubious, because the timestamp taken in the usual code
>>> path in PCM core is right after the trigger callback, hence the
>>> difference should be negligible -- that's the argument.
>>
>> Exactly. Sorry if my communication was not clear on that.
>>
>>>
>>> No matter how the fix will be, could you put the Fixes tag pointing to
>>> the culprit commit(s) at the next submission?
>>
>> Will do. I guess I'll have to look up which commit actually enabled the
>> trigger_tstamp_latched in hda, as 2b79d7a6bf34 has no driver using that
>> yet, so is not technically the culprit?
> 
> You can take the HD-audio side, the commit ed610af86a71 ("ALSA: hda:
> read trigger_timestamp immediately after starting DMA") instead, too.
> Maybe it doesn't matter much which commit is chosen; both should
> appear in the same kernel version.

Well, I think I've waited a decent amount of time now for more comments.
How do we proceed?

I'm still of the opinion that the removal is the most sensible solution,
so if we agree I could prepare a V2 where I just improve the commit message
a bit further.

But if we don't have a good enough consensus on this, I'd need some guidance
which alternate path should be taken to at least fix the bug of bad stop
trigger timestamps for hda devices (e.g. should I try to fix it also for
soc/intel/skylake without any testing? That seems to me the only other place
that should be affected, apart from the generic pci hda code).

Thanks,
Zeno

