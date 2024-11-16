Return-Path: <linux-kernel+bounces-411691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847AF9CFE4C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 11:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49ADA284E0D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738818C039;
	Sat, 16 Nov 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yRlFYdW/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0A1922E5;
	Sat, 16 Nov 2024 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731753751; cv=none; b=O3Zvh31Hu3HHr13RtHOsFLQOtn18p+ndekipgyrQKGrGWeWNLVxPzqk4kKCReqFUMCFB8jecMgawfTxQHqXAK40PuFKB2HZsTsFvdlm0zqCGYS5LuL5eU6kvbrYMm3wIic8ZBBskfATxkl2FRIVx6MIDU9BPUuCpEZHu9ffdW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731753751; c=relaxed/simple;
	bh=epOxwwFJwjyymxYyPieR6wax2dUIYBTxH4NYFHrrlZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3HynfpIm4pfMG/hzmarLgKpqD6RpYWth+kTmAmFJ/80ku7MVZYyV/5QSBZEUSXz3L45A8ou067us2mz2f07C8oIm5Ndocbx2tnBVvK+BUi+Da5M3IrmjU6qDIFGL3RXJdkIOc1GPJ//yPFTd7Ul9io9yv0N4R278PehDTk9neQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yRlFYdW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62CBC4CEC3;
	Sat, 16 Nov 2024 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731753750;
	bh=epOxwwFJwjyymxYyPieR6wax2dUIYBTxH4NYFHrrlZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yRlFYdW/tzlect7iL6vCI86Y0nhlTEIubwlq6dUaot8DPRLIBq0zQjTngXOC2f2+c
	 c0APep/LoZajaQFRF95neMUXz+wId/nY1Nh5r2zvsARglYNWIVf7l2joeuFKPsPvFR
	 R/8bwlVbNGx/klHHE2bjvTQhUvjWF+FyFe91g7nw=
Date: Sat, 16 Nov 2024 11:42:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 2/2] docs: clarify rules wrt tagging other people
Message-ID: <2024111651-slather-blabber-857f@gregkh>
References: <cover.1731749544.git.linux@leemhuis.info>
 <b7dce8b22a391c2f8f0d5a47bf23bc852eca4e71.1731749544.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7dce8b22a391c2f8f0d5a47bf23bc852eca4e71.1731749544.git.linux@leemhuis.info>

On Sat, Nov 16, 2024 at 10:33:59AM +0100, Thorsten Leemhuis wrote:
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
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> Note: this triggers a few checkpatch.pl complaints that are irrelevant
> when when to comes to changes like this.
> 
> v2:
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
>  Documentation/process/5.Posting.rst          | 17 ++++++--
>  Documentation/process/submitting-patches.rst | 44 ++++++++++++++------
>  2 files changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index dbb763a8de901d..b45c4f6d65ca95 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -268,10 +268,19 @@ The tags in common use are:
>   - Cc: the named person received a copy of the patch and had the
>     opportunity to comment on it.
>  
> -Be careful in the addition of tags to your patches, as only Cc: is appropriate
> -for addition without the explicit permission of the person named; using
> -Reported-by: is fine most of the time as well, but ask for permission if
> -the bug was reported in private.
> +Be careful in the addition of tags to your patches, as nearly all of them need
> +explicit permission of the person named.
> +
> +The only exceptions are Cc:, Reported-by:, and Suggested-by:, as for them

I don't understand what you mean by "only exceptions" here.  Exceptions
to what?

> +implicit permission is sufficient under the following circumstances: when the
> +person named according to the lore archives or the commit history regularly
> +contributes to the Linux kernel using that name and email address -- and in
> +case of Reported-by: and Suggested-by: did the reporting or suggestion in
> +public. For all other situations explicit permission is required to among
> +others prevent exposing email addresses considered private. Especially ask for
> +permission when it comes to bug trackers, as most only show addresses to logged
> +in users; that includes bugzilla.kernel.org, whose privacy policy explicitly
> +states that 'your email address will never be displayed to logged out users'.

How about makeing this much simpler, basically "any public reference can
be used, but please note, email addresses in bugzilla.kernel.org are not
public.  Anything offered in private should probably not be referenced."
or something like that?

thanks,

greg k-h

