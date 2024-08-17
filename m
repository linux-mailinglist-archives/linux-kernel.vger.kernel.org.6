Return-Path: <linux-kernel+bounces-290847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36530955977
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BEBB21846
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D615534E;
	Sat, 17 Aug 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Xy9PBN2N"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CC646
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723924176; cv=none; b=SxxiXJlOgjEdcKhr/4mHc+mEwJ5Or3Gng87KOQkauR8T4M0R0sOEEIgGULRSuHUzSJm6b/SSCfxu+Ksfl3E1MN7IIoMeiYNSTtCoTwSkWDqJhBX8kRz0FmJVv+p+mcqO6AIbKUcIfMLOsmK0EwZTT8hDB/47K0SuVU5xpnKh/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723924176; c=relaxed/simple;
	bh=pO9Bne77T4X6W4L5z6JgOJmlvTThUrdYpYS1LGWbQHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+eFrO/xooPF2c5vVoNLZYLj6t7byeJ0+Z9vYcGnQF87SKXHOV8tI2TBXsWB1raR7k50TbhmCnliApbkOO9npt7Hgx5y2s6Gfu8Wf/tVekQJjvlKeqj3PrJlLUFLcDklw+dXOxTd1o+MuCK8yrI4h8r9s70tsm2vFzPVRPYgfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Xy9PBN2N; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5FA69250;
	Sat, 17 Aug 2024 21:48:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1723924112;
	bh=pO9Bne77T4X6W4L5z6JgOJmlvTThUrdYpYS1LGWbQHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xy9PBN2NeVfbkwIPqGBIRbZRLjMvD3eeOGcYKDdNRA4tHOldSpEpUYVKR2oRR4DVt
	 +SP5UAyYk2FgpCjZzhrhp8lv9tNipD1i0DuWTA/fm5fZG6Rq86sbFjr3vfpZ/cxop+
	 /7OOjXjvifxfd+YOPxc9VjIKNEZMcn6esg2wNLUA=
Date: Sat, 17 Aug 2024 22:49:05 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Alexey Dobriyan <adobriyan@sw.ru>,
	=?utf-8?B?Uy7Dh2HEn2xhcg==?= Onur <caglar@pardus.org.tr>
Subject: Re: [PATCH] Remove *.orig pattern from .gitignore
Message-ID: <20240817194905.GA14638@pendragon.ideasonboard.com>
References: <20240729155738.29142-1-laurent.pinchart@ideasonboard.com>
 <20240801011120.GA1620143@thelio-3990X>
 <20240817193342.GA12234@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817193342.GA12234@pendragon.ideasonboard.com>

On Sat, Aug 17, 2024 at 10:33:42PM +0300, Laurent Pinchart wrote:
> On Wed, Jul 31, 2024 at 06:11:20PM -0700, Nathan Chancellor wrote:
> > On Mon, Jul 29, 2024 at 06:57:38PM +0300, Laurent Pinchart wrote:
> > > Commit 3f1b0e1f2875 (".gitignore update") added *.orig and *.rej
> > > patterns to .gitignore in v2.6.23. The commit message didn't give a
> > > rationale. Later on, commit 1f5d3a6b6532 ("Remove *.rej pattern from
> > > .gitignore") removed the *.rej pattern in v2.6.26, on the rationale that
> > > *.rej files indicated something went really wrong and should not be
> > > ignored.
> > > 
> > > The *.rej files are now shown by `git status`, which helps located
> > > conflicts when applying patches and lowers the probability that they
> > > will go unnoticed. It is however still easy to overlook the *.orig files
> > > which slowly polute the source tree. That's not as big of a deal as not
> > > noticing a conflict, but it's still not nice.
> > > 
> > > Drop the *.orig pattern from .gitignore to avoid this and help keep the
> > > source tree clean.
> > > 
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > As this has been in the tree for so long and appears not to have botherd
> > > anyone, I have a strong feeling I've overlooked something and this patch
> > > will be rejected. I've actually had that feeling for a few years
> > > already, and today I decided that maybe everybody else used the exact
> > > same reasoning, explaining why the annoying *.orig pattern is still in
> > > .gitignore.
> > 
> > I don't really have a strong opinion myself but it does seem reasonable
> > to be consistent. For what it's worth, Stephen Rothwell checks for
> > accidentally added .orig and .rej files in -next (and catches them
> > occasionally [1]), so I wouldn't expect removing this to matter much.
> > 
> > [1]: https://lore.kernel.org/linux-next/?q=.rej
> 
> I didn't know that, it's useful information, thanks. I wonder if
> checkpatch.pl could also check for that ? Although git-add already
> warns unless you specify -f, so people ignoring that may also ignore
> checkpatch.pl, I'm not sure.

And I should obviously wake up before writing e-mails. This patch
removes the pattern from .gitignore, so git-add won't warn. A
checkpatch.pl check could make sense.

> Who decides on whether this patch should be merged ?
> 
> > > ---
> > >  .gitignore | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/.gitignore b/.gitignore
> > > index 7902adf4f7f1..58fdbb35e2f1 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -142,7 +142,6 @@ GTAGS
> > >  # id-utils files
> > >  ID
> > >  
> > > -*.orig
> > >  *~
> > >  \#*#
> > >  
> > > 
> > > base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b

-- 
Regards,

Laurent Pinchart

