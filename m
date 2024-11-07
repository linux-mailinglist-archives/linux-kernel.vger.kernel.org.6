Return-Path: <linux-kernel+bounces-400689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125F69C10F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18EC285E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0153D21833C;
	Thu,  7 Nov 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BR4GP991"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AA1CF7BB;
	Thu,  7 Nov 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014876; cv=none; b=X+k1jU9MPena+PlByLGio46VluITir/7l6IZlzt74+HVblC7zEMrdqt7aYf0eNJaeH7BDD2ST8DlcWBzis4kFE077s4lsOwic5Qg/gfiTwkedWQnWu7PSm9q//4ZorWYTiXg15Wj/SsHFIqumOGgT5yOSMmwOeXjcyNOuVdz8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014876; c=relaxed/simple;
	bh=/5O2yM6cSoexUm1k2FuSpVpukyPaM82R9j5MQmDfdMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rD/dVlbdPUjtAq2rDJiCH+A01vKYxwBklNvkKlENP4NUdywnmpG6A3Fh+MLafk0S/fY7/DoQurLHaUQ8AZC0H/LPXS4KJN64iRcej2g25Ji3XgJCWIsCYSuMyg+6ZCqSW2c7vvEl7iFFjnKdfhUCHl5D6Prg5P3p3zOOcetODok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BR4GP991; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=H53gTgSvdWax/zZL64yJwGeYE21AjKgQA626FjrFwLs=; b=BR4GP991Y9geV8HsB/7flsgSWc
	yWeY44FYPTSEz96TvCs95Slu/6skrii7R3ogGOnyO+oxCQPTUi9aA1jyQEFuB/3Xl4ag/lJGb4C44
	YuY0oYHeLeRbbAp+x3T/U1ZzJqxhiWUl+9XiftnETJaacBgeUjaQTIuxDjdZq9oaatYEpQN9dyl4j
	Ayrozy3fhEcTfQbenIl56gU7iioU8zt6hjcWndszrrOQ9gentzc1hjL3Bl/N1N7u0xmh2phoLQim0
	Pdr6eZ/c+wIBMTS3DVfMVhrIlaFsF/nJoigSnJiwk4kAO1HXg6EjG3PbxJF6NBjPV8y4y/v0OnFtp
	e73M+Fgw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9A2f-00000007RPw-1rwZ;
	Thu, 07 Nov 2024 21:27:50 +0000
Message-ID: <274400c3-fd64-4e45-bbd2-319634a09d61@infradead.org>
Date: Thu, 7 Nov 2024 13:27:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ALSA: Add debugging guide for audio issues
To: Jonathan Corbet <corbet@lwn.net>, anish kumar <yesanishhere@gmail.com>,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <20241107200835.3033-1-yesanishhere@gmail.com>
 <87cyj622oc.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87cyj622oc.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/24 12:45 PM, Jonathan Corbet wrote:
> anish kumar <yesanishhere@gmail.com> writes:
> 
>> Add a comprehensive debugging guide for ALSA audio issues, covering
>> topics from bootup to runtime debugging. This document aims to help
>> developers diagnose and resolve common audio problems in Linux.
>>
>> The guide includes sections on:
>> - Bootup/bringup issues
>> - Runtime debugging
>> - XRUN debugging
>> - Audio pops and clicks
>>
>> This addresses the lack of a centralized debugging resource for ALSA
>> and should help improve the troubleshooting process for audio drivers.
>>
>> Inspired by discussions on LKML:
>> https://lkml.org/lkml/2024/9/24/392
>>
>> Signed-off-by: anish kumar <yesanishhere@gmail.com>
>> ---
>>  Documentation/sound/soc/debug.rst | 334 ++++++++++++++++++++++++++++++
>>  Documentation/sound/soc/index.rst |   1 +
>>  2 files changed, 335 insertions(+)
>>  create mode 100644 Documentation/sound/soc/debug.rst
> 
> At a first glance, this seems useful.
> 
> I was just looking at Sebastian's new debugging documentation:
> 
>   https://lore.kernel.org/all/20241028-media_docs_improve_v3-v1-0-2b1b486c223e@collabora.com/
> 
> ... so my immediate thought is that this documentation should be
> coherent and together, rather than scattered though the docs.  Maybe
> move this to process/debugging and integrate it with his work?

and once again I disagree that these docs should be in Documentation/process/.

-- 
~Randy


