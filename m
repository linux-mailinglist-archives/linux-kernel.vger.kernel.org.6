Return-Path: <linux-kernel+bounces-384826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1B9B2EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9661F224CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897941CF2A3;
	Mon, 28 Oct 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HzpyWrqP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97B18C91F;
	Mon, 28 Oct 2024 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114957; cv=none; b=uSu+Zm0+tMLKZHnXva6kaaWEhV3TRE0H9hk4e/l5/SeJJeMjnZ2wC0DemYFAU085I3Y/cB/5rLBIO0ndoiNxmg46+tXRlZXXtRwVWE+xY0gSD4oWtZCThc4VFAt8F0onL7nYNRiy6Bb77zdEfSVGQ+aXCRrZWWX7LFdyMqaKRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114957; c=relaxed/simple;
	bh=DCtJ5HW9wfc2GrhVDWw44uFxf+d5EMOaqW910++IUbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biSEGwiIUzWnM9zDVHf1rbL7s59FO0cs48Rb728IIIwonHLngkVmS56UFs01J0EnRGfRVQYbkJ5k8OCdCI9sBLr2waOQAzFkpkXK5sRSdBG1zvGxGmUDa43n7GS4heul/JI9mLT1pNeSrjWKtenMcra2IFHXGITAVqaJUUuZ7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HzpyWrqP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 487231A7D;
	Mon, 28 Oct 2024 12:29:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730114942;
	bh=DCtJ5HW9wfc2GrhVDWw44uFxf+d5EMOaqW910++IUbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzpyWrqPopJ2t02+Kjy5R1wCQtBEhlazs51FpL4fwy+ifQai+4Tn+0+2U9yBPPpjG
	 noE7Rxom/stFgPdM0uP+EgQmmOfgPbL8fyyhQ1a0fXcAM2Jc6vvvl7NM4JcnSZXq8U
	 T8OMTb2hr/8KDzDys2XDcmQf0q4La34FGgNCBOHI=
Date: Mon, 28 Oct 2024 13:28:57 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241028112857.GF24052@pendragon.ideasonboard.com>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-3-herve.codina@bootlin.com>
 <20241027162350.GA15853@pendragon.ideasonboard.com>
 <20241028091331.6f67e29e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028091331.6f67e29e@bootlin.com>

On Mon, Oct 28, 2024 at 09:13:31AM +0100, Herve Codina wrote:
> Hi Laurent,
> 
> On Sun, 27 Oct 2024 18:23:50 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> 
> [...]
> > > +static int sn65dsi83_reset_pipeline(struct sn65dsi83 *sn65dsi83)
> > > +{
> > > +	struct drm_device *dev = sn65dsi83->bridge.dev;
> > > +	struct drm_modeset_acquire_ctx ctx;
> > > +	struct drm_atomic_state *state;
> > > +	int err;
> > > +
> > > +	/* Use operation done in drm_atomic_helper_suspend() followed by
> > > +	 * operation done in drm_atomic_helper_resume() but without releasing
> > > +	 * the lock between suspend()/resume()
> > > +	 */
> > > +
> > > +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> > > +
> > > +	state = drm_atomic_helper_duplicate_state(dev, &ctx);
> > > +	if (IS_ERR(state)) {
> > > +		err = PTR_ERR(state);
> > > +		goto unlock;
> > > +	}
> > > +
> > > +	err = drm_atomic_helper_disable_all(dev, &ctx);
> > > +	if (err < 0)
> > > +		goto unlock;
> > > +
> > > +	drm_mode_config_reset(dev);
> > > +
> > > +	err = drm_atomic_helper_commit_duplicated_state(state, &ctx);  
> > 
> > Committing a full atomic state from a bridge driver in an asynchronous
> > way seems quite uncharted territory, and it worries me. It's also a very
> > heavyweight, you disable all outputs here, instead of focussing on the
> > output connected to the bridge. Can you either implement something more
> > local, resetting the bridge only, or create a core helper to handle this
> > kind of situation, on a per-output basis ?
> 
> A full restart of the bridge (power off/on) is needed and so we need to
> redo the initialization sequence. This initialization sequence has to be
> done with the DSI data lanes (bridge inputs) driven in LP11 state and so
> without any video stream. Only focussing on bridge outputs will not be
> sufficient. That's why I brought the pipeline down and restarted it.

Fair point.

> Of course, I can copy/paste sn65dsi83_reset_pipeline() to a core helper
> function. Is drm_atomic_helper_reset_all() could be a good candidate?

The helper should operate on a single output, unrelated outputs should
not be affected.

-- 
Regards,

Laurent Pinchart

