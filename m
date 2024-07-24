Return-Path: <linux-kernel+bounces-260697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF23E93AD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499ED1F227C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E9A6E611;
	Wed, 24 Jul 2024 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5eYjVer";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wohCYoZu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5eYjVer";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wohCYoZu"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55D4C84;
	Wed, 24 Jul 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805694; cv=none; b=rOAsBiAXXJkCS2ZghePl+R2tDdpQ1Yxw6yAC1g0VhWxiiuEZ1RNCxaD2AK2L4PcOJmvBsNhrUAGNKcdQEXjt8M/KTvdks6ptwwTNeTKiJUj+i8nsgqmUROQ2SReTCzn4A8n5rf+6BngaMWQ8QjcGdndvw+bwmhmRYT8dplTDk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805694; c=relaxed/simple;
	bh=/OxbqeFXZJBzITyYv+VkE5wJKT+kzst/yWR2yQbPhNI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZHMoHFcQNFazx+6mFtASJh9s7T7UPdoWs9HUIti7zyFrUW3aHeTSzUYUD4bw+gs5841MZSZyc1Bl1qxdwOh/CzNG5CVTGY9D0RTkv4n2SlzVdL1uNTvNHIIKNmVq6kWN9Ttm1beuQCE6uZ6C3XgNxlwF9OyKY7seSuX1vN+86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J5eYjVer; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wohCYoZu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J5eYjVer; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wohCYoZu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 191CD1F74B;
	Wed, 24 Jul 2024 07:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721805690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPPgtgLiOKT8FFQeCtEOAG2iHovCigqjgeJnxTCVTi8=;
	b=J5eYjVerz1TnhJP0ultEZFNJxXNFGMmJbyBTH9h4P1IZYH3NuSK01QC0oVsife43s97m+Y
	um/XDvF1Kz3/9i7r1UttEpeSciizEcPuItBWccEkdka/+mG6teF8JXJfFxdEdIJpTK7aNE
	ROQxdwcQS8C1UbBUsqiXRdlZAf27yVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721805690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPPgtgLiOKT8FFQeCtEOAG2iHovCigqjgeJnxTCVTi8=;
	b=wohCYoZuO6HZ9ZoHa17pK7Ac7tuln8TgDrlkahs4MZ+F2CYFxQHx/apoF57GtBDixjFYFJ
	+PMQ7vw/7XmdyMBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J5eYjVer;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wohCYoZu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721805690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPPgtgLiOKT8FFQeCtEOAG2iHovCigqjgeJnxTCVTi8=;
	b=J5eYjVerz1TnhJP0ultEZFNJxXNFGMmJbyBTH9h4P1IZYH3NuSK01QC0oVsife43s97m+Y
	um/XDvF1Kz3/9i7r1UttEpeSciizEcPuItBWccEkdka/+mG6teF8JXJfFxdEdIJpTK7aNE
	ROQxdwcQS8C1UbBUsqiXRdlZAf27yVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721805690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPPgtgLiOKT8FFQeCtEOAG2iHovCigqjgeJnxTCVTi8=;
	b=wohCYoZuO6HZ9ZoHa17pK7Ac7tuln8TgDrlkahs4MZ+F2CYFxQHx/apoF57GtBDixjFYFJ
	+PMQ7vw/7XmdyMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3CCF1324F;
	Wed, 24 Jul 2024 07:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ucHrMXmroGYyNQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Jul 2024 07:21:29 +0000
Date: Wed, 24 Jul 2024 09:22:04 +0200
Message-ID: <871q3jmezn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+78eccfb8b3c9a85fc6c5@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: line6: init buf to zero
In-Reply-To: <tencent_6ECFD36FE36EC96283A5C4587761F76F8605@qq.com>
References: <00000000000000949c061df288c5@google.com>
	<tencent_6ECFD36FE36EC96283A5C4587761F76F8605@qq.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[78eccfb8b3c9a85fc6c5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 191CD1F74B
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.81

On Wed, 24 Jul 2024 07:58:45 +0200,
Edward Adam Davis wrote:
> 
> Syzbot report KMSAN uninit-value warnings.
> When alloc buffer for midi_buffer->buf, init mem to 0.
> 
> Reported-and-tested-by: syzbot+78eccfb8b3c9a85fc6c5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=78eccfb8b3c9a85fc6c5
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  sound/usb/line6/midibuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/line6/midibuf.c b/sound/usb/line6/midibuf.c
> index e7f830f7526c..1b699cb3b38d 100644
> --- a/sound/usb/line6/midibuf.c
> +++ b/sound/usb/line6/midibuf.c
> @@ -48,7 +48,7 @@ void line6_midibuf_reset(struct midi_buffer *this)
>  
>  int line6_midibuf_init(struct midi_buffer *this, int size, int split)
>  {
> -	this->buf = kmalloc(size, GFP_KERNEL);
> +	this->buf = kzalloc(size, GFP_KERNEL);

Thanks for the patch.  But this just hides the KMSAN warning, and it
doesn't really address the cause - why it was exposed at all; the
driver code had already a check and should have accessed only the
updated data, but by some reason it slipped.

Through a quick glance, I see a possible.  If that's the cause, the
patch like below might help.  I checked the reproducer locally but
couldn't  trigger the bug on my image, unfortunately, so it's just a
wild guess, and it might be shooting a wrong way.  Let's see.


thanks,

Takashi

-- 8< --
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -286,12 +286,14 @@ static void line6_data_received(struct urb *urb)
 {
 	struct usb_line6 *line6 = (struct usb_line6 *)urb->context;
 	struct midi_buffer *mb = &line6->line6midi->midibuf_in;
+	unsigned long flags;
 	int done;
 
 	if (urb->status == -ESHUTDOWN)
 		return;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+		spin_lock_irqsave(&line6->line6midi->lock, flags);
 		done =
 			line6_midibuf_write(mb, urb->transfer_buffer, urb->actual_length);
 
@@ -300,12 +302,15 @@ static void line6_data_received(struct urb *urb)
 			dev_dbg(line6->ifcdev, "%d %d buffer overflow - message skipped\n",
 				done, urb->actual_length);
 		}
+		spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 
 		for (;;) {
+			spin_lock_irqsave(&line6->line6midi->lock, flags);
 			done =
 				line6_midibuf_read(mb, line6->buffer_message,
 						   LINE6_MIDI_MESSAGE_MAXLEN,
 						   LINE6_MIDIBUF_READ_RX);
+			spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 
 			if (done <= 0)
 				break;

