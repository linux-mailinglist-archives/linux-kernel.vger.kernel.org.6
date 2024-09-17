Return-Path: <linux-kernel+bounces-331627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86DF97AF22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805BB1F25149
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A07316A949;
	Tue, 17 Sep 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ub/0zY/t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBpji7Zg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175616B75B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569855; cv=none; b=G2OT4K82HVKNxQWVRV3OOmPpY//8blE5RAerdUNVediEcAj7jtNiQD8BvRv2O9gWd5Yd4lHl0ed6MEb4QAB7GoHmf0okK9D2uNAIicspJvQgdRzpMDjgP6rMcF6D3wiutCA2j1uqFs/OKqGK+g7diInb11VMrV0DNczc4NhYFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569855; c=relaxed/simple;
	bh=l1r68LTKLywKVsGY+ZFYbZcPWb/OIIeCjYvjb/r7INY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kELXcPd/7Hss9sn05V3omf2qrhPU68fa91PsyJgf5ZVVFO2UkdibBUxN9fKllHDKFbzruOOPvciXnVt3te8h+eSXDSCO5klNiB5QRNcp0G8+3yNiJ0pgaEaFYYKNv7kPSGqsiwYwAZyh6AVjenkXNuutqFpnGDKYwL5Z7iEiC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ub/0zY/t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eBpji7Zg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Sep 2024 12:44:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726569851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sy+4/1n+ad3a8AV+WCtI2cD2537ZZ8vIrmHCHPAf+Do=;
	b=ub/0zY/tn1KHEjEdR/XC3W39Ov6R9WCQxkU59zhLnSZnLXB9HrljO/DzW831JF4pTWX/r0
	2GpvVc3KVj3z30V96G31IYSYBy1MPtKF/bMmxliNfP3Emw/nWWUX14Ex+lEUePWXSnXwKK
	h2D335M62o8zSCtu1jowrFHpv0IR0VHDscnhEeMt7BOYJt0E2coHu1NW1zhMwVjLSujmGl
	flpiBY+QVRM8G22Wn3OlKIlo3vudtEENkVWSLahN7y6TZEiU/rL+2aRYlc1tTd/ac+9uyi
	5dEtfiPzdf37dnIFMcti4Uppx4Eo4sJj/bblljtSm7klbCBNe5QCYEBFn8MsKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726569851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sy+4/1n+ad3a8AV+WCtI2cD2537ZZ8vIrmHCHPAf+Do=;
	b=eBpji7ZgNulCp86xJPG08myqucni+BhjZBxZNfbpwdtzuUv3PhyCEzFNm1uL8ArdqV5hEE
	8HA/t7tPHdd4wGCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: namcao@linutronix.de, tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org, hpa@zytor.com,
	aou@eecs.berkeley.edu, bp@alien8.de,
	Catalin Marinas <catalin.marinas@arm.com>, williams@redhat.com,
	dave.hansen@linux.intel.com, mingo@redhat.com,
	john.ogness@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
	pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] riscv: Allow to enable PREEMPT_RT.
Message-ID: <20240917104409.b9nGBsc8@linutronix.de>
References: <20240906151324.tVwX6lFy@linutronix.de>
 <mhng-64eec780-df98-4e8d-bf6c-0aa07a8d85da@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-64eec780-df98-4e8d-bf6c-0aa07a8d85da@palmer-ri-x1c9>

On 2024-09-06 11:48:03 [-0700], Palmer Dabbelt wrote:
> I don't have a test setup yet, but I figure it's a new feature so I'll just
> flip it on as a config post-rc1.  Presumably this just works in the QEMU
> virt board, or is there some wizardry I'll need to copy?

I don't think you want to enable it by default for everyone. The riscv
defconfig sets CONFIG_PREEMPT_NONE=y by default. For testing you need to
flip this to CONFIG_PREEMPT_RT=y and since CONFIG_EXPERT=y is already
set this option is available.
And yes, it works on the virt board and there is no wizardry needed ;)

Sebastian

