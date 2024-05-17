Return-Path: <linux-kernel+bounces-181869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 457EB8C8297
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B185D1F21432
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2993846D;
	Fri, 17 May 2024 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B+eXxu2V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nkn5CX03";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XBQquzRY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QiDVTAnD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529B23D7;
	Fri, 17 May 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715934724; cv=none; b=NzAcaW8FBWcRX/1u7Xuxl9DNXYC/Xi60x6REaxOT8rfogDgGooJgMv5JjxKXYku9/AHJfrGSe3/C6DvKueWx03a5baoU2Me/gYhY+uBOIxbiRibqFEYnsmo3ZHgtGhpiEc9CiVcXTrz6qPAT1zKF8yuk9/NAE2XqXzYQ4ZiaeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715934724; c=relaxed/simple;
	bh=kjvazuQuqETl/IXyrw87rOgS4pHUVyCZxapnDbsW/Yw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9FSBgU5hCbkpHn0GgWEbHQBUMOXMTXpqfSS7ZF8UI2mPVew6IpxU5lW0FCz+qYe094sQ9jPo4umAA/Ks5m/0pAuBUBIGEQweIfgOTyjsLPd+3Do9mZfkwsmB7NKNl3lOe3bBxr5tv5T/NLnw/2TOND4shf7MfK7hkUbc7kxP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B+eXxu2V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nkn5CX03; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XBQquzRY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QiDVTAnD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E8495D166;
	Fri, 17 May 2024 08:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715934717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zqz0OaANQmSJJHh0zh/GpJL6XmrML7vZiZlKMlamf3k=;
	b=B+eXxu2VTlg7CqGvQY19Zexizks2tPlSY6gls8GISwnxnKlxwlzEamWzpc6XVOY99AR8Tk
	7aGdO2XZ1Tjylx1L921rlOJc/Nh6v1nDIDb2bZ5Qxq/53EizgQEbiO+AmPJY/VBge6WXt+
	jbFSQy9TefYfVfiNhkYJacpRpbV38TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715934717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zqz0OaANQmSJJHh0zh/GpJL6XmrML7vZiZlKMlamf3k=;
	b=nkn5CX03oz6G+afVGgEKkBfX+gIvRJZ6zLHVmsr/ggkleYVJuIgKG5lV/+CHi0i5Xb5ZHr
	QdTaN+9lh1BAgMBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XBQquzRY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QiDVTAnD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715934716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zqz0OaANQmSJJHh0zh/GpJL6XmrML7vZiZlKMlamf3k=;
	b=XBQquzRYQyjLj+ddYw4Z1m5dwFCvHbyagvrFkvF51vJXxVcbuqpBh1zqCNN5t+bi8TFV0k
	0O8/cGa+nUbYnDPYEDco/uNWlxU67y196ROiQM5fF60WynQUUxX4931g96uNCbKAECjFL8
	8a/eDwPnVCz7EdGIMd6y01EXM1GPuzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715934716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zqz0OaANQmSJJHh0zh/GpJL6XmrML7vZiZlKMlamf3k=;
	b=QiDVTAnDR0vH0cfCdqYWAh1jsVTXyLOCsIGsLiO5n5agLaiH0oa+hA9aWcXJHkyw+jD0B8
	UfeOSS/uRkLv41BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FCA113942;
	Fri, 17 May 2024 08:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X80zEvwVR2bLNQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 May 2024 08:31:56 +0000
Date: Fri, 17 May 2024 10:32:13 +0200
Message-ID: <8734qg260i.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: yskelg@gmail.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] line6: add midibuf init failure handling in line6_init_midi()
In-Reply-To: <20240516174737.415912-1-yskelg@gmail.com>
References: <20240516174737.415912-1-yskelg@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-2.62 / 50.00];
	BAYES_HAM(-2.61)[98.29%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,linuxfoundation.org,lists.linuxfoundation.org,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9E8495D166
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.62

On Thu, 16 May 2024 19:47:38 +0200,
yskelg@gmail.com wrote:
> 
> From: Yunseong Kim <yskelg@gmail.com>
> 
> This patch fixes potential memory allocation failures in the
> line6_midibuf_init(). If either midibuf_in, midibuf_out allocation
> line6_midibuf_init call failed, the allocated memory for line6midi
> might have been leaked.
> 
> This patch introduces an error handling label and uses goto to jump there
> in case of allocation failures. A kfree call is added to release any
> partially allocated memory before returning the error code.
> 
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>

The allocated object is already freed by snd_line6_midi_free() that is
called via rawmidi private_free at its destruction.  So your change
would lead to a double-free.


thanks,

Takashi

> ---
>  sound/usb/line6/midi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
> index 0838632c788e..abcf58f46673 100644
> --- a/sound/usb/line6/midi.c
> +++ b/sound/usb/line6/midi.c
> @@ -283,13 +283,18 @@ int line6_init_midi(struct usb_line6 *line6)
>  
>  	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
>  	if (err < 0)
> -		return err;
> +		goto error;
>  
>  	err = line6_midibuf_init(&line6midi->midibuf_out, MIDI_BUFFER_SIZE, 1);
>  	if (err < 0)
> -		return err;
> +		goto error;
>  
>  	line6->line6midi = line6midi;
>  	return 0;
> +
> +error:
> +	kfree(line6midi);
> +	return err;
> +
>  }
>  EXPORT_SYMBOL_GPL(line6_init_midi);
> -- 
> 2.34.1
> 

