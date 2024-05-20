Return-Path: <linux-kernel+bounces-184202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8D8CA3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D372823B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF574139CE6;
	Mon, 20 May 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="I+elryIQ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7813957D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241623; cv=none; b=TKzo75ZZMxL9WcoShILdNVC+dINoyz+cctcvAVckLoA9dVKYfGg9l7tHEm91e389EiwJIDCMv62IR7kPZVJQ/HUzmMmxGua602sxNXofO2ArKDyxfr1nltekcicTyVDCHQBNyzXxXzqGydVbsm9czVzZc6mn2fSZDvFhAM/uAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241623; c=relaxed/simple;
	bh=OBZ4UnVND23iZdDbBUolowsdzICqIrrs4UwZjORzYCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX3ROl8wXXUrCjNREq5ENY8dUYOyzuGMl15YRhcG4cLyJ3FcMgR2wKp47XqwbHITptFwakJoEhYUy6u/z6Nn+j9HWOAKcZFaYwx7mkCohlv/okAz6+g6KesfCWaXWU0zjGol2RKtB8zESOgGQNkaA0O9TTfONddw6S/MTvG8sVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=I+elryIQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Ok5RVEZ0HFuT4YkDoWBUQzZ5XHrTvxopGdB43fRXSDw=; b=I+elryIQDN1KMFwI
	lM+qjHXCmooMXEAmrrEfv2BaTamydwp6zBBRvPqEp3t8HpoooKab8Tij1KYrLq3IaH0MKe2QcmOkh
	qTbKylHDrYCVcnDFItxmXAshZuKHt4rOwPhdsXLeiEoYodJ+XYp3z5vgu5zKRCqR5NtJaQ04xHtRL
	RO2GlOCTnBrbi1bG3LRIPmBgjewPszTT/ruPGs4sbU0PabqPbVR6KmAxXFKz6N0tPxLeVEqXWrqJ/
	e+IAue8XcMBo7a9DBOCPHoXUb3KX2IEz3VQTrf+i5SBapd4Jh6GClabbiGQzzYKB5D3Yt4+Uke0G3
	27Gm68Z/TiDvgcKx0Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s9AqM-001kya-0c;
	Mon, 20 May 2024 21:46:54 +0000
Date: Mon, 20 May 2024 21:46:54 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <ZkvEzg0GQTl1nE9u@gallifrey>
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
X-Uptime: 21:46:41 up 12 days,  9:00,  1 user,  load average: 0.00, 0.00, 0.00
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

Thanks.

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

