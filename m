Return-Path: <linux-kernel+bounces-330477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA8E979F14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D181C231FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73E14B965;
	Mon, 16 Sep 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEzADLZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FF14AA9;
	Mon, 16 Sep 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481739; cv=none; b=As4i6rSg9CiVUQQD6M3b22MUXtrDpLBMSsGRr0f1dyP2C8zC5XaJrsKhpYXM+4KswsSRJQ5uJqu4Gu13byUrMov3JTxtOqmbchkWKrXJ2kAukMVdO85spYtQ1Uinic0Y4N8h4qYKIjOevXGa7nW/OIaFakKGGI0H5AOff2q65Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481739; c=relaxed/simple;
	bh=0TWt/E9h071v0SXzRGXM9nnf0J/m4R13yaLwwe6bf10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+7kzz6O9KfEz0M/QNS/gv/YF9DYWw3h14EVO2YW7MTZkto+HMaVg3sxwE5ZGyBTBssAJzUqPNTV18pDRL6dMAGUNyuz11pyZ785RmRH5DrqvpFoqg5djTSGl1xGNL5+l9/zWWmOLAaSNAIrejz6Q8tsp4UkRQ3jSmD6cp0msKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEzADLZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC5AC4CEC4;
	Mon, 16 Sep 2024 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726481738;
	bh=0TWt/E9h071v0SXzRGXM9nnf0J/m4R13yaLwwe6bf10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEzADLZ4RGCV0L+G+Czd2Xd5vHF6iwN2UjHqi6a0RWxck6/GVtjtyJytxOUXYAZgI
	 RVq9FGPCuNz7fMzCfziql9jlUXZxovU3wl4PRQknhuzdv3iecp6sMRXKFBypyBL1xs
	 gi9kpVI2+DoiKDz9LHQQ34nqYFJXMCocl8PRGALFkrk+fzUXClvR87gfuL6a7asDJZ
	 2I2yHLU6Q2t6yxs9C8rXY+geuDoexSKSFVuKehzuPQEULVrtyxdZzZ6lD5Qwi1rBhn
	 9azIrJbRenzWIXAcAaAYPWaIoElENeqbCqfj5T2m2QtsrVTSfz+Y4T5nNEYUJER/HL
	 WQWEP+5Gr2FMQ==
Date: Mon, 16 Sep 2024 12:15:32 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] drm/i915: Fix typos
Message-ID: <gamwfgmreryzvy6fazduxs4z3sfjxck7xmsho4elpemcf7llpl@epzlqmudvrzx>
References: <20240915120155.101395-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915120155.101395-1-algonell@gmail.com>

Hi Andrew,

On Sun, Sep 15, 2024 at 03:01:55PM GMT, Andrew Kreimer wrote:
> Fix typos in documentation.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Because we are receiving lots of typos patches in this period,
it's nice to have the context written in the subject, e.g., in
this case, Fix "bellow" -> "below" typo.

Don't worry, I will take care of it.

Thanks,
Andi

