Return-Path: <linux-kernel+bounces-283793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4694F8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426A51C21939
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1318E051;
	Mon, 12 Aug 2024 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AuSBj3yA"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE003168488;
	Mon, 12 Aug 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496727; cv=none; b=QpstNCGN7gDg2+vC3u7YvtdnOKGEpJuJBXbVdUkPWyxU3BzSD0Y0VSUE58vYMuyT0Yzb7/BJWnc3jA1hTJzNsaoBqUZzriq99fHb0yrygj89PVT7F/9PBvbrmycquzMKhHewOzH9N6DQbEeMGIIbdnYs796aejgBbMgfviAd14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496727; c=relaxed/simple;
	bh=SsXRmHgGJem89i8pNPhft9ydb31kePHL1GxGga6LJAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKTSgAKLDxWk30CUp1w5Vp9C75KFgRlbVLQFk67Osv0ElBT2VcSdGfI6k5R68qPrVfWzT0FZ4vrQR0Kq0ut3BwfMJhSUOhnHyQ+kZZAW9Irbv01n5yfvp+t8xyJoPzrR+jRpFDQzs5Q7uFmsWI8JGP0llqZyRx/SaLrspCkJOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AuSBj3yA; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WjRqg6TLtz9snv;
	Mon, 12 Aug 2024 23:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1723496719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QCIUdDSk7frtnt3g6xVWqSWfjLm42IUZdkBb53/lcU=;
	b=AuSBj3yA06Ts1CaVwT26+hxIS3vM27ugE7kwgyOrFSbv9D+8yCFswTnvZkbBO5Hfc58Mf8
	WLlXN3w5B16/CMbe8Z9vA4+HhnUWrNCLOA+TeXQUDQs2CKI8vOt50sRptcNNS7LZfL5qTd
	Bh00gy3b/BAlpxKHXQOGm+wCEbsiyT1kC+MNT4jjI6/IprtbXX+tx0K2YlqXgjDj8VIJwI
	jNp/BU0w2MnIpjbyvEIbQSGdMHk1ketZLtGmIWgLoEptbPh+A3Y/p29s7QBNuk1In4AcIr
	gGCBpkHaX4zRmg1BCb9SQrMyxpkAkik7opZm62YjFaik4UUmlZqTW3C32y03UQ==
Message-ID: <3e9cd14b-7355-4fde-b0c1-39d40467e63c@mailbox.org>
Date: Mon, 12 Aug 2024 23:05:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
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
Content-Language: en-US
From: Zeno Endemann <zeno.endemann@mailbox.org>
In-Reply-To: <dec71400-81f1-4ca6-9010-94b55ecdaafa@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: osir8xq189qno4cqyetzsk9bwspdt8tp
X-MBO-RS-ID: 48fa6584647c2bfafec

Pierre-Louis Bossart wrote on 12.08.24 19:25:
>> * The custom timestamp there does not seem to be a meaningful
>>    improvement over the default one; There is virtually no code in
>>    between them, so I measured only a difference of around 300ns in a
>>    KVM VM with ich9-intel-hda device.
> 
> Humm, you're analyzing timestamps with a VM and a rather old device?
> ICH9 support was added in 2014, some ten years ago. The timestamping
> stuff is only improved with SKL+.

With more modern hardware on bare metal I would assume this difference to
the default timestamp to be even smaller. I am not a hardware guy, so
correct me if I'm wrong, but I would think that the unknown timing delays
of the IO operations and internal audio hardware are orders of magnitude
larger than even 300ns, making this improvement drown in the noise. Do you
have some measurements of the differences with modern hardware?

Besides, the only improvement here is that the timestamp is taken slightly
earlier, nothing fancy as far as I can tell. It seems a bit odd to me that
the hda core is the only one that cares for this.

Finally, I cannot imagine what audio application needs sub-microsecond
accuracy for the trigger timestamps. That is less than a single audio frame
even for silly sample rates. Is this intended for some scientific use case?
For regular audio apps I'd think most do not even care that much for the
trigger timestamps and rather use the hw-pointer-update timestamps anyway,
to prevent clock drifts. In my case I use only the stop trigger timestamp
to estimate at which sample position a snd_pcm_drop happened, and don't use
the start timestamp at all.

But these are just my possibly narrow views on this. If you really have
valid use cases for those improved timestamps I won't insist on removing it.
In fact I'd be rather interested to know if you can point me to an
application that makes use of this.


> 
>> * It creates a pitfall for hda driver writers; Calling
>>    snd_hdac_stream_timecounter_init implicitly makes them responsible
>>    for generating these timestamps.
> 
> That's the point, let those drivers generate a better timestamp if they
> can. Not sure what the problem is?

This is more of an API issue. At least to me it seems bad to sneakily enable
this flag in snd_hdac_stream_timecounter_init. The documentation of it does
not make it clear that after calling it the driver is responsible for the
timestamps. Now I am admittedly not that deep into this code, so there may
be a reason, but again at least to an "outsider" like me it is quite unclear
why initializing the time counter also means the driver now has to manage the
trigger timestamps.

If you really want this functionality to stay, maybe it would be better to
move that out of snd_hdac_stream_timecounter_init and just make every driver
that wants to manage them raise the flag explicitly themselves.


