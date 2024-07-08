Return-Path: <linux-kernel+bounces-244434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D4192A438
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5C01C219D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2EE13BAD7;
	Mon,  8 Jul 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zddo+N8A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I0RRW3vr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hgmlxR7a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rMEMOgXh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463B13A3FF;
	Mon,  8 Jul 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447196; cv=none; b=jI+hKnLi+EgYOxmJkWUEF829rTlG1r45nRd3kXcQbEys0UYlReykIiN5ihwF0QYGRfxtvbRZwBjS1SUXzK+AULWRBCPh66+HkZvJR0cYnqj01HSXnLxT3W8n0HTdGidN9h54ms0VwcyoPo/zCdTHrGXNBeGm/+4JJ+yMNHMAoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447196; c=relaxed/simple;
	bh=KTjPz8HreuaDkbK28vIVvBVwBU/JqwxZLb37hSBqBm4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n00LHDYIfR3qynbhT3mKGWx3I0W1ZZIkht7kaHEta/hhdgI4mHzIK3ZiK6vlH07LhJu3gfqilqQlP8pOkqM1/2/qJ56yJTWtW+uBZUmpUbs4NYkrhtNiKElUbhfh6gQQP3ODn2+r3uc0uVAJMBrq+BcY+XQkdJJWYipkieZMAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zddo+N8A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I0RRW3vr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hgmlxR7a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rMEMOgXh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBE401F449;
	Mon,  8 Jul 2024 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720447193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5sXTijI002hf7XAvpPYziM6tBUMYCMUGWGA3oNXAdI=;
	b=Zddo+N8AEsko7Qfi9lCopkSb+e7e9vgF6/s8Oe/6UiWXIixcjuKerzlJf+WMFEBxy5xqpW
	TVjCdYeHFJOTBaUsf0MrxTddleRn2wZGOmbCIUhaZ/iBFM1xy/b+K7zarLbZDL/42laB/L
	FGYZoyEcT91+KM89cxNq/jqF6iPlHtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720447193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5sXTijI002hf7XAvpPYziM6tBUMYCMUGWGA3oNXAdI=;
	b=I0RRW3vrEDfPJsD6t8fKGkK1ZYYXXo17E0Vs+lGLi6aZ4qsEAy4MoK2Fv6zXS27A4UEQ5u
	gkGgHdPcQay9kJBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hgmlxR7a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rMEMOgXh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720447192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5sXTijI002hf7XAvpPYziM6tBUMYCMUGWGA3oNXAdI=;
	b=hgmlxR7anY41yimQ8IeVpAVQqJ99AvsOSssSwkf3EdP8wVC7NTSdyvuvSJhDL6mgviI8Vl
	IPekXjrn0gcl5LDh9TDN2HBvBdYY5/Anv6euLXeCU/rtaawont6Sz1qVJwf7dS12ac97Th
	3sMvt1y2rd4RF2z0YS3Xop54PzKbSAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720447192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5sXTijI002hf7XAvpPYziM6tBUMYCMUGWGA3oNXAdI=;
	b=rMEMOgXhaJmCTYOaRaKOcJHS/lViuvP7NZACG0aHKvQA19s8s8f0wzxdls+9k5Wb+7IW8F
	6wtUIl+lwLWSxNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 952B313A7F;
	Mon,  8 Jul 2024 13:59:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ajUfI9jwi2aMCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 08 Jul 2024 13:59:52 +0000
Date: Mon, 08 Jul 2024 16:00:24 +0200
Message-ID: <87ed84rnk7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>,	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
In-Reply-To: <1j4j90hurv.fsf@starbuckisacylon.baylibre.com>
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
	<20240628122429.2018059-2-jbrunet@baylibre.com>
	<326792b9-e706-4ab0-a1e8-cc48943e357d@linux.intel.com>
	<874j99434a.wl-tiwai@suse.de>
	<1j4j90hurv.fsf@starbuckisacylon.baylibre.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,suse.com,perex.cz,alsa-project.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,baylibre.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DBE401F449
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Mon, 08 Jul 2024 15:34:44 +0200,
Jerome Brunet wrote:
> 
> On Mon 01 Jul 2024 at 16:07, Takashi Iwai <tiwai@suse.de> wrote:
> 
> > On Mon, 01 Jul 2024 10:50:02 +0200,
> > Amadeusz S³awiñski wrote:
> >> 
> >> On 6/28/2024 2:23 PM, Jerome Brunet wrote:
> >> > The usual sample rate possible on an SPDIF link are
> >> > 32k, 44.1k, 48k, 88.2k, 96k, 172.4k and 192k.
> >> > 
> >> > With higher bandwidth variant, such as eARC, and the introduction of 8
> >> > channels mode, the spdif frame rate may be multiplied by 4. This happens
> >> > when the interface use an IEC958_SUBFRAME format.
> >> > 
> >> > The spdif 8 channel mode rate list is:
> >> > 128k, 176.4k, 192k, 352.8k, 384k, 705.4k and 768k.
> >> > 
> >> > All are already supported by ASLA expect for the 128kHz one.
> >> > Add support for it but do not insert it the SNDRV_PCM_RATE_8000_192000
> >> > macro. Doing so would silently add 128k support to a lot of HW which
> >> > probably do not support it.
> >> > 
> >> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> > ---
> >> 
> >> From what I remember the recommendation is to not add new rates, but
> >> use SNDRV_PCM_RATE_KNOT for all rates not included already.
> >
> > In general yes -- unless the new rate is used for significant amount
> > of drivers.
> >
> > So this case is a sort of on a border line; if it's only for ASoC
> > SPDIF codec driver, I'd rather implement with an extra rate list
> > instead of extending the common bits (that has some potential risks by
> > breaking the existing numbers).
> 
> At the moment it would be used by ASoC spdif codec yes (and with Amlogic
> eARC support reasonnably soon, hopefully) 
> 
> However it is likely to be a common rate of any derivative of an IEC958
> interface, with a sufficiently high bandwidth. I suspect there might be
> more of those in the future. Also, it is not an exotic rate for some obscure
> codec no one really has. It is part of specified interface that every TV
> with HDMI 2 is likely to have nowadays. This is why I thought it made
> sense to add it to the usual list. It is the only rate missing,
> everything else is already there.
> 
> Changing the spdif codecs with SNDRV_PCM_RATE_KNOT and a custom rate
> list is doable I suppose, if the new ID is not OK. 
> 
> BTW, I tried not changing the existing numbers and add 128k last but that
> broke. I guess something requires the IDs to be ordered. I did not check
> this further since updating the IDs worked fine (for me, at least :) )
> 
> > OTOH, if we can take this for further
> > cleanups of the existing requirement of 128khz rate, we can go with
> > it.
> >
> 
> Apart from the problem reported in sound/usb/caiaq/audio.c, is there
> another clean up expected ?

The change for caiaq/audio.c is rather a "fix" :)
As a cleanup, I meant, whether this extension can be applied to the
other existing drivers that already use 128kHz with RATE_KNOT and an
extra list.


thanks,

Takashi

