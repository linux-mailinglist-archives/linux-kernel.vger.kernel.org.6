Return-Path: <linux-kernel+bounces-407638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749299C7052
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C201F2330B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CB1DF726;
	Wed, 13 Nov 2024 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0FhHWPv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7F1DF251;
	Wed, 13 Nov 2024 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503477; cv=none; b=CUui97C2vsv1Eefa/bmywwbHiayisBRtZAC7Pt2IBKJZmhpUKzWrZ/F9z7fk1+7upggU/efAmJdW5g4wKdUQLO/f/QCSvVSDDfUIpvZBgy1iKTvQLfPhpaow0MG6nM53oDoVQQ4yiO0Pd8uqrS18sLSI/YaWpkl1msxJgXJ6R8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503477; c=relaxed/simple;
	bh=zfie/E1ejEu920lClS0G5OiKpMGDI5CUJMDzl5K4lUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBvbgvbZM1OhUGKdJrRQ7wS/DLDVuX7zBKYj+V76afjLu6ltEwxENEnsfuXSFI02ssGGJzpLdC2gp8L9rrJWhiqnVjH+8ilFjGW8d0gEblXdG0OB00+UjGUAbO1k0ORnlF+ctnX96KMZTcFW1bJHMT6klnNDNPw3lS3TCiX5uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0FhHWPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8C7C4CECD;
	Wed, 13 Nov 2024 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731503477;
	bh=zfie/E1ejEu920lClS0G5OiKpMGDI5CUJMDzl5K4lUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n0FhHWPvyQLvZqMB0eHaqoWOdCe+0yMbIxwkd4UHj/PRkITg5aY/zrvQpf9mzUl3A
	 vDS77KbwSD24OeCXnTmtm2V/eq3m959skV5YPVzSVBvc4QIFZsRN9r37FlU5XTlzF8
	 T9f1CFScJBbnacidmq3ax1kozbvxuCws9BzUZbYGLX2QfID0xh1kyL711hnZMlt1Jb
	 xceYZ8psEsKkplKTnocUPT4odCOb+8LQ45+ZnNNfC3p72N8tRXTG53+UD/eAO3Oels
	 Dn4wo4T8PKNWmleothWFfZB+XImKsujIYAkYpLsF330dusfZHzMJr3RkuDHsVSMv5z
	 M4Qq12Xsl8fLw==
Date: Wed, 13 Nov 2024 14:11:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, Thorsten Leemhuis
 <linux@leemhuis.info>, Jonathan Corbet <corbet@lwn.net>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: reminder to not expose potentially private
 email addresses
Message-ID: <20241113141112.10bde770@foz.lan>
In-Reply-To: <20241113113650.GA31681@pendragon.ideasonboard.com>
References: <f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info>
	<20241113102619.GC29944@pendragon.ideasonboard.com>
	<b160f728-b34f-433d-8cc4-677605990936@leemhuis.info>
	<CAKMK7uGwK0OYu+cVJnUVd5nMZRG8jJBXJUuo0xFXdyrubJFW4g@mail.gmail.com>
	<20241113113650.GA31681@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Nov 2024 13:36:50 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> On Wed, Nov 13, 2024 at 11:59:39AM +0100, Simona Vetter wrote:
> > On Wed, 13 Nov 2024 at 11:55, Thorsten Leemhuis <linux@leemhuis.info> wrote:  
> > >
> > > On 13.11.24 11:26, Laurent Pinchart wrote:  
> > > > On Wed, Nov 13, 2024 at 09:35:03AM +0100, Thorsten Leemhuis wrote:  
> > > >> Remind developers to not expose private email addresses, as some people
> > > >> become upset if their addresses end up in the lore archives or the Linux
> > > >> git tree.
> > > >>
> > > >> While at it, explicitly mention the dangers of our bugzilla instance
> > > >> here, as it makes it easy to forget that email addresses visible there
> > > >> are only shown to logged-in users.
> > > >>
> > > >> These are not a theoretical issues, as one maintainer mentioned that
> > > >> his employer received a EU GDPR (general data protection regulation)
> > > >> complaint after exposuring a email address used in bugzilla through a
> > > >> tag in a patch description.
> > > >>
> > > >> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> > > >> ---
> > > >> Note: this triggers a few checkpatch.pl complaints that are irrelevant
> > > >> when when ti comes to changes like this.
> > > >>
> > > >> v1:
> > > >> - initial version
> > > >> ---
> > > >>  Documentation/process/5.Posting.rst          | 17 +++++++++---
> > > >>  Documentation/process/submitting-patches.rst | 27 +++++++++++++++++---
> > > >>  2 files changed, 36 insertions(+), 8 deletions(-)
> > > >>
> > > >> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> > > >> index b3eff03ea2491c..1f6942948db349 100644
> > > >> --- a/Documentation/process/5.Posting.rst
> > > >> +++ b/Documentation/process/5.Posting.rst
> > > >> @@ -264,10 +264,19 @@ The tags in common use are:
> > > >>   - Cc: the named person received a copy of the patch and had the
> > > >>     opportunity to comment on it.
> > > >>
> > > >> -Be careful in the addition of tags to your patches, as only Cc: is appropriate
> > > >> -for addition without the explicit permission of the person named; using
> > > >> -Reported-by: is fine most of the time as well, but ask for permission if
> > > >> -the bug was reported in private.
> > > >> +Note, remember to respect other people's privacy when adding these tags:
> > > >> +
> > > >> + - Only specify email addresses, if owners explicitly permitted their use or
> > > >> +   are fine with exposing them to the public based on previous actions found in
> > > >> +   the lore archives. In practice you therefore often will be unable to hastily
> > > >> +   specify addresses for users of bug trackers, as those usually do expose the
> > > >> +   email addresses at all or only to logged in users. The latter is the case
> > > >> +   for bugzilla.kernel.org, whose privacy policy explicitly states that 'your
> > > >> +   email address will never be displayed to logged out users'.
> > > >> +
> > > >> + - Only Cc: is appropriate for addition without the explicit permission of the  
> > > >
> > > > Isn't Cc: as problematic as any other tag, is it ends up in both the git
> > > > history and the lore archive ?  
> > >
> > > Hmmm. Good point, thx for bringing this up. And of course it is. But
> > > it's the second point in a list and thus should not overrule the first
> > > one. But I can see that it could be read like that. :-/ Up to some point
> > > I even was aware of it, as the added "given the above constraints" later
> > > in that point shows. But I guess I wanted to stay close to the previous
> > > text and that is not sufficient.
> > >
> > > Hmmm. So how about writing the second point like this:
> > >
> > > """
> > > Even if the email address is free to use in tags, it is only appropriate
> > > to use in Cc: without explicit permission of the person named; using it
> > > in Reported-by: likewise is often appropriate as well, but ask for
> > > permission for bugs reported in private.
> > > """
> > >
> > > Hope that "likewise" is sufficient here...  
> > 
> > I think these two points are fairly unrelated. The first is about
> > using the email address, for privacy concerns. The second point is
> > about adding the tag at all, which you're not allowed to do except for
> > Cc: tags. Because forging reviewed/acked/tested-by tags is really not
> > good. Putting the "no tag forgeries" rule under the privacy section is
> > I think what's confusing here.  
> 
> Reviewed-by, Acked-by, Tested-by or Signed-off-by clearly must never be
> forged, and that's indeed unrelated to privacy. Separating the privacy
> concerns and the no-forgery concerns sounds like it would make the
> document clearer.
> 
> It's not just tag forgery though. I can imagine that some people would
> be fine with their e-mail address appearing in lore, but wouldn't when
> to be listed in any tag in the git history.

I can't imagine that. This is for sure an exceptional case, on which
people should explicitly notify.

> I try to ask permission
> before adding a Reported-by or Co-developed-by tag, even if the person
> has participated in public discussions on mailing lists.

If someone reports a problem publicly, IMO the right thing to do is
to just add a reported-by to credit who reported the issue, except
if, while doing the report, someone explicitly asks not to do so.
Personally, I never faced such case, though.

Co-developed-by requires explicit ack, perhaps with one exception:
if we receive two or more independent patches with the same diff, which
is common when there is an issue reported by commonly used CIs and
static analyzers, all with their SoBs, I guess it should be ok to
group them into a single patch and use Co-developed-by.

> Should we
> generalize asking for permission ? The alternative of saying that
> Reported-by can "often" be added without explicit permission doesn't
> seem very clear to me.

I don't like "often" either, but it should be ok in the absense of a
clearer alternative.

Thanks,
Mauro

