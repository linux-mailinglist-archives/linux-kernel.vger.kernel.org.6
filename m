Return-Path: <linux-kernel+bounces-511613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B9A32D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C331634E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E0E255E42;
	Wed, 12 Feb 2025 17:22:44 +0000 (UTC)
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E31DC075
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380963; cv=none; b=buyDHnHyypb7ZL86CfBxvCdyhu6MAEumpEFbnXowcgKZQQCDAEd4AiQ9AVn/1+nzeOidFwK8BNnVXqsJHicOhpvUQ1z2GAxFOf9Xo02LMD8iKQGk48tVSjziqKr96jlTV0DDxIXWQAopUjgiuzWUN2j+4NY8WC58EwqoYtYpzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380963; c=relaxed/simple;
	bh=lPg3TzC5nGtOuu7+NoPmJ3QHmbM/Mb1pwd25ZtTzQMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1fQbR7Lvnw3aSJ7kLj0DcU0cOQKymHSc0SWilsHnesK0+1tHI7zSvZe8EI8EFDQnLCl8qHSitUNCWpcc5BdnfXiDsEgHkfF6CazmOmVqWmqXXIQEImB74/iJk16oLdcxU/1nAZyuEb4ZXASc4NI73V/uxTga031oYGbDvJsBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D7FC520241;
	Wed, 12 Feb 2025 18:22:38 +0100 (CET)
Date: Wed, 12 Feb 2025 18:22:37 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: "James A. MacInnes" <james.a.macinnes@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robdclark@gmail.com, quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org, 
	sean@poorly.run, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 1/2] drm/msm/dp: Disable wide bus support for SDM845
Message-ID: <wjfjjkowvsd7rkmtrggd63fjfc2gy3o3gh7n33uiq2pjp7jdny@muffgnmc24ul>
References: <20250212034225.2565069-1-james.a.macinnes@gmail.com>
 <20250212034225.2565069-2-james.a.macinnes@gmail.com>
 <vl6cfjpckgndu5nacw3o5wvdfwaijactokby6q2lywcdccicgz@k27my3352m2k>
 <20250212081641.258dea11@jamesmacinnes-VirtualBox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212081641.258dea11@jamesmacinnes-VirtualBox>

On 2025-02-12 08:16:41, James A. MacInnes wrote:
> On Wed, 12 Feb 2025 11:03:39 +0100
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > On 2025-02-11 19:42:24, James A. MacInnes wrote:
> > > SDM845 DPU hardware is rev 4.0.0 per hardware document.  
> > 
> > Just checking: version 4.0.0 is not named in the code that you're
> > changing: are you mentioning this because the patch you're fixing
> > here [1] says that widebus is "recommended" on 5.x.x which includes
> > sc7180, yet didn't account for that sc7180_dp_descs also being used
> > in the SDM845 compatible which is 4.0.0?  That is something worth
> > mentioning in the patch description.
> > 
> > [1]:
> > https://lore.kernel.org/linux-arm-msm/20240730195012.2595980-1-quic_abhinavk@quicinc.com/
> 
> That is correct. All the 'modern' Qualcomm dpus got wide-bus turned on
> and as the SDM845 has not had a working Type-C port it was never tested.
> 
> Happy to add that to my commit message. This is my second submission to
> the kernel forum.

Thanks, would be great to include all of this as context in some form!

> > > Incorrect setting caused inop displayport.  
> > 
> > Inop doesn't seem to be a common abbreviation, there's enough space
> > to spell out "inoperative".  And spend some more words on _why_ this
> > is an "incorrect setting" in the first place  (based on the
> > suggestion above)?
> > 
> 
> Happy to spend many more words. Just looking to meet the requirements
> for the boards and try to not ruffle any feathers. It seems to easy to
> be far too verbose.

I'd say: the more the merrier.  Especially DRM/MSM is *flooded* with
poorly-worded series, if they include a description (beyond paraphrasing the
title...) at all :(.  Having all this context available makes it possible
to understand the debugging and thought process behind a change.  Links to
downstream are a great way to showcase how things are dealt with there, as it's
generally the only source of "documentation" for these drivers (to hobbyist
contributors like myself).

> 
> > I am trying to remember the details from the original widebus series:
> > we discussed that the INTF_CFG2_DATABUS_WIDEN flag was available
> > starting with DPU 4.0.0 (IIRC, cannot find the source), yet the DSI
> > host only supports it from 6G v2.5 onwards (SC7280 and up?) [2].
> > Seems a similar limitation applies to DP hosts.
> > 
> > [2]:
> > https://lore.kernel.org/linux-arm-msm/20230822-add-widebus-support-v4-4-9dc86083d6ea@quicinc.com/
> > 
> 
> That would reflect the testing I have performed. With the wide_bus
> system enabled, The MIPI display functions fine, but the Altmode
> DisplayPort (type-c to DP) does not turn on a standard monitor and the
> type-c to HDMI connection has either a system that does not sync
> (horrific flashing) or just a single solid line. At other resolutions I
> was getting vblank errors from deeper into the system.

Technically the MIPI DSI display (data connection between DPU INTF and DSI host
AFAIR) shouldn't be using wide_bus, AFAIK it has DSI host 6G v2.4 which doesn't
support it according to the code.

Thanks for taking all these suggestions!

- Marijn

