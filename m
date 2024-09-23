Return-Path: <linux-kernel+bounces-336400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2559983A43
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C14B22355
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF05126C0B;
	Mon, 23 Sep 2024 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIAk09aN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1EB23DE
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133388; cv=none; b=ZwMnP8r2PcRi/IvKLu0JukoVSoUuSdMdD7p0vW15fjvCU7Bt62u5X7TIY5rwn5073/H7gwnLUNWamAucuiweCPQ43R92l0OGBiHaEKr2epa0fmoRjV0iyXPuMluu2EFZB7O2qz6gHCE3xTMo8TcdiB/e+03CFfTBhSDKMqVea5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133388; c=relaxed/simple;
	bh=ElxzDnHDm+cQyLjqxzn0fvBfDC2loxlsAlEw4+uXM+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8DXcrOcz/xjzDQlSZB9f8eS94NpXQLeaeuP8nbkEWgLZENq6PXTPSRv+93sJdNNQmL41QE/DEpR2YyQbUh93t4QiLIY251iqfdF+jalBgYLFW4fepV3hp008cAN+l/ujiBQLie+ffU/x32XWXZLmiEvQwi1NyrruKWX45xbGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIAk09aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D394BC4CEC4;
	Mon, 23 Sep 2024 23:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727133388;
	bh=ElxzDnHDm+cQyLjqxzn0fvBfDC2loxlsAlEw4+uXM+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIAk09aNXrgSIqDhOwqbW5TSzHJceiq2OvRtRjoJIV+pU9cWfV3h939PQuxFlDmDY
	 veZG5CHSRPpJiYhXmXBw+NSDQDRJC6HGbUhAdUgRPjM4ItAaVqKXkk4VRe46Xyi3Pp
	 IeCJKJnT5dWPRh7i3pePB4wZersiPclxnwRydRAhQyZkVExnN709Zv8uWnTBfNkQy8
	 1r4ZWTPWQ6OFKG3zoH4jFNE8IlgS6T+B9AWUWhwdb+te0JdEEC4b/m7syxC7eDLeQM
	 nFHZ152WgWZzcgPHxq4Coh1Bd6AxXLMM5TnkKEj2Hza/qFSKNs7OLvpJtLDG1Twmgg
	 UibhAQ8BhhLuA==
Date: Tue, 24 Sep 2024 01:16:24 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <pstanner@redhat.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH] MAINTAINERS: drm/sched: Add new maintainers
Message-ID: <ZvH2yIsPIbDXN-_r@pollux.localdomain>
References: <20240916185159.35727-3-pstanner@redhat.com>
 <ZuiP/4AzCNnoaDZ/@DUT025-TGLU.fm.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuiP/4AzCNnoaDZ/@DUT025-TGLU.fm.intel.com>

On Mon, Sep 16, 2024 at 08:07:27PM +0000, Matthew Brost wrote:
> On Mon, Sep 16, 2024 at 08:52:00PM +0200, Philipp Stanner wrote:
> > DRM's GPU scheduler is arguably in need of more intensive maintenance.
> > Danilo and Philipp volunteer to help with the maintainership.
> > 
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > 
> 
> Acked-by: Matthew Brost <matthew.brost@intel.com>

Applied to drm-misc-fixes.

> 
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 10430778c998..fc2d8bf3ee74 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7710,6 +7710,8 @@ F:	drivers/gpu/drm/xlnx/
> >  DRM GPU SCHEDULER
> >  M:	Luben Tuikov <ltuikov89@gmail.com>
> >  M:	Matthew Brost <matthew.brost@intel.com>
> > +M:	Danilo Krummrich <dakr@kernel.org>
> > +M:	Philipp Stanner <pstanner@redhat.com>
> >  L:	dri-devel@lists.freedesktop.org
> >  S:	Maintained
> >  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> > -- 
> > 2.46.0
> > 
> 

