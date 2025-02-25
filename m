Return-Path: <linux-kernel+bounces-531532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA7DA44187
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF07169525
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09426A0AC;
	Tue, 25 Feb 2025 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0in2wbK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44D269D06
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491756; cv=none; b=jZRX2w638EsA9kTLe55s5g1c2iBCruC8Doj39mODaOxBCmcX8eZ3sulB05YDje5nTl4nJT4UCtdevdFduL0t04aWUz8jT9fzGjqr8TKz56+qFeodWR2jxfqWsY1CXuzPXy9XgVKZ8ABbuQv9ihBJyz0DcdrgcmvoJrIpSeOWVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491756; c=relaxed/simple;
	bh=HeiWbUguAKUYy1aVv0iBfNJLRPPEIGhzLryoTTLyFIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyXfIurBdSc1SEZ9Tp6Z4qOH1P3UM0EmPLQkJPQtrwy/e3k3ykIVQ4Bj/N6W+gQYrh7y+mgSZohSC/C+Epp9bwo3B6bKt0eFWZh5Tl2+h80RRj/gsEZ88VoPO9zxwCIhiH7UrumVPzP7mV3EoZwgZNoAWng8ZOJL/U3dkp/GMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0in2wbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F066C4CEDD;
	Tue, 25 Feb 2025 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740491756;
	bh=HeiWbUguAKUYy1aVv0iBfNJLRPPEIGhzLryoTTLyFIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0in2wbKSIU1S5+2vstT9d7ZxIjjOSs0YlwaW2tnv/XWu0no/PgMsvAKM4wI+QciP
	 vNevM+ZgL5YXC4a0TB6IExzKwo/c8+xkCBuwvSBsI1h9Sa5FZnjUzQap4yh2m3FxhY
	 bvajFRqXn46FDxgd64ykCyTtczVGwUH8vQs6MKJ6/PAIYfbiFTAtoBNXrTZ1kr0CWo
	 0G3co3+uczamhorX37a5A1hBMsuD59KrKxAE0teGfRHyXVRXGJwqGblV7qnU+GCHnq
	 pshmjvXUmbk+OFTLLgqZGc4pDW7RCr2wqDSzYAwOon7UHAqoKZypQ4twjSlpTpgV6B
	 pAmqX1Qu0WZkA==
Date: Tue, 25 Feb 2025 14:55:51 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sched: Remove kthread header
Message-ID: <Z73L5_wrBWudDemZ@cassiopeiae>
References: <20250225131332.83415-2-phasta@kernel.org>
 <20250225131332.83415-4-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225131332.83415-4-phasta@kernel.org>

On Tue, Feb 25, 2025 at 02:13:34PM +0100, Philipp Stanner wrote:
> The kthread header doesn't need to be included anymore. It's a relict
> from the days when the scheduler was still using a kthread instead of
> workqueues.
> 
> Remove the unneeded includes.
> 
> Fixes: a6149f039369 ("drm/sched: Convert drm scheduler to use a work queue rather than kthread")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> I'm not sure whether we should Cc the stable kernel. It's inconvenient
> and makes build times slower, but isn't really a bug.

I don't think that's needed. Analogous to the previous patch of this series, I
don't even think it should have a 'Fixes' tag.

