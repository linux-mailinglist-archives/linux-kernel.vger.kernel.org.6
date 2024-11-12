Return-Path: <linux-kernel+bounces-406070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA69C5A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4691F215B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE41FCF60;
	Tue, 12 Nov 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M+HMnFFN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1ab6ZrMQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M+HMnFFN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1ab6ZrMQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E21FCC66;
	Tue, 12 Nov 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422336; cv=none; b=Qrw2tOjXeE+lrgLUTp3cV+6Izj3R/xMz4duTxEKLKqNgZRI+iYXg8PURLYKuugaA/hDi8a0xzFmSJs6kQpxmIV4HT3hZUBRoCkFpVrY6tZ9vtwRZOZdZmjRAQtczx2BE60rapevaG5OxalXMgbya+RjWlpPapCJgX2NmSNNDV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422336; c=relaxed/simple;
	bh=1UtOMHtwH1SOUw9FhScQrAe8SxbWdIG4GnE7JRRQYBE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmfjd73rAjq/fsAdMWJvFr2Y7GEufl9sjIryjmqVrycvZsaVMiUq61ce0lxFwNIEYBy9LZMLY7d1S8ee9/zMAljbRGprhaACBZcVhnsuaQSx4THqM1r8b6MgbdazSLA6pyf4ylusJUwbQF0KQvkV8vbSMNKN4g2pu8V1XqXgA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M+HMnFFN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1ab6ZrMQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M+HMnFFN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1ab6ZrMQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C84521276;
	Tue, 12 Nov 2024 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731422333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0BOez1F3uJWzNvDLZTFi0Elq1JhL9g4ZhgqCxyl7/c=;
	b=M+HMnFFN0tok4v4N2bGnomNceBbIxyEoU/t9QIQdiybu1Zy6t5n6VbsNvqQWLHtrueenCj
	zuyscEnY8bq9PI0smP5tx1zOthv+clSj6+MIWRhhAnRXK8xQTsJi6LqAkj1wVAFFWn6X0L
	IxQ39y0y52Mw8bWNQp6Jl8nLVINmMz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731422333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0BOez1F3uJWzNvDLZTFi0Elq1JhL9g4ZhgqCxyl7/c=;
	b=1ab6ZrMQvYoTwrSMQVq9wcsoejEq4UfQ6f9oNSOOTg9JBtCChepK/gBPAIMFWOaure/Rym
	iwk03JpMW1NAcyBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731422333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0BOez1F3uJWzNvDLZTFi0Elq1JhL9g4ZhgqCxyl7/c=;
	b=M+HMnFFN0tok4v4N2bGnomNceBbIxyEoU/t9QIQdiybu1Zy6t5n6VbsNvqQWLHtrueenCj
	zuyscEnY8bq9PI0smP5tx1zOthv+clSj6+MIWRhhAnRXK8xQTsJi6LqAkj1wVAFFWn6X0L
	IxQ39y0y52Mw8bWNQp6Jl8nLVINmMz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731422333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0BOez1F3uJWzNvDLZTFi0Elq1JhL9g4ZhgqCxyl7/c=;
	b=1ab6ZrMQvYoTwrSMQVq9wcsoejEq4UfQ6f9oNSOOTg9JBtCChepK/gBPAIMFWOaure/Rym
	iwk03JpMW1NAcyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E564113301;
	Tue, 12 Nov 2024 14:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YBRGNXxoM2csfwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 12 Nov 2024 14:38:52 +0000
Date: Tue, 12 Nov 2024 15:38:52 +0100
Message-ID: <87frnwtt37.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Eryk Zagorski <erykzagorski@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	soyjuanarbol@gmail.com
Subject: Re: [PATCH] ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry
In-Reply-To: <20241111164520.9079-2-erykzagorski@gmail.com>
References: <20241111164520.9079-2-erykzagorski@gmail.com>
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
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 11 Nov 2024 17:45:21 +0100,
Eryk Zagorski wrote:
> 
> This patch switches the P-125 quirk entry to use a composite quirk as the
> P-125 supplies both MIDI and Audio like many of the other Yamaha
> keyboards
> 
> Signed-off-by: Eryk Zagorski <erykzagorski@gmail.com>

Thanks, applied now.


Takashi

