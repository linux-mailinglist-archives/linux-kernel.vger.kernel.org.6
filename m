Return-Path: <linux-kernel+bounces-290888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10984955A8D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 03:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120711C20AD1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EDF442C;
	Sun, 18 Aug 2024 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOmCPPvp"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D62900
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723945452; cv=none; b=ZEvDZ06y9mPQYH+ep35iAwaUm1dlTkZprF4mCT/f3NlLJzfyJaMk5gfAkVWPFZBtvuud2uzyvcsCcTo4Gf/9iy2mLirlhrjQVH081jFcrQMLQqiDaPHMz49A4oIDu6fjbMIxdWZJ2ewPZ/7uSuuT4m/AaGoEwRp67vf1nr8iQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723945452; c=relaxed/simple;
	bh=mt+js9gJ4yLNeNtORjx4zzVsM9epzUgTtUBxgpv0jMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/kzDVAAUkDbD9nXFulITpLlr2awSmeMp4tpEdngNdgNIrFIrOeIQqKYz0z9fvBaQVIRVdPwUnbHVLg+V3MTTEB4M7IrUqDRgUwh8rGn8H4gFfvbqUr9zOsZauSBOGFlvsnSv0WW2iaYNTVNsXOHG8KYw8Zy5+3HaxzO2+0c37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EOmCPPvp; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Aug 2024 19:43:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723945446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsmCRvD6tamXf0Qz1t9iwGkiMlbd413+tGXPImjhPFc=;
	b=EOmCPPvpQHiha90GjZPgX6p2yoh5tuKE0SPfehWGjSLsF0VETqNBDAmjI0d1TGkYkJfvqJ
	15F+keZdFix6JUEjZYc6Gq0Hz7YpGJhICi7wTGr9Ou1TkddvXnEva8U+QB5fJn2/9b6Gkq
	Ge0X+ylNuq+jKiqyKut13C1Sd2+e21w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jose Fernandez <jose.fernandez@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Christian Heusel <christian@heusel.eu>, 
	Nathan Chancellor <nathan@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Peter Jung <ptr1337@cachyos.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: add debug package to pacman PKGBUILD
Message-ID: <eiljecw4snqa3kfg45hqxllzlgruexc5p5vegkbjx7bgtizavr@sk4657c3jgom>
References: <20240817151147.156479-1-jose.fernandez@linux.dev>
 <0dbfa069-a931-416d-ac1f-e9ceaee96b80@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dbfa069-a931-416d-ac1f-e9ceaee96b80@t-8ch.de>
X-Migadu-Flow: FLOW_OUT

On 24/08/17 07:15PM, Thomas Weißschuh wrote:
> On 2024-08-17 09:11:47+0000, Jose Fernandez wrote:
> > Add a new debug package to the PKGBUILD for the pacman-pkg target. The
> > debug package includes the non-stripped vmlinux file, providing access
> > to debug symbols needed for kernel debugging and profiling. The vmlinux
> > file will be installed to /usr/src/debug/${pkgbase}. The debug package
> > will be built by default and can be excluded by overriding PACMAN_EXTRAPACKAGES.
> > 
> > Signed-off-by: Jose Fernandez <jose.fernandez@linux.dev>
> > Reviewed-by: Peter Jung <ptr1337@cachyos.org>
> > ---
> > v1->v2:
> > - Use the new PACMAN_EXTRAPACKAGES [1] variable to allow users to disable the
> > debug package if desired, instead of always including it.
> > 
> > [1] https://lore.kernel.org/lkml/20240813185900.GA140556@thelio-3990X/T/
> > 
> >  scripts/package/PKGBUILD | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
> > index fbd7eb10a52c..d40d282353de 100644
> > --- a/scripts/package/PKGBUILD
> > +++ b/scripts/package/PKGBUILD
> > @@ -5,7 +5,7 @@
> >  pkgbase=${PACMAN_PKGBASE:-linux-upstream}
> >  pkgname=("${pkgbase}")
> >  
> > -_extrapackages=${PACMAN_EXTRAPACKAGES-headers api-headers}
> > +_extrapackages=${PACMAN_EXTRAPACKAGES-headers api-headers debug}
> >  for pkg in $_extrapackages; do
> >  	pkgname+=("${pkgbase}-${pkg}")
> >  done
> > @@ -106,6 +106,15 @@ _package-api-headers() {
> >  	${MAKE} headers_install INSTALL_HDR_PATH="${pkgdir}/usr"
> >  }
> >  
> > +_package-debug(){
> > +	pkgdesc="Non-stripped vmlinux file for the ${pkgdesc} kernel"
> > +	depends=(${pkgbase}-headers)
> > +
> > +	cd "${objtree}"
> 
> This should make use of _prologue() from 
> "kbuild: pacman-pkg: move common commands to a separate function"
> 
> https://lore.kernel.org/lkml/20240816141844.1217356-1-masahiroy@kernel.org/
> 
> It's not yet part of the kbuild tree, but I guess will be soon.

Ack. I'll wait for that to be merged before I send out v3.

> > +	mkdir -p "$pkgdir/usr/src/debug/${pkgbase}"
> 
> The mkdir shouldn't be necessary, as install -D is used.
> 
> > +	install -Dt "$pkgdir/usr/src/debug/${pkgbase}" -m644 vmlinux

I'll remove the mkdir line in v3.

> Can you also add a symlink to /usr/lib/modules/$(uname -r)/build/vmlinux
> for compatibility with the vanilla package?

Yes, will do.

> > +}
> > +
> >  for _p in "${pkgname[@]}"; do
> >  	eval "package_$_p() {
> >  		$(declare -f "_package${_p#$pkgbase}")
> > 
> > base-commit: 869679673d3bbaaf1c2a43dba53930f5241e1d30
> > -- 
> > 2.46.0
> > 

