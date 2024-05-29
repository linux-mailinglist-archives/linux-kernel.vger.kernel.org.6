Return-Path: <linux-kernel+bounces-193588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885F8D2E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF35C1F29B04
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9416728A;
	Wed, 29 May 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dgRx0q1q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dgRx0q1q"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC91667DA;
	Wed, 29 May 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967821; cv=none; b=NLI4jCMWInYfFNE8kqM3Bfq3yZgA4tXpy4Q9bbDebpno5KwM44AqWEM3VC80r23OLeVVWQlwN4NMEwBqT9YLvobSvEZhiB/YrnGddphyiX07mdBkWTyUCRiYCMBQzDuCxLEGcDIiQz57N7e6p67/DMn5Xs/8U5I6nGjjyixlCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967821; c=relaxed/simple;
	bh=TyoDc8SUsSlbKqwVQ+JP+87caWaix/w0LvYnBIPCg6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8rAH204udRsb+iRtafybxwRty1zPG9ZOpXaIwtBECTsJQBExUxz01P/UlbM+WxPHveiN2PiN9BU2twvIDznqpbGUyONUTz8SySsvn87vgBXDlucpB/ObN8ex7VfF/hzBEWmpPbjZd1OMN/7ooyBKChkzAnbwOSj0OdQNNysZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dgRx0q1q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dgRx0q1q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33EE022910;
	Wed, 29 May 2024 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716967817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mXHhNcpzxQrgHEA5eaKouzF+exu8A9y4UV52b0W+XMQ=;
	b=dgRx0q1qKeOyGnloow89N0bEYXEu9hH6g3qra9CLDH4Q2SrO3A3sYzEZY1bjgY4ckBgubo
	rOmxuiAvpNPXtPY9v4wxZShRsAQ1UrXG8kib1RsmymoFtNDNA0vy2xpVFWgQ+Jjcn9WsmE
	1CP5fqiJvfiLyaD7z2ZiUgJT59V+nw4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dgRx0q1q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716967817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mXHhNcpzxQrgHEA5eaKouzF+exu8A9y4UV52b0W+XMQ=;
	b=dgRx0q1qKeOyGnloow89N0bEYXEu9hH6g3qra9CLDH4Q2SrO3A3sYzEZY1bjgY4ckBgubo
	rOmxuiAvpNPXtPY9v4wxZShRsAQ1UrXG8kib1RsmymoFtNDNA0vy2xpVFWgQ+Jjcn9WsmE
	1CP5fqiJvfiLyaD7z2ZiUgJT59V+nw4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C59513A6B;
	Wed, 29 May 2024 07:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3POWBInZVmaxUAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 29 May 2024 07:30:17 +0000
Date: Wed, 29 May 2024 09:30:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2023-52734: net: sched: sch: Bounds check priority
Message-ID: <ZlbIZ8bdBK4tZcBa@tiehlicka>
References: <2024052100-CVE-2023-52734-c8c2@gregkh>
 <ZlWNaIMC3NCkIFxv@tiehlicka>
 <2024052824-justice-lair-14e6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052824-justice-lair-14e6@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 33EE022910
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 28-05-24 21:06:39, Greg KH wrote:
> On Tue, May 28, 2024 at 09:53:12AM +0200, Michal Hocko wrote:
> > Is this really soemthing that should be getting a CVE assigned?
> > First the fix is incomplete - 9cec2aaffe96 ("net: sched: sch: Fix off by one in htb_activate_prios()")
> 
> Incomplete fixes are still part of a fix :)

Sigh

> > Second is this even real problem? https://lore.kernel.org/all/Y9V3mBmLUcrEdrTV@pop-os.localdomain/
> > suggests it is not.
> 
> Ah, good catch, I didn't see that.  I'll go revoke this as it's not
> doing anything.

Thanks!

I wish the CVE review process would catch something like that before
issuing a CVE for it.

> > And third, WARN_ONs are considered a real deal by CVE team because
> > somebody might be running with panic_on_warn. This patch adds one!
> 
> Yes, but if you can't hit that by anything from userspace, it's not an
> issue and just dead code.  We'll have to wait for a future syzbot report
> to prove that wrong :)

I am not judging the patch itself. It is maintainers who should decide
whether this is something they want to accept.

I am questioning the decision to make it a CVE. Because if that was a
real deal then WARN_ON is something kernel CNA is considering a CVE worth
problem! So a CVE has been filed with a fix that is CVE itself.
Seriously how could this pass through the CVE review process?
-- 
Michal Hocko
SUSE Labs

