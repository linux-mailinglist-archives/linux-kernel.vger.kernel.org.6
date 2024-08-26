Return-Path: <linux-kernel+bounces-301976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866795F830
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A461F237AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35D1990A5;
	Mon, 26 Aug 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GlqAxXBR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SqSvGkEU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748919884C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693514; cv=none; b=bd5tn8f84sDNOyU1xc441s8X/9oVJmevCxw1xKs9EXPVIj4ay+RFetomFbJ8iDoFXuebxWZWDs/jQU4vAPO5xet4uOpAu4MhanmZV93E91LphLWYzda9aamaWQNR/WTXDDe7KOyuPRPc65paNUE1hBsx7VG+QgIjGqtf6TzXXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693514; c=relaxed/simple;
	bh=rqrE37Ymk/6DIySLGlwXDHCbwP2tm2cJNWIAq724c8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmeDJSniWHBsCW9Oj5I793ltnK6ix2OdlSiDonHqVRaIGcGGkydkwNQwiMDZ32w+82dBCYSCM3vjpuHscIf6v7gpSWy5nGPdH3MXC9wSRKtciC7JCqM3YJ83zMEiG4Jvwg8tpVRDZbALxLgKk/5LeyTQrUJmPX+GUaDIzetauhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GlqAxXBR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SqSvGkEU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Aug 2024 19:31:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724693511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkZcASK4ZhVjM72PRr7wbPEwfXLYJAc1hlsf/gSb5Wg=;
	b=GlqAxXBRPQBeqRIdp7YEFkKGSYyjuJ95hzkSmIq8lVdpmRgSdpDAHvFFHTphEHIF7FHTDM
	5PSz07IXyHDeDZ+Y2o6QF5z6Y+A9eOCKTlRVTYuvpDCxqslD/1ocwKqQCh+Ot66v2HcfEN
	PbuRXrTyzdJSOiCfA7xVbFpUW+TXGmFG5s/1d3+R0BWB6DRAovv3+ZvIPBSQFu/VTTu96g
	QGoPH9I73b7kwAlLkRk0xk0o4j3dNIPj9nbGr0jY7yJuxyh3iUl2ELSfIC1IIP7y5st4dw
	dMFt/Ke/hDrZSr1oc/Wnv+oC+Vg/OHokmAw8mrlbwSPRGfibdNx0eJdwDq/qFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724693511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkZcASK4ZhVjM72PRr7wbPEwfXLYJAc1hlsf/gSb5Wg=;
	b=SqSvGkEU6QOjP5krxwFS/EKg/yysjqLKhkJPWnYHRP++vjK9SQmcVSs4lwYF4azefHCQPb
	dw2acvrVcW6ZA7CQ==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] drivers: perf: Fix smp_processor_id() use in
 preemptible code
Message-ID: <20240826173143.CxUkM4j0@linutronix.de>
References: <20240826165210.124696-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826165210.124696-1-alexghiti@rivosinc.com>

On Mon, Aug 26, 2024 at 06:52:10PM +0200, Alexandre Ghiti wrote:
> As reported in [1], the use of smp_processor_id() in
> pmu_sbi_device_probe() must be protected by disabling the preemption, so
> simple use get_cpu()/put_cpu() instead.
> 
> Reported-by: Nam Cao <namcao@linutronix.de>
> Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linutronix.de/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Nam Cao <namcao@linutronix.de>

I think this also needs:
Fixes: a8625217a054 ("drivers/perf: riscv: Implement SBI PMU snapshot function")

Best regards,
Nam

