Return-Path: <linux-kernel+bounces-230750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F75D91816D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497AF1F22951
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9625180A61;
	Wed, 26 Jun 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Gs8TT9xE"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAC1E87C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406384; cv=none; b=bIKTZWkE4pydxrWwioBGfXkHRprnd/Lr0SSv8P31DBykor1F8AsFfBF3m8JCj3+P/JWHVpeV82UXYuxe5YDHDg7NCau649WXMTbD/QOGpQbt5En/CNMlBvDhfKi6Do1/N+9n9xu+ewxNAlp/77roxJQUYwu4Zq9+Q3EKZPQCSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406384; c=relaxed/simple;
	bh=b3NSYr4A7rhOQf7hyJ0eOj0PBbnA5dAe2vjUEtfa54M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAZbleERgIisdjd2aNScKTZwr1C5/Y5VA0l8YLUPJxfZeMA4H8jYvXagyFF/Zr+KeMn1AqzXQDd31gQQy7UkN6ZRzNZq1jUCyoa0PssQmreJIAP2NptReovy34yfAMMW+Fkng961puve0vBfctHNjBqC4BRMnAz15J6FstP9O+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Gs8TT9xE; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1719406372; bh=b3NSYr4A7rhOQf7hyJ0eOj0PBbnA5dAe2vjUEtfa54M=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Gs8TT9xEiVVtFfcByqaWKnR3ZR5eumb3IKTvKB6jdGYEm9aEEKmom8Ij9bb7Aqghk
	 zs90BTjZXmHpqdgH7CRvee/BPOAzixwKcJS9MZrv4eQSjE5Towcmm5TTFh1W6AcvC6
	 zsDP4moX4EyFioxClADoBOO85mzf5FEiN3zIYLjA=
Date: Wed, 26 Jun 2024 14:52:52 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Tejas Vipin <tejasvipin76@gmail.com>, kernel@puri.sm, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, dianders@chromium.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: sitronix-st7703: transition to mipi_dsi
 wrapped functions
Message-ID: <uhjjn5fto22s24vy6gaerhnuqepgc3y6im7mq36dbvdya62m5w@wfjp5qgqym4f>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>, Tejas Vipin <tejasvipin76@gmail.com>, kernel@puri.sm, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, dianders@chromium.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240626045244.48858-1-tejasvipin76@gmail.com>
 <ZnwIrH47Rhcu4zDq@qwark.sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnwIrH47Rhcu4zDq@qwark.sigxcpu.org>

Hi Guido,

On Wed, Jun 26, 2024 at 02:25:16PM GMT, Guido Günther wrote:
> [...]
> > -	ret = ctx->desc->init_sequence(ctx);
> > -	if (ret < 0) {
> > -		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
> > -		return ret;
> > -	}
> > +	ctx->desc->init_sequence(&dsi_ctx);
> 
> Why no return early here in the error case (same for the other cases
> below) giving us an indication which step went wrong?

Return early is hidden in the wrapped *_multi() function calls.

> >  
> > -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> > -	if (ret < 0) {
> > -		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
> > -		return ret;
> > -	}
> > +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> >  
> >  	/* It takes the controller 120 msec to wake up after sleep. */
> > -	msleep(120);
> > +	mipi_dsi_msleep(&dsi_ctx, 120);
> >  
> > -	ret = mipi_dsi_dcs_set_display_on(dsi);
> > -	if (ret)
> > -		return ret;
> > +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> >  
> > -	dev_dbg(ctx->dev, "Panel init sequence done\n");
> 
> Would be nice to keep the debug message.
> 
> > +	if (!dsi_ctx.accum_err)
> > +		dev_dbg(ctx->dev, "Panel init sequence done\n");
> >  
> > -	return 0;
> > +	return dsi_ctx.accum_err;
> >  }
> >  
> >  static int st7703_disable(struct drm_panel *panel)
> >  {
> >  	struct st7703 *ctx = panel_to_st7703(panel);
> >  	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> > -	int ret;
> > +	struct mipi_dsi_multi_context dsi_ctx = {.dsi = dsi};
> >  
> > -	ret = mipi_dsi_dcs_set_display_off(dsi);
> > -	if (ret < 0)
> > -		dev_err(ctx->dev, "Failed to turn off the display: %d\n", ret);
> > +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> 
> Similar to the above: it'd be nice to keep the information which step
> failed.

That's done by the _multi() wrappers.

kind regards,
	o.


