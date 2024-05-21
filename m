Return-Path: <linux-kernel+bounces-185235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848798CB27D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C601C2225B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA38214900A;
	Tue, 21 May 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gobkc1hM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lB3uYTCy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB87F46C;
	Tue, 21 May 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310294; cv=none; b=AI46rxM7ZUbOgJShbCxR/CMmgcyxHig0B6TuOtO9RcOb7sW/2Us0PJRxfHhvTuFGPb1mquJsZ7vH3/omfAX5ZDzqD8OXwet+CgepxEvWGkLKvWL8C+znMr2xVXyndTXhLkb9aIj3efJr6tKoKxcyszr4HVwrberi/bA7DOHzWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310294; c=relaxed/simple;
	bh=/Za7lnT4RsmuqCIRbxLG0h0/4OY5h36ZAB8c418kAgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jbwt8Xr+R3dSpln+W58LjNQ/4v1XsRSa1O5tdo0LcwMC1w7rDxFe6KBbx1E/iNVNTallL6avsJ7g2pgBc0zVdJFftmhIc8TrWRKMVPw0O6epLC0NK6yXuqc9blx3/pFerujyMAsnTlBMS+Eu8rqco4+01SkTqVUvyRWdrtphUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gobkc1hM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lB3uYTCy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E7CB75C306;
	Tue, 21 May 2024 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716310289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5wC6St2W9a0079FlsAxBdt60ygW6DNeyzJ9RWIk3mJk=;
	b=Gobkc1hMhGR3JTdFeJHDpv94vLnYIgo9oz8G0aoAudQA8Z1gnsghCSZghslpC2gmTZ26Xb
	TLqg8JTnKLFIEzsLvX8gFFJTP+iUmWqYr8AWbhqqsqw+PBYKuqxJ0Zpa4x17EykbGHKpHM
	NJMCaNnSnN0AOPpmawF7XPpOV6g1F4I=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lB3uYTCy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716310288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5wC6St2W9a0079FlsAxBdt60ygW6DNeyzJ9RWIk3mJk=;
	b=lB3uYTCyDJNBCZlLYrikF/6JDThFyvL9PGVNLcsW+XifeHfu7lSYHaNEGIgFjxVsnq37C1
	k4wdav7ecXHW7Cjt9s58/3bsk88QH+bLzkODW3sH4+OfzSCgNHoc+vQtc0albOJ6tUHxxQ
	rbPedyBUpouzzKhBH4waCqFDa30IIZA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D243313685;
	Tue, 21 May 2024 16:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R35IMRDRTGYgJgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 21 May 2024 16:51:28 +0000
Date: Tue, 21 May 2024 18:51:28 +0200
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <ZkzREEA5_N_xfqED@tiehlicka>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
 <ZkxbObACcnUMZ3LA@tiehlicka>
 <2024052136-cubbyhole-ecologist-5b68@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052136-cubbyhole-ecologist-5b68@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,linuxfoundation.org:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E7CB75C306
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.01

On Tue 21-05-24 16:39:51, Greg KH wrote:
> On Tue, May 21, 2024 at 10:28:41AM +0200, Michal Hocko wrote:
> > CVE-2024-35881 to revert f341055b10bd ("drm/amd/display: Send DTBCLK
> > disable message on first commit") by 3a6a32b31a11 ("Revert
> > "drm/amd/display: Send DTBCLK disable message on first commit"") has
> > been filed as well.
> > 
> > Is this really intentional? Should both be rejected?
> 
> I don't think so as we had releases with the original commit in it,

I do not think so. Looking at stable kernel branches:
$ git describe-ver 0dab75b433ed2480d57ae4f8f725186a46223e42
v6.8.5~88
$ git describe-ver d6d5622f64f3e07620683d61c880f57965fe1b48
v6.8.5~239

Both of them were released in 6.9-rc1 in Linus tree. I do not see them
in any other stable trees. Neither of them is even marked for stable and
they seemed to be merged only because of (stable tree) 7ea8a0e12088eb0c
which has Stable-dep-of: f341055b10bd ("drm/amd/display: Send DTBCLK
disable message on first commit"). Btw note that 7ea8a0e12088eb0c is not
marked for stable, nor I see anybody requesting that on lore.
Stable rulez!

Let's put aside whether f341055b10bd should get a CVE, we have clearly a
different view on that but looking at the vulns.git tree both CVEs have
been assigned together
$ git log ./2024/CVE-2024-35906.sha1 ./2024/CVE-2024-35881.sha1
commit a6191f0053349c3234f690316d6511e97927f28f
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun May 19 10:35:32 2024 +0200

    some 6.8.5 cves assigned

    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

which to me indicates that both CVEs were assigned by a script
without a proper review which is really unfortunate.

Please keep in mind that there are actual consumers of these CVEs and
you are burning their time evaluating these noops. A waste of time, if
you ask me, and not something that could be just neglected considering
how many CVEs you are producing.
-- 
Michal Hocko
SUSE Labs

