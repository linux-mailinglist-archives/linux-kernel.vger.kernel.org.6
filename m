Return-Path: <linux-kernel+bounces-360995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2C99A225
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B332876DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E2213EC9;
	Fri, 11 Oct 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="LDqP8meK"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DD1E3DC0;
	Fri, 11 Oct 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644243; cv=none; b=aYCsi0k7EwdWTqqauIObaRlwuD3OQBje/6lWyIUjnoNWMHB6FAnPbi2OV5vBnjlH+4RZtWz8FK9N1f47U9CCOdVvoOTx9gJFiHJ/KeH9XwPsArqWlz3203xSJikZPos/1nUSLc+MLGwewvxUjzIdlpSaIPcrl6YcrFWUEbPQ56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644243; c=relaxed/simple;
	bh=mnkksVx2Xxyxhko4Q7iJCbRLxEhP+89tZTZn5w/HAiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7xuUj+8gj16G37aUAJ5IHHvlOgNzz+SS+GpcTIPal9k8v5aKqY6mrMr9jHQSf2qNw0rLnv9WEHQTjM0a6i54QAuFDAkVXGf3TEuGF6/M3EELcRqw6Hi+jCPnu/jenvjzaCbJLe+M2vN9KOEBQ9All18wSVyNiJdx986OI8tKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=LDqP8meK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=WyUU7HyfsDsDc16P/YLUuRui/IhSHQhUa6UHKkM8cSA=; b=LDqP8meKMsgdAOyr
	zyW8TibS5uAC7LxtAhHWduU+fo6GdtodbKsX5SQqFO8jQHiv7yRMcyEh8ADj0FXV+h3oqGE6fSq+z
	IZdQ1Pwh5PyOUDDHpJRcc7Ivv0XHAUwoSbClHPFBXo+tOFp1zQvS0MEmAGgccv+OIrytA/sUOXSBb
	ALaubGnzuS82fwwZ7WFKRtFgeDw9xIZpK+IumWd7eW1+u5NrOGGyOqjFzFoXemZielsAwITUD2+s3
	Pxa/GOuWR05yt9SRSpIGXeSxA20wbL704QcG8X5MEBdooilnkSmNStzC7xnj5l7eJj2H2XnX0zPyb
	jLErUfRCfHx4RTPrnA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1szDKY-00AUHy-1o;
	Fri, 11 Oct 2024 10:57:10 +0000
Date: Fri, 11 Oct 2024 10:57:10 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: core: Remove unused copy_from_user_toio
Message-ID: <ZwkEhsYvaEHW_Czd@gallifrey>
References: <20241010205340.278133-1-linux@treblig.org>
 <87o73rm29d.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87o73rm29d.wl-tiwai@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 10:56:56 up 155 days, 22:10,  1 user,  load average: 0.03, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Takashi Iwai (tiwai@suse.de) wrote:
> On Thu, 10 Oct 2024 22:53:40 +0200,
> linux@treblig.org wrote:
> > 
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > copy_from_user_toio() has been unused since commit
> > ce2d8ed8d809 ("ASoC: qcom: Convert to generic PCM copy ops")
> > 
> > Remove it.
> 
> It's a pair of copy_to_*(), so if any, it should be dropped only after
> both users are gone.

OK, fair enough.

Dave

> 
> thanks,
> 
> Takashi
> 
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  include/sound/core.h |  1 -
> >  sound/core/memory.c  | 20 --------------------
> >  2 files changed, 21 deletions(-)
> > 
> > diff --git a/include/sound/core.h b/include/sound/core.h
> > index 1f3f5dccd736..b5a6f3d2bff5 100644
> > --- a/include/sound/core.h
> > +++ b/include/sound/core.h
> > @@ -267,7 +267,6 @@ static inline int snd_minor_info_oss_init(void) { return 0; }
> >  /* memory.c */
> >  
> >  int copy_to_user_fromio(void __user *dst, const volatile void __iomem *src, size_t count);
> > -int copy_from_user_toio(volatile void __iomem *dst, const void __user *src, size_t count);
> >  
> >  /* init.c */
> >  
> > diff --git a/sound/core/memory.c b/sound/core/memory.c
> > index 2d2d0094c897..8222a851da87 100644
> > --- a/sound/core/memory.c
> > +++ b/sound/core/memory.c
> > @@ -63,26 +63,6 @@ int copy_to_iter_fromio(struct iov_iter *dst, const void __iomem *src,
> >  }
> >  EXPORT_SYMBOL(copy_to_iter_fromio);
> >  
> > -/**
> > - * copy_from_user_toio - copy data from user-space to mmio-space
> > - * @dst: the destination pointer on mmio-space
> > - * @src: the source pointer on user-space
> > - * @count: the data size to copy in bytes
> > - *
> > - * Copies the data from user-space to mmio-space.
> > - *
> > - * Return: Zero if successful, or non-zero on failure.
> > - */
> > -int copy_from_user_toio(volatile void __iomem *dst, const void __user *src, size_t count)
> > -{
> > -	struct iov_iter iter;
> > -
> > -	if (import_ubuf(ITER_SOURCE, (void __user *)src, count, &iter))
> > -		return -EFAULT;
> > -	return copy_from_iter_toio((void __iomem *)dst, &iter, count);
> > -}
> > -EXPORT_SYMBOL(copy_from_user_toio);
> > -
> >  /**
> >   * copy_from_iter_toio - copy data from iov_iter to mmio-space
> >   * @dst: the destination pointer on mmio-space
> > -- 
> > 2.47.0
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

