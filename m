Return-Path: <linux-kernel+bounces-258986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C91C938F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BED280DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F58F16A38B;
	Mon, 22 Jul 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gEx/O9jn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MzuayszW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gEx/O9jn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MzuayszW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4016A399;
	Mon, 22 Jul 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721653033; cv=none; b=ZciN0W0q+hFq0iIuJd5VPXXmum+0Qrsx+t1iqScUAh5btLI+0YbZofJFxufXojM9/qpfAlwdw2e5UXM4uJsLesyvuXpgfjB3Eczw+iQBGK6GrgUoCnHrmo4inoXVEPDvJVG0zX/w4uCFBga9eKdR0jYM70FJYyKiWZrL3DeNSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721653033; c=relaxed/simple;
	bh=WChoUybuFOfPdrfhko7m25GNRNYjGCeVsl5cWwnGGoM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABncEIVQOLBvtbPWdXhklqPJViThQQA+pEBkccNEUnohFULlTl++wO7hre9s2lVU8bCq3TXey73qSbxbuKyTVdRRiJGk4v+KQv8ZLfewg44uk/W2Aw8kBTBKQBA74BLFxjXPA2pYpiLnqYtYX13VGKi08dzT+uF/rmbyS8akKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gEx/O9jn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MzuayszW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gEx/O9jn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MzuayszW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 418D621A2A;
	Mon, 22 Jul 2024 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721653029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Cp1ZyS4N4wStUscrinCWknLNr7kS4hDp7m0OYKKM7k=;
	b=gEx/O9jn8sdafbaRiBC6u15YDe0JcSSXL8OWvSvRrUIncvUt3MVfhhRsAs8opf3aITHFqZ
	YkEfWRL5cOc7aWGguj0RIrjwJCbPmbdjJXK9FMawJmnB6wkZ85YPc3CUw8pN3NwYBtlDm0
	+u9mSA6UhPqcP6seesh75CA18X2oI7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721653029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Cp1ZyS4N4wStUscrinCWknLNr7kS4hDp7m0OYKKM7k=;
	b=MzuayszWdKjNc+GmV+0LC8hb2D9YXvRaHJFLToeDMySi+UOVVAgLFfqQX43QTNfsm0oxUn
	fFk8LhZ0vTnRMHBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="gEx/O9jn";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MzuayszW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721653029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Cp1ZyS4N4wStUscrinCWknLNr7kS4hDp7m0OYKKM7k=;
	b=gEx/O9jn8sdafbaRiBC6u15YDe0JcSSXL8OWvSvRrUIncvUt3MVfhhRsAs8opf3aITHFqZ
	YkEfWRL5cOc7aWGguj0RIrjwJCbPmbdjJXK9FMawJmnB6wkZ85YPc3CUw8pN3NwYBtlDm0
	+u9mSA6UhPqcP6seesh75CA18X2oI7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721653029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Cp1ZyS4N4wStUscrinCWknLNr7kS4hDp7m0OYKKM7k=;
	b=MzuayszWdKjNc+GmV+0LC8hb2D9YXvRaHJFLToeDMySi+UOVVAgLFfqQX43QTNfsm0oxUn
	fFk8LhZ0vTnRMHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 124F5136A9;
	Mon, 22 Jul 2024 12:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zbqjAiVXnmbHLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Jul 2024 12:57:09 +0000
Date: Mon, 22 Jul 2024 14:57:42 +0200
Message-ID: <87zfq9oa7t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Nick Weihs <nick.weihs@gmail.com>
Cc: tiwai@suse.com,
	lsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Implement sound init sequence for Samsung Galaxy Book3 Pro 360
In-Reply-To: <CAGKKx0-FRCbeS5CTQfoe3Zqw9BH6Wws1ch_XhyzxaP_s2z+OqA@mail.gmail.com>
References: <CAGKKx0-FRCbeS5CTQfoe3Zqw9BH6Wws1ch_XhyzxaP_s2z+OqA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.81
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 418D621A2A
X-Spamd-Result: default: False [-1.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO

On Mon, 22 Jul 2024 02:10:59 +0200,
Nick Weihs wrote:
> 
> Samsung Galaxy Book3 Pro 360 sends a large amount of data to the codec
> through hda processing coefficients.  This data was captured using a
> modified version of QEMU, but the actual content of the data remains
> opaque to me.  Elliding any part of the data seems to cause sound to
> not work.
> 
> Signed-off-by: Nick Weihs <nick.weihs@gmail.com>

Thanks for the patch.  However, the patch isn't cleanly applicable as
your mailer seems breaking spaces.  Please try to fix the mailer setup
(at best use git-send-email) or use attachment as the last resort.

About the code change:
> +static inline void alc298_samsung_write_coef_pack2(struct hda_codec *codec,
> +                           const unsigned short coefs[4])

Passing the fixed size array as an argument is hard to read and
error-prone.  Better to define a struct instead?

> +{
> +    int i;
> +
> +    for (i = 0; i < 100; i++) {
> +        if ((alc_read_coef_idx(codec, 0x26) & 0x0010) == 0)
> +            break;
> +    }

This loop looks unreliable.  Usually this kind of loop should have
some delay and/or timeout as the break out condition.

> +static void alc298_fixup_samsung_amp2(struct hda_codec *codec,
> +                      const struct hda_fixup *fix, int action)
> +{
> +    int i;
> +    static const struct alc298_samsung_coeff_fixup_desc fixups1[] = {
> +        { 0x99, 0x8000 }, { 0x82, 0x4408 }, { 0x32, 0x3f00 }, { 0x0e, 0x6f80 },
> +        { 0x10, 0x0e21 }, { 0x55, 0x8000 }, { 0x08, 0x2fcf }, { 0x08, 0x2fcf },
> +        { 0x2d, 0xc020 }, { 0x19, 0x0017 }, { 0x50, 0x1000 }, { 0x0e, 0x6f80 },
> +        { 0x08, 0x2fcf }, { 0x80, 0x0011 }, { 0x2b, 0x0c10 }, { 0x2d, 0xc020 },
> +        { 0x03, 0x0042 }, { 0x0f, 0x0062 }, { 0x08, 0x2fcf },
> +    };
> +
> +    static const unsigned short amp_0x38[][4] = {
> +        { 0x2000, 0x0000, 0x0001, 0xB011 }, { 0x23FF, 0x0000, 0x0000, 0xB011 },
> +        { 0x203A, 0x0000, 0x0080, 0xB011 }, { 0x23E1, 0x0000, 0x0000, 0xB011 },
(snip)

Such a bulk of data is usually put into another file, and included
from patch_realtek.c.  Otherwise the code becomes too clumsy.
See sound/pci/hda/*_helper.c files as examples.

Also, we prefer the lower alphabet for hex numbers.

> +    ///// First set of fixups

Too many slashes.  Just use '//'.

Last but not least, try to fix coding-style issues reported by
scripts/checkpatch.pl.


thanks,

Takashi

