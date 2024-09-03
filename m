Return-Path: <linux-kernel+bounces-313315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA8696A39A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9744282B30
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A555418952C;
	Tue,  3 Sep 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nTJakKbQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ha9mxalt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nTJakKbQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ha9mxalt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FFA7462;
	Tue,  3 Sep 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379573; cv=none; b=BQPGWco2/L6kSrtSPBbH+jT+1JEIVBR7CCpuyifnVaRUvrTTKXxDd9cIEYAiR/DBEMiLdyknJLtvwKUun6/HXpqfljnLoS8Rl6aTK4zpnTZl2IdtigR1NkxYDmq3EFskfte6whIHxK+ov0EOooIckEo0ezL44A0jnv5an0ifofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379573; c=relaxed/simple;
	bh=ms+XzDsR1UJ1O9Nuwh7PPwFY3G4HnjMYGY/l3z4DUbY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gv5w/LgCm+fIDfSofltAuW0kfIjbWuPQv6rq+zkeEcAPZsE+5RDI5svpH+Yzdgx4sMXol9PiPmi2KH17rKGhT7q8+G2KLJrc5VDazgGKUNxOMF3CKUMw23LrgwYgoyRRRJPp6Puau2N7FeMR3cf9azaA6MsFfNfXeamkWrypVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nTJakKbQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ha9mxalt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nTJakKbQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ha9mxalt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 297561F399;
	Tue,  3 Sep 2024 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725379569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwY9WzA/KSibfSO3LLCf56r8Ah7e9u6W6/Ky6mmwavk=;
	b=nTJakKbQO0ZZd79YUw3cYkdM8/cDgH0Q7+6kZdVHNjvwIiQXqJt2jMPttEjvaMFNweQ5wH
	uIIM34dN31jcRpJJATRbreTj0rTNWArCUwnDnHnxWu5O57VM+kTZB0mabBlMsqYda4PiP4
	DBd6Sb3wYiCutN7maC3kOQOgm/3OYo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725379569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwY9WzA/KSibfSO3LLCf56r8Ah7e9u6W6/Ky6mmwavk=;
	b=Ha9mxalt23gSdquqw0iynTex9kEX6Cx8Wdp35qH70/d7syJCm8M39tjX+t2VNQdxy3Wat0
	cX5dZ1jwgQqGs/BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nTJakKbQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ha9mxalt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725379569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwY9WzA/KSibfSO3LLCf56r8Ah7e9u6W6/Ky6mmwavk=;
	b=nTJakKbQO0ZZd79YUw3cYkdM8/cDgH0Q7+6kZdVHNjvwIiQXqJt2jMPttEjvaMFNweQ5wH
	uIIM34dN31jcRpJJATRbreTj0rTNWArCUwnDnHnxWu5O57VM+kTZB0mabBlMsqYda4PiP4
	DBd6Sb3wYiCutN7maC3kOQOgm/3OYo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725379569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwY9WzA/KSibfSO3LLCf56r8Ah7e9u6W6/Ky6mmwavk=;
	b=Ha9mxalt23gSdquqw0iynTex9kEX6Cx8Wdp35qH70/d7syJCm8M39tjX+t2VNQdxy3Wat0
	cX5dZ1jwgQqGs/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFD2313A52;
	Tue,  3 Sep 2024 16:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LYN3MfAz12aRegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 03 Sep 2024 16:06:08 +0000
Date: Tue, 03 Sep 2024 18:06:54 +0200
Message-ID: <87o754k9gh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Asahi Lina <lina@asahilina.net>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Mark Hills <mark@xwax.org>,
	Arun Raghavan <arun@arunraghavan.net>,
	Cyan Nyan <cyan.vtb@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ALSA: usb-audio: Add basic support for RME Digiface USB
In-Reply-To: <20240903-rme-digiface-v2-0-71b06c912e97@asahilina.net>
References: <20240903-rme-digiface-v2-0-71b06c912e97@asahilina.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 297561F399
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,b4.vu,sakamocchi.jp,xwax.org,arunraghavan.net,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 03 Sep 2024 12:52:28 +0200,
Asahi Lina wrote:
> 
> Hi everyone,
> 
> This series adds basic support for the RME Digiface USB interface. This
> is a 4x ADAT I/O interface with an extra headphones output and support
> for S/PDIF mode.
> 
> There are 3 streaming configurations:
> 
> - 32in/34out at 1x speed mode
> - 16in/18out at 2x speed mode
> - 8in/10out at 4x speed mode
> 
> The appropriate speed mode is automatically set based on the PCM rate,
> and this governs the available channel count.
> 
> The first commit adds basic init and streaming support. This is enough
> to use the interface in its default settings (ADAT outputs, internal
> sync) using the ALSA PCM.
> 
> The second commit adds basic mixer controls to set up the I/O features
> (output modes, sync source) and report I/O status.
> 
> This series does not implement the output faders, matrix mixer, or input
> level meters. These features are more useful when the interface is used
> as a router (possibly stand-alone), and are not really something that
> can be exposed via ALSA mixer controls usable via something like
> alsamixer (the matrix mixer has up to 2048 possible mixer nodes). Since
> we expect users to use a dedicated control app, the intent is that the
> app directly controls these features via the libusb API. This is similar
> to how things work with some FireWire interfaces (ffado-mixer) today.
> 
> Of course, there is room for extending the mixer interface to add more
> controls in the future, once we settle on a mechanism to expose
> complex/large matrix mixers.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
> Changes in v2:
> - Fix BIT(32) that was intended to be BIT(31) (for 32-bit platforms)
> - Rebased on sound/for-next and rewrote quirk using macros
> - Removed USB_ENDPOINT_USAGE_IMPLICIT_FB since the sync info is explicitly
>   specified.
> - Link to v1: https://lore.kernel.org/r/20240902-rme-digiface-v1-0-6e88472a2744@asahilina.net
> 
> ---
> Asahi Lina (1):
>       ALSA: usb-audio: Add mixer quirk for RME Digiface USB
> 
> Cyan Nyan (1):
>       ALSA: usb-audio: Add quirk for RME Digiface USB

Applied to for-next branch now.


thanks,

Takashi

