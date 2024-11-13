Return-Path: <linux-kernel+bounces-407391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B1F9C6CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC68B2AC55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68D1FC7EB;
	Wed, 13 Nov 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mSU0O9Lx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4D2AF12;
	Wed, 13 Nov 2024 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493592; cv=none; b=FGUlDQwTLNSkvI1CWwUaSTYvkAw1Tzj4C3l0+xgxOR86rUZNWlYnavnSzwH5X6nQs6RWo/w0eUoRraR01bTjUd2t2AZbdkObT4idsPfHuA0F4B7Kb2BeRG2DV67lmG5aUUrlJnWaEe3Qw+7hAI3TCHyQ+62KYB6f7HHNqRuP/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493592; c=relaxed/simple;
	bh=3FcBxucqRCqPlLwXwQj/lnLelCVu67pOFv8cVSFW0EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhQxY6LKSk0Ryfc7OmzoBvxuWeTsJjC7cC1PPorzW7nTZWb2rMAltup8JEsMa5B329jAeyrP8GFw/oZg4XTGyWOtuTrVMg0bcrBs2Sl3FoPb2sq3pHW0p7TFP9F/NzLv3PuT22Bpz05f7EzRfvZiR/GPGuj7P0SXZO5XuzPLqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mSU0O9Lx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61E6D752;
	Wed, 13 Nov 2024 11:26:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731493575;
	bh=3FcBxucqRCqPlLwXwQj/lnLelCVu67pOFv8cVSFW0EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSU0O9LxrGJAmZq05VsTr6aOJYDTbtzWoxxeyhRAK5JyJLi2uoxgIlwkgcAQevJhO
	 IL8NCV7htlYwRbC3sSpmz4qqJJ2kX7mcfk/AtU2OuNF+gGGQT1SRfZmlIFhI+GVuR6
	 h27Htg+YNC09QdUjMgcjWMEH/4kDLWDa8rbVBoAI=
Date: Wed, 13 Nov 2024 12:26:19 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: reminder to not expose potentially private
 email addresses
Message-ID: <20241113102619.GC29944@pendragon.ideasonboard.com>
References: <f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info>

Hi Thorsten,

On Wed, Nov 13, 2024 at 09:35:03AM +0100, Thorsten Leemhuis wrote:
> Remind developers to not expose private email addresses, as some people
> become upset if their addresses end up in the lore archives or the Linux
> git tree.
> 
> While at it, explicitly mention the dangers of our bugzilla instance
> here, as it makes it easy to forget that email addresses visible there
> are only shown to logged-in users.
> 
> These are not a theoretical issues, as one maintainer mentioned that
> his employer received a EU GDPR (general data protection regulation)
> complaint after exposuring a email address used in bugzilla through a
> tag in a patch description.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> Note: this triggers a few checkpatch.pl complaints that are irrelevant
> when when ti comes to changes like this.
> 
> v1:
> - initial version
> ---
>  Documentation/process/5.Posting.rst          | 17 +++++++++---
>  Documentation/process/submitting-patches.rst | 27 +++++++++++++++++---
>  2 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index b3eff03ea2491c..1f6942948db349 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -264,10 +264,19 @@ The tags in common use are:
>   - Cc: the named person received a copy of the patch and had the
>     opportunity to comment on it.
>  
> -Be careful in the addition of tags to your patches, as only Cc: is appropriate
> -for addition without the explicit permission of the person named; using
> -Reported-by: is fine most of the time as well, but ask for permission if
> -the bug was reported in private.
> +Note, remember to respect other people's privacy when adding these tags:
> +
> + - Only specify email addresses, if owners explicitly permitted their use or
> +   are fine with exposing them to the public based on previous actions found in
> +   the lore archives. In practice you therefore often will be unable to hastily
> +   specify addresses for users of bug trackers, as those usually do expose the
> +   email addresses at all or only to logged in users. The latter is the case
> +   for bugzilla.kernel.org, whose privacy policy explicitly states that 'your
> +   email address will never be displayed to logged out users'.
> +
> + - Only Cc: is appropriate for addition without the explicit permission of the

Isn't Cc: as problematic as any other tag, is it ends up in both the git
history and the lore archive ?

> +   person named; using Reported-by: is fine most of the time as well given the
> +   above constraints, but ask for permission for bugs reported in private.
>  
>  
>  Sending the patch
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 1518bd57adab50..3373ba3025d6d8 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -484,7 +484,9 @@ provided such comments, you may optionally add a ``Cc:`` tag to the patch.
>  This is the only tag which might be added without an explicit action by the
>  person it names - but it should indicate that this person was copied on the
>  patch.  This tag documents that potentially interested parties
> -have been included in the discussion.
> +have been included in the discussion. Note, ensure owners of email addresses
> +are fine with exposing their addresses in tags like this; see 'Privacy aspects
> +when using tags...' below for details.
>  
>  Co-developed-by: states that the patch was co-created by multiple developers;
>  it is used to give attribution to co-authors (in addition to the author
> @@ -530,9 +532,10 @@ hopefully inspires them to help us again in the future. The tag is intended for
>  bugs; please do not use it to credit feature requests. The tag should be
>  followed by a Closes: tag pointing to the report, unless the report is not
>  available on the web. The Link: tag can be used instead of Closes: if the patch
> -fixes a part of the issue(s) being reported. Please note that if the bug was
> -reported in private, then ask for permission first before using the Reported-by
> -tag.
> +fixes a part of the issue(s) being reported. Note, ensure owners of email
> +addresses are fine with exposing their addresses in tags like this; see
> +'Privacy aspects when using tags...' below for details. And if the bug was
> +reported in private, ask for permission first before using the Reported-by-tag.
>  
>  A Tested-by: tag indicates that the patch has been successfully tested (in
>  some environment) by the person named.  This tag informs maintainers that
> @@ -600,6 +603,22 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
>  patch candidates. For more information, please read
>  Documentation/process/stable-kernel-rules.rst.
>  
> +Privacy aspects when using tags like Cc:, Reported-by:, Tested-by:, ...
> +-----------------------------------------------------------------------
> +
> +Only specify email addresses, if owners explicitly permitted their use or
> +are fine with exposing them to the public based on previous actions found in
> +the lore archives. In practice you therefore often will be unable to blindly
> +specify addresses for users of bug trackers, as those usually do expose the
> +email addresses at all or only to logged in users. The latter is the case
> +for bugzilla.kernel.org, whose privacy policy explicitly states that 'your
> +email address will never be displayed to logged out users'.
> +
> +Furthermore note that only Cc: is appropriate for addition without the
> +explicit permission of the person named; using Reported-by: is fine most of
> +the time as well given the above constraints, but ask for permission for bugs
> +reported in private.
> +
>  .. _the_canonical_patch_format:
>  
>  The canonical patch format
> 
> base-commit: 623e5747c680d3854b6b9882d9907096bc63580d

-- 
Regards,

Laurent Pinchart

