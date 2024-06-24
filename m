Return-Path: <linux-kernel+bounces-227211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6AB914A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699F41F20FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B770B13D250;
	Mon, 24 Jun 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CcfiOsim";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="90Mqj0rn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CcfiOsim";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="90Mqj0rn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDB1386DA;
	Mon, 24 Jun 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232728; cv=none; b=BadduWOi0XKVMbI8KFBpu/k/+qqXvlCb0iMFLXasO/PJFhX9xLVz7e2GrxBnfVcVFzajojmt2OhZFNKVeMpDMG1Tfw+6kxi+hFq1DhMm+rAdZ5wauBqg1zKayQjfC5ksHW0hZNGNEnsAGFUFhYAT65DSLGqBeFmHcjm8Nse9eSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232728; c=relaxed/simple;
	bh=5f271pDr1ahM5SqwJ/FdzIvWr5YTy8DEC+ubl041pkA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfZ9jeqctqv7YAVbwiydU02ZH9Pa+R1JWoBIN4rSQdq95bT2btb/aMNuYsFiPbvToFEy6J7YyW4pjRe0MU/l+IFkcBrI1RawQjiNgdWcjkKKQgxBmHoTzyamxY6Plx4OkoDwcVcnFg/ld48/3gliuHNfW5CiJn5Net0hMabmdE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CcfiOsim; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=90Mqj0rn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CcfiOsim; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=90Mqj0rn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 444611F80B;
	Mon, 24 Jun 2024 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719232725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbSage3HyrEVwFLtd/Vvui2tvoWIUIjXv/F2zE7Q6fM=;
	b=CcfiOsimvtVMem5AXBI8XchBHjKtHK/2Z31AG7GcElIeKJ+98O7RfCWzkCbg42vVf30QMH
	BqVRuh2YmnXYgijwdR1GET3WvLAPSXpDvxE3I7Im4Y2tn+Knw/CljYQ6AAMcwpDFUaNU/a
	1GwF1vu/185iDIVPKfqtIGRHbkxpzZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719232725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbSage3HyrEVwFLtd/Vvui2tvoWIUIjXv/F2zE7Q6fM=;
	b=90Mqj0rnCZbnLYmhZNvEDKpRJIvo15yJznxe+aLPbWoxEVOOkEFcaTqVJ792LZDZdWyek2
	V/dXcDiHA9EWsoDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719232725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbSage3HyrEVwFLtd/Vvui2tvoWIUIjXv/F2zE7Q6fM=;
	b=CcfiOsimvtVMem5AXBI8XchBHjKtHK/2Z31AG7GcElIeKJ+98O7RfCWzkCbg42vVf30QMH
	BqVRuh2YmnXYgijwdR1GET3WvLAPSXpDvxE3I7Im4Y2tn+Knw/CljYQ6AAMcwpDFUaNU/a
	1GwF1vu/185iDIVPKfqtIGRHbkxpzZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719232725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbSage3HyrEVwFLtd/Vvui2tvoWIUIjXv/F2zE7Q6fM=;
	b=90Mqj0rnCZbnLYmhZNvEDKpRJIvo15yJznxe+aLPbWoxEVOOkEFcaTqVJ792LZDZdWyek2
	V/dXcDiHA9EWsoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03BD41384C;
	Mon, 24 Jun 2024 12:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3XVJO9RoeWasZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 24 Jun 2024 12:38:44 +0000
Date: Mon, 24 Jun 2024 14:39:12 +0200
Message-ID: <87cyo6plan.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	lars@metafoo.de,
	perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [RESEND PATCH] ALSA: dmaengine_pcm: terminate dmaengine before synchronize
In-Reply-To: <CAA+D8APZ8-3NFceuQeTnEL-K4reUGGfrgyG63jyjydFA6o_4MA@mail.gmail.com>
References: <1718851218-27803-1-git-send-email-shengjiu.wang@nxp.com>
	<87frt82gj7.wl-tiwai@suse.de>
	<CAA+D8APZ8-3NFceuQeTnEL-K4reUGGfrgyG63jyjydFA6o_4MA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Fri, 21 Jun 2024 04:21:19 +0200,
Shengjiu Wang wrote:
> 
> On Thu, Jun 20, 2024 at 3:56 PM Takashi Iwai <tiwai@suse.de> wrote:
> > But, this may need more rework, too; admittedly it imposes the
> > unnecessary resume of the stream although it shall be stopped and
> > closed immediately after that.  We may have some optimization in
> > addition.
> 
> The suspended_state is not cleared that the resume may be called again
> at the end of stream.

Right, that's the known side effect of this approach.

> Will you push the code?

I'm rethinking of this again, and I'm inclined rather to take your
patch for now.  The side-effect above would be much higher impact in
theory, so I'm not quite sure whether the behavior is acceptable.

Basically, a missing piece is the shortcut state change from SUSPENDED
to CLOSED.  Most drivers don't care as the SUSPENDED state is almost
equivalent with STOPPED state, and they don't support RESUME (hence
the application needs to re-initialize via PREPARE).  But a case like
dmaengine, there can be inconsistency as you pointed out.

By putting snd_pcm_resume() at the beginning of close procedure like
my patch, the state change itself is corrected.  However, it imposes
unnecessary resume, which should be avoided.

Ultimately, we may need some flag or conditional trigger for clearing
this pending SUSPENDED state.  But it needs further consideration.


thanks,

Takashi

