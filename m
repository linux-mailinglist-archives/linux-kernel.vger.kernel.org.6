Return-Path: <linux-kernel+bounces-427071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817239DFBEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2064B224F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE81F9ED6;
	Mon,  2 Dec 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q35cDcMA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160521F9EC0;
	Mon,  2 Dec 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128143; cv=none; b=k6TtYq1hGembsfFhFwHyzpUV+/oDGzeZH2AqzgoaPVsrL8+1srDDSrEBMEinbU3m62rJOj4Apnu2uj6UVgJleAgQPio2pOok1g+fsUwx7V8WcUvA00jxPMhCJcUfAkXs6du6D3s/VqCGH/dxJERaWoYRn5OVFGCm7Mnor2xbWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128143; c=relaxed/simple;
	bh=o9JnUFIRDJbTJY1jC7r2fXEGsNi+iIpPh2OY1FMnb+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dve40J6eQjHmnrobN5t/9+h9qC7J3yWqEcTGUMUwAnM0QY8XOguF2g2r1X/F2Qt84RC6C8tXOEfPKgRCCrhgncpIgu55j6fmEdFtJZWK+6tWQz9Zgo+B7X+z8NdJOLTaCQzMbTJBgfEglzzX3CGYO7y9aQHqfdSK82UdYwHY5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q35cDcMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB073C4CED2;
	Mon,  2 Dec 2024 08:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733128142;
	bh=o9JnUFIRDJbTJY1jC7r2fXEGsNi+iIpPh2OY1FMnb+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q35cDcMADnf+6229U2vpgK468Gp62BZWPG1ZhcGAAFGdaFfQ8iLwekqVLytfcRVSk
	 k1jvBen8AaXRU4r+QfiSqQbWera8njvL+mpydAe0wFdzDR3QPjwOuuqysl01lupsS3
	 rT92FuhJsk0C0tAn3KMRroUvBaYxEj0qrll/g8rCHhBUfsUGgnChQQezT6VkzXGW4n
	 Nr58YF4Iy0swEXCoUV3QJ6soDVXECbRG29HkMrSSnRMOMjKggyRYBOMPX1rbIkAjdX
	 9+OAVCOzDP+O6TqO+CPZioRo50p2Is4GWk5DAkqNRgLnHdSu7cJGD/a78IJmL6sBnU
	 Gv/sFr1JfbE7A==
Date: Mon, 2 Dec 2024 09:28:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 DONOTMERGE] docs: clarify rules wrt tagging other
 people
Message-ID: <20241202092857.7d197995@foz.lan>
In-Reply-To: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
References: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon,  2 Dec 2024 09:14:19 +0100
Thorsten Leemhuis <linux@leemhuis.info> escreveu:

> Point out that explicit permission is usually needed to tag other people
> in changes, but mention that implicit permission can be sufficient in
> certain cases. This fixes slight inconsistencies between Reported-by:
> and Suggested-by: and makes the usage more intuitive.
> 
> While at it, explicitly mention the dangers of our bugzilla instance, as
> it makes it easy to forget that email addresses visible there are only
> shown to logged-in users.
> 
> The latter is not a theoretical issue, as one maintainer mentioned that
> his employer received a EU GDPR (general data protection regulation)
> complaint after exposing a email address used in bugzilla through a tag
> in a patch description.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
> Note: this triggers a few checkpatch.pl complaints that are irrelevant
> when when to comes to changes like this.
> 
> v3:
> - try yet again from a slightly different angle which loosens the rules
>   slightly. This from review feedback to earlier versions is apparently
>   what other developers want and from their "no lawyer" perspective
>   consider to be okay. As IANAL myself I don't feel totally comfortable
>   with this and have no idea if this legally is sound, so tag patch with
>   "DONOTMERGE" for now; will remove this for v4 if enough people add a
>   "Reviewed-by". Otherwise the story of this patch might end here, unless
>   someone else submits it for inclusion (you are free to do so!).
> - remote patch adding Suggested-by: tag to 5.Posting and submit it
>   separately
> 
> v2: https://lore.kernel.org/all/cover.1731749544.git.linux@leemhuis.info/
> - Retry differently. This slightly hardens the rule for Reported-by:
>   while slightly lessening it for Suggested-by:. Those in the end are
>   quite similar, so it does not make much sense to apply different ones.
>   I considered using an approach along the lines of "if you reported it
>   in pubic by mail, implicit permission to use in a tag is granted"; but
>   I abstained from it, as I assume there are good reasons for the
>   existing approach regarding Suggested-by:.
> - CC all the people that provided feedback on the text changes in v1
> 
> v1: https://lore.kernel.org/all/f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info/
> - initial version
> ---
>  Documentation/process/5.Posting.rst          | 13 +++++--
>  Documentation/process/submitting-patches.rst | 39 ++++++++++++++------
>  2 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index b3eff03ea2491c..73961565040ed8 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -264,10 +264,15 @@ The tags in common use are:
>   - Cc: the named person received a copy of the patch and had the
>     opportunity to comment on it.
>  
> -Be careful in the addition of tags to your patches, as only Cc: is appropriate
> -for addition without the explicit permission of the person named; using
> -Reported-by: is fine most of the time as well, but ask for permission if
> -the bug was reported in private.
> +Be careful in the addition of tags to your patches, as all except for Cc:,
> +Reported-by:, and Suggested-by: need explicit permission of the person named.
> +For the three aforementioned ones implicit permission is sufficient if the
> +person contributed to the Linux kernel using that name and email address
> +according to the lore archives or the commit history -- and in case of
> +Reported-by: and Suggested-by: did the reporting or suggestion in public.
> +Note, bugzilla.kernel.org is a public place in this sense, but email addresses
> +used there are private; so do not expose them in tags, unless the person used
> +them in earlier contributions.
>  
>  
>  Sending the patch
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 1518bd57adab50..9d26a4b7ca8ba3 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -481,10 +481,10 @@ list archives.
>  
>  If a person has had the opportunity to comment on a patch, but has not
>  provided such comments, you may optionally add a ``Cc:`` tag to the patch.
> -This is the only tag which might be added without an explicit action by the
> -person it names - but it should indicate that this person was copied on the
> -patch.  This tag documents that potentially interested parties
> -have been included in the discussion.
> +This tag documents that potentially interested parties have been included in
> +the discussion. Note, this is one of only three tags you might be able to use
> +without explicit permission of the person named (see 'Tagging people requires
> +permission' below for details).
>  
>  Co-developed-by: states that the patch was co-created by multiple developers;
>  it is used to give attribution to co-authors (in addition to the author
> @@ -530,9 +530,9 @@ hopefully inspires them to help us again in the future. The tag is intended for
>  bugs; please do not use it to credit feature requests. The tag should be
>  followed by a Closes: tag pointing to the report, unless the report is not
>  available on the web. The Link: tag can be used instead of Closes: if the patch
> -fixes a part of the issue(s) being reported. Please note that if the bug was
> -reported in private, then ask for permission first before using the Reported-by
> -tag.
> +fixes a part of the issue(s) being reported. Note, the Reported-by tag is one
> +of only three tags you might be able to use without explicit permission of the
> +person named (see 'Tagging people requires permission' below for details).
>  
>  A Tested-by: tag indicates that the patch has been successfully tested (in
>  some environment) by the person named.  This tag informs maintainers that
> @@ -582,11 +582,11 @@ Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
>  in the patch changelog (after the '---' separator).
>  
>  A Suggested-by: tag indicates that the patch idea is suggested by the person
> -named and ensures credit to the person for the idea. Please note that this
> -tag should not be added without the reporter's permission, especially if the
> -idea was not posted in a public forum. That said, if we diligently credit our
> -idea reporters, they will, hopefully, be inspired to help us again in the
> -future.
> +named and ensures credit to the person for the idea: if we diligently credit
> +our idea reporters, they will, hopefully, be inspired to help us again in the
> +future. Note, this is one of only three tags you might be able to use without
> +explicit permission of the person named (see 'Tagging people requires
> +permission' below for details).
>  
>  A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
>  is used to make it easy to determine where a bug originated, which can help
> @@ -600,6 +600,21 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
>  patch candidates. For more information, please read
>  Documentation/process/stable-kernel-rules.rst.
>  
> +.. _tagging_people:
> +
> +Tagging people requires permission
> +----------------------------------
> +
> +Be careful in the addition of tags to your patches, as all except for Cc:,
> +Reported-by:, and Suggested-by: need explicit permission of the person named.
> +For the three aforementioned ones implicit permission is sufficient if the
> +person contributed to the Linux kernel using that name and email address
> +according to the lore archives or the commit history -- and in case of
> +Reported-by: and Suggested-by: did the reporting or suggestion in public.
> +Note, bugzilla.kernel.org is a public place in this sense, but email addresses
> +used there are private; so do not expose them in tags, unless the person used
> +them in earlier contributions.
> +
>  .. _the_canonical_patch_format:
>  
>  The canonical patch format
> 
> base-commit: 83a474c11e8cb59e230a43365cb42fa00d3bddaa



Thanks,
Mauro

