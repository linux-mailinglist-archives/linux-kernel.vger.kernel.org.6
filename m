Return-Path: <linux-kernel+bounces-317912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32DA96E556
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DDFB21A48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DFD1AD5D7;
	Thu,  5 Sep 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srcp3mkF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EMuvnRnB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CEF1A3026
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573359; cv=none; b=kArAq/y0xOQPEMRsfBlzp7LYvhFs1U34sqvmgQUczi0UEPVXRDzNTpB6FZQ5P4xn/o0XWFvVG6t87fVzn2tV8KWlHWXEYnfRHlbI92fS8eEs3ENSMdxKhHe2abX8wx54ggy8oAdm6p9fjtR5aoGpGnbD713sRgcZSATFASuv03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573359; c=relaxed/simple;
	bh=DKg2J2VUGUtYiNmS4dXWfWS5wxBXc6+j3tzetDyDm00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1bhLcBQd1bE2DXgc3I12F6WchJBGI1pHpIrCfbSHrEhhdi9VbkuY8xu5ACx5mbSDl6Vx8SHymg1khj0J8nZ6hDMT5BwwzaVTXqNsOWb5UBKb0aJvy2URg50p7RU+yD6f+rh/gozEKy7fXPi50+Sb/STrbv07kAfcMvgJCcg9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srcp3mkF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EMuvnRnB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Sep 2024 23:55:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725573355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pEM9gGlpQQWWBHAcLa/gZM6Ih/LFyxbonn9OJ6Yciks=;
	b=srcp3mkFfNQiwhScFEaugg95R8wXB8TiiSHkpQKwQ3kksWfCSQtsp8g9CnX/jDufcrkFKr
	kAFhx8pNkvOD1hqaUGAZekkVPKZ1zzVot9tdQXScni12HyjwyPC8rHX8FyCA71WY2ZBj5u
	rkTr5ZVRabzcSn2/92m0XiXj2D6TwgEVRYVZvwWSb6gV6O5Mm7VlEkFTujh22/hOnsxgpV
	pGqm//FP7MQ4bsXT9YzUypSEeapwj0rjNI8/BsGDADudR83cutagKaAqNgW54jLPNVgCMq
	1Uaf1sSyUC6MteQgALEgJCiYTBfjEtWD8B1gJVc78robSug72qpoRNSxKv1Y7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725573355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pEM9gGlpQQWWBHAcLa/gZM6Ih/LFyxbonn9OJ6Yciks=;
	b=EMuvnRnB4hX40WSXb2CgBJyDVCOVLLYsx4YOKIqOICX0hejn1lLw5kS3tifCNfHLHv2SG3
	Dmw+e21O3OtNsiAA==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH -fixes v2] drivers: perf: Fix smp_processor_id() use in
 preemptible code
Message-ID: <20240905215550.cegYWVFe@linutronix.de>
References: <20240829090034.15777-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829090034.15777-1-alexghiti@rivosinc.com>

On Thu, Aug 29, 2024 at 11:00:34AM +0200, Alexandre Ghiti wrote:
> As reported in [1], the use of smp_processor_id() in
> pmu_sbi_device_probe() must be protected by disabling the preemption, so
> simply use get_cpu()/put_cpu() instead.
> 
> Reported-by: Andrea Parri <parri.andrea@gmail.com>
> Reported-by: Nam Cao <namcao@linutronix.de>
> Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linutronix.de/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

