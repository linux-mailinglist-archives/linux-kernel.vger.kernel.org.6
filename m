Return-Path: <linux-kernel+bounces-284835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC39505A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464371F24A36
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6B19B3CE;
	Tue, 13 Aug 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jmtZ0NzI"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFD199E93;
	Tue, 13 Aug 2024 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553692; cv=none; b=Z6RXHB3EFjCQhDklps6Xl/VFkemRHOAH+w77+yBp2kRu1svJT8muiz1q+W8eI3rV+gzlzn79NJXPHhkorUlZbHbZvhws/BiMdW48YyQFgjcF5kOxoSgGK9FQGs5KokhRXQTGTBVnxYxRxH+pxK64OPWJiPQtplptXWaYLOGMRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553692; c=relaxed/simple;
	bh=4jkxlxxs3iiA0rDKR9QpB6FndHFiQG+lULBgyG+97cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ey232bOr65DusqSErXVNPvPdTEsSDttm+/dAHpEoVyjqH48C3qKXB00ZzSe38rsTj5j3dA5SiztGVr3oahQkyFMyBGWjk2pNfgc14ur7W6PZvDCiF9oMUdy6CMtYvtvCA697XPP2UW8JzefuPpVGu9EsKYj8Cqiv9RjBlKW256g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jmtZ0NzI; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WjrvB0PClz9s2t;
	Tue, 13 Aug 2024 14:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1723553686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jkxlxxs3iiA0rDKR9QpB6FndHFiQG+lULBgyG+97cc=;
	b=jmtZ0NzIuh2R0eTuYI/bCTf7aoS8+Zweqcn6qbB+JLxoZlmEpb4Ics3mBb7vYs4gPUVg0O
	KUpmrsDx8moVGMyguSke8OpNHbo5Jnb5yZOU1SecAnAUZt3kduQSvUekcBoipO71khjuQs
	lqOtHK1igKGgKjG2oHfdUTpHqfctEh+E+mxEN8xjElMuDG5HdjGDhppN66YST4U9k7b3P0
	2ljaHST+ZhDB3B11ejMSpd2bLDIIRCkjdgo9dlvH8OYdJNBvi33gR/ktWGsO0zVJKKitBR
	bykIt54dgphBRiCrkArZQ/D8cH16XiSwaE5zPMdAQuqtdUffdzWmCZ29BH5VyQ==
Message-ID: <c2a46079-b9fa-46fb-8d2d-e01e5d620ea7@mailbox.org>
Date: Tue, 13 Aug 2024 14:54:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: core: Remove trigger_tstamp_latched
Content-Language: en-US
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
 <3e9cd14b-7355-4fde-b0c1-39d40467e63c@mailbox.org>
 <8c71ea3d-5c97-423e-a270-3184c16e1603@linux.intel.com>
From: Zeno Endemann <zeno.endemann@mailbox.org>
In-Reply-To: <8c71ea3d-5c97-423e-a270-3184c16e1603@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h8uwbux7mjy6b6ygyd7aqee7pfix3xdw
X-MBO-RS-ID: 1c900356cada227ece4

Pierre-Louis Bossart wrote on 13.08.24 10:04:
> by focusing on the trigger timestamp I think you're looking at the wrong
> side of the problem. The timestamping is improved by using the same
> hardware counter for the trigger AND regular timestamp during
> playback/capture. If you look at a hardware counter during
> playback/capture but the start position is recorded with another method,
> would you agree that there's a systematic non-reproducible offset at
> each run? You want the trigger and regular timestamps to be measured in
> the same way to avoid measurement differences.

I am not sure what you are talking about. I have not seen any place in the
code where the trigger timestamp is taken in any other more sophisticated
way than what the default is doing, i.e. calling snd_pcm_gettime. So I do
not see how your custom *trigger* timestamps are done "with another method".

> I will not disagree that most applications do not need precise
> timestamping, but if you want to try to enable time-of-flight
> measurements for presence or gesture detection you will need higher
> sampling rates and micro-second level accuracy.

I don't know, this sounds very theoretical at best to me. However I do not
have the desire to try to further argue and convince you otherwise.

Do you want to propose a different solution for the stop trigger timestamp
bug? That is my main goal after all.


