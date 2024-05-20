Return-Path: <linux-kernel+bounces-183769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3078E8C9DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4106F283F90
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407113440A;
	Mon, 20 May 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eda2OZxY"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910A134402
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716209864; cv=none; b=sOmGIcbINqsNFc9USS7wiAnZX0r4FF61Kr1Qr/eYVgz1nG+MB3cARr1z8Um2QNqnQZsgatuccum6yQtmgA8TIAXaNnPppoKhLvGEk+wPOroRfSIlFPRjHLNh3cHE7nz5FMAarZtX7zkYTct6ExLoJsFEFTtQUykovoEnmfq4Vl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716209864; c=relaxed/simple;
	bh=TYI55Sikfz3oeSTitZ7AEvAnVkIXHlaDzYbGrBFX70w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPkLsnw3RKQ+nPy/SzeRadwr9ikGBqVl6jSIDQXJTGvq1SQeOXihzn+T3HK3nw1A26fsaLvc7QYHOGDQg9EpLt19hL1bViHsHD7pKxyR4N8CJGA1Y8TV7eaFRF7oHC8jlsViD/WW8UkhGGlrb+BEZ6bqbj0PMsgVeSsJP0R4mRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eda2OZxY; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=FC82UVm0nxuHlkVFmwyybG3PQLsRDR21pe9bb6BPHdU=; b=eda2OZxYl8OiNQHS
	VtHxZlq2kddk2ePPDL7FY0UQ+TmTixzqliTNw2ZEChfdtaZSeshkyN2gZ28XshpU9zjTcr4b/KXdL
	jYQM0r3Nw8CiZ0A3+TWpor7FuLBBhAg9xbLzYiMqFNnJxjAjxmV7/vxT8oRsNXWJ8ftK4FbIVAlje
	DPrwSKD3ImxaKAoFjAIv0bTKraq7qa8kcFAhm8y0DOVA9q1Tv4TBWKGci5njpm8lIuJnhcJq+7n7f
	CJbCVvFGtXtAv+p9dcmra1P5DzH96jpNV5+H16olnDel8hNpw3WPEdzN1X2j2ceySqyYjIn9rMf2s
	8JzAOT8w0d2jj50evg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s92a8-001g5e-0T;
	Mon, 20 May 2024 12:57:36 +0000
Date: Mon, 20 May 2024 12:57:36 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <ZktIwMWtQXuxCgRN@gallifrey>
References: <20240517232427.230709-1-linux@treblig.org>
 <6tfxkc3foarpfuo6viwmsm4e2ujxjmhpqsku37d4ov6ppufpjr@byrbjs7srqri>
 <ZkqAoG9ZGg0_dC-9@gallifrey>
 <la43b5ra7aziiv7dwt4o5zha3px7jarfmk45dwsf24qn6pgcre@pcmcsicjdrus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <la43b5ra7aziiv7dwt4o5zha3px7jarfmk45dwsf24qn6pgcre@pcmcsicjdrus>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:56:59 up 12 days, 11 min,  1 user,  load average: 0.06, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> On Sun, May 19, 2024 at 10:43:44PM +0000, Dr. David Alan Gilbert wrote:
> > * Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> > > On Sat, May 18, 2024 at 12:24:27AM +0100, linux@treblig.org wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > 
> > > > 'bridge_init' is unused, I think following:
> > > > commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
> > > > (which is where a git --follow finds it)
> > > > Remove it.
> > > 
> > > Please rephrase the commit message following guidelines in
> > > Documentation/process. Use Fixes tags if suitable.
> > 
> > I specifically don't want to use Fixes in these set because
> > there's no need for someone to backport this to older
> > kernels that use the original, and many backporters
> > use 'Fixes' as an automated means to find stuff they should
> > backport.
> > 
> > Other than that, is there something specific you think I've
> > missed?
> 
> It's not about missing things. It's about a way it is written.
> Consider something like:
> 
> The commit aaaaaaa ("drm/bridge: foo bar") has dropped all the users of
> the struct bridge_init from the exynos_dp_core, while retainng unused
> structure definition. Later on the driver was reworked and the
> definition migrated to the analogix_dp driver. Remove unused struct
> bridge_init definition.

OK, v2 sent with text close to that.

> 
> > 
> > (I'm also purposely being less certain here, because --follow
> > is showing it in a ptn3460 and I don't quite follow
> > why that changes it here).
> 
> The mentioned commit is a correct one. Historically exynos_dp_core had
> been creating the ptn3460 bridge manually. Later on this was fixed in
> the ptn3640 driver and the code was dropped from exynos_dp_core.

Ah OK; remember I don't know the actual structure of these devices
or the history.

Dave

> > 
> > Dave
> > 
> > > 
> > > > 
> > > > Build tested.
> > > > 
> > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > > ---
> > > >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 -----
> > > >  1 file changed, 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > > > index df9370e0ff23..1e03f3525a92 100644
> > > > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > > > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > > > @@ -36,11 +36,6 @@
> > > >  
> > > >  static const bool verify_fast_training;
> > > >  
> > > > -struct bridge_init {
> > > > -	struct i2c_client *client;
> > > > -	struct device_node *node;
> > > > -};
> > > > -
> > > >  static int analogix_dp_init_dp(struct analogix_dp_device *dp)
> > > >  {
> > > >  	int ret;
> > > > -- 
> > > > 2.45.1
> > > > 
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry
> > -- 
> >  -----Open up your eyes, open up your mind, open up your code -------   
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> 
> -- 
> With best wishes
> Dmitry
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

