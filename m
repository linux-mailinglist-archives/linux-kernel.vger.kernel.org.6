Return-Path: <linux-kernel+bounces-182692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F168C8E86
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4571281D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A802E1419AA;
	Fri, 17 May 2024 23:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="IlOm3EsP"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71443ACA
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988852; cv=none; b=RwYG6zDTU1a+oheANByK14926UxMFz1i9eZQSVhWHbe3RxubUtmVKQpquF6jqLH1ZQ4STq2X6IVAcnKtUuHgTZEBcDguJLMrPOk548/7P9tDhhXg5EsJBIhl5HJCnUIs+8QRYcm6TXpf4tNdG0ns/PTj1ykKn2GrnhuTe0AmjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988852; c=relaxed/simple;
	bh=8DPhNaqe/N6w9oI+xj9s51m1FI5ST+027Bbd814DH9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPy7oQZC3g3LXxPVGZPTY5cvqLmbkLAqOx3ETIzIi9H1lke1KbS5Ri3cVq6d7iWmU73/ZbAiG97cMypfbiUsRvSmAg2axAeYx05ZRAB2NgDs9STbS5z6qd0HBgpkR/Y4YQPBKSpgBZVK5vUCFn9OnCCcBcdXwBHnWMWYjXcAp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=IlOm3EsP; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=tpXjH4wlI2gDEjHISCa0fJRzaI47j+Q15Jmn84/q5X8=; b=IlOm3EsPRkxGH6We
	T38EbWVr44PtyzFKIMsFIiAedB9vaeWKKEwxUlQICYGUeuEu42b4qw+WJVdQVnVuBWo0rKDydqqe9
	eQVGiPLf031INCWKiz5kXyCZabNAxJSGtqIkE0H/lhEkfnGnhoXjlCKjhTVq6TaJjH+e2QeCbueFN
	ZqSCJ5HNZJ9WbCb+mWrEizT37PkhXIhFlHp7B1cAJ+Mlh1Vt77f+P6HsQzYI/sgZTwAGKn/jTlX3q
	DA4efTeUoudxNrsEpxkS265YBGdJSQd6aO8eifez4vTJu4Zy1dtq09H5obggWcTZXU87HadEYpGI9
	GURs83BmyfydDd01kQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s875R-001ToB-1x;
	Fri, 17 May 2024 23:34:05 +0000
Date: Fri, 17 May 2024 23:34:05 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org
Cc: maarten.lankhorst@linux.intel.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <ZkfpbdOu9m41S1b1@gallifrey>
References: <20240517232427.230709-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240517232427.230709-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:33:35 up 9 days, 10:47,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

(oops the patch numbering in these 3 are wrong, they're all independent
patches)

Dave

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'bridge_init' is unused, I think following:
> commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
> (which is where a git --follow finds it)
> Remove it.
> 
> Build tested.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index df9370e0ff23..1e03f3525a92 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -36,11 +36,6 @@
>  
>  static const bool verify_fast_training;
>  
> -struct bridge_init {
> -	struct i2c_client *client;
> -	struct device_node *node;
> -};
> -
>  static int analogix_dp_init_dp(struct analogix_dp_device *dp)
>  {
>  	int ret;
> -- 
> 2.45.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

