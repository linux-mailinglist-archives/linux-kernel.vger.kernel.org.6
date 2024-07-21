Return-Path: <linux-kernel+bounces-258340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C1C93868D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 00:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79911B20C4F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E2A10A0D;
	Sun, 21 Jul 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sZYt+xRX"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D3322E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721602247; cv=none; b=HP/w5JeyOgDmdYyuocw5r+nofBHfJpTwOovVb21xMMUeqYPGnB8cv9vkejCnGr+HlgqbPp7dTxW7w6SrM6EgcXHH6IRthJj3vRRiXBOKnCxDJUljkbau+wiVpyeLBS9w38wD+Di7bWW+OZw7DY6jRB/i40WGH5O2sror1yxffeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721602247; c=relaxed/simple;
	bh=v2UNyep4THUJg1xVgMlOoqxyGwmDDXwWOdwE9FmYaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCTPtK33Fj0XpK+6rwdgiHgA0IE+ZNAb9bgBOl3lyXk5f7Jf44iK5xV2ovEnThgzETrUaEPEis/wNKkh1YxjtLgiWGxSP7qoqyphieHsyL8PWjm8vAshzwi1ORUtG66xqKlYK3ImQchdpyxDTjFr2CwsMyU9lkcbqB5e0TWwfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sZYt+xRX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Z6+tcN90xgP1nrdUqmcA2EVQqwgriS18uB284QzrNV8=; b=sZYt+xRXyyak1MyM
	64csFKH7xecno+beGEc3djBlikJSVwnhgbgvf+1f0Ta76xnsjo8cTH3QbN0n3yNNZ9PH+qsB1vT+p
	zoXd5duXuwev5q18Dr8EElP6ISUxu18cV0jc1PdQIxgte5dLFA0TBi//kDkHyJFRXgUjwBm7hoISb
	HJBYpDqeFY8jtPSRGKIKEJMGyE14QFvdJObCfoRIoSGCsbsoxD90HrnmYoey3QdaQ6a0b0ENuYB7+
	M3logoeTMaXttN+dxlZdVUSY7lfQJMv15FoUL2ol8DXA3f78rEmE4HUaKwwI9Tu1u0tMYTY1Sclcq
	sm0HmC6wFAR1okcupQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sVfNt-00CdQr-04;
	Sun, 21 Jul 2024 22:50:29 +0000
Date: Sun, 21 Jul 2024 22:50:28 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: camelia.groza@nxp.com, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/fsl/qbman: remove unused struct 'cgr_comp'
Message-ID: <Zp2QtPET9649y9pA@gallifrey>
References: <20240528231123.136664-1-linux@treblig.org>
 <336239e6-4369-44ea-a60c-d300cf6e6f81@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <336239e6-4369-44ea-a60c-d300cf6e6f81@linux.dev>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:49:30 up 74 days, 10:03,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Sean Anderson (sean.anderson@linux.dev) wrote:
> On 5/28/24 19:11, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'cgr_comp' has been unused since
> > commit 96f413f47677 ("soc/fsl/qbman: fix issue in
> > qman_delete_cgr_safe()").
> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/soc/fsl/qbman/qman.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> > index 7e9074519ad2..4dc8aba33d9b 100644
> > --- a/drivers/soc/fsl/qbman/qman.c
> > +++ b/drivers/soc/fsl/qbman/qman.c
> > @@ -2546,11 +2546,6 @@ int qman_delete_cgr(struct qman_cgr *cgr)
> >  }
> >  EXPORT_SYMBOL(qman_delete_cgr);
> >  
> > -struct cgr_comp {
> > -	struct qman_cgr *cgr;
> > -	struct completion completion;
> > -};
> > -
> >  static void qman_delete_cgr_smp_call(void *p)
> >  {
> >  	qman_delete_cgr((struct qman_cgr *)p);
> 
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

Hi Sean,
  Do you know who will pick this one up?
  I got a notification a while ago from a patchwork at
  linuxppc-dev marked 'Handled elsewhere' - but I'm not
sure where.

Thanks,

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

