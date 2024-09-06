Return-Path: <linux-kernel+bounces-318641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A796F12D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73968B21AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FCF1C9EC4;
	Fri,  6 Sep 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CeYQsswE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pjuD68FU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1j06WJdQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8UW/w7hR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9C1C9EC3;
	Fri,  6 Sep 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617947; cv=none; b=qrBe/2PsxURATjt67B+KD0uRnk6OaEz7uryGq8SWlIxUHz77n7zOG8lSZh1zpVfVpBRLE/RyyP1/1tAJL1CJTp+LQ5IxOPAQx/YfaprmOOyYeXadDGAaB85jkc5027HdKnWgpEweWolDv5HOu4DKg/NSHDWZwMpfmCbR70ILVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617947; c=relaxed/simple;
	bh=vm88TeckKEfRVOI1RrBAU85WzovMARX7iYP0ox+MMSc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjmppBaidaZ7GLgMMkXl8+WwVLBJderJZz83ofMul0rBJBToYpw+ZbRA76x4CRJUJ41McwqajcA76ZK+zv2i/+7nK4Jvxr5TBxRGXnhhvXa/g+SlKgTkb2kSd8aKzZPXQEXBAh4CcgnrbyJziEMb6gp/yJEyT+c2tob1ZkHUNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CeYQsswE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pjuD68FU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1j06WJdQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8UW/w7hR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B543A1F8AE;
	Fri,  6 Sep 2024 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725617944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeK2Vaq3tXX7jBGNJaN+KI2gYQ+03eKMGI7GkuMZBlU=;
	b=CeYQsswEVXQ6mpP342+y+chhpegQN6iDio/aBYD5PHcOgj5ReyrOeMmE1HXmAEHk+8+ojP
	1bKqAxh62s1K6hyc71ZKmBrBEYhi1BwlHCo3xf4r2AKKWZjCBXvd4IcNSftj+6IHf9ygqe
	zYo12iLIaOjjT2IqXOlrYuBjYxiuT3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725617944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeK2Vaq3tXX7jBGNJaN+KI2gYQ+03eKMGI7GkuMZBlU=;
	b=pjuD68FUtpRrKK906lLrLS3dI7LDuxkVmcx2Zi8pff8klWcOpTZJpT0fEvLPlaECSiVtPz
	iLWfHNW/JfoiamAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1j06WJdQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8UW/w7hR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725617942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeK2Vaq3tXX7jBGNJaN+KI2gYQ+03eKMGI7GkuMZBlU=;
	b=1j06WJdQgSRkoGbJWPjDsqiAVfa77sXPooTcvqMeqx5uH5QMXezteTDVtzOD3y+US8txbR
	TGXm97yIBE0fViJvJMQQXvDrt0jBwdjGI5SJyAue6XChjipCSpSZSSyWpFUdHjoGdRYG86
	UTydMeeGWEtLROHz5aO1wRP89dhFcBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725617942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeK2Vaq3tXX7jBGNJaN+KI2gYQ+03eKMGI7GkuMZBlU=;
	b=8UW/w7hRgaEueGBS9xozr0KYP76QyriNUR1uBrcIlknI6+b23L5lnr+xbKryZY9wYz5Hzg
	y8GAOTr0Jt+aF8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78A5E136A8;
	Fri,  6 Sep 2024 10:19:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pzr2GxbX2mYZaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Sep 2024 10:19:02 +0000
Date: Fri, 06 Sep 2024 12:19:48 +0200
Message-ID: <87y145dqyj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: zenghongling <zenghongling@kylinos.cn>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	zhongling0719@126.com
Subject: Re: [PATCH] ALSA: hda/cs8409: Support new Dell Dolphin for device
In-Reply-To: <20240906092703.1303605-1-zenghongling@kylinos.cn>
References: <20240906092703.1303605-1-zenghongling@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: B543A1F8AE
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,perex.cz,suse.com,126.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.51
X-Spam-Flag: NO

On Fri, 06 Sep 2024 11:27:03 +0200,
zenghongling wrote:
> 
> Add 1 new Dell Dolphin Systems, same configuration as older systems.
> 
> Signed-off-by: zenghongling <zenghongling@kylinos.cn>
> ---
>  sound/pci/hda/patch_cs8409-tables.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
> index 36b411d1..bc14b18 100644
> --- a/sound/pci/hda/patch_cs8409-tables.c
> +++ b/sound/pci/hda/patch_cs8409-tables.c
> @@ -546,6 +546,7 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1028, 0x0BD6, "Dolphin", CS8409_DOLPHIN),
>  	SND_PCI_QUIRK(0x1028, 0x0BD7, "Dolphin", CS8409_DOLPHIN),
>  	SND_PCI_QUIRK(0x1028, 0x0BD8, "Dolphin", CS8409_DOLPHIN),
> +	SND_PCI_QUIRK(0x1028, 0x0BAA, "Dolphin", CS8409_DOLPHIN),
>  	SND_PCI_QUIRK(0x1028, 0x0C43, "Dolphin", CS8409_DOLPHIN),
>  	SND_PCI_QUIRK(0x1028, 0x0C50, "Dolphin", CS8409_DOLPHIN),
>  	SND_PCI_QUIRK(0x1028, 0x0C51, "Dolphin", CS8409_DOLPHIN),

It's sorted in PCI SSID order.  Please put at the right place.


thanks,

Takashi

