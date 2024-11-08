Return-Path: <linux-kernel+bounces-401071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DFC9C15A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A39B1F22E76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ADC1C7B8F;
	Fri,  8 Nov 2024 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJwhRuHp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935718F5B;
	Fri,  8 Nov 2024 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041637; cv=none; b=rHVNPBFRhokAO7BE20SR62eSZ8coeNwVm7Qqoo13scx4wiBDmc+j2cQtBsE61386ArjdEUaBLzMjmioyPfBlTTOLYMN/QtC8UyvKiEkC0lDKwy4TgCkTvKUuC2SAeODdEEujIqI+sgSW3U26H5UUuQviSEv3PkAApjfceNc9+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041637; c=relaxed/simple;
	bh=xDe0Rih1Zy6/eX4VW4AwzGi2ydWUQRGpEBHgSFFALH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6T5+sU3QBjoGr3ka5u+72UjOBsNyzKtDfTiUmfarHaMdxC9r17jBEHhu2ay8LU9KsXc2upQV66qR618IagxakPSJAW078HP7hTjQ2S/QlP7KiRTxoJ5jNlGUvKfoc0UJ0YfjQNkjTX+SRxUNtoPxhc3k7rPlbsCBGEZ6wuevkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SJwhRuHp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=7j+d4WbYzfbUnCfgkJbRyFaO8OIKFdo630TnG1rTP+c=; b=SJwhRuHptvNLNMhQnERjbWvWfL
	ZMFXB2gg25v5tNivRHMFv0L06uHzzaAPhwPbHVJLOSPRG1fnEoA/TPxUmh1r/zyyFX25vtF+20SJ9
	QUK056fclMNmb+90DJ/UZWn/mX1YMPPLc7M8PD6X9tFBRB/dSf9OKNQ/wSOJOUKwdG8mczt+StJuw
	EaKR4lDdkKDErGCoIscfJYQjFh8PNWS5xXmL4ahjolJe1txI8jLqSkg7GtFoxIh7O+m4dlX+uQdD/
	Y4X/ldsdzAKQ8F/TAtN8gqZY0GCwRxpKyPmHZJq2N5CEeH4Wdi61S/rv9TEBF5dyErIlXjf4ZwKO+
	pO5IWiTg==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9H0B-000000086Lq-0KDr;
	Fri, 08 Nov 2024 04:53:43 +0000
Message-ID: <109984d7-98f7-4b2a-8fee-1f7b30230a44@infradead.org>
Date: Thu, 7 Nov 2024 20:53:37 -0800
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
 <70a27fe2-cc85-4f35-b24a-8e3425e447d0@infradead.org>
 <87v7wyznow.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87v7wyznow.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/24 2:25 PM, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> I see a few possibilities, none perfect:
>>
>> a. in Documentation/driver-api/debug/  [not quite driver-api though]
> 
> No, it's not API stuff, and not limited to drivers.
> 
>> b. in Documentation/core-api/ along with debugging-via-ohci1394.rst
>> [maybe in a new /debug/ subdir]
> 
> Again, not really API stuff.
> 
>> c. in (new) Documentation/debug/ and invite the kernel debugging
>> community to add some of their docs here as well.
> 
> If we really want to separate the mechanics of kernel development from
> the associated process information - not always an easy separation, IMO
> - we could make a top-level "development" directory, put a lot of the
> other relevant stuff there, and include the debugging stuff.  It seems
> really weird to put debugging by itself, though; it's only part of the
> picture.

I could go with that.

> 
> Why is Documentation/process so bad?

Documentation/process/ is meta-documentation about kernel social "standards"
among other things. It is "soft" documentation, whereas debugging (IMHO) is
"hard" documentation.

But hey, it's all your baby. Do whatever pleases you. :)

-- 
~Randy


