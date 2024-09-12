Return-Path: <linux-kernel+bounces-326037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8629761A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE545B21B77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8E218BB80;
	Thu, 12 Sep 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i6yEJ0SH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OzgyJ6HO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kkg6zmEc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qkU2/s7w"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91A1898E6;
	Thu, 12 Sep 2024 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123224; cv=none; b=W67ZBObEpDHUFwFwIyF7Zhy4qesS7aHLskw2tTy7LINPKrhP5V9gXuMEFRUThX+WkBhTRrjRpHX4TRhuuugRogu2WmflP3WpPAVnV7gm/YbcEKqtoxnnyUhSHPyRLxkx2x2wU1vRYzd3u+6xuJpG1fIguKyJuHuYftgOPr7MZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123224; c=relaxed/simple;
	bh=qlkxiGVfAawnzAbu4vj+aVeVqB1IK3wCK1Ay8Qsvn/E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9YBigDyqcBzRu+FBLgTNhj0SKJAFeN9hg1B9OKUNXkgRo8xllueqhbKraYI6AjpAKaWugfBCF8BemEHmpF+5wWw3DHaQGYkskifr3W4iQHqn7zEG+/wUdG2UtaJKJNng0fybqYoeMlOXox292hF5j83cE3vv+uWp+hC/HyRiqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i6yEJ0SH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OzgyJ6HO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kkg6zmEc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qkU2/s7w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E276E21ADF;
	Thu, 12 Sep 2024 06:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726123220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ra0Qgw/VImENFFqMCROKUJr/aKmzw6l5/J/Yegu0dQI=;
	b=i6yEJ0SHJzs2ZYcXuxoC6Bb/26hldZ+YQ6PGzq1n/rI/007oFiPW2676gzkaDuctnl5FpK
	H+LlGV4XUgDudkJb7ODjNceg1zm4gFMpw4NUj/jhXmdpJZBKOH5cnwKxdS37N7JQh7dr9c
	yNo9x1pqYg3IYXZLJ+yoxBs+NyMrVZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726123220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ra0Qgw/VImENFFqMCROKUJr/aKmzw6l5/J/Yegu0dQI=;
	b=OzgyJ6HOBUvSZeFu6dbWFtQQyJTH/EGk7ZEPGPUcP64livuMJSj8uoQxP+jTrqEhMYQCXb
	Uo4JjxF8w7TM4zDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kkg6zmEc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="qkU2/s7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726123219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ra0Qgw/VImENFFqMCROKUJr/aKmzw6l5/J/Yegu0dQI=;
	b=kkg6zmEcOiUcCRdxBAAOoRz2rv5ryGlRh91j74Xx/RdqQ6THfIstZaZDV3rluMX8+gSHQK
	2joZt5+J2ZELIzsW4XrXWWtMFPyXl/rj7ekpoEdsPWEXvQ3NAm0+Y0RrQGlK3ZuKUAnoFa
	J/uP13Srmef0I0s9p0tgFl15/od2OT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726123219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ra0Qgw/VImENFFqMCROKUJr/aKmzw6l5/J/Yegu0dQI=;
	b=qkU2/s7wmTkcJgu00Jd3F89FXjzxo4RhzAUbN3y3N7Qoy7+dHFruTFdae+XYYgLz3XPf0m
	zlypK7Onq7hTTuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABD3313A73;
	Thu, 12 Sep 2024 06:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tO8pKNOM4mYoaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 12 Sep 2024 06:40:19 +0000
Date: Thu, 12 Sep 2024 08:41:07 +0200
Message-ID: <87h6al1iik.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ALSA: ump: Use %*ph to print small buffer
In-Reply-To: <20240911195039.2885979-1-andriy.shevchenko@linux.intel.com>
References: <20240911195039.2885979-1-andriy.shevchenko@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E276E21ADF
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 11 Sep 2024 21:50:39 +0200,
Andy Shevchenko wrote:
> 
> Use %*ph format to print small buffer as hex string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, applied now.


Takashi

