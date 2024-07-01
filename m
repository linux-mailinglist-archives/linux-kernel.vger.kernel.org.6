Return-Path: <linux-kernel+bounces-236475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A153B91E2BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35DB1C230E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8DE16C6BD;
	Mon,  1 Jul 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb4vhXlR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7B16C6B0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845307; cv=none; b=LYL5WTNKrd+UDwR+z1fEVFZ6Y3qXkXG5hjs9ZHI7gladQSl4lasfggMesdR6nVfVDqxtVsgGj9jyl+WcKAXUHnHTrHvRDd5Msp6jl+8qtoodmYWQ8xSqyw9s3B5AhcV6BIty7GgnIo2Bh365wBHnQtcjT5N+KqPPuEcsGzyjP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845307; c=relaxed/simple;
	bh=BLfunpm870UGqu8HJHmdD3DQQr7XTTLgfAxt12C1WPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+Cbm81j11vTyaXW5Argy1pjo0EmZOa2rX3wMQCVm1vY3t9l8MiIA0A7lf+lb1Xc966r3Bf+M6KozWVTsuqRjOJ5NSgMOJN1FE5uFdn3SFAJn5qP602da77Ouj0ZndCvilPQ253gxkrVtd1ijdLU9s4s3TH778u7YTvENSNz7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb4vhXlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603E6C116B1;
	Mon,  1 Jul 2024 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845306;
	bh=BLfunpm870UGqu8HJHmdD3DQQr7XTTLgfAxt12C1WPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb4vhXlRDsizNW4xNEmjJZbEiu76JIpRUhN8mZ7LggCBD2TtS6ocm0Ox21YDJSYJa
	 WTYhgT1AkXCz8nLLi5Q3uk5+FRr/Kt/8VfFwyBqmUgjo4cMc/T9y2UGIgenCQT7qsa
	 RmbUG8OVwWOQMBTlSaXctHyRBnqOlTur4JOypdwhDccvpYJpYDmk28KSGylRNx2SFD
	 B2D0SlISNu0ON7nzr5GXcTP83BaFrbfpvtc/T9xZeXICtQ6cMp0+NSrJH+9NEAAvz9
	 +tTtchLFm7hVsIQMkGCWXQ0X2BfUf7VAF3P+sNrHNVEx5sJc8pW8dDhusBuT88wUii
	 Y5MzAH0zSokAA==
Date: Mon, 1 Jul 2024 15:48:22 +0100
From: Will Deacon <will@kernel.org>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gcherian@marvell.com
Subject: Re: [PATCH v5 0/3] Marvell Odyssey uncore performance monitor support
Message-ID: <20240701144821.GA2754@willie-the-truck>
References: <20240620131256.590903-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620131256.590903-1-gthiagarajan@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 20, 2024 at 06:42:53PM +0530, Gowthami Thiagarajan wrote:
> Odyssey is a 64 bit ARM based SoC with multiple performance monitor
> units for various blocks.
> 
> This series of patches introduces support for uncore performance monitor
> units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
> series include the DDR PMU and LLC-TAD PMU.

This series doesn't apply:

	Applying: perf/marvell : Odyssey LLC-TAD performance monitor support
	error: patch failed: drivers/perf/marvell_cn10k_tad_pmu.c:362
	error: drivers/perf/marvell_cn10k_tad_pmu.c: patch does not apply

Will

