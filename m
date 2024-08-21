Return-Path: <linux-kernel+bounces-295875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543E595A25E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790671C208BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE9C14EC5C;
	Wed, 21 Aug 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OlD4prbM"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A914D45E;
	Wed, 21 Aug 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256292; cv=none; b=FAD0DTajxpydrxvI4UxXE+Qc3FtkalTJNHiZ1rGdBTRiCO6F9Rz8cPb8/je9n+c2JE3oOuqPFSL+5Ez01FLnystYqRAVb+rnqVeoTehXju441sDScJxYyDIHiOQVe4anGnwP6UzJTzAoK3od5ZDKHERiyWdfA9D3JHjLTifkaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256292; c=relaxed/simple;
	bh=fcx0ayAD2468sDF3wyu2k6I/h9HoOGcWbZGKF58Pjl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIYWZUIOASAcL+oFwSFZiuBolIq/GBify6flZY2tsOSvAP1e3cZMW2wwzUpEDJhg/KgSNM0gjX1KAiaRpIQnEzsLz7370XCKfBprfCHmpEfJ50B6hkObDoFA36ZhVskwWpONXDexCK9BhIcZBT/KFARwCL6WN2xpA+vbadzSexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OlD4prbM; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wprkj5p8jz9tFl;
	Wed, 21 Aug 2024 18:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1724256285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gbw+0zHJguAp1I73P13erWrKTR0VunGFvCAtXoVd4wM=;
	b=OlD4prbMbPu0/DKAXh5/wOJas38v7D2uRJ4fsNN9i6T1qjRBBUh+9m8H5QG4X+z5xjLurY
	sH6ABAszJHiUVpz934fzYRGbEoUkOWDSKgN2N/1CTZAyNBWPtc8YzmE+pep1/W4KIxyRga
	r/ZC/ohRtzN0+WrTGo6Htn367g2culiHDRO7fvuFwOxp00x6gyKZksF2a8rdx2C6bmKRk0
	YlJYwQMRjF94X469/7MTDaOAUnNLNlgRRlv0WoE7ri8OezzXD1DcYRqqXHzAcRDCsJc4cM
	VlNWnfL+MyynLROxTrO5mDtfgI2Y60EMWUwgJ/CldzaTwPlXlmnsILZ6FRUyYQ==
Message-ID: <5588b900-6ea4-4002-bbf9-cb18264c90a3@mailbox.org>
Date: Wed, 21 Aug 2024 18:04:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
Content-Language: en-US
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Cezary Rojewski <cezary.rojewski@intel.com>,
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
 <aa308e18-f9e0-4b1a-b548-fcc61e641c6f@mailbox.org>
 <87frqyorzi.wl-tiwai@suse.de> <cea341dc-bcc2-49f2-a641-af365bfd213a@perex.cz>
From: Zeno Endemann <zeno.endemann@mailbox.org>
In-Reply-To: <cea341dc-bcc2-49f2-a641-af365bfd213a@perex.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f441f6196ed67f1bac8
X-MBO-RS-META: mh87wug3qe737qespcpf8ck6bhy6ajjd

Jaroslav Kysela wrote on 21.08.24 16:59:
> On 21. 08. 24 16:44, Takashi Iwai wrote:
>> On Wed, 21 Aug 2024 16:27:43 +0200,
>> Zeno Endemann wrote:
>>>
>>> Takashi Iwai wrote on 13.08.24 16:05:
>>>> On Tue, 13 Aug 2024 15:58:13 +0200,
>>>> Zeno Endemann wrote:
>>>>>
>>>>> Takashi Iwai wrote on 13.08.24 15:41:
>>>>>> On Tue, 13 Aug 2024 14:54:42 +0200,
>>>>>> Zeno Endemann wrote:
>>>>>>>
>>>>>>> Pierre-Louis Bossart wrote on 13.08.24 10:04:
>>>>>>>> by focusing on the trigger timestamp I think you're looking at the wrong
>>>>>>>> side of the problem. The timestamping is improved by using the same
>>>>>>>> hardware counter for the trigger AND regular timestamp during
>>>>>>>> playback/capture. If you look at a hardware counter during
>>>>>>>> playback/capture but the start position is recorded with another method,
>>>>>>>> would you agree that there's a systematic non-reproducible offset at
>>>>>>>> each run? You want the trigger and regular timestamps to be measured in
>>>>>>>> the same way to avoid measurement differences.
>>>>>>>
>>>>>>> I am not sure what you are talking about. I have not seen any place in the
>>>>>>> code where the trigger timestamp is taken in any other more sophisticated
>>>>>>> way than what the default is doing, i.e. calling snd_pcm_gettime. So I do
>>>>>>> not see how your custom *trigger* timestamps are done "with another method".
>>>>>>>
>>>>>>>> I will not disagree that most applications do not need precise
>>>>>>>> timestamping, but if you want to try to enable time-of-flight
>>>>>>>> measurements for presence or gesture detection you will need higher
>>>>>>>> sampling rates and micro-second level accuracy.
>>>>>>>
>>>>>>> I don't know, this sounds very theoretical at best to me. However I do not
>>>>>>> have the desire to try to further argue and convince you otherwise.
>>>>>>>
>>>>>>> Do you want to propose a different solution for the stop trigger timestamp
>>>>>>> bug? That is my main goal after all.
>>>>>>
>>>>>> Ah, I guess that the discussion drifted because of misunderstanding.
>>>>>>
>>>>>> This isn't about the accuracy of the audio timestamp, but rather the
>>>>>> timing of trigger tstamp.  The commit 2b79d7a6bf34 ("ALSA: pcm: allow
>>>>>> for trigger_tstamp snapshot in .trigger") allowed the trigger_tstamp
>>>>>> taken in the driver's trigger callback.  But, the effectiveness of
>>>>>> this change is dubious, because the timestamp taken in the usual code
>>>>>> path in PCM core is right after the trigger callback, hence the
>>>>>> difference should be negligible -- that's the argument.
>>>>>
>>>>> Exactly. Sorry if my communication was not clear on that.
>>>>>
>>>>>>
>>>>>> No matter how the fix will be, could you put the Fixes tag pointing to
>>>>>> the culprit commit(s) at the next submission?
>>>>>
>>>>> Will do. I guess I'll have to look up which commit actually enabled the
>>>>> trigger_tstamp_latched in hda, as 2b79d7a6bf34 has no driver using that
>>>>> yet, so is not technically the culprit?
>>>>
>>>> You can take the HD-audio side, the commit ed610af86a71 ("ALSA: hda:
>>>> read trigger_timestamp immediately after starting DMA") instead, too.
>>>> Maybe it doesn't matter much which commit is chosen; both should
>>>> appear in the same kernel version.
>>>
>>> Well, I think I've waited a decent amount of time now for more comments.
>>> How do we proceed?
>>>
>>> I'm still of the opinion that the removal is the most sensible solution,
>>> so if we agree I could prepare a V2 where I just improve the commit message
>>> a bit further.
>>>
>>> But if we don't have a good enough consensus on this, I'd need some guidance
>>> which alternate path should be taken to at least fix the bug of bad stop
>>> trigger timestamps for hda devices (e.g. should I try to fix it also for
>>> soc/intel/skylake without any testing? That seems to me the only other place
>>> that should be affected, apart from the generic pci hda code).
>>
>> IIUC, the achievement of the timestamp at the exact timing was the
>> goal of that change (which caused a regression unfortunately), so
>> keeping that feature may still make sense.  I'd rather try to fix in
>> HD-audio side at first.
>>
>> If Pierre agrees with the removal of the local timestamp call, we can
>> revert to there afterwards, too.
> 
> What about a patch bellow. I'll send it with proper formatting, when we decide to go with it. Perhaps, the 
> latched flag may be reset when start is false, too.
> 
>                      Jaroslav
> 
> diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> index 7e39d486374a..b098ceadbe74 100644
> --- a/include/sound/hdaudio.h
> +++ b/include/sound/hdaudio.h
> @@ -590,7 +590,7 @@ void snd_hdac_stream_sync_trigger(struct hdac_stream *azx_dev, bool set,
>   void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
>                 unsigned int streams);
>   void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
> -                      unsigned int streams);
> +                      unsigned int streams, bool start);
>   int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
>                   struct snd_pcm_substream *substream);
> 
> diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
> index b53de020309f..0411a8fe9d6f 100644
> --- a/sound/hda/hdac_stream.c
> +++ b/sound/hda/hdac_stream.c
> @@ -664,7 +664,7 @@ static void azx_timecounter_init(struct hdac_stream *azx_dev,
>    * updated accordingly, too.
>    */
>   void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
> -                      unsigned int streams)
> +                      unsigned int streams, bool start)
>   {
>       struct hdac_bus *bus = azx_dev->bus;
>       struct snd_pcm_runtime *runtime = azx_dev->substream->runtime;
> @@ -672,6 +672,9 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
>       bool inited = false;
>       u64 cycle_last = 0;
> 
> +    if (!start)
> +        goto skip;
> +
>       list_for_each_entry(s, &bus->stream_list, list) {
>           if ((streams & (1 << s->index))) {
>               azx_timecounter_init(s, inited, cycle_last);
> @@ -682,6 +685,7 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
>           }
>       }
> 
> +skip:
>       snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
>       runtime->trigger_tstamp_latched = true;
>   }
> diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
> index 5d86e5a9c814..f3330b7e0fcf 100644
> --- a/sound/pci/hda/hda_controller.c
> +++ b/sound/pci/hda/hda_controller.c
> @@ -275,8 +275,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>       spin_lock(&bus->reg_lock);
>       /* reset SYNC bits */
>       snd_hdac_stream_sync_trigger(hstr, false, sbits, sync_reg);
> -    if (start)
> -        snd_hdac_stream_timecounter_init(hstr, sbits);
> +    snd_hdac_stream_timecounter_init(hstr, sbits, start);
>       spin_unlock(&bus->reg_lock);
>       return 0;
>   }
> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
> index 613b27b8da13..7eec15a2c49e 100644
> --- a/sound/soc/intel/skylake/skl-pcm.c
> +++ b/sound/soc/intel/skylake/skl-pcm.c
> @@ -446,10 +446,10 @@ static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
> 
>       if (start) {
>           snd_hdac_stream_start(hdac_stream(stream));
> -        snd_hdac_stream_timecounter_init(hstr, 0);
>       } else {
>           snd_hdac_stream_stop(hdac_stream(stream));
>       }
> +    snd_hdac_stream_timecounter_init(hstr, 0, start);
> 
>       spin_unlock_irqrestore(&bus->reg_lock, cookie);
> 
> @@ -1145,8 +1145,7 @@ static int skl_coupled_trigger(struct snd_pcm_substream *substream,
> 
>       /* reset SYNC bits */
>       snd_hdac_stream_sync_trigger(hstr, false, sbits, AZX_REG_SSYNC);
> -    if (start)
> -        snd_hdac_stream_timecounter_init(hstr, sbits);
> +    snd_hdac_stream_timecounter_init(hstr, sbits, start);
>       spin_unlock_irqrestore(&bus->reg_lock, cookie);
> 
>       return 0;
> 
> 
>                      Jaroslav
> 

Functionally it looks correct, so that would be acceptable to me.


