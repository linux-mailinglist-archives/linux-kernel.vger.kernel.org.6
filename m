Return-Path: <linux-kernel+bounces-185292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA48CB321
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350661C217F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78DD14830B;
	Tue, 21 May 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q1nqOSwV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q1nqOSwV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233077710F;
	Tue, 21 May 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314219; cv=none; b=PBRNb6xE4cLj15rGUNuOkHROg847slBiyEwN55FPLrpHS+x73PutC+L1IXTkxo/YPemF3zB8Hxo0150vq04zHz4q5pqT4GmRKpCoyO3DVhmoYQf58Rb/e7/+zgil1NKtwf6a7d6JBIm0aCJWjIoXoXiA1XtBjeiXXB8RKE9eprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314219; c=relaxed/simple;
	bh=xfDQO188zHzWOmlwzOQJS8rjKs/2HgeiIclILtQHEFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXt9qSWQmopHpn4cc7h94olKtUXHvZpd1hWiq6IOSaGOySRk0e4WqXYq+2NeozkK4GaLsaert7tSA9uVwJ/1RHQB5mQ05friorVGHx3sby0Gq2rxYVCNGU27nccIdJCXJOcpCjpLbkHRz1M0yT1AfqD2di4oDCGbrxqeOLB2Tw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q1nqOSwV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q1nqOSwV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 047A5348C4;
	Tue, 21 May 2024 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716314215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehWe83GKebpIGUMrOmfiP68kD8jXH869Oz31MmSJNq8=;
	b=Q1nqOSwVkp/1hlbwwZ7uUSFwaDZQyXQF+W7f+xK3jnzfyhanYplIL2sOtwsSgNNtBOzjdZ
	N+qEnw7JyRHGHVdjW7midmfJ3ALKk+LAZZvKeYB93J/QaRWYH9HGgXo8k81A1LwNufQ0qV
	pvynGRDv4VqkADtwQu2xFufVoPJ4ISM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Q1nqOSwV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716314215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehWe83GKebpIGUMrOmfiP68kD8jXH869Oz31MmSJNq8=;
	b=Q1nqOSwVkp/1hlbwwZ7uUSFwaDZQyXQF+W7f+xK3jnzfyhanYplIL2sOtwsSgNNtBOzjdZ
	N+qEnw7JyRHGHVdjW7midmfJ3ALKk+LAZZvKeYB93J/QaRWYH9HGgXo8k81A1LwNufQ0qV
	pvynGRDv4VqkADtwQu2xFufVoPJ4ISM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D938613A1E;
	Tue, 21 May 2024 17:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jnt1MmbgTGaAcQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 21 May 2024 17:56:54 +0000
Date: Tue, 21 May 2024 19:56:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <ZkzgZoxF_RD50PdW@tiehlicka>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
 <ZkxbObACcnUMZ3LA@tiehlicka>
 <2024052136-cubbyhole-ecologist-5b68@gregkh>
 <ZkzREEA5_N_xfqED@tiehlicka>
 <2024052110-grasp-liking-22c0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052110-grasp-liking-22c0@gregkh>
X-Spam-Flag: NO
X-Spam-Score: -6.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 047A5348C4
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
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]

On Tue 21-05-24 19:03:58, Greg KH wrote:
> On Tue, May 21, 2024 at 06:51:28PM +0200, Michal Hocko wrote:
[...]
> And really, in the end, if you have a "CVE and fix for CVE" in the same
> release, applying both doesn't hurt anyone, so this is a "fail secure"
> mode for everyone, right?

Look Greg, we have been through this discussion at several occasions and
I do not want to repeat that again. Stable tree users probably do not
care because they are getting all these patches, including regressions
and patches they do not need or even want, anyway. They are getting what
they are _paying_ for. Marking them CVE doesn't make any difference. But
stable tree backporting model is simply not a good fit for _many_ users.

Now, for $reasons, people _do_ care about CVEs and that is why there is
an engineering cost on downstreams to review them. Exactly because
applying all of them blindly is a _risk_. Exactly because the stable
backporting model/policy and CVE assigning policy is simply incompatible
with the stability/correctness/performance/$other requirements. 

I completely do get why you do not care about that downstream
engineering cost but generating bogus CVEs on top of a huge pile of
dubious ones is less than useful, don't you think?

Seriously, we can disagree whether something is a security threat that
is worth marking by a CVE. But making the CVE generation process mostly
unattended script driven process without any _serious_ review in place
is burning a lot of man power that could be used in a much more
productive way. This is not the way how to convince people to use stable
kernels.

Bye
-- 
Michal Hocko
SUSE Labs

