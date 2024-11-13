Return-Path: <linux-kernel+bounces-407481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E59C6E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643AD2823FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F56F200109;
	Wed, 13 Nov 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f73l2Dsa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034074DA04;
	Wed, 13 Nov 2024 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498017; cv=none; b=HXZwwSnP56/5VeMFO5yu4oMeqI4uh0TEYaUQ/wInrpQ+AS8xYDGOUDJyjBIk2JsjwOVnP7XVoD51h+yu8R9vbvJWUbcveXuWcE33IIhY5iyGoDtzyfFTftBLBvFNsTTSLLIvbNHmurWzmH6mvR8/hTfU5UWE6AJNlgwjNElonaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498017; c=relaxed/simple;
	bh=pH/drVezZjQoNO7PGRj8CNyoPiRUnDsx5whFrgim2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCCWLFN03gdOCjkqKyK90enXHhTtMSKFHna+YgI82k/b0Q/7flGKzvReauXp4RikFTF0JvoVsfrMJEj6qDFZxOW+o28pArpYAfxxHYVpcC0gy+CwCBtmLYlnKvqonIauEac4zovz0/cldQmTKgAvRZctHI0hoQc0P8Ch5g6FTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f73l2Dsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADB0C4CECD;
	Wed, 13 Nov 2024 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731498016;
	bh=pH/drVezZjQoNO7PGRj8CNyoPiRUnDsx5whFrgim2qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f73l2DsaHFlFCg+vhwK6wQQGIxbfM/odVdFrAYPJDVq5ORCmLk7iAJboZ+NUM/awb
	 WAnCoSywzazRUdsa233qJeiBw3BmGQLI53sLKLiErkFqy9KOIDRrGBpSZn1Dx895d6
	 nnOmehKY1ujDoukyneQlxU0mP1wlFeQUs91B7vnQVypZYNtN7t0Wn129TNBO25ZSCp
	 GK9QOjzvElvo1EEJSsZbJ5XE8yOTAncUHZI3+WzUbM5rpcZEpmRpHPS5B25RtxOcmV
	 eNGQr1iY9InOjMzLi8wKwQyy0X0vq3ZzF9Ob+d8M+QD0Vatb4JASUNUavaJvhCfo4A
	 Vw3wwglvM0Guw==
Date: Wed, 13 Nov 2024 12:40:10 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Jonathan Corbet <corbet@lwn.net>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: reminder to not expose potentially private
 email addresses
Message-ID: <20241113124010.7e7edaa1@foz.lan>
In-Reply-To: <CAKMK7uGwK0OYu+cVJnUVd5nMZRG8jJBXJUuo0xFXdyrubJFW4g@mail.gmail.com>
References: <f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info>
	<20241113102619.GC29944@pendragon.ideasonboard.com>
	<b160f728-b34f-433d-8cc4-677605990936@leemhuis.info>
	<CAKMK7uGwK0OYu+cVJnUVd5nMZRG8jJBXJUuo0xFXdyrubJFW4g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Nov 2024 11:59:39 +0100
Simona Vetter <simona.vetter@ffwll.ch> escreveu:

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
> > >> +   the lore archives. 

There is no comma between "addresses" and "if".

"previous actions" sounds a little to vague. Also, the text doesn't cover
everything, as lore archives may contain gaps.  I would, instead be clear:

	 - Only specify email addresses if owners explicitly permitted their use or
	   if such e-mail was previously used publicly for Linux contributions, which
	   can be checked by looking at the lore archives and at the git log. 

I added "git log there" because, in practice, nobody has the time to double-check
what e-mails are public: developers rely that scripts/checkpatch.pl will
check git log when creating the Cc: list.

Thanks,
Mauro

