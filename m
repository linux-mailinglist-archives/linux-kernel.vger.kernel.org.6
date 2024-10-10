Return-Path: <linux-kernel+bounces-358362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB29997DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112B3283DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A431A3BC0;
	Thu, 10 Oct 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJY2/YDJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3CBNVWhH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0E18BBB0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543223; cv=none; b=Zs96fknannCmN1hbx7oi0wMEcNuPo5xPD4s2+YdNSZO2tVY8hzCnLyF9aYyIFwnZ2gpkaH+qCPNUTVaUDE5kYA2SPrEB7ulCcpInn6S+oRKV/W+DDuDHLFeRszIGyWfu5vFM8pikywDR4lNt+Zm+ONBTZfA9KJUYrK5LgJ1s1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543223; c=relaxed/simple;
	bh=BAECMXOvRgmGW3pGukjMbCWEzmTOIfKujclgs2AwWfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArxIJ2+pygvrPnD0k6655ukSgES3h+eo/HhTJfHlU4oJZGKFjG27RphRiCIu0CkMhleqBSW1GRIAoJXejeJvLZyLWEJRy/vbQssQIy/W43iQciQbs6u928QgX1MWoR5j5IhR2cEWt+C7q6S6x4IqIs71+T8lftFzzOx7T89WRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJY2/YDJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3CBNVWhH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 08:53:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728543219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qkAGYDlv4PdDaphwVZHGOvWe+t+u+L3VAPL4iGlpnE=;
	b=WJY2/YDJDK2ucSE4onPawIdME92U+9ehkaqmjJGq8p4qn/CB8kEBgXceoa9yr2a2rTsZ99
	05BYQOYZBVSomcPsGAPb6xn1Id6Ht6HWKe/CVdRx00E8X7JtAdnDK0ZaZTJaYpj2Al39FL
	Wr1Ja/p0xtKDfhCpxiYhlegs7cvBid5ZLS4/LNjMOk//k4ddmE9raunKYXVVRDFznzFysy
	v8M04ENIY6Q1Xftq4Phfsw4cLj0Wg58by+9aQe1HaYvGsveZtYDv0/z0ti/eONeeUKk+4R
	C16lqWddv5WYzoksZoqEZfB0bnCzM/+YQHCwsZH7KQQezxUp8khpSqkwCSGE1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728543219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qkAGYDlv4PdDaphwVZHGOvWe+t+u+L3VAPL4iGlpnE=;
	b=3CBNVWhHJJ5O41/2xipgrwTSxftOcZa1qrbMsaLJ5numrTwtcg7bBhXhMaOz4cNcKn6KsL
	Lh71jIi3v/jzeQDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 6/7] osnoise: handle quiescent states for PREEMPT_RCU=n,
 PREEMPTION=y
Message-ID: <20241010065338.sw4zZlbm@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-7-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009165411.3426937-7-ankur.a.arora@oracle.com>

On 2024-10-09 09:54:10 [-0700], Ankur Arora wrote:
> To reduce RCU noise for nohz_full configurations, osnoise depends
> on cond_resched() providing quiescent states for PREEMPT_RCU=n
> configurations. And, for PREEMPT_RCU=y configurations does this
> by directly calling rcu_momentary_eqs().
> 
> With PREEMPT_LAZY=y, however, we can have configurations with
> (PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above
> can help.

PREEMPTION=y, PREEMPT_RCU=n should not be possible.

> Handle that by fallback to the explicit quiescent states via
> rcu_momentary_eqs().

Sebastian

