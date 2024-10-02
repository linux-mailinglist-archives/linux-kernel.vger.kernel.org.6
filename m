Return-Path: <linux-kernel+bounces-347993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F698E133
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4A1C231D4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F53E1D0F6F;
	Wed,  2 Oct 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0JSUcBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037A15D1
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888040; cv=none; b=hAsH+OgOnU6f820QU2Bus3YcFurjimg3++DxEnpR6vQ8ADqCYtECnjx6yv2tNQuIp6H/U2FsV5qcKg9oVrhuegkQzCmhhy67u8/s+yVGX2UnDxSOueUcS5GZp7VmKQ1Tx2wN20FlYgR/9kUpGEtVgphsOnFoJlXONQji5saFT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888040; c=relaxed/simple;
	bh=w8g0GZi7SGUqqDqlK/8TqGsUUCNME8mW0HU+S7qHwQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTaso8AmDgPiLMgy3DJpXxO/B6I84imqhXS9M4OWKjxfxwX2QzzcNqNB+xx0JRip5Li8qWMHDe2rAUc0mKH8PmGMLuv0zwi+UwgIq313V30SVl4e0JtUm++CgzhjoS4Qub7CsuW3HqA5EKN4ZAMwcRIFGN3xI7F4gv9NC/BJqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0JSUcBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C42C4CEC2;
	Wed,  2 Oct 2024 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727888039;
	bh=w8g0GZi7SGUqqDqlK/8TqGsUUCNME8mW0HU+S7qHwQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0JSUcBgdBbQ1HVUVAZTu2b0MqnS40Nh9KPlfXu39HxyJplIcnppEeiEssjvhhXjA
	 yeW5xb8tNO0gC9qJMG9Ryl35gUoofMhSsXaxoAB6NTq3q9JXNsg0BUS8Pe9mJp8d3m
	 artKWbiGZfX8lnVESbQSgkC3/ByLqQCdZyQLKaa4YXWBYl98HuenpoO5qq0v7xsL//
	 HE/fz7jgNu84YeJGiGLVBe3vmONgAyS+7zirzSao7rMNhkn33LFpLHIq0FEFOKi1vF
	 52NDQAN7ZDzOTUCNwKoXsbMbVfAJufN6o9Wmlg1PSCJikUHZz9hCeQR1fiZEdKNnZK
	 Rm5doHQLgynmQ==
Date: Wed, 2 Oct 2024 06:53:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: David Vernet <void@manifault.com>, Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>, Barret Rhoden <brho@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Add __weak markers to BPF helper function
 decalarations
Message-ID: <Zv16pW_OilT1y9d5@slm.duckdns.org>
References: <ZvzxONGQMnRpueRC@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvzxONGQMnRpueRC@linux.ibm.com>

On Wed, Oct 02, 2024 at 12:38:06PM +0530, Vishal Chourasia wrote:
> Fix build errors by adding __weak markers to BPF helper function
> declarations in header files. This resolves static assertion failures
> in scx_qmap.bpf.c and scx_flatcg.bpf.c where functions like
> scx_bpf_dispatch_from_dsq_set_slice, scx_bpf_dispatch_from_dsq_set_vtime,
> and scx_bpf_task_cgroup were missing the __weak attribute.
> 
> [1] https://lore.kernel.org/all/ZvvfUqRNM4-jYQzH@linux.ibm.com
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

