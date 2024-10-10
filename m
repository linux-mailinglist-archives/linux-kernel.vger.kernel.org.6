Return-Path: <linux-kernel+bounces-359221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CF9988DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FC11F25C99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B346B1CB329;
	Thu, 10 Oct 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XDpQ7bY6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hMEK6aEU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XDpQ7bY6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hMEK6aEU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4861CB322;
	Thu, 10 Oct 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569476; cv=none; b=eglma0j/Tpt4a6XizfI7jbDuZuzBiZ8uZ1oZcOJhG5JzLjPtyWTjMLujJZwRf3a6FM4daN6yEfsHoZYVWP/DdU+NWoEGJzsrThBKjzi7NKI/VVe925thESQKJl17Y8/ByuidpkJPGAJ22HlxPQsKNP9B4AnanupT59OlpNGgvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569476; c=relaxed/simple;
	bh=1yylciXsLYYSioPLf48P+RnSSIHazRBTvgOQ20rKQXQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otq5SCZiGbuVhGfsQZtHTu77dWpZB8vDnsXmWhpE4uf08WNW9KzU0p5viEgpSv9X50k/lEEY2nqPaz25PpX0RUYIe+9nRhH+Jd7VJU1tuzY2PHQeCDucef3G/MrQkZ8TV/1HDMIw5Jb4N2RvdtA9iYZ1OuIFPyx1kSqVBj9AZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XDpQ7bY6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hMEK6aEU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XDpQ7bY6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hMEK6aEU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C57B21FAC;
	Thu, 10 Oct 2024 14:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728569472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKGWuHnoAY3oScw9gPPFvX+fuzsUbv/zXNsP6f00WS4=;
	b=XDpQ7bY6n45UwZvFtC9+TAMeJJEJg0xBBFXi786tPXIf2UfKs6lkxJ9mDg81Uh6aDSgWNl
	Voy2NVfzlgyD1t8uLQzzL8ORIRhI0gehVZVYT03LUBQLA6z/F9nbvl0XGCmawrtNFxRC94
	Ee93UbfKwyx4kuPzxArVDD7t4nTgB1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728569472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKGWuHnoAY3oScw9gPPFvX+fuzsUbv/zXNsP6f00WS4=;
	b=hMEK6aEUuGS0jJYIfjWNeTBYPI1dK/HNX3omGOoLAy6Z7Gdahi08qr0s+QV8FoUbBjxNCm
	PGGjMRULOalcDSBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728569472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKGWuHnoAY3oScw9gPPFvX+fuzsUbv/zXNsP6f00WS4=;
	b=XDpQ7bY6n45UwZvFtC9+TAMeJJEJg0xBBFXi786tPXIf2UfKs6lkxJ9mDg81Uh6aDSgWNl
	Voy2NVfzlgyD1t8uLQzzL8ORIRhI0gehVZVYT03LUBQLA6z/F9nbvl0XGCmawrtNFxRC94
	Ee93UbfKwyx4kuPzxArVDD7t4nTgB1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728569472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKGWuHnoAY3oScw9gPPFvX+fuzsUbv/zXNsP6f00WS4=;
	b=hMEK6aEUuGS0jJYIfjWNeTBYPI1dK/HNX3omGOoLAy6Z7Gdahi08qr0s+QV8FoUbBjxNCm
	PGGjMRULOalcDSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0B1D1370C;
	Thu, 10 Oct 2024 14:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0KyvNX/gB2duYgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Oct 2024 14:11:11 +0000
Date: Thu, 10 Oct 2024 16:12:08 +0200
Message-ID: <877cag11zb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Yann Sionneau
 <ysionneau@kalrayinc.com>
Subject: Re: [PATCH] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
In-Reply-To: <20241010124601.700528-1-jvetter@kalrayinc.com>
References: <20241010124601.700528-1-jvetter@kalrayinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 10 Oct 2024 14:46:01 +0200,
Julian Vetter wrote:
> 
> When building for the UM arch and neither INDIRECT_IOMEM=y, nor
> HAS_IOMEM=y is selected, it will fall back to the implementations from
> asm-generic/io.h for IO memcpy. But these fall-back functions just do a
> memcpy. So, instead of depending on UML, add dependency on 'HAS_IOMEM ||
> INDIRECT_IOMEM'.
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>

This is expected to be applied via sound.git tree?
Then I'll happily take it.


thanks,

Takashi

> ---
>  sound/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/Kconfig b/sound/Kconfig
> index 4c036a9a420a..8b40205394fe 100644
> --- a/sound/Kconfig
> +++ b/sound/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig SOUND
>  	tristate "Sound card support"
> -	depends on HAS_IOMEM || UML
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	help
>  	  If you have a sound card in your computer, i.e. if it can say more
>  	  than an occasional beep, say Y.
> -- 
> 2.34.1
> 
> 
> 
> 
> 

