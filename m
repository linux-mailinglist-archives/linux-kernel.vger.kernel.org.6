Return-Path: <linux-kernel+bounces-326659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D4976B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98E62821C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B746F1AD25A;
	Thu, 12 Sep 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CMZ1lW6c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P7JH6P8b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CMZ1lW6c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P7JH6P8b"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19F19F43E;
	Thu, 12 Sep 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149794; cv=none; b=XCMO3G5e8KN1CJfkaRvltjy+j+Dct5vhAZY2Yn2KDK6UqR5F6ek4WHpV3Q2ADmCMiBPVCDej6Crkudv0TV8PbTv4JP/WN77269Ub42oKWWNXVOccRlYaIevuApjfffk79XFQwijrXjpk8ml/ahXPvyX+EosqOhYALpA4eSm60qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149794; c=relaxed/simple;
	bh=pU9EDLH8YOlI7K9VrpwxvKT6yC9pj2rCPVeHAQU1uBQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXxbpwHTre92udd6/fRnAVJswHWjepaTgIbJwiqPtrWvCokmF+Bx8d2eMzVYr5pWyb0iU9kFxjroXGRq51qh9dgDFInlThvgouzJof3ZrZT19/cj91K5XUguDKfbWTM48HfSOy7xfda9YE1WrNynU6QClcRaq1xPJisT8xWd6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CMZ1lW6c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P7JH6P8b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CMZ1lW6c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P7JH6P8b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8546B219B8;
	Thu, 12 Sep 2024 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726149790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBsxw1L2t1ColpoRoRCyZTlOXVTERMyxbhoF1TUdq/8=;
	b=CMZ1lW6cTvMdjxTvTspPNghdaDtJtCh7bWp/ocpsmktR4BpBFtfkemMaiu22A3DOfisBbt
	wPOdBYa72NXs3pJFgYlBWVtmoIbDPaVC9qw6zb5w17tl5PywRHyjXZtW3+KLjUf5kQSdto
	ZOELaSpjNF/JHTqBRbYFQpeknSNTQSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726149790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBsxw1L2t1ColpoRoRCyZTlOXVTERMyxbhoF1TUdq/8=;
	b=P7JH6P8bKk+/Qr/MfLkxtXmF4Yw6mmMxYEF6tM8up6UMN5ney/voYLuQZ4Ogtb2Zp1uiCs
	SXu0pkKRCH9qQ7Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726149790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBsxw1L2t1ColpoRoRCyZTlOXVTERMyxbhoF1TUdq/8=;
	b=CMZ1lW6cTvMdjxTvTspPNghdaDtJtCh7bWp/ocpsmktR4BpBFtfkemMaiu22A3DOfisBbt
	wPOdBYa72NXs3pJFgYlBWVtmoIbDPaVC9qw6zb5w17tl5PywRHyjXZtW3+KLjUf5kQSdto
	ZOELaSpjNF/JHTqBRbYFQpeknSNTQSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726149790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBsxw1L2t1ColpoRoRCyZTlOXVTERMyxbhoF1TUdq/8=;
	b=P7JH6P8bKk+/Qr/MfLkxtXmF4Yw6mmMxYEF6tM8up6UMN5ney/voYLuQZ4Ogtb2Zp1uiCs
	SXu0pkKRCH9qQ7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 432BA13A73;
	Thu, 12 Sep 2024 14:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H+4uD5704mYbewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 12 Sep 2024 14:03:10 +0000
Date: Thu, 12 Sep 2024 16:03:58 +0200
Message-ID: <87r09pynn5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: control: prevent some integer overflow issues
In-Reply-To: <72907305-eddc-4fb4-9c74-7e1d2750f4b9@stanley.mountain>
References: <0f03d569-9804-4617-a806-f0e5c32399fb@stanley.mountain>
	<87v7z1yyok.wl-tiwai@suse.de>
	<20c99f50-948e-4076-ba28-9640c3cd982d@stanley.mountain>
	<72907305-eddc-4fb4-9c74-7e1d2750f4b9@stanley.mountain>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 12 Sep 2024 14:44:30 +0200,
Dan Carpenter wrote:
> 
> On Thu, Sep 12, 2024 at 02:29:58PM +0300, Dan Carpenter wrote:
> > On Thu, Sep 12, 2024 at 12:05:31PM +0200, Takashi Iwai wrote:
> > > On Thu, 12 Sep 2024 10:51:14 +0200,
> > > Dan Carpenter wrote:
> > > > 
> > > > I believe the this bug affects 64bit systems as well, but analyzing this
> > > > code is easier if we assume that we're on a 32bit system.  The problem is
> > > > in snd_ctl_elem_add() where we do:
> > > > 
> > > > sound/core/control.c
> > > >   1669          private_size = value_sizes[info->type] * info->count;
> > > >   1670          alloc_size = compute_user_elem_size(private_size, count);
> > > >                                                                   ^^^^^
> > > > count is info->owner.  It's a non-zero u32 that comes from the user via
> > > > snd_ctl_elem_add_user().  So the math in compute_user_elem_size() could
> > > > have an integer overflow resulting in a smaller than expected size.
> > > 
> > > So this should also use the overflow macro, too, in addition to your
> > > changes?  Something like:
> > > 
> > > --- a/sound/core/control.c
> > > +++ b/sound/core/control.c
> > > @@ -1618,7 +1618,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
> > >  	struct snd_kcontrol *kctl;
> > >  	unsigned int count;
> > >  	unsigned int access;
> > > -	long private_size;
> > > +	size_t private_size;
> > >  	size_t alloc_size;
> > >  	struct user_element *ue;
> > >  	unsigned int offset;
> > > @@ -1666,7 +1666,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
> > >  	/* user-space control doesn't allow zero-size data */
> > >  	if (info->count < 1)
> > >  		return -EINVAL;
> > > -	private_size = value_sizes[info->type] * info->count;
> > > +	private_size = array_size(value_sizes[info->type], info->count);
> > >  	alloc_size = compute_user_elem_size(private_size, count);
> > >  
> > >  	guard(rwsem_write)(&card->controls_rwsem);
> > > 
> > 
> > I've reviewed this some more and those changes are harmless but unnecessary.
> > info->count is checked in snd_ctl_check_elem_info().
> > 
> 
> I also considered if I should fix this bug by adding checks to
> snd_ctl_check_elem_info() but I don't think that's the right approach.  I
> couldn't see how it would work at least.

OK, so it doesn't seem affected in the end.
The input values have been checked, and they can't overflow.


thanks,

Takashi

