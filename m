Return-Path: <linux-kernel+bounces-407480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566FE9C6E14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1E7B2469F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75F1FF7D3;
	Wed, 13 Nov 2024 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VnslGWQm"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BBD1FF056;
	Wed, 13 Nov 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497823; cv=none; b=RDbejuOne+8K0PVC/Am7TGWzvFX5NuPDBMcO3FSGnqpM/kkh/XlAFCFlo8EwNis+QovPWOz6LJHa1098Vimz9aNVILoehHnmE4nQZNezNOlZZ5ykmS3jwmiStQx5lGo1J9ggIZef7LCuBh8blTFUroQw3fwXOSIVfcQSgbW2PpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497823; c=relaxed/simple;
	bh=Cu6uy2wlmY8rj1HSuGkGPIcG/KroQWNV59+LWnWDUqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOF2BJ4qPxzl9ImWzTYv+bkPZlVTijj0xF5/TK7YUJdakkvnnz2LNbCuLOfHzPPn7fmOYsA1GYzzhl70NpVzWlMummhKRmBkrKfXef5xrYSISehCfpNBAIifcy1aLP2cYsQd78AJZvJaSczQKIyZMXFcbCXPGwIBT0WUiiSdYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VnslGWQm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA52A594;
	Wed, 13 Nov 2024 12:36:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731497806;
	bh=Cu6uy2wlmY8rj1HSuGkGPIcG/KroQWNV59+LWnWDUqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnslGWQmwPg88FFGvfCwhk6S/XgtezDyxW2ACgul2mu006IShErQi3qJ8J4fTOWfT
	 9RKSbUnttjRK6KA+DRDFzfNt/k3OwXiQ4+/QWZRuT5YxOY5ZT6JnRhd5qmF5CX8pDn
	 b6ZlnfdlvuKkKLqxl0mmQNXDSUUbFv3iMzkH4l+c=
Date: Wed, 13 Nov 2024 13:36:50 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: reminder to not expose potentially private
 email addresses
Message-ID: <20241113113650.GA31681@pendragon.ideasonboard.com>
References: <f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info>
 <20241113102619.GC29944@pendragon.ideasonboard.com>
 <b160f728-b34f-433d-8cc4-677605990936@leemhuis.info>
 <CAKMK7uGwK0OYu+cVJnUVd5nMZRG8jJBXJUuo0xFXdyrubJFW4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKMK7uGwK0OYu+cVJnUVd5nMZRG8jJBXJUuo0xFXdyrubJFW4g@mail.gmail.com>

On Wed, Nov 13, 2024 at 11:59:39AM +0100, Simona Vetter wrote:
> On Wed, 13 Nov 2024 at 11:55, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >
> > On 13.11.24 11:26, Laurent Pinchart wrote:
> > > On Wed, Nov 13, 2024 at 09:35:03AM +0100, Thorsten Leemhuis wrote:
> > >> Remind developers to not expose private email addresses, as some people
> > >> become upset if their addresses end up in the lore archives or the Linux
> > >> git tree.
> > >>
> > >> While at it, explicitly mention the dangers of our bugzilla instance
> > >> here, as it makes it easy to forget that email addresses visible there
> > >> are only shown to logged-in users.
> > >>
> > >> These are not a theoretical issues, as one maintainer mentioned that
> > >> his employer received a EU GDPR (general data protection regulation)
> > >> complaint after exposuring a email address used in bugzilla through a
> > >> tag in a patch description.
> > >>
> > >> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> > >> ---
> > >> Note: this triggers a few checkpatch.pl complaints that are irrelevant
> > >> when when ti comes to changes like this.
> > >>
> > >> v1:
> > >> - initial version
> > >> ---
> > >>  Documentation/process/5.Posting.rst          | 17 +++++++++---
> > >>  Documentation/process/submitting-patches.rst | 27 +++++++++++++++++---
> > >>  2 files changed, 36 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> > >> index b3eff03ea2491c..1f6942948db349 100644
> > >> --- a/Documentation/process/5.Posting.rst
> > >> +++ b/Documentation/process/5.Posting.rst
> > >> @@ -264,10 +264,19 @@ The tags in common use are:
> > >>   - Cc: the named person received a copy of the patch and had the
> > >>     opportunity to comment on it.
> > >>
> > >> -Be careful in the addition of tags to your patches, as only Cc: is appropriate
> > >> -for addition without the explicit permission of the person named; using
> > >> -Reported-by: is fine most of the time as well, but ask for permission if
> > >> -the bug was reported in private.
> > >> +Note, remember to respect other people's privacy when adding these tags:
> > >> +
> > >> + - Only specify email addresses, if owners explicitly permitted their use or
> > >> +   are fine with exposing them to the public based on previous actions found in
> > >> +   the lore archives. In practice you therefore often will be unable to hastily
> > >> +   specify addresses for users of bug trackers, as those usually do expose the
> > >> +   email addresses at all or only to logged in users. The latter is the case
> > >> +   for bugzilla.kernel.org, whose privacy policy explicitly states that 'your
> > >> +   email address will never be displayed to logged out users'.
> > >> +
> > >> + - Only Cc: is appropriate for addition without the explicit permission of the
> > >
> > > Isn't Cc: as problematic as any other tag, is it ends up in both the git
> > > history and the lore archive ?
> >
> > Hmmm. Good point, thx for bringing this up. And of course it is. But
> > it's the second point in a list and thus should not overrule the first
> > one. But I can see that it could be read like that. :-/ Up to some point
> > I even was aware of it, as the added "given the above constraints" later
> > in that point shows. But I guess I wanted to stay close to the previous
> > text and that is not sufficient.
> >
> > Hmmm. So how about writing the second point like this:
> >
> > """
> > Even if the email address is free to use in tags, it is only appropriate
> > to use in Cc: without explicit permission of the person named; using it
> > in Reported-by: likewise is often appropriate as well, but ask for
> > permission for bugs reported in private.
> > """
> >
> > Hope that "likewise" is sufficient here...
> 
> I think these two points are fairly unrelated. The first is about
> using the email address, for privacy concerns. The second point is
> about adding the tag at all, which you're not allowed to do except for
> Cc: tags. Because forging reviewed/acked/tested-by tags is really not
> good. Putting the "no tag forgeries" rule under the privacy section is
> I think what's confusing here.

Reviewed-by, Acked-by, Tested-by or Signed-off-by clearly must never be
forged, and that's indeed unrelated to privacy. Separating the privacy
concerns and the no-forgery concerns sounds like it would make the
document clearer.

It's not just tag forgery though. I can imagine that some people would
be fine with their e-mail address appearing in lore, but wouldn't when
to be listed in any tag in the git history. I try to ask permission
before adding a Reported-by or Co-developed-by tag, even if the person
has participated in public discussions on mailing lists. Should we
generalize asking for permission ? The alternative of saying that
Reported-by can "often" be added without explicit permission doesn't
seem very clear to me.

> > >> +   person named; using Reported-by: is fine most of the time as well given the
> > >> +   above constraints, but ask for permission for bugs reported in private.
> > > [...]
> >
> > Ciao., Thorsten

-- 
Regards,

Laurent Pinchart

