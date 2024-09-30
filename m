Return-Path: <linux-kernel+bounces-343507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E9989BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0C2B210FB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B44616F282;
	Mon, 30 Sep 2024 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rug9c+30";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kY0G684a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rug9c+30";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kY0G684a"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF8158DB1;
	Mon, 30 Sep 2024 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682441; cv=none; b=SanSTMEd7kEZ+ds2Us0MtKSLn0sh/g7he/TgXVmoFdbJk4gKb+E2Yy8taNOdx0M/eAOm/tIrpEG2Z/D+j3B6/nzPkWpurmUEADB3l31a/Sy7h5ge2VBGWyK2BVb4UIxZwO1aeHX+vWxTVuvBUV8XO6rkceSzlsiaXtJf94xQ+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682441; c=relaxed/simple;
	bh=cm8kDeM123/J6mQbskB5lmeq5cU9YZetNPy2B5Cpqkc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEUXJS01Mj5+kzqCFJfYZcEqFc8Zzl/bJDMzoRheCkxobmd26Oa3RN1GvDYb9VZ0cSfdoWNZg360EKCQNkiRT6TM3SxlsXPdArp3X/MFGUKwS55MUn9HB3GhV264GJolmGm66GhTIOwccNCICLj96Cd+Mv6tazcneRAdF24ZKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rug9c+30; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kY0G684a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rug9c+30; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kY0G684a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A4191F7F0;
	Mon, 30 Sep 2024 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727682438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFO5n9LL1sBEWGz7J+mlj3k+Yl5s25FHR3JSaS0rrJY=;
	b=rug9c+303WKp4rP28mc7w+Qe007g28boCGAzSWoS72oXGhV4ZDGMXuHJYVS21S0Mwlbzxi
	grcNY8cfpqLZBCprckSH4m41mrFXpf4+SYSH7R8RuGEssQ7+fo2/1hBJnp8SbcNbfMArG+
	Tp397XUIN2A/n0H2/UBiaBE3k05tGB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727682438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFO5n9LL1sBEWGz7J+mlj3k+Yl5s25FHR3JSaS0rrJY=;
	b=kY0G684aZei4ewQTWWAsR154hzTsPvNHotaCiEhB6iViRWvZWMfWqWLGuwQywBuvtsehMr
	DFBae0/1Rh+PIjBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727682438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFO5n9LL1sBEWGz7J+mlj3k+Yl5s25FHR3JSaS0rrJY=;
	b=rug9c+303WKp4rP28mc7w+Qe007g28boCGAzSWoS72oXGhV4ZDGMXuHJYVS21S0Mwlbzxi
	grcNY8cfpqLZBCprckSH4m41mrFXpf4+SYSH7R8RuGEssQ7+fo2/1hBJnp8SbcNbfMArG+
	Tp397XUIN2A/n0H2/UBiaBE3k05tGB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727682438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFO5n9LL1sBEWGz7J+mlj3k+Yl5s25FHR3JSaS0rrJY=;
	b=kY0G684aZei4ewQTWWAsR154hzTsPvNHotaCiEhB6iViRWvZWMfWqWLGuwQywBuvtsehMr
	DFBae0/1Rh+PIjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5954413A8B;
	Mon, 30 Sep 2024 07:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iFKxFIZX+mbEDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 07:47:18 +0000
Date: Mon, 30 Sep 2024 09:48:11 +0200
Message-ID: <87ikudk2f8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Abdul Rahim <abdul.rahim@myyahoo.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: alsa: check if user has alsa installed
In-Reply-To: <20240922225824.18918-1-abdul.rahim@myyahoo.com>
References: <20240922225824.18918-1-abdul.rahim.ref@myyahoo.com>
	<20240922225824.18918-1-abdul.rahim@myyahoo.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 23 Sep 2024 00:58:18 +0200,
Abdul Rahim wrote:
> 
> Currently, if alsa development package is not installed on the user's
> system then the make command would print a `pagefull` of errors. In
> particular one error message is repeated 3 times. This error is returned
> by `pkg-config` and since it is not being handeled appropriately,
> repeated calls to `pkg-config` prints the same message again.
> 
> This patch adds check for alsa package installation. If alsa is not
> installed, a short and consize error is returned. Also, it does not
> affect the compilation of other tests.
> 
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>

Sorry for the late reply, as I've been off in the last weeks.

Now applied to for-linus branch.  Thanks.


Takashi

