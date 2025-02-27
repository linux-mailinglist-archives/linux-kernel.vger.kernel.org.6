Return-Path: <linux-kernel+bounces-536859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E5A48527
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEABF173414
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BFB1B0421;
	Thu, 27 Feb 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sflvuWkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D711A3178
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673649; cv=none; b=FcK6tD6HFvhXRX7KeeLubeN13vY+xb8nLEfWaqXsFIVyjCsNX+1klvu324n2O7zlsyIifpzFetCuPqLdz93kqK3sveYUgDbOIb8SJ3gfm20Y6I96EnoVQSDCbWCCc0bXZFfU+YPLOeqUx/VBP+HeksgsHL8xBGmdurPjEY83uow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673649; c=relaxed/simple;
	bh=CqfgSenLX0g4/F+BPmO4k7pBbeoQY+ChNLkUs2hFiO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fATjahTCCmtRTLSZiK0tUeaViaUopmqNFyaZ/7+jWvP4L9KvCVAXvnRhpkKVkSohg1FhCM/B6PvdMDtPMaHr88xBAm+1EG82TbFLk3AiKcaHUY9JqFaibmlKnyrYImjGKukSK3jS2RVxN5LPFkIp6D679Q6dgSLUtLizkLMXH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sflvuWkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D769C4CEDD;
	Thu, 27 Feb 2025 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673648;
	bh=CqfgSenLX0g4/F+BPmO4k7pBbeoQY+ChNLkUs2hFiO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sflvuWkXKWbDYL212qkVg3GDGJ8FoYujaTBndVsQxAJqoVFx36hhI7W2NcWAqMefz
	 MO1RNegYJUEGjvK2h5ebT6XfGUIHmfGYlrcWtdQEUR9La7agj9eKtFAd2HCrQTokBl
	 aova2gecbzO1eDMsc34FWbNCufUo8oKJs6nCmlFoOGpl++Obt+fj/MjZE3wxg+/C+2
	 Ru1a++5+NBDDfYaFBp2qB/17Rknbu0WCZ34f943KncalWPC2Q5snvkjOj6khwznDb0
	 jOtOi+KLaqY0Oam7gH6wqZ78Zf5pvN4J2LmPfP/9kRV9e0dS7LWEl3gUMee+Q8HcUN
	 sW03y7kznxGkg==
Date: Thu, 27 Feb 2025 06:27:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] tools/sched_ext: Provide a compatible
 helper for scx_bpf_events()
Message-ID: <Z8CSb4qe3xwx5Rdm@slm.duckdns.org>
References: <20250227091138.253809-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227091138.253809-1-arighi@nvidia.com>

On Thu, Feb 27, 2025 at 10:11:38AM +0100, Andrea Righi wrote:
> Introduce __COMPAT_scx_bpf_events() to use scx_bpf_events() in a
> compatible way also with kernels that don't provide this kfunc.
> 
> This also fixes the following error with scx_qmap when running on a
> kernel that does not provide scx_bpf_events():
> 
>  ; scx_bpf_events(&events, sizeof(events)); @ scx_qmap.bpf.c:777
>  318: (b7) r2 = 72                     ; R2_w=72 async_cb
>  319: <invalid kfunc call>
>  kfunc 'scx_bpf_events' is referenced but wasn't resolved
> 
> Fixes: 9865f31d852a4 ("sched_ext: Add scx_bpf_events() and scx_read_event() for BPF schedulers")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15.

Thanks.

-- 
tejun

