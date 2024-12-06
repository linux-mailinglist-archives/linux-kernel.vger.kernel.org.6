Return-Path: <linux-kernel+bounces-435036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C2A9E6EB0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D501883E93
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370E4202F7E;
	Fri,  6 Dec 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7HF1KNr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tiYtZTAf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7HF1KNr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tiYtZTAf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124AE1F6681;
	Fri,  6 Dec 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489776; cv=none; b=KCLdHoYQXf8XvGoSn6F5Oqhp/d/l32d8G426PKtuO301HKFSjTYloouMIbovcxLdHbbs6r6fDcxU5/+f5Yqkkv7AUatVVX3ZIsL9Ev/RcGOyXskYwEQAsakBZeiQKp2pdIizkijRmPbB+0IQxDAl4+DEUAe6rRiD5fDDryDkysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489776; c=relaxed/simple;
	bh=72LUJxgs/+MQeIJms0MDfuMiTHLYe1I/ue8PkNgEZT8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NukQ/I8AdjbowfOoz1TCobdo0y5dxQWYS6/VBULLyxgwl5Xu7SsYOBrIGzkfRDzC0E9zxlgYPrn6mpvVPAKkJS7vVy9K6TQ2+EXvxpFnFxFi1jruFXgRSqucaToQlPgVN3moYIIRrmLFW330iTfrHms590MQFUYpIU6OHcSThbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7HF1KNr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tiYtZTAf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7HF1KNr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tiYtZTAf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E40F2115B;
	Fri,  6 Dec 2024 12:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTwBQJA6d0xkJH+z2GGckQIl4ehOOnUecm/iCaf5Z0M=;
	b=k7HF1KNrnQVBBgMSztwTQmGdPFIaVw6pix4wIZGKtZBpiX5UrUBPjw7WovQ4vz44F/eI9M
	cNhqG84wy+NMId+O10lJQu8YwjkTAUNPu4oIXOMWnU3I3HG13EnCURUOx2pZErTljITmli
	kYxQa0RPWrU5FoQshifKaexQJ8pGegs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTwBQJA6d0xkJH+z2GGckQIl4ehOOnUecm/iCaf5Z0M=;
	b=tiYtZTAfowQpMectUy2EVhMVFNFpCNm4pKMAtBIHuwhFofuZJ7Yaj+XUDZnAkdOK34MgDP
	gohg7eOzulSyZYAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTwBQJA6d0xkJH+z2GGckQIl4ehOOnUecm/iCaf5Z0M=;
	b=k7HF1KNrnQVBBgMSztwTQmGdPFIaVw6pix4wIZGKtZBpiX5UrUBPjw7WovQ4vz44F/eI9M
	cNhqG84wy+NMId+O10lJQu8YwjkTAUNPu4oIXOMWnU3I3HG13EnCURUOx2pZErTljITmli
	kYxQa0RPWrU5FoQshifKaexQJ8pGegs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTwBQJA6d0xkJH+z2GGckQIl4ehOOnUecm/iCaf5Z0M=;
	b=tiYtZTAfowQpMectUy2EVhMVFNFpCNm4pKMAtBIHuwhFofuZJ7Yaj+XUDZnAkdOK34MgDP
	gohg7eOzulSyZYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1018013647;
	Fri,  6 Dec 2024 12:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cfLPAWz0UmeoTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Dec 2024 12:56:12 +0000
Date: Fri, 06 Dec 2024 13:56:11 +0100
Message-ID: <87ldwtrmvo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Remove calls to cs35l56_force_sync_asp1_registers_from_cache()
In-Reply-To: <20241206105757.718750-1-rf@opensource.cirrus.com>
References: <20241206105757.718750-1-rf@opensource.cirrus.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 06 Dec 2024 11:57:57 +0100,
Richard Fitzgerald wrote:
> 
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> Commit 5d7e328e20b3 ("ASoC: cs35l56: Revert support for dual-ownership
> of ASP registers")
> replaced cs35l56_force_sync_asp1_registers_from_cache() with a dummy
> implementation so that the HDA driver would continue to build.
> 
> Remove the calls from HDA and remove the stub function.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thanks, applied now.


Takashi

