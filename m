Return-Path: <linux-kernel+bounces-301227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC5595EDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04E91C21D86
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6AB146A6B;
	Mon, 26 Aug 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e5ct1bAK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wJ7UxLax";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e5ct1bAK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wJ7UxLax"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CED804;
	Mon, 26 Aug 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666621; cv=none; b=Gsm4Z2XDi9ey+fjtEoazBDloIl/giy+YHqsGasd6TDRRLMQxUpBITKCqErtJcobWc482INmXJ3WoIZqz2n9ufnhfuNmNl4G6HStaMBuK9qjYbGh+tT2kIDC+VUy4fzHWnQXJ0sd+C0YK1lfYev8g/fQdvFGiPkzyv2L3oyFt4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666621; c=relaxed/simple;
	bh=X/mqdZCFi4LTSzjI6F3xX6K/KLHUaTrHYg+1IwoTG+s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXOrHG4RcDpuHUhZ4FLKhbJhvvqk9tGpYmNiQCnJcTLcIjiaryd8uff1jFKx4/62gISeM7nRfE2hNprYydS1wrS3pLYThXlYpUvuCfSoxPHpInZgRNPfjPO8OM+MvDRG/l4VAxvhe22mXKIwiQKoDLHJGg4YCrxbvtu2/E6g5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e5ct1bAK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wJ7UxLax; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e5ct1bAK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wJ7UxLax; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 212C21F850;
	Mon, 26 Aug 2024 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724666618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkErUlMgye/QxLsycfZwn1IALWdHfgnpbNDo4eIGwPo=;
	b=e5ct1bAKIMsCTCQ64UvmmYQ13eKRGNu4cm6tEFtfYm9TKyL3fucd/4WSgYHnEyBIaYsVcE
	D46KQy+BTaDlHSA9VwCg6PtL2sq5FAc7AycQWbMqIKkIXq9Im+XjbUE0nyfA7CyoM3+0gu
	VIpOILeu+I/pHK+FuVdb7+thM7Ye8j8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724666618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkErUlMgye/QxLsycfZwn1IALWdHfgnpbNDo4eIGwPo=;
	b=wJ7UxLaxlHTaONGFS0lH2T2SQHoHxTaMh/d91v1ga3Kjv6n68gQUMODZ4vsfP3bAd9uAL3
	7QTgsuzYcbydE4Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e5ct1bAK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wJ7UxLax
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724666618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkErUlMgye/QxLsycfZwn1IALWdHfgnpbNDo4eIGwPo=;
	b=e5ct1bAKIMsCTCQ64UvmmYQ13eKRGNu4cm6tEFtfYm9TKyL3fucd/4WSgYHnEyBIaYsVcE
	D46KQy+BTaDlHSA9VwCg6PtL2sq5FAc7AycQWbMqIKkIXq9Im+XjbUE0nyfA7CyoM3+0gu
	VIpOILeu+I/pHK+FuVdb7+thM7Ye8j8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724666618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkErUlMgye/QxLsycfZwn1IALWdHfgnpbNDo4eIGwPo=;
	b=wJ7UxLaxlHTaONGFS0lH2T2SQHoHxTaMh/d91v1ga3Kjv6n68gQUMODZ4vsfP3bAd9uAL3
	7QTgsuzYcbydE4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E0A1398D;
	Mon, 26 Aug 2024 10:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sUtjN/lSzGZ+egAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 26 Aug 2024 10:03:37 +0000
Date: Mon, 26 Aug 2024 12:04:22 +0200
Message-ID: <87frqriord.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: hda_component: Fix mutex crash if nothing ever binds
In-Reply-To: <20240826094940.45563-1-rf@opensource.cirrus.com>
References: <20240826094940.45563-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 212C21F850
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 26 Aug 2024 11:49:40 +0200,
Richard Fitzgerald wrote:
> 
> Move the initialization of parent->mutex into
> hda_component_manager_init() so that it is always valid.
> 
> In hda_component_manager_bind() do not clear the parent information.
> Only zero-fill the per-component data ready for it to be filled in
> by the components as they bind.
> 
> Previously parent->mutex was being initialized only in
> hda_component_manager_bind(). This meant that it was only
> initialized if all components appeared and there was a bind callback.
> If there wasn't a bind the mutex object was not valid when the
> Realtek driver called any of the other functions.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 047b9cbbaa8e ("ALSA: hda: hda_component: Protect shared data with a mutex")

Thanks, applied now to for-linus branch.


Takashi

