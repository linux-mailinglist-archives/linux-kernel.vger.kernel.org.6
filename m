Return-Path: <linux-kernel+bounces-290768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D87C955860
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B9A1C21290
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B6D528;
	Sat, 17 Aug 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HJ4KGbcm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s9nfMM8r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HJ4KGbcm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s9nfMM8r"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E1D2FB;
	Sat, 17 Aug 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905191; cv=none; b=Kt2oX0rOHz04zWBlGvHaTrITpQFaCUJWsnO567HMa9jkKqijiLoQ/maAKMQbkHYdYEpfT9unIl4QrrgfkaY7FeW+DtGvpD8kiVRhxSQ1g4qBZNwgickGfBzGLopWvS0YL3Qn6OvPhW0Ro+Jx9vNH1Z+TYL5zjWALUfHRVZW6iNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905191; c=relaxed/simple;
	bh=P7XAFbV0SN4dW8j8/XnNvX/OfIOzKTU6tgUHMI2Wjbs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCUID+2RZ6J+nVJIe+rMwAld64uIj54flJ9le1mWSYT2UQ//DNa8MZs9x2k9aGELNdzhTUAdVrkDUiRt4VkPK+WOPoWBCB2vx/rEGoXpFtvhYkHuv9sO0LjuTUMno/OpisQbprmAxnQvob2saIwhajBM583BxfWIuPxpd5xZ+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HJ4KGbcm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s9nfMM8r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HJ4KGbcm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s9nfMM8r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E2B222525;
	Sat, 17 Aug 2024 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723905187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCQbpS+QIXCwwA3tC4YutAsPWszxrwZWJszs+8DMaWM=;
	b=HJ4KGbcm1Iv+epxJSakKG6dnCz74qKS3BYo5/bA6oA4ik0S+FQbfbPP5fszVH2cUeTA9q1
	JVyEtQRsuOde1D8TaeJfCUhPW9DIRq67ahEMAu+DPPF4yqB4PB74GszKz7lJY22jUYy16T
	pYfYOpk4LA8Tnk/N8YiSX+dpwGRCqjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723905187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCQbpS+QIXCwwA3tC4YutAsPWszxrwZWJszs+8DMaWM=;
	b=s9nfMM8rcywurNYVJ+2/hHno2WUra3qR8cxpZhsuQddOeY/z0oxvhPeDRk4d/XrXaU13EV
	9AUi2DXhD540ebAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HJ4KGbcm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s9nfMM8r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723905187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCQbpS+QIXCwwA3tC4YutAsPWszxrwZWJszs+8DMaWM=;
	b=HJ4KGbcm1Iv+epxJSakKG6dnCz74qKS3BYo5/bA6oA4ik0S+FQbfbPP5fszVH2cUeTA9q1
	JVyEtQRsuOde1D8TaeJfCUhPW9DIRq67ahEMAu+DPPF4yqB4PB74GszKz7lJY22jUYy16T
	pYfYOpk4LA8Tnk/N8YiSX+dpwGRCqjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723905187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCQbpS+QIXCwwA3tC4YutAsPWszxrwZWJszs+8DMaWM=;
	b=s9nfMM8rcywurNYVJ+2/hHno2WUra3qR8cxpZhsuQddOeY/z0oxvhPeDRk4d/XrXaU13EV
	9AUi2DXhD540ebAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DFBD1397F;
	Sat, 17 Aug 2024 14:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r2jYFKO0wGakWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 17 Aug 2024 14:33:07 +0000
Date: Sat, 17 Aug 2024 16:33:48 +0200
Message-ID: <87mslb1ann.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<arnd@arndb.de>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ALSA: seq: Remove unused declarations
In-Reply-To: <20240817093334.1120002-1-yuehaibing@huawei.com>
References: <20240817093334.1120002-1-yuehaibing@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9E2B222525
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Sat, 17 Aug 2024 11:33:34 +0200,
Yue Haibing wrote:
> 
> These functions are never implemented and used.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Applied, thanks.


Takashi

