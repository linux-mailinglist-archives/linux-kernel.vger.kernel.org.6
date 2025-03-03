Return-Path: <linux-kernel+bounces-542111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B224BA4C5BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9C21884824
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40B214A79;
	Mon,  3 Mar 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQJYKHSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89D1CAA90
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017191; cv=none; b=OFNuOMLqT+THZFyu6zY8oRjJOEdPfkk/8hO8xzPwNulOoL1m8NkLj6R5NZudtoAAnMSVAnbquLGThWKPoY/LkTlldhu0ieyOoWt1oA7IIVjy2DGsismHItIextNA7RHn90qR3f/77fEzfB3TwAXQxIJPQaB9ZlDPDlY1+jjKCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017191; c=relaxed/simple;
	bh=ORKfRgQGW0056hFlRKXF0EJAyVhkyKhngGPxX2PqvPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgZwEVOT/l+oizX07jgMI5kLvILXETfNK58xlC/7pJdJidNJijRK/tDRfbHnZb4cv45dRwEinqnVkPvy/P+Yd639qTTjGBeIFvaWYulwSpsmHneCyZ3JC4SQlQJAhkr/yT8CqG2DdDCoAYHBI1vLUiWDGNu+taaKjxfe8DcC/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQJYKHSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DBDC4CED6;
	Mon,  3 Mar 2025 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741017190;
	bh=ORKfRgQGW0056hFlRKXF0EJAyVhkyKhngGPxX2PqvPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQJYKHSIhCc+zkDJOINw/+gYZGMW1saFycpp7jykJx/liPxunoNS1bYapqJy44Tzl
	 0YosxQCdFCdm2eNMkXF1Fb7YD90Oz1f3sRmTJNk19aLiDl6sBfIPAOcukqaH1FZJnp
	 hZ3FIIiGJxLNftS0do9jClz/yzcyfj+Nb0iyZdl9IYtxp3XK2JPTuKlrRY4t/y+H1r
	 SKB4cIQAAkANGYzq4lIZruJlr66Mhui6H0DVEXFmmdLV3s3K49n7hckYbJCF+myC5m
	 PifzLKwMGjvQJeEUR/Z/vKygTPm5o01XKWIWCX4DmtxfYO923kJFOa21DH2U6Bmj9i
	 gO2Z1CUOzl8gQ==
Date: Mon, 3 Mar 2025 16:53:05 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: phasta@kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/sched: Fix outdated comments referencing thread
Message-ID: <Z8XQYTXOktHKaOY1@pollux>
References: <20250225131332.83415-2-phasta@kernel.org>
 <Z73LVBw7HXANVbHQ@cassiopeiae>
 <d7308a0c8ea0fa95f0d4a93364e72e4a1eb15587.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7308a0c8ea0fa95f0d4a93364e72e4a1eb15587.camel@mailbox.org>

On Mon, Mar 03, 2025 at 04:48:36PM +0100, Philipp Stanner wrote:
> On Tue, 2025-02-25 at 14:53 +0100, Danilo Krummrich wrote:
> > On Tue, Feb 25, 2025 at 02:13:32PM +0100, Philipp Stanner wrote:
> 
> > > -		 * is parked at which point it's safe.
> > > +		 * drm_sched_cleanup_jobs. It will be reinserted
> > > back after the
> > > +		 * scheduler's workqueues are stopped at which
> > > point it's safe.
> > 
> > You don't know whether the workqueues are "stopped". I think you want
> > to say
> > that run_job / free_job work isn't scheduled or running.
> 
> How about "after the scheduler's work items have been cancelled"?

Sure, that's fine too. But be aware that you may have to change this wording in
case another (unrelated) work item is gets added to the scheduler for some
reason.

