Return-Path: <linux-kernel+bounces-345920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2386C98BCEE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479C51C23164
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638E11C32E2;
	Tue,  1 Oct 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CunjGNYC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WSNfE8p9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CunjGNYC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WSNfE8p9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD21C32E6;
	Tue,  1 Oct 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787466; cv=none; b=GMOU/TrRF+tICXRv0CLX5v0DLgi/+ZK5XEo6f6l9OplGk0o0RKPuaAgfLfGCuOyAyqZDYO4EeglNUFOOWqg5q/Za9L0RK1MB9RDVc0LqK4a50kvac2cliOq2cW2Y4HscMrMD9UnS9/xz8CTmiQOSeTIHNrnOZjO8wBlFml6BsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787466; c=relaxed/simple;
	bh=LhfTWB6tMQoWK5z/g3CKPQKyuMtWQdNoeXO09I/1CtY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGbWQf9kmpZcOrRchZ5avB0+IGd6uiuOAkx9qjQEXVusmVXhw2t5qwCQ1Vflk/vrb9kovW7HG1xb+VSg8dcWsRvtWQ7Wkd+7RBL891OyqJ6yqiN/PUcJohE1u9FREHcr5X8UbZ+oRB2dO7sS2DkLHDTdQPpATior4OgRfFMqSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CunjGNYC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WSNfE8p9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CunjGNYC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WSNfE8p9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6081B1F813;
	Tue,  1 Oct 2024 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727787458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/kDTqIJofFIgoNOS4v+PAn/L9GKINANjFS8cBnzqJY=;
	b=CunjGNYCnF9KlUnOSD6P6JnWRGfYWXKjd2rPp1jqsfivkuBQq7cglo4EvtS+jwKvXBBMIq
	YkFNsG77FUIH0qwUSFWUwveAAXHdbDBKtAsz2E9pCBwCOf0uaQqQRjGBachvX5PWVUNnde
	Y2sOLKXQ8nDq5VtJmKm8Iq85I70z5MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727787458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/kDTqIJofFIgoNOS4v+PAn/L9GKINANjFS8cBnzqJY=;
	b=WSNfE8p9JWi7Fk/GM35ZHyvTEvRjEh5zo+Y4IGDOlfB5KGyPLqfbX8sOQl2DoMenl5IYv9
	sZvfgMhrygwfbiCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CunjGNYC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WSNfE8p9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727787458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/kDTqIJofFIgoNOS4v+PAn/L9GKINANjFS8cBnzqJY=;
	b=CunjGNYCnF9KlUnOSD6P6JnWRGfYWXKjd2rPp1jqsfivkuBQq7cglo4EvtS+jwKvXBBMIq
	YkFNsG77FUIH0qwUSFWUwveAAXHdbDBKtAsz2E9pCBwCOf0uaQqQRjGBachvX5PWVUNnde
	Y2sOLKXQ8nDq5VtJmKm8Iq85I70z5MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727787458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/kDTqIJofFIgoNOS4v+PAn/L9GKINANjFS8cBnzqJY=;
	b=WSNfE8p9JWi7Fk/GM35ZHyvTEvRjEh5zo+Y4IGDOlfB5KGyPLqfbX8sOQl2DoMenl5IYv9
	sZvfgMhrygwfbiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EE7513A6E;
	Tue,  1 Oct 2024 12:57:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AiFWDsLx+2bNAwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 01 Oct 2024 12:57:38 +0000
Date: Tue, 01 Oct 2024 14:58:31 +0200
Message-ID: <87ed50nfns.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: silence integer wrapping warning
In-Reply-To: <5457e8c1-01ff-4dd9-b49c-15b817f65ee7@stanley.mountain>
References: <5457e8c1-01ff-4dd9-b49c-15b817f65ee7@stanley.mountain>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 6081B1F813
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 30 Sep 2024 09:19:58 +0200,
Dan Carpenter wrote:
> 
> This patch doesn't change runtime at all, it's just for kernel hardening.
> 
> The "count" here comes from the user and on 32bit systems, it leads to
> integer wrapping when we pass it to compute_user_elem_size():
> 
> 	alloc_size = compute_user_elem_size(private_size, count);
> 
> However, the integer over is harmless because later "count" is checked
> when we pass it to snd_ctl_new():
> 
> 	err = snd_ctl_new(&kctl, count, access, file);
> 
> These days as part of kernel hardening we're trying to avoid integer
> overflows when they affect size_t type.  So to avoid the integer overflow
> copy the check from snd_ctl_new() and do it at the start of the
> snd_ctl_elem_add() function as well.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I'm going to write a blog about this which explains the kernel hardening
> proposal in more detail.
> 
> The problem is that integer overflows are really hard to analyze
> because the integer overflow itself is harmless.  The harmful thing comes
> later.  Not only are integer overflows harmless, but many of them are
> done deliberately.
> 
> So what we're doing is we're saying that size_t types should not overflow.
> This eliminates many deliberate integer overflows handling time values for
> example.  We're also ignoring deliberate idiomatic integer overflows such
> as if (a + b < a) {.
> 
> We're going to detect these integer overflows using static analysis and at
> runtime using UBSan and Syzbot.
> 
> The other thing, actually, is the we're planning to only work on 64bit
> systems for now so if you want to ignore this patch then that's fine.  There
> are a lot more (like 10x more) integer overflows on 32bit systems but most
> people are on 64bit.  So it's less work and more impact to focus on 64bit
> at first.

The fix is straightforward and still better to have even for 64bit, so
let's take it.  Now merged to for-linus branch.


thanks,

Takashi

