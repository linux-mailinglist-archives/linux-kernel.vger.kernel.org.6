Return-Path: <linux-kernel+bounces-406277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF99C5CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F771F23AED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF5220721E;
	Tue, 12 Nov 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="piTpMSD+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vkBlhbKp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GmSl3jJ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DM4Yn+lS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B02204005;
	Tue, 12 Nov 2024 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427448; cv=none; b=IvuAK/6OZ2vPh+dYn35YYUP2kAtKJASBh3QK2v8RHaopsupvJptsn//iKS8up61yM4FE1SH5dkD+Frx+cNa2S+n7sBt7zzRJCZqmEH3/5Otyp8IoEpE3JctQy2Xpts0I7wE5tUsU6KhgY19BAX1EtU8NrYrrO4sHj3JDBfkCoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427448; c=relaxed/simple;
	bh=l5DrxO8EWdrMiwMpBgE3J+dkWpcb2S9HNrdbP8mt9hE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBJQkieMFwCVWFyvneDUAwCH5i1EaYidooVQ3EIN3rvR59qGDbXSfQHUX5PxiL7w1oNYQM6JNP5I+q+HuGIK3u588H+3oHIxbc2KWLl/lAXdqkKPvW7Cu2a4M9yN8Vuiv5Kkvk+tX8+V74cJGZbbPRaYEHgWGFec+r2SbFPQ7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=piTpMSD+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vkBlhbKp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GmSl3jJ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DM4Yn+lS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE0B52126C;
	Tue, 12 Nov 2024 16:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731427445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64qgWyYd2C7QnivLzTaPxC5rj5UDbBbbzqPmBwQcZDw=;
	b=piTpMSD+gxnxUaLQReGiekO1FNXVASwD0xVarBwx53dF0sWVinCTNSzb4SNpzvyXnVnFM0
	qT4yQsa3e19bbCMyFJFM66mOEIPcQLnvxDAsWdxWuSVSta3KCozZfc8QDzxMqkMFbrc3PN
	GliTxPrTA3M9bJrorKUeNRLIarCXmjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731427445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64qgWyYd2C7QnivLzTaPxC5rj5UDbBbbzqPmBwQcZDw=;
	b=vkBlhbKpJ2z2Uht41v5PaxSJiWxLv8UVoW3bYGevfWNGBa7+qGN/+milQ58xjS1s1VluhC
	/1dVkvWxTUpXLwAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GmSl3jJ7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DM4Yn+lS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731427444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64qgWyYd2C7QnivLzTaPxC5rj5UDbBbbzqPmBwQcZDw=;
	b=GmSl3jJ71FSnZoLeljsh5u+R91yyufm5YFHzyhKNB6Mo84hUvc/8oerqC5Bpa5ivyXb0RF
	1NHUHayqIZKoUiVcItGg4Pp0ATd7gRAuDX3d6zMzWcXDhe7/AA/cOT33OL2h2Msy5ph0XV
	INioHOCMPj04k1XW1jrWcXNKvWsXxzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731427444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64qgWyYd2C7QnivLzTaPxC5rj5UDbBbbzqPmBwQcZDw=;
	b=DM4Yn+lS7d91qaVVTCObnfwqJU4ufFHAP7Hdp6I6Gs/V3Gseh2SWefsPqszbbNrU2TmjgD
	+Mn9mgcz5lJDl8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A864713721;
	Tue, 12 Nov 2024 16:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TCrbJ3R8M2dmGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 12 Nov 2024 16:04:04 +0000
Date: Tue, 12 Nov 2024 17:04:04 +0100
Message-ID: <874j4ctp57.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH] usb: fix a task hung in snd_card_free
In-Reply-To: <tencent_9E3DBD3732961C37FC4AEC74E3763367E209@qq.com>
References: <6726bf35.050a0220.35b515.018b.GAE@google.com>
	<tencent_9E3DBD3732961C37FC4AEC74E3763367E209@qq.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: DE0B52126C
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[73582d08864d8268b6fd];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01
X-Spam-Flag: NO

On Wed, 06 Nov 2024 03:15:49 +0100,
Edward Adam Davis wrote:
> 
> task 1: snd ctrl will add card_dev ref count and can't call close to dec it,
>         it is blocked waiting for task 2 to release the USB dev lock.
> 
> task 2: usb dev lock has been locked by hung task (here is usb_disconnect),
>         it is hung waiting for task 1 to exit and release card_dev.
> 
> Adjust the USB lock acquisition method to non-blocking in ioctl to avoid
> hang when the USB connection is closed.

I'm afraid that this change would break things too badly.
i.e. changing the blocking behavior to non-blocking is no-go.

> Reported-and-tested-by: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd

This particular syzkaller entry can be fixed rather by replacing
snd_card_free() in snd_usx2y_disconnect() with
snd_card_free_when_closed() like other USB audio drivers, something
like below.

Judging from the git log, it had been with snd_card_free_in_thread(),
but was switch to snd_card_free() around year 2005.  Meanwhile the
handling of async card release got improved, and it's very likely OK
to use snd_card_free_when_closed() there with the recent kernel.


thanks,

Takashi

-- 8< --
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -422,7 +422,7 @@ static void snd_usx2y_disconnect(struct usb_interface *intf)
 	}
 	if (usx2y->us428ctls_sharedmem)
 		wake_up(&usx2y->us428ctls_wait_queue_head);
-	snd_card_free(card);
+	snd_card_free_when_closed(card);
 }
 
 static int snd_usx2y_probe(struct usb_interface *intf,

