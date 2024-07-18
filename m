Return-Path: <linux-kernel+bounces-256637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF0935159
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A173B22B34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72D1459E2;
	Thu, 18 Jul 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hEluMvje"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C242F877
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721324973; cv=none; b=ji22A9akdEl/CM9+RPSMEE4zr8n/5vLTOC+pM3ZoG8VyDO2fZs234jOucLn90qcbZoBwq0nK3QQYU587zWOrBZMibDAyJY+otnCV/Z1jPsw028OvygcbK/4wUH2s19ytRXzptl6ZEVoifAFuKGnoYCI09PJ6/NCIpTPNRZe1jTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721324973; c=relaxed/simple;
	bh=GG3cmYBj90FbRp7kBVFg2jwR2ny67g3T0+78i1SlIos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvQH+XF50HpJc4DM35ZwYLJwI4yQE2c6+SB2FJ2fotsbb6SFluwxwAmyMfVtcCwAY9ETHMClhGWFkbfWT5ZzIpE1F3voFvXKg3P5Kg2gi04obRPcQMwNNREEpSzRtnpglPuukR//9ve+akMP3zqY5SVp6k3SEvtbm4lCmPr9rjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hEluMvje; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=APE8v24CDfDeTKUllDKgnHGGXJJZJeBkAsUOI8cc6ss=; b=hEluMvjecZ4OxKIQ
	mBoFy9o0g6IOs2BN0jRywV4uZ/P1cijkwXGaAHDzbASbGMQ7dx2v8VdFuoNLdVzoz9VsZO3MhwDar
	e9izJ+SLrswXFaSefq1uDq8q932MNF2Pnab69kMEZJV68C4PBiRQIwTZFoPmNDzdssIXCgn6J+4kw
	NsVBg65EygRefNAO513ekoOPLC9tEQgcvkeRagUog74alI8EiarkQKgcdiccJ4PZeGo/w/bxwb1dy
	U++mWSimunqOHI9LzZehyXgkKOnnHY/BOoALKZvpXnWqWRQTyD1TTsbc4pihLHlwkA/kxHXRYvbeg
	LJeJoj5qN5YDbCt69A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sUVFq-00CLPp-0U;
	Thu, 18 Jul 2024 17:49:22 +0000
Date: Thu, 18 Jul 2024 17:49:22 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <ZplVoj6xAAaMnisJ@gallifrey>
References: <20240520125551.11534-1-linux@treblig.org>
 <g4nwb5cgcg2wff4qogzayhdrj3omneeusfjqmdupghy6zlji5m@kp55dmkbj6k3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <g4nwb5cgcg2wff4qogzayhdrj3omneeusfjqmdupghy6zlji5m@kp55dmkbj6k3>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:48:31 up 71 days,  5:02,  1 user,  load average: 0.06, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> On Mon, May 20, 2024 at 01:55:51PM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
> > has dropped all the users of the struct bridge_init from the
> > exynos_dp_core, while retaining unused structure definition.
> > Later on the driver was reworked and the definition migrated
> > to the analogix_dp driver. Remove unused struct bridge_init definition.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Hi Dmitry,
  Do you know who is likely to pick this one up?  I think all
my other drm patches have found their way into -next.

Thanks,

Dave

> 
> -- 
> With best wishes
> Dmitry
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

