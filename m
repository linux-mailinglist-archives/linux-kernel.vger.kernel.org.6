Return-Path: <linux-kernel+bounces-400718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A449C115F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967F9B21E55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68701218944;
	Thu,  7 Nov 2024 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0JPbbFF"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713221892F;
	Thu,  7 Nov 2024 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016487; cv=none; b=aUIpaXu3FwR4nkr9AUXAxeG+AfvAJaAbiNk6G7cQY3G3JD7aroQNpWbDiLkzqjAvQeYrraZ/GDPutI5UV+FMnmEixuWENFZUgaRsVbuZJJAdF2Hpi+084dc2xvSq7doD11IWQMk1AocYRtKK3za93ucDljPZjvYJWG7c36MCRn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016487; c=relaxed/simple;
	bh=oIY/GsragsYa+Wkwcmz4K24x4XSEWsBnoMuQbghFAIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qg/vKEwDJYvLEju+zVmtua75pWnnsNrrhThydneeMuvdNT3HK9tnUvhww/AW9G3+3AMz8ysMDzsH66bcKKy4UviSfpSDkwqjKME36ku3T3v/iC15vReh7qQn35dO2PH3eUjNkZ0FX2vWKGzuJ6vUgwQEUmUhZ4btFFzVTl6c8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T0JPbbFF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=GUzuw2C8tWbRxEn7TQiiZns2qpMGqquka3U/u2AU4dc=; b=T0JPbbFFQkkdbbdLWSk0TsIIxX
	3JTnjDYP3S5+eYDAGoUR/JkLdS82v+rnLk2siz6LldPUh5vV+gI2Oez2AmSeDxHRcauBag2/insQk
	FwFyOFV8OulM8VZjN/YFUoeWvOtGFjrSHfeKVu/qLuHUiD+3+4+lUvNu7ZejkavtFd1n0lBwSnATJ
	Cg02fWNnZba0jgzB7T4m+ftUC+E0XhR6sqZc8GaITo+CSGL6IBA/K/FIWC9lgIH1LSevk4bYfJlse
	P63SJOjkzKXIrBDGWQIO225rzhcNImefUmFL+3/ZDKbk6KAkAK4ttOn69nmzv5AQW2lmFGUArgfIy
	4062f1sw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9ASe-00000007Tdz-1QQx;
	Thu, 07 Nov 2024 21:54:41 +0000
Message-ID: <70a27fe2-cc85-4f35-b24a-8e3425e447d0@infradead.org>
Date: Thu, 7 Nov 2024 13:54:36 -0800
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
 <274400c3-fd64-4e45-bbd2-319634a09d61@infradead.org>
 <874j4i205j.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <874j4i205j.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/24 1:40 PM, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 11/7/24 12:45 PM, Jonathan Corbet wrote:
>>> anish kumar <yesanishhere@gmail.com> writes:
>>>
>>>> Add a comprehensive debugging guide for ALSA audio issues, covering
>>>> topics from bootup to runtime debugging. This document aims to help
>>>> developers diagnose and resolve common audio problems in Linux.
>>>>
>>>> The guide includes sections on:
>>>> - Bootup/bringup issues
>>>> - Runtime debugging
>>>> - XRUN debugging
>>>> - Audio pops and clicks
>>>>
>>>> This addresses the lack of a centralized debugging resource for ALSA
>>>> and should help improve the troubleshooting process for audio drivers.
>>>>
>>>> Inspired by discussions on LKML:
>>>> https://lkml.org/lkml/2024/9/24/392
>>>>
>>>> Signed-off-by: anish kumar <yesanishhere@gmail.com>
>>>> ---
>>>>  Documentation/sound/soc/debug.rst | 334 ++++++++++++++++++++++++++++++
>>>>  Documentation/sound/soc/index.rst |   1 +
>>>>  2 files changed, 335 insertions(+)
>>>>  create mode 100644 Documentation/sound/soc/debug.rst
>>>
>>> At a first glance, this seems useful.
>>>
>>> I was just looking at Sebastian's new debugging documentation:
>>>
>>>   https://lore.kernel.org/all/20241028-media_docs_improve_v3-v1-0-2b1b486c223e@collabora.com/
>>>
>>> ... so my immediate thought is that this documentation should be
>>> coherent and together, rather than scattered though the docs.  Maybe
>>> move this to process/debugging and integrate it with his work?
>>
>> and once again I disagree that these docs should be in Documentation/process/.
> 
> OK, I guess I missed that...where do you think we should put them?

It was just a few minutes before this email. ;)


I see a few possibilities, none perfect:

a. in Documentation/driver-api/debug/  [not quite driver-api though]

b. in Documentation/core-api/ along with debugging-via-ohci1394.rst  [maybe in a new /debug/ subdir]

c. in (new) Documentation/debug/ and invite the kernel debugging community to add some of their
   docs here as well.

I'm open to other places (except "process").


-- 
~Randy


