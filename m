Return-Path: <linux-kernel+bounces-435040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA569E6EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE57188348B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0E205AA3;
	Fri,  6 Dec 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XsHAcxKs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gg8o5l1r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yvf+hoEh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yGYcODO6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0895464A;
	Fri,  6 Dec 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489890; cv=none; b=Naqtc112yqWkhVU4Z1+jL0e8bvZIbFKmqz9fgP8COCJ+LdRfSKHN+mJe7dd4KhjJtYcfP5Bh5IARe53fKR6IX+iLAYeapuWB/CPMmjRqRWerhstMYOCHLqMhCMJvWTP4BV92N5k6lyBumSfyup0pVXDDu4/S7NeoDjD5FCzBCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489890; c=relaxed/simple;
	bh=ryCcTJb/dELeZefAkrp49/3wtThxaiYycX4o8AEs6AQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG2g6d4YfS6SCkwrb734SaUbQKAWXwUMtGY1X8tVk+T1ROJGE8uCFCfGSCKs/h5lvb+AIcmhXNzkIvt4c1eEgRwO5WLeIoMOjGGjvCy+T3m0Er0oKulecCS8pQ/NxgKqh9pdTQHWIZPuuOD6OlTckvvSg834M+pXjNOmqHEAvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XsHAcxKs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gg8o5l1r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yvf+hoEh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yGYcODO6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFFA71F394;
	Fri,  6 Dec 2024 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQE15vh+1yWgkrtLLBTYuQfgLTdDbrdR9IU2Yus/X/U=;
	b=XsHAcxKsh5vvBsPSTTYnbp9EehorLxA26X6Jmx4wjo8gKTnM1qZ/7wEsx2kqN+zpubsqDA
	jmwnagTSMHDzUwcB0iMEDNVRG7N8CQHGr7KwHIEBqcKcW16vK3fXJbwXuh1wmXbprZoZkr
	5LFqpwSLZw2RxnNzwlqAtt9zTjQWRlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQE15vh+1yWgkrtLLBTYuQfgLTdDbrdR9IU2Yus/X/U=;
	b=Gg8o5l1rYnCiIEYjp16ycq5Qh0ig+x7meIx/e9zpuyv79qTWWAi2YF9wBUMKi7b9yUTnRn
	jnlPLiRG57SIZbAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Yvf+hoEh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yGYcODO6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQE15vh+1yWgkrtLLBTYuQfgLTdDbrdR9IU2Yus/X/U=;
	b=Yvf+hoEhQLV4dvRIoPvWdZPST6kilsrjSfOfjD3GE0jFVRUTfvRe4KywNiUmMjD/KuD2CF
	QawbYFTxaEKCWHLQByNj6pdJFjia+AeHt8Ctxpqy8HLIfl7zTqLF9C9VAqna0whF1nPfPu
	2GVD73Qmg/wXnj5m1oPpvSo+H8HxMeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQE15vh+1yWgkrtLLBTYuQfgLTdDbrdR9IU2Yus/X/U=;
	b=yGYcODO66zeZbi9f6eU3kHjLWc1yl3ZTgywWt7SGdj+cJoVM/PRjwJd9QL3QYiNhJIHSdd
	SqeWw3myWyiZv4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A726413647;
	Fri,  6 Dec 2024 12:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wfJ8J970Umc5TQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Dec 2024 12:58:06 +0000
Date: Fri, 06 Dec 2024 13:58:06 +0100
Message-ID: <87ikrxrmsh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kailang Yang <kailang@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Pshou <pshou@realtek.com>,
	Derek Gordon <derek@derekgordon.com>
Subject: Re: [PATCH] ALSA: hda/realtek - Add support for ASUS Zen AIO 27 Z272SD_A272SD audio
In-Reply-To: <20241205210306.977634-1-kovalev@altlinux.org>
References: <20241205210306.977634-1-kovalev@altlinux.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: EFFA71F394
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 05 Dec 2024 22:03:06 +0100,
Vasiliy Kovalev wrote:
> 
> Introduces necessary quirks to enable audio functionality on the
> ASUS Zen AIO 27 Z272SD_A272SD:
> - configures verbs to activate internal speakers and headphone jack.
> - implements adjustments for headset microphone functionality.
> 
> The speaker and jack configurations were derived from a dump of
> the working Windows driver, while the headset microphone
> functionality was fine-tuned through experimental testing.
> 
> Link: https://lore.kernel.org/all/CAGGMHBOGDUnMewBTrZgoBKFk_A4sNF4fEXwfH9Ay8SNTzjy0-g@mail.gmail.com/T/
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>

Thanks, applied.


Takashi

