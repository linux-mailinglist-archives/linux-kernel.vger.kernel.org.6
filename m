Return-Path: <linux-kernel+bounces-284928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53407950700
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A491F220B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0E19D06D;
	Tue, 13 Aug 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jxpbJwSL"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247D19B3DA;
	Tue, 13 Aug 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557503; cv=none; b=jSPrTHbNvGCwnIwq1qvgYarV/izQZU/Av3mybcthLkYzwCC+sHg0gF2BhyccUFyxwv5UDC1Z81wCSZx+4e1k3SpvgYX2Ktf2AinEw5UEd7fp328xu+fQUvYIMgnmMlrJ19jRGLolCW+ZuMP0gigI9a0ajmLbHwEfNg8pzk6ZhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557503; c=relaxed/simple;
	bh=EPyG3nOU88GArBjgkUZpPzYT6s/ETx0CH7LjVIaC+2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc/TXEjWK/maxG1cu+FbpeNly350Ny6XiPiRIFsRZLkMD7zpHc9Zle7r72g1136FEGV7KMJJxvc7fubp9/sVSRLvZaIUff6Vy2M1eL7ztLVg8iNSTkZe9JVLwS/GNKlC4MuEqGCZ5NiAZYagemhgS08WDE1X3+HeT6isOA+zQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jxpbJwSL; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WjtJS49YLz9tG1;
	Tue, 13 Aug 2024 15:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1723557496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqYFDCRvqul+vrA24NtXz3uzUS5Kooanaa1dB4kK0xI=;
	b=jxpbJwSL4EMb+maDTJWIhtEOKgm1WmP35ePLudvJa8IJGtt69YMFr/THhYAsSY2fJmljjh
	6iu0STI1MUe+qjW3jigFreeKrJB7UM3Getz5f0xblYeEx78+XmXJWccygvNHHGciz+Lq1A
	Y0HoV6x0NRvTp5FF0t+j6xgeJ0wcjC1MTgIRTQDO1upZ8FOcSt1WfQSFMdMzCuWZLmxbmS
	GHCyg0THcMJxCSirSEX08Fv+JiFkOADhifr0bB73CoVqrj1OiVc3hwX52NE1JFu0/JC5nI
	ayZVMns62Td1xX2S9ZF1FKjtMBN9YKdjwry3AK19UAdzRhtfOzWU+JzPzORVAw==
Message-ID: <f41762a1-048c-4ab6-86ae-f364753210c7@mailbox.org>
Date: Tue, 13 Aug 2024 15:58:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
Content-Language: en-US
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
From: Zeno Endemann <zeno.endemann@mailbox.org>
In-Reply-To: <878qx0mtfe.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 56gurb75pd85yrj7iitm53nbdbkxes7p
X-MBO-RS-ID: 39020c8db8410ed7b21

Takashi Iwai wrote on 13.08.24 15:41:
> On Tue, 13 Aug 2024 14:54:42 +0200,
> Zeno Endemann wrote:
>>
>> Pierre-Louis Bossart wrote on 13.08.24 10:04:
>>> by focusing on the trigger timestamp I think you're looking at the wrong
>>> side of the problem. The timestamping is improved by using the same
>>> hardware counter for the trigger AND regular timestamp during
>>> playback/capture. If you look at a hardware counter during
>>> playback/capture but the start position is recorded with another method,
>>> would you agree that there's a systematic non-reproducible offset at
>>> each run? You want the trigger and regular timestamps to be measured in
>>> the same way to avoid measurement differences.
>>
>> I am not sure what you are talking about. I have not seen any place in the
>> code where the trigger timestamp is taken in any other more sophisticated
>> way than what the default is doing, i.e. calling snd_pcm_gettime. So I do
>> not see how your custom *trigger* timestamps are done "with another method".
>>
>>> I will not disagree that most applications do not need precise
>>> timestamping, but if you want to try to enable time-of-flight
>>> measurements for presence or gesture detection you will need higher
>>> sampling rates and micro-second level accuracy.
>>
>> I don't know, this sounds very theoretical at best to me. However I do not
>> have the desire to try to further argue and convince you otherwise.
>>
>> Do you want to propose a different solution for the stop trigger timestamp
>> bug? That is my main goal after all.
> 
> Ah, I guess that the discussion drifted because of misunderstanding.
> 
> This isn't about the accuracy of the audio timestamp, but rather the
> timing of trigger tstamp.  The commit 2b79d7a6bf34 ("ALSA: pcm: allow
> for trigger_tstamp snapshot in .trigger") allowed the trigger_tstamp
> taken in the driver's trigger callback.  But, the effectiveness of
> this change is dubious, because the timestamp taken in the usual code
> path in PCM core is right after the trigger callback, hence the
> difference should be negligible -- that's the argument.

Exactly. Sorry if my communication was not clear on that.

> 
> No matter how the fix will be, could you put the Fixes tag pointing to
> the culprit commit(s) at the next submission?

Will do. I guess I'll have to look up which commit actually enabled the
trigger_tstamp_latched in hda, as 2b79d7a6bf34 has no driver using that
yet, so is not technically the culprit?

