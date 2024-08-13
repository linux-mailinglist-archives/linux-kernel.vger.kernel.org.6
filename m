Return-Path: <linux-kernel+bounces-284573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E99502A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3ED61F2278C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCC01940AB;
	Tue, 13 Aug 2024 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f4RlCaz1"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E41898E6;
	Tue, 13 Aug 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545678; cv=none; b=G8nI1cQvsg2/YIV1jwIqPSz24cp/LPoq9+gAErJR5rRmCbaIbQyT8KFcDoyGsrbOdTnXJ+YDaJzls0tDtD6I8sFkOpna9dGeU63THzckzw5lCAoh+CDnktm/SS50eQn5acT/dgg8nnniBzH/R7BwZGFgG6v6CWxLhh7y3dpZzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545678; c=relaxed/simple;
	bh=9mKCxx8+2X5rvCdlShdYOIfm5LOmV8H+OkmwF/sxbro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=it4O0j0DhGUUv/h+bCHGaEXvajUEMRAOauZSEiCz9fwHRpQI8kE18xDccYwlTXlQ2dR9chMn+8ROWpZZZqKv0Qwjxh02z5FuN93m11wnYVacoA/Ak++nKlblGFNHtjzJ9j2Q/k8Qc3B+WFpIYc9MRL+FQc2qh/nue7PhBou8x4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=f4RlCaz1; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wjnww4Gtkz9tfQ;
	Tue, 13 Aug 2024 12:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1723545664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58/3EynXgXrH5ygMZ88GZjIf+UGLcLEsrncwiGRbwQM=;
	b=f4RlCaz1PQL+n6tSRWmqKvvawXFA5Ltn3ETJUi0jzwvQkWn/WFxSjuFJ/GM8n+zyhLOFCn
	bIrcYIg8CVWDTZfRwFod7cFaLko5vcl+EVAZ1N1K9jMzSH0FHQ8KTPOiub5bCgEUl6sX3j
	a76Prxh0yuv4+kOOLF2m4fg1mJalfpghlEVoTLZVkrhyaIjysRHbVRW7HE4s1cNDZPdsqd
	svCuYHI/LHUgawMigy+X8tQ/UZmdLkL8ArmU5r26Eh1q0wflaYtU2iwRDQv7MQcvvWqZC6
	en2xPUd2efmtv28O3019zOi3jHQDGynTgHOP5Mo+41yOJECrq8dgBCSC/362zQ==
Message-ID: <74ab57c8-9984-425f-8272-045527a2a4e0@mailbox.org>
Date: Tue, 13 Aug 2024 12:41:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Christian Brauner <brauner@kernel.org>, Mark Brown <broonie@kernel.org>,
 Pavel Hofman <pavel.hofman@ivitera.com>, David Howells
 <dhowells@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20240812142029.46608-1-zeno.endemann@mailbox.org>
 <87r0asbwpi.wl-tiwai@suse.de>
From: Zeno Endemann <zeno.endemann@mailbox.org>
In-Reply-To: <87r0asbwpi.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9acrc5bocq5qj5f3r74mq3uup55143nd
X-MBO-RS-ID: e268f99544f7a52de7a

Takashi Iwai wrote on 13.08.24 11:26:
> As long as I read the thread, there seems still use cases for this
> high resolution time counter, so I'm rather for fixing the bugs of
> bogus trigger tstamp than dropping the feature.

I still remain fully unconvinced that moving the point where the
timestamp is taken back by a couple of fairly trivial CPU instructions
does anything of value, but if that convinces you I suppose I'll have
to propose an alternative.

In that case I'd rather simply go with what also Jaroslav Kysela
suggested, and add a timestamp read in the azx_pcm_trigger when stopping.
There may be some Intel drivers that have their own trigger callback,
where this bug would still remain, but I believe it is fair that I do not
worry about that, as I wouldn't be able to test it anyway.

> 
> I still wonder, though, why the trigger_tstamp becomes *earlier* when
> runtime->trigger_tstamp_latched is set.  I thought the same value
> would be kept, instead.  What am I overlooking?

The trigger timestamp is kept separately from the runtime timestamp. So
the runtime timestamp gets updated, but the trigger timestamp does not,
thus the stop trigger timestamp is the same as the start trigger timestamp,
which is earlier than any runtime timestamp.

> 
> In anyway, if it's only about the missing trigger_tstamp update at PCM
> trigger actions other than START, it could be fixed simply by clearing
> trigger_tstamp_latched flag, too.  Alternatively, move the conditional
> call to snd_pcm_post_start() instead of snd_pcm_trigger_tstamp()
> itself, something like below.

I strongly advise against that. That would make the trigger_tstamp_latched
flag even more confusing, as then the driver would only be able to override
the start trigger timestamp, not any other.

If that flag should stay, it may also be a good idea to rename it to
something more descriptive, like "trigger_tstamp_managed_by_driver".
With simply "latched" it is unclear whether it is only latched for the
next timestamp that would be taken (and need to be re-raised by the driver)
or stays in effect permanently (or, as it is now, stays in effect until
the next start)...

