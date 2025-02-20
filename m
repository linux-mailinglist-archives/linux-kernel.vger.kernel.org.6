Return-Path: <linux-kernel+bounces-524136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A199BA3DF95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEAD188B0D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2942D1FBC9E;
	Thu, 20 Feb 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsfQVd5p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LTA3d9Z0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349371FE46F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067080; cv=none; b=lig1jmaRaUzbgQpaHGqUbZDfracKxN6JaAwWByKTssDMJ2uAyXsI7sgBPwBrjgPhZQEFZ78eKvd3VMLeJhbbSPPZ+WPGMny95H1aSCHQBvrCjLB5Sk2kvjZpWqaLGZU6btcCem3853g7cvsqvQCDOXVyt3pSQxZtiqDr+lVxqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067080; c=relaxed/simple;
	bh=ji3wK1761EdJc8zNaBYGgLOdH4v+xM36mjARw12TKiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8/sVlpeSK/7jio02wLcuvSTpRlXCbN0oVHfzT3XVBRWKgAGvmxjj7Bcy1N+l+iixV17v2EAH/MDolhxtlPNRtfxNmap63EO2Hmq48VwkxpJ14VAyTA4v90w8Ra1qOy0dYaj6rxU4FPNGIji53RkV9FKe5xmHA4Ho6MQX64sKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsfQVd5p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LTA3d9Z0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Feb 2025 16:57:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740067077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ji3wK1761EdJc8zNaBYGgLOdH4v+xM36mjARw12TKiE=;
	b=rsfQVd5pd1Jdf+PEQ3wCwYIfAIf5gHP/rc2NS5HMrlkrhTXFaJx4G1wmH5/fXILegoPCp+
	gbEKd59aibnLMBeC4EcRZNYDGMRbddyCNYdJsvwSYIWOyb8IZA6aXG7gzNfoDfIXly62Xo
	xQ8LTCLQRS4kPvAuQmyUP4AiicFGRNA6d3gcakOLnDZ+43aE7oGd6aw7bpPWkV4whcrvYG
	ZhEypWYEzJnivSlHuBOHPtjcoOOPSOEeo5qWzERPpcVGRaxUMVpX3+ugTcGJnZdmN2TmkP
	qqb4yB4SzhwC0Gpvgn45BetM3Oxn1sFUeBRt6AxDIcNFSmkF2MhhswCCBCDvkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740067077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ji3wK1761EdJc8zNaBYGgLOdH4v+xM36mjARw12TKiE=;
	b=LTA3d9Z0qpAYTMbXiCTkpO3zpHOQlrXLx+J7A3V4nnY9UtqB65FDcsRHw+9OS+amzqRMUx
	uInjG/A3G1qSlHAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 00/15] futex: Add support task local hash maps.
Message-ID: <20250220155756.A4uvp2T-@linutronix.de>
References: <20250203135935.440018-1-bigeasy@linutronix.de>
 <20250204151405.GW7145@noisy.programming.kicks-ass.net>
 <20250205122026.l6AQ2lf7@linutronix.de>
 <20250220151206.GB11590@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220151206.GB11590@noisy.programming.kicks-ass.net>

On 2025-02-20 16:12:06 [+0100], Peter Zijlstra wrote:
> Sorry for the delay.. got distracted :/
Thank you. I will digest it tomorrow.

Sebastian

