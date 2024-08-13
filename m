Return-Path: <linux-kernel+bounces-284189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDA694FE23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980F51F21952
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA3433CB;
	Tue, 13 Aug 2024 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tf49YoSR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SSLwWqpD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tf49YoSR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SSLwWqpD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B793BBFB;
	Tue, 13 Aug 2024 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532198; cv=none; b=pfVD2JD0bwCXpZ+K9J4Im77nBlAtK4gVh7zuVT9D7WT/Eo9d8TwIlQUNlw5FuZYyO8bfmqS7f5YwV8hFyWXIXXwMwXGXmnjL+pSJdkezpW2UkyYwd7mTDSO17o2v9SuD0PJJRzsamjVuM+tOsJF5m1oUJ4WRoErYuRwix/WJezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532198; c=relaxed/simple;
	bh=GzDmjyA9qpOP6bZ2PN7E9sKqCfDgQQFEumgOmZVth+Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnC0uBPbnxnPzAWKW8DLNpPu9qiCI14mvnjk215ZsL89dgI3UgZM9UOkPA7rAkjUQCmms4pOYXH8BeuwY6CpHWmS7j0UEQTBCFmyeTMrPbnuLu53f6bIYFAM7jjICp6xJ8oO6gGvBd15upI09CuIqX4dP1cjN+zp+NwFvGQukx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tf49YoSR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SSLwWqpD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tf49YoSR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SSLwWqpD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AF452035C;
	Tue, 13 Aug 2024 06:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723532189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIBGOgywqiviTEt8cyJqNNk8OTWsWTYZ7dP6GFBF1j4=;
	b=Tf49YoSREe+1dCLPiDqBmRLzPEAoBVDRvaI13X2ZbzKexcrHtCFSpqvmWSumfJDnrnjHZH
	WnI6edqy7avJes1Zt3Km/s06azDkPaWYG+fiuBAugxSeQb7lwESFx6LeGVj4IfqQIdHffx
	F3KvnhM/nIukmZCIVqI2DzoGJNg5aCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723532189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIBGOgywqiviTEt8cyJqNNk8OTWsWTYZ7dP6GFBF1j4=;
	b=SSLwWqpD93JGOzcOBVHzXbv63D2n85glqKz4J0f5yXYYZlw8bndP555ryDmuJ/uB3YFo4G
	gX2m60/MT9z2USAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Tf49YoSR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SSLwWqpD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723532189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIBGOgywqiviTEt8cyJqNNk8OTWsWTYZ7dP6GFBF1j4=;
	b=Tf49YoSREe+1dCLPiDqBmRLzPEAoBVDRvaI13X2ZbzKexcrHtCFSpqvmWSumfJDnrnjHZH
	WnI6edqy7avJes1Zt3Km/s06azDkPaWYG+fiuBAugxSeQb7lwESFx6LeGVj4IfqQIdHffx
	F3KvnhM/nIukmZCIVqI2DzoGJNg5aCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723532189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIBGOgywqiviTEt8cyJqNNk8OTWsWTYZ7dP6GFBF1j4=;
	b=SSLwWqpD93JGOzcOBVHzXbv63D2n85glqKz4J0f5yXYYZlw8bndP555ryDmuJ/uB3YFo4G
	gX2m60/MT9z2USAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 159DC13983;
	Tue, 13 Aug 2024 06:56:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VRYABJ0Du2ZUGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 06:56:29 +0000
Date: Tue, 13 Aug 2024 08:57:09 +0200
Message-ID: <87cymcdi62.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Juan =?ISO-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [PATCH 2/2] ALSA: usb-audio: reduce checkpatch issues in quirks-table.h
In-Reply-To: <6dabfd5c05c04b0e4fc00a708cc65d691af4e267.1723518816.git.soyjuanarbol@gmail.com>
References: <cover.1723518816.git.soyjuanarbol@gmail.com>
	<6dabfd5c05c04b0e4fc00a708cc65d691af4e267.1723518816.git.soyjuanarbol@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 4AF452035C
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 13 Aug 2024 05:31:28 +0200,
Juan José Arboleda wrote:
> 
> Reduced checkpatch errors from 185 to 2, and warnings from 4 to 1 in
> sound/usb/quirks-table.h.
> 
> Remaining issues were reviewed and considered non-blocking.
> 
> Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>

Honestly speaking, I don't find it's much improvement from the code
readability POV.  (And you don't have to "correct" the spaces in
comment lines :)

That is, if the reason of the changes is only about the complaint from
checkpatch, we can simply ignore it.  Above all, applying space-only
fixes would make the stable backports more difficult.

OTOH, if we really want to improve the code readability, maybe it'd be
better to introduce some macros to simplify the definitions.  e.g.

/* Quirk driver_info, use like QUIRK_DRIVER_INFO { ... } */
#define QUIRK_DRIVER_INFO \
	.driver_info = (unsigned long)&(const struct snd_usb_audio_quirk)

/* Quirk data entry for struct audioformat */
#define QUIRK_DATA_AUDIOFORMAT \
	.data = &(const struct audioformat)
/* Quirk data entry for struct snd_usb_midiendpoint_info */
#define QUIRK_DATA_MIDI_EP_INFO \
	.data = &(const struct snd_usb_midi_endpoint_info)

and replace accordingly.

But again, I'm not sure whether it's worth.  Macros might be good from
the code safety as the open code is error prone, though.


thanks,

Takashi

