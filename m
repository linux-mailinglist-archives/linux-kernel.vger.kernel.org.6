Return-Path: <linux-kernel+bounces-183300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0228C9753
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A151C208EE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8BB6E5FD;
	Sun, 19 May 2024 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="AnjKfBO/"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F3FBFC
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716158639; cv=none; b=hq25tl2Bao8xvbVXlHtmRi0iUqkrJdn43aksdiQJxJKUta/bZEk5E3/8sJX+0gkVwAZoZvbLTpsTv6NaidJMtZfA7HQ994yHqvyPPD+sSDd5D1fhpQ8GM/hU2RKjF2zGz8rzSCSXnd3gA75OXQx4lUY+qg79eNPxrEdyX+wkdKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716158639; c=relaxed/simple;
	bh=G+F+Hf1AnEf5DA4qW5UvXwr09bdDb5A0NW/n2JXaeQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i06k/GIKqZ12nPmIGW8AieJczWNUXgSpNc+smYWRCD7cgm4Z/Zi0aSQyWDtJTlXN2V7yuqzwg4/dkTXdTudKf80tLg/3kK4uo4tlsggwcLJAMWbuk8PdZx9Dk9q188I6ZLkxeG71te7z4y1CM3hpfF1Jk2GEMmvjhstQa3he+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=AnjKfBO/; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=J3/ioIXhhPl1WkhHdEKeMp+H1rIxu4VfJ+H2RNtKwnA=; b=AnjKfBO/Nebgq+Gr
	chrvfBHUY94HIwTYaudj092q02/oF+gR3Q2LzX/VY9hiEoiPi8jFo3kUl9CJ8rQsri9F43Tgvzdfz
	HDkaOY82DD+dMdyBYQm31RmF6i5pKcWDlXMMyJ0s6ljSfwAAjw0Bxvv3vbAuh4t8kamIvI95wLXuZ
	PBq0MOVwhERb4l919Kuk3kKdzJI2xyvk7gXCTcqE5sPW04SAPc4ihtWo2Qc6MoJgi/ab6unhVsX0B
	bMuDxo5zECrwZpzABBoa4ODiYAzwgSdrv32u7xZIsmEFbx5psAQ9lO9q/sxpCEdLV/wm9+nbf62nt
	5Eoc0Q+qXTlxXmOo7w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s8pFo-001bZi-1W;
	Sun, 19 May 2024 22:43:44 +0000
Date: Sun, 19 May 2024 22:43:44 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <ZkqAoG9ZGg0_dC-9@gallifrey>
References: <20240517232427.230709-1-linux@treblig.org>
 <6tfxkc3foarpfuo6viwmsm4e2ujxjmhpqsku37d4ov6ppufpjr@byrbjs7srqri>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6tfxkc3foarpfuo6viwmsm4e2ujxjmhpqsku37d4ov6ppufpjr@byrbjs7srqri>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:40:28 up 11 days,  9:54,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> On Sat, May 18, 2024 at 12:24:27AM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'bridge_init' is unused, I think following:
> > commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
> > (which is where a git --follow finds it)
> > Remove it.
> 
> Please rephrase the commit message following guidelines in
> Documentation/process. Use Fixes tags if suitable.

I specifically don't want to use Fixes in these set because
there's no need for someone to backport this to older
kernels that use the original, and many backporters
use 'Fixes' as an automated means to find stuff they should
backport.

Other than that, is there something specific you think I've
missed?

(I'm also purposely being less certain here, because --follow
is showing it in a ptn3460 and I don't quite follow
why that changes it here).

Dave

> 
> > 
> > Build tested.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > index df9370e0ff23..1e03f3525a92 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > @@ -36,11 +36,6 @@
> >  
> >  static const bool verify_fast_training;
> >  
> > -struct bridge_init {
> > -	struct i2c_client *client;
> > -	struct device_node *node;
> > -};
> > -
> >  static int analogix_dp_init_dp(struct analogix_dp_device *dp)
> >  {
> >  	int ret;
> > -- 
> > 2.45.1
> > 
> 
> -- 
> With best wishes
> Dmitry
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

