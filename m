Return-Path: <linux-kernel+bounces-511627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82BA32D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E1316427B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E825A2DD;
	Wed, 12 Feb 2025 17:24:59 +0000 (UTC)
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138E2586E8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381099; cv=none; b=E6ru/x7a+wk3gb0U5lHG7Tp32z0R5oAdBdjkVAdbq5FKZ2oaUVyckRlzbeRLtZopBpstiATqEX1YeWe1N+PsTDMDLFMapkAXwvuY45S0uy/9iMNFNOOzCPel47sd8wmRTPxgCcYJv1QWvqOxTLHj8Ftn2MvTpb1zwh1eMAgvU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381099; c=relaxed/simple;
	bh=9gCjobiYa/6p9KenXe+D1iIF8xmGMgHGb1ynZLgSv4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcGsBx/3OCXc3uwkiM0Nnhudnhm7vMD8jS50WBo5esWMvx/CHQuOF69NcQM6hbhRo+SsuqNI88Dx6qv3SZd5MZZUvxiCps9TrLC7tzfVJPz/qWdE2TgIlt9EUviUH3XO2A487kr3w3oXLBnEcExZEiRMIk4Mo05W3Wm3FRsoT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 553821F974;
	Wed, 12 Feb 2025 18:24:48 +0100 (CET)
Date: Wed, 12 Feb 2025 18:24:47 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: "James A. MacInnes" <james.a.macinnes@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, robdclark@gmail.com, 
	quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 0/2] drm/msm/dp: Fix Type-C Timing
Message-ID: <4f2w7yb2f3fvg5t3hyr3ionncqgfgilud4rytotxvmxr675272@oenwx5cf6ltl>
References: <20250212034225.2565069-1-james.a.macinnes@gmail.com>
 <yle4tv3rhxkygvxvq56pls2u4muzmuxlzg5mp6ibckkyhbaycm@mv4hmom2e46c>
 <20250212083424.2bf95a43@jamesmacinnes-VirtualBox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212083424.2bf95a43@jamesmacinnes-VirtualBox>

On 2025-02-12 08:34:24, James A. MacInnes wrote:
> On Wed, 12 Feb 2025 13:20:01 +0200
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
> > On Tue, Feb 11, 2025 at 07:42:23PM -0800, James A. MacInnes wrote:
> > > SDM845 DisplayPort output inop on DP Monitor and tears on HDMI.
> > > 
> > > Fixed
> > >  - SDM845 does not support wide mode.
> > >  - SDM845 does not need porch shift.
> > > 
> > > Verified functionality on SDM845.  
> > 
> > Please use ./scripts/get_maintainer.pl to get the To / Cc lists. Your
> > messages missed several mailing lists and maybe some of maintainers.
> > 
> 
> Will do. The list from get_maintainers.pl was very long and I was
> attempting to not spam everyone. On revision I will include everyone.

May I suggest using b4 for patch handling?  It'll help with tracking revisions,
cover letters, To/Cc, running checkpatch andsoforth:

https://b4.docs.kernel.org/en/latest/

(Another patch of you seemed to have V2 tacked on to the end of the cover letter
title; it's instead supposed to be part of the PREFIX like [PATCH v2 1/2] for
every message.  This tool will automatically handle that for you :D)

- Marijn

