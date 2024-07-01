Return-Path: <linux-kernel+bounces-236478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B47CA91E2C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B31F22797
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBDF16C6AA;
	Mon,  1 Jul 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjPXSDxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224FC16C69B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845430; cv=none; b=iPyu7hbraU3xQW5R18Lxv5gWto1LXPGPsTSL12c3VdxPrMHrhI66WQoKCRwmccYVgeqWStarwcFx3FPZbLajah4L6yj3ehOYQqAPVbgPCdqSOSJG7WK6bBBSz9tgmzeC/k0N81xMJj12KgcGtFpNv/J0aPtMAiL8zKRth2dLD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845430; c=relaxed/simple;
	bh=BBtaH4ItxcBvqlwA+CXoJ18dn9/8Bb3N1BwEc3GeS34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC9hiOLKTExI7Ms4pRiQFDbThM+bIKtCEMGZolL/RI3JIAqIT58esAnIZdowMl5S77+6UhV1oqbKQn5nsiURsOkh80uNSciOQVxceZoK5Y5pCfE0ZavQ92vJDABi55Y/DA1hWQ6Dp80rrO79Jw/KUQjfQGEjnTcnYpvgQIgGzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjPXSDxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8034EC116B1;
	Mon,  1 Jul 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845429;
	bh=BBtaH4ItxcBvqlwA+CXoJ18dn9/8Bb3N1BwEc3GeS34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjPXSDxXoQjsch+OfUaGGyz5izgBfRqKmgDY2i7oRhaOxrnmjcCpdlWjcTiR640Sp
	 CcgSnvbabZtyTNTcHajSmxJRYLOc/OXN+dYehJhRX2zuRGlJxf4hhUmsq8nEEyWeOz
	 DyPTRxIpgloDxpbKv2SO953QNeO0lwrerWtH2yNaK2cX82msrOSrBsfOu6SAXhEPtg
	 nSPpzDt2P+3wbQNR5NrHwJYqKBC2RmmfE3FuMUP4+cfw3EL+hnx6+JPLo/0gKwR0hz
	 Dnoo4ckriWFukz2PoKvsn/9qVJqmoGVcWQcxIT1XXBj7MtClMzlaMxOxM4Z+wJJvkm
	 0Om+mk+A/FDTQ==
Date: Mon, 1 Jul 2024 15:50:25 +0100
From: Will Deacon <will@kernel.org>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, lcherian@marvell.com, gcherian@marvell.com
Subject: Re: [PATCH v5] perf/marvell: Marvell PEM performance monitor support
Message-ID: <20240701145024.GB2754@willie-the-truck>
References: <20240620131621.591130-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620131621.591130-1-gthiagarajan@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 20, 2024 at 06:46:21PM +0530, Gowthami Thiagarajan wrote:
> PCI Express Interface PMU includes various performance counters
> to monitor the data that is transmitted over the PCIe link. The
> counters track various inbound and outbound transactions which
> includes separate counters for posted/non-posted/completion TLPs.
> Also, inbound and outbound memory read requests along with their
> latencies can also be monitored. Address Translation Services(ATS)events
> such as ATS Translation, ATS Page Request, ATS Invalidation along with
> their corresponding latencies are also supported.
> 
> The performance counters are 64 bits wide.
> 
> For instance,
> perf stat -e ib_tlp_pr <workload>
> tracks the inbound posted TLPs for the workload.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
> 
> v4->v5:
> - Kconfig : Removed the dependency on 64BIT based on the feedback received.
> 
>  MAINTAINERS                    |   6 +
>  drivers/perf/Kconfig           |   7 +
>  drivers/perf/Makefile          |   1 +
>  drivers/perf/marvell_pem_pmu.c | 425 +++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h     |   1 +
>  5 files changed, 440 insertions(+)
>  create mode 100644 drivers/perf/marvell_pem_pmu.c

PLease add some documentation for the new driver (see
Documentation/admin-guide/perf for some examples).

Will

