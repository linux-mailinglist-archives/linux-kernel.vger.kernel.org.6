Return-Path: <linux-kernel+bounces-354764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C255599424D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760F11F2709F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EF81F893B;
	Tue,  8 Oct 2024 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wjXRt0fM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9qM4j6xj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wjXRt0fM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9qM4j6xj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D431F8938;
	Tue,  8 Oct 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375261; cv=none; b=fGAdLe7BfWjVDBWy1FZm3Ib2L4vS7vixkbldsJvrfpigV4EUX0xje6LWOezO5nTcR2609VfaQnVHa2Bqsr8XA9tkeMMgvF1Xte3AMRIP7Ln8dvk5L0Y6Fr0MP1aI0Y5rlsFjBcGj/xqQM9IfscLKzf4MOYWfC1mUmccrZidotdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375261; c=relaxed/simple;
	bh=L/QmjdwYXtD7qhDvIh8zwDFlEO+1SN0K1JB9/r5PQOY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/9EPGoF8QMv2pyslhZtqjL7ZVqS+R4PA+1NWrHi1iGPqzMgV15JFf//q7hF5U6xxHFMxehC9X+M7uA+0AW8NPVh8EhVdoOM0x9fMy/w8P18iaS4zuNp1r1VuqEhIBk3WELUIS6omFn+A7Q8nUW/gl7S93wxXdsaclNDIAnHVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wjXRt0fM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9qM4j6xj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wjXRt0fM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9qM4j6xj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 369E81F8D7;
	Tue,  8 Oct 2024 08:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728375257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNgQOVSJba/SG7VP6HnAsJdis+x4ecxVxnMn4uwlezI=;
	b=wjXRt0fME5y8X1KBPeylfpaOFAdx2vxDtgNK5w2iBxlJPhOvdKLc6kuHl36rQ7PEWanrd+
	UoPQLFYc+EWmtNVVmNfNY7RwGjOffqhekRCo0e6nD6G2cMmmYWBPXxdKRwMpubLUYtmtGV
	7eeYcyhmjyFRNdhB7MaSNA6mriAdqRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728375257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNgQOVSJba/SG7VP6HnAsJdis+x4ecxVxnMn4uwlezI=;
	b=9qM4j6xjHmkYH/xkF5PcK/CLqjOrkK6IF0Y0Rs/6hxALAO+Il4P2HxLfRTHoXHQki8nW2w
	Yqc9PaDuNHynLrAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728375257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNgQOVSJba/SG7VP6HnAsJdis+x4ecxVxnMn4uwlezI=;
	b=wjXRt0fME5y8X1KBPeylfpaOFAdx2vxDtgNK5w2iBxlJPhOvdKLc6kuHl36rQ7PEWanrd+
	UoPQLFYc+EWmtNVVmNfNY7RwGjOffqhekRCo0e6nD6G2cMmmYWBPXxdKRwMpubLUYtmtGV
	7eeYcyhmjyFRNdhB7MaSNA6mriAdqRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728375257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNgQOVSJba/SG7VP6HnAsJdis+x4ecxVxnMn4uwlezI=;
	b=9qM4j6xjHmkYH/xkF5PcK/CLqjOrkK6IF0Y0Rs/6hxALAO+Il4P2HxLfRTHoXHQki8nW2w
	Yqc9PaDuNHynLrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DA951340C;
	Tue,  8 Oct 2024 08:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id onskAtnpBGfbHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 08 Oct 2024 08:14:17 +0000
Date: Tue, 08 Oct 2024 10:15:12 +0200
Message-ID: <87jzejvwmn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] Sound:vx_uer:Delete extra blank lines
In-Reply-To: <20241008014806.7573-1-zhujun2@cmss.chinamobile.com>
References: <20241008014806.7573-1-zhujun2@cmss.chinamobile.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,chinamobile.com:email]
X-Spam-Score: -3.29
X-Spam-Flag: NO

On Tue, 08 Oct 2024 03:48:06 +0200,
Zhu Jun wrote:
> 
> Delete extra blank lines inside in vx_uer.c
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

I won't take space-fix only change unless it's together with other
real fixes.  So skip this for now.


thanks,

Takashi

