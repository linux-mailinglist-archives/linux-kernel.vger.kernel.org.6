Return-Path: <linux-kernel+bounces-186379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815A8CC373
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F351F21A39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497161BDD0;
	Wed, 22 May 2024 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="v/oyrv0K"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AE1A29A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389060; cv=none; b=UzV+2swjeO5cUrtGnMerq4oTk+b5qnil3poMzFzpXVpJENFwalm4oNAYGzJsBk+03cOti1ho7E5vXxW3neF+oV6fkcasVZGhInnvJIqRzgrrrjA2a2/f5qCT8o7vC2mcm0Lx5srfdDHnPlGAnvGp8PxqFpzmnSg8LliE82gDw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389060; c=relaxed/simple;
	bh=Wrhas7+z7n060qrEQIfs83yAi9030U03bjQ2PFmw0J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGMUauPOwO3+YBSA3Ir4hVyXkz+BdkC2ZQTahRnB4BNDIinASARxlMIbu+2VLUaaM9ruYHHhYwnuJ1WR+0mwDMag47OPASc0ZyiPz+MqVfJAL3z5cumJar3JOlqUdkOc5RvxhGacAp4voJN7KEtKWdlfHmpWg/Wj5FK3Uz9zOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=v/oyrv0K; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF99AABE;
	Wed, 22 May 2024 16:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716389038;
	bh=Wrhas7+z7n060qrEQIfs83yAi9030U03bjQ2PFmw0J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v/oyrv0KILjs8z/brlz+dJvcaKKT7YhWyIzKEZPsbAHemOkYKMea/pcWGhPj8Gysg
	 BWvgv3FD1uCKD74pb/o2afPBTPtcrjssf9oZ3rDmIj3AksK/3kgzWI6CWbhhGPTjmV
	 i6hDsXbKfMpHeL2JYrC7gyoYGi63As6BuhFFv4Xo=
Date: Wed, 22 May 2024 17:44:01 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, michal.simek@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Subject: Re: [PATCH] drm: xlnx: zynqmp_disp: Fix WARN_ON build warning
Message-ID: <20240522144401.GA9789@pendragon.ideasonboard.com>
References: <20240521142814.32145-2-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240521142814.32145-2-palmer@rivosinc.com>

Hi Palmer,

(CC'ing Anatoliy)

Thank you for the patch.

On Tue, May 21, 2024 at 07:28:15AM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Without this I get warnings along the lines of
> 
>     drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: error: logical not is only applied to the left hand side of this comparison [-Werror,-Wlogical-not-parentheses]
>       949 |         if (WARN_ON(!layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE)) {
>           |                     ^            ~~
>     arch/s390/include/asm/bug.h:54:25: note: expanded from macro 'WARN_ON'
>        54 |         int __ret_warn_on = !!(x);                      \
>           |                                ^
>     drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: note: add parentheses after the '!' to evaluate the comparison first
>     drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: note: add parentheses around left hand side expression to silence this warning
> 
> which get promoted to errors in my test builds.  Adding the suggested
> parens elides those warnings.

I think this should have

Fixes: b0f0469ab662 ("drm: xlnx: zynqmp_dpsub: Anounce supported input formats")

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405080553.tfH9EmS8-lkp@intel.com/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I couldn't find a patch for this in Linus' tree or on the lists, sorry
> if someone's already fixed it.  No rush on my end, I'll just stash this
> in a local branch for the tester.
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 13157da0089e..d37b4a9c99ea 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -981,7 +981,7 @@ u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
>  	unsigned int i;
>  	u32 *formats;
>  
> -	if (WARN_ON(!layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE)) {
> +	if (WARN_ON((!layer->mode) == ZYNQMP_DPSUB_LAYER_NONLIVE)) {

That doesn't seem right. layer->mode isn't a boolean, it's an enum. The
right fix seems to be

	if (WARN_ON(layer->mode != ZYNQMP_DPSUB_LAYER_NONLIVE)) {

Anatoliy, could you check this ? Palmer, do you plan to submit a new
version of the patch, or should I send the right fix separately ?

>  		*num_formats = 0;
>  		return NULL;
>  	}

-- 
Regards,

Laurent Pinchart

