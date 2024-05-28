Return-Path: <linux-kernel+bounces-191883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E058D158D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F1B1F21794
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AC173501;
	Tue, 28 May 2024 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VNxzCtks";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SGmQeCuT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7C2A1D8;
	Tue, 28 May 2024 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882800; cv=none; b=Ef92kmuqcp4auBjtQyF4+/kpC5HZ2OZ9sv0xozNygT3/DQOnfe9KeNmP4BDwWRbrD0rEfqki/aKfsGtS+OlBDz54/fuH06spCQffmxQacrfiMXhzPSRwSkDvz4KxVRvB3Ing4JqGntt9CRaadhb7XikwCk80kdydofGe2xmzRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882800; c=relaxed/simple;
	bh=c8qAEUCtyBz16gyroZ454TvXkmeNGW/ADkOi1Dc/lok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7slVLxL6aJrL0CU1AF7VvKQmR4GHsVpGjuLHkIP3aVgeC9IeiIKOIF9RD9gFkOa3AJ4K7gv+3dSMU0BzQW4gIECkleuqWvS6LXWtFc1/2m3dFYKVVqcbS74Tbhh84PbU9BEdqwKSnye1b9hT34RvGxTk4Ax5UL9ty7izrYwrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VNxzCtks; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SGmQeCuT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EABAD2266A;
	Tue, 28 May 2024 07:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716882797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlnQj/um52bHrhyjsTUhAylXLXscPrdwWMhWZp74EC0=;
	b=VNxzCtksGOhYaq8xvqXv9YLWw3GwlzeHpqlgMG3KZjwvUsigvcTt+Ksfe00E1zfZDqyAz4
	Y4tsn1KkPK3b3iB4aobxyV9/mOwSsbr/08wt74s610hR/Y3vpja7RI9+zv8JYb3FDjMzE5
	IvvtzE2fhg+kKGw+CaANz7tyeo8Bpcg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SGmQeCuT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716882796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlnQj/um52bHrhyjsTUhAylXLXscPrdwWMhWZp74EC0=;
	b=SGmQeCuTWHVxkvNya6rOTIXozUNIrwbJMM0uyAtzEs3z9U2hHMw+tfEBkpFuB/RnCDVBbm
	yC8RMdGvBJUXsQxuyil6l5gbwzqvxe7Mk+kypXSroA7u5Zqm9wwLDH2n4/uWamJZdpH2Wc
	hBwS4aPelGAdU9NP3vwYyq8rY1UTGtU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C008913A5D;
	Tue, 28 May 2024 07:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JLfbK2yNVWZbJgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 28 May 2024 07:53:16 +0000
Date: Tue, 28 May 2024 09:53:12 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2023-52734: net: sched: sch: Bounds check priority
Message-ID: <ZlWNaIMC3NCkIFxv@tiehlicka>
References: <2024052100-CVE-2023-52734-c8c2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052100-CVE-2023-52734-c8c2@gregkh>
X-Spam-Flag: NO
X-Spam-Score: -6.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EABAD2266A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cve.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]

Is this really soemthing that should be getting a CVE assigned?
First the fix is incomplete - 9cec2aaffe96 ("net: sched: sch: Fix off by one in htb_activate_prios()")
Second is this even real problem? https://lore.kernel.org/all/Y9V3mBmLUcrEdrTV@pop-os.localdomain/
suggests it is not.

And third, WARN_ONs are considered a real deal by CVE team because
somebody might be running with panic_on_warn. This patch adds one!

On Tue 21-05-24 17:23:11, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> net: sched: sch: Bounds check priority
> 
> Nothing was explicitly bounds checking the priority index used to access
> clpriop[]. WARN and bail out early if it's pathological. Seen with GCC 13:
> 
> ../net/sched/sch_htb.c: In function 'htb_activate_prios':
> ../net/sched/sch_htb.c:437:44: warning: array subscript [0, 31] is outside array bounds of 'struct htb_prio[8]' [-Warray-bounds=]
>   437 |                         if (p->inner.clprio[prio].feed.rb_node)
>       |                             ~~~~~~~~~~~~~~~^~~~~~
> ../net/sched/sch_htb.c:131:41: note: while referencing 'clprio'
>   131 |                         struct htb_prio clprio[TC_HTB_NUMPRIO];
>       |                                         ^~~~~~
> 
> The Linux kernel CVE team has assigned CVE-2023-52734 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 5.4.232 with commit fbe71c5dacaa
> 	Fixed in 5.10.169 with commit 90fcf55d83b2
> 	Fixed in 5.15.95 with commit 99875ea9b5b4
> 	Fixed in 6.1.13 with commit f6415c9c9a0b
> 	Fixed in 6.2 with commit de5ca4c3852f
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2023-52734
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	net/sched/sch_htb.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/fbe71c5dacaa5a9960323215f118958174c81aa0
> 	https://git.kernel.org/stable/c/90fcf55d83b20da1091f926a291af05fb74f61c6
> 	https://git.kernel.org/stable/c/99875ea9b5b47995bfb3c684d21eb17feb4b7e6a
> 	https://git.kernel.org/stable/c/f6415c9c9a0b3881543d38528a58b54af4351522
> 	https://git.kernel.org/stable/c/de5ca4c3852f896cacac2bf259597aab5e17d9e3

-- 
Michal Hocko
SUSE Labs

