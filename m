Return-Path: <linux-kernel+bounces-275767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F12F948993
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B7CB21DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7D1BC9F4;
	Tue,  6 Aug 2024 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PQO5OEqT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tadESHvh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M3+Mb4/7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JmobEoqX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F279A94A;
	Tue,  6 Aug 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926780; cv=none; b=DWudMasdNsDST/vRzE+K23l52NIMjP3FNx558sNjcgjQXpeff6NTw2rTjOgFG/AHkC3b1VylvuKG8EP0EPC/gBcPEuikpKYW3xJhZ1YzgyY01HqyddYhaFkwnMENCNjOfbBfkH2gptQ17Kd/hmUVYbZLdjYEYiEqMk1/hBZARlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926780; c=relaxed/simple;
	bh=zAUroZkbYUiYkj1fZojDj+I5ZFvwK8DYp1Fs6p2xXFk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeuU1T3p3r9FIiLFom/j/eZ2z/sQm2ELlI/nCxZNAbpuDoPrlV3ej1vBS5sEJJT7cb1uhVAMa8dNCMR3whG4ykmp9XdhgTWiyKqi89trU2IyikSZHeotQ0M7Ph6V0lzqDxwdK9HNfwEH0lUiS3T3tEzhXJa6nKHnQ04uU8XwVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PQO5OEqT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tadESHvh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M3+Mb4/7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JmobEoqX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E822B1F7D4;
	Tue,  6 Aug 2024 06:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722926770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHfmuv8sXX+oH8BW97sEQ6nsuTkEviC0eHXDTTuvsA8=;
	b=PQO5OEqT8yssN2LkM1UACpmej5WvXD47DDzCk4WFUcUZM3an8D6cfy6kkqPXXZhfblx8+C
	2foIRc0C4th/b4gNfO3fJ/3ibZlp8gsH7iOmweRTewbIPtlpZ7QaOhRUv37cGK6M3bFm8P
	ajPTc4QLjujSSVTBYXQPEIX+VJvzg1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722926770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHfmuv8sXX+oH8BW97sEQ6nsuTkEviC0eHXDTTuvsA8=;
	b=tadESHvhlrijUJwBa3j/WL7Rh9Kb+5V1LaEvHaS/QdzQkqxN4PabDI+dIsGuXQVnGnxgyg
	Zw97XPFoq6BrwxBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="M3+Mb4/7";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JmobEoqX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722926768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHfmuv8sXX+oH8BW97sEQ6nsuTkEviC0eHXDTTuvsA8=;
	b=M3+Mb4/7ouoUxeGC0GY93x6zbm+ABfvlOHkRcu8WQylCJQkGZdlgQB7nZza8KD8mSUtNU0
	BCg9cXvEYVTwZXtY8a29c0vBi5/HI9OSsagGKqJlGmFyET/1dRE9uppwxZ7OBkay0BTqIH
	WoGNpA5+WxpZTkKkI5zTAkXhbDUg9bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722926768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHfmuv8sXX+oH8BW97sEQ6nsuTkEviC0eHXDTTuvsA8=;
	b=JmobEoqXJzTIgTJed1UAz49wnvPzakRuWaI4Q+Gw2E5VaouY+hiNs30dxmaSiRUdVVcEAO
	1HL6qgDQf6j7tKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B900B13770;
	Tue,  6 Aug 2024 06:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tF1sK7DGsWbiTgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 06 Aug 2024 06:46:08 +0000
Date: Tue, 06 Aug 2024 08:46:46 +0200
Message-ID: <87y15ai1wp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Steven 'Steve' Kendall <skend@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda: Add HP MP9 G4 Retail System AMS to force connect list
In-Reply-To: <20240806-hdmi-audio-hp-wrongpins-v2-1-d9eb4ad41043@chromium.org>
References: <20240806-hdmi-audio-hp-wrongpins-v2-1-d9eb4ad41043@chromium.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E822B1F7D4
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, 06 Aug 2024 02:08:24 +0200,
Steven 'Steve' Kendall wrote:
> 
> In recent HP UEFI firmware (likely v2.15 and above, tested on 2.27),
> these pins are incorrectly set for HDMI/DP audio. Tested on
> HP MP9 G4 Retail System AMS. Tested audio with two monitors connected
> via DisplayPort.
> 
> Link: https://forum.manjaro.org/t/intel-cannon-lake-pch-cavs-conexant-cx20632-no-sound-at-hdmi-or-displayport/133494
> Link: https://bbs.archlinux.org/viewtopic.php?id=270523
> Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
> ---
> Changes in v2:
> - Now instead adds value to force connect list as suggested in review.
> - I tested these changes with two monitors via DP, results identical to v1.
> - Link to v1: https://lore.kernel.org/r/20240802-hdmi-audio-hp-wrongpins-v1-1-8d8ba10d77f8@chromium.org

Thanks, applied now.


Takashi

