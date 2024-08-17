Return-Path: <linux-kernel+bounces-290844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951195596B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24DDB21837
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D0813DBA2;
	Sat, 17 Aug 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Guf/rmLW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A227F7CA
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723923253; cv=none; b=cjno0vpPG769RtHwXtHGOeHXhEqMdUYUlX0V/BqXoGsjpb5RKpwM0sJk8lhsuaLnP1/gxIyYLv0+rmIL2z2EKHKdbJLM9zr/yZiayNHn32ur8wbPECcbzHbaXjvXqxbld0xNgAYByJXLXZFF/AjHkh8vvtDDOxkIe8bmrFWTjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723923253; c=relaxed/simple;
	bh=0JBO1dxyJIDIBSIBLxm28zVxfTS+j4l5X5RngmBL/lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE471q5N4UjRfkEYxMOcSbe4yP2VisSDqKggOku7EEWQvOrRh5BXAbslNqhI2ZP1jwsOXCf0FghHMs1TQx25yf8qp6yuTGDrLeYU1UQtNfIuOAgRFQt/cHHCVOlxJA+wHDtB7R+en+LkfbX4ck68IlW0v/ug5HauOOfZxgK+hT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Guf/rmLW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4C36E250;
	Sat, 17 Aug 2024 21:33:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1723923189;
	bh=0JBO1dxyJIDIBSIBLxm28zVxfTS+j4l5X5RngmBL/lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Guf/rmLWNsyMKypdfC5seu+FLOCxtgbwsKRmsfjwHY9IzD1FcINpbWnXp7wrfn7sH
	 e0LQL6eJI8SXHbSOSuaTaYxDsv/PwwgDb/v5QqOFp5PZ8GtB2UzvzipxvZtQmK8hmw
	 5kicXK008aM0heLPyrU2+91p5zt91kInkfqUN68w=
Date: Sat, 17 Aug 2024 22:33:42 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Alexey Dobriyan <adobriyan@sw.ru>,
	=?utf-8?B?Uy7Dh2HEn2xhcg==?= Onur <caglar@pardus.org.tr>
Subject: Re: [PATCH] Remove *.orig pattern from .gitignore
Message-ID: <20240817193342.GA12234@pendragon.ideasonboard.com>
References: <20240729155738.29142-1-laurent.pinchart@ideasonboard.com>
 <20240801011120.GA1620143@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801011120.GA1620143@thelio-3990X>

On Wed, Jul 31, 2024 at 06:11:20PM -0700, Nathan Chancellor wrote:
> On Mon, Jul 29, 2024 at 06:57:38PM +0300, Laurent Pinchart wrote:
> > Commit 3f1b0e1f2875 (".gitignore update") added *.orig and *.rej
> > patterns to .gitignore in v2.6.23. The commit message didn't give a
> > rationale. Later on, commit 1f5d3a6b6532 ("Remove *.rej pattern from
> > .gitignore") removed the *.rej pattern in v2.6.26, on the rationale that
> > *.rej files indicated something went really wrong and should not be
> > ignored.
> > 
> > The *.rej files are now shown by `git status`, which helps located
> > conflicts when applying patches and lowers the probability that they
> > will go unnoticed. It is however still easy to overlook the *.orig files
> > which slowly polute the source tree. That's not as big of a deal as not
> > noticing a conflict, but it's still not nice.
> > 
> > Drop the *.orig pattern from .gitignore to avoid this and help keep the
> > source tree clean.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > As this has been in the tree for so long and appears not to have botherd
> > anyone, I have a strong feeling I've overlooked something and this patch
> > will be rejected. I've actually had that feeling for a few years
> > already, and today I decided that maybe everybody else used the exact
> > same reasoning, explaining why the annoying *.orig pattern is still in
> > .gitignore.
> 
> I don't really have a strong opinion myself but it does seem reasonable
> to be consistent. For what it's worth, Stephen Rothwell checks for
> accidentally added .orig and .rej files in -next (and catches them
> occasionally [1]), so I wouldn't expect removing this to matter much.
> 
> [1]: https://lore.kernel.org/linux-next/?q=.rej

I didn't know that, it's useful information, thanks. I wonder if
checkpatch.pl could also check for that ? Although git-add already
warns unless you specify -f, so people ignoring that may also ignore
checkpatch.pl, I'm not sure.

Who decides on whether this patch should be merged ?

> > ---
> >  .gitignore | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 7902adf4f7f1..58fdbb35e2f1 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -142,7 +142,6 @@ GTAGS
> >  # id-utils files
> >  ID
> >  
> > -*.orig
> >  *~
> >  \#*#
> >  
> > 
> > base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b

-- 
Regards,

Laurent Pinchart

