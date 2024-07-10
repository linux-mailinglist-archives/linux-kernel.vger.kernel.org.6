Return-Path: <linux-kernel+bounces-247052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA5A92CA53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B06D1C22551
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE98446CF;
	Wed, 10 Jul 2024 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1bGArdIE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aY765yiw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D017C9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591320; cv=none; b=u4ub3Ykf3zSCo1dW7wJvUmJvEF4m91sQs42KuzDzEcRHzlv7GGw9orV14FVZIMAUyukj4J5Tc76ruqpBR6YaPKYIWdFD95+PvTSW8eK6RtWONWS9qpm1c861agssyx19LTfVzyH4YlR/pCT7HA6g5Uv4W2zplXGunlAcAStoKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591320; c=relaxed/simple;
	bh=QDFuKbY/lFGtlFiMEK/m0bauR/F2ScuWg1EF/31L9A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9uN94sj6J4sr+57wqQxcjFnWo/PKjH1QoDw4K5Fq3OWBI8mweFNUIzpov7DvXYuP3FRuFhq/wqqYzafaKq+haKgfEH5lrBOaT5FkqmiZ15wNqz4Pa3M/D6jUhnAYGITxTBoMTpWhveWJuCIHHVy9AQRzCkOs7smv7e5KKtPfj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1bGArdIE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aY765yiw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 08:01:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720591316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFpeUUACA6NTNu3LnOhh72MWRdsJCh6gQP5+7xWftQs=;
	b=1bGArdIEO5lUJKNOScOJoD4pXU+iVhYkdcfsXtcKPLMjyfUWMjOTVRevnJ6G/FJQVvtd8F
	vam/RPc041BMhsGnkmtODtwsvV/DvLPDVB2sFpQRT+4YZiCbgcVnxpdFwHkaGGzBP4BCVT
	RCCqXMNA/9Whe2xuALb4XYTRcxuFxZC8oY9RnQu8vStJJexALO/xwudCl10O+UFIbHFcip
	lCKW9MQpsQExjrMGVsZz9GPfhOng6+fIsvcQUXhJ5jel6r/x5Yf28rEee0jh5SayclF2d5
	XZ5z2U9NkWw+9aRkIEqf3srE3JssJfMPGvskcV43irNTUrq3ymEDWdhQ32BSxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720591316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFpeUUACA6NTNu3LnOhh72MWRdsJCh6gQP5+7xWftQs=;
	b=aY765yiwoBLANlpGh+lK48587cnzfDthp1PKt6+du8XnLwrHnOYzuc4+8cGfXPwqOKHbhc
	+fI1qMYfT02nB0BA==
From: Nam Cao <namcao@linutronix.de>
To: Tyler Taormina <taormina.dev@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Remove redundant parentheses
Message-ID: <20240710060152.Qu9miO0u@linutronix.de>
References: <Zo2MTjKCM_UaLIGx@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo2MTjKCM_UaLIGx@localhost.localdomain>

On Tue, Jul 09, 2024 at 12:15:26PM -0700, Tyler Taormina wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: Unnecessary parentheses around (...)
> 
> Signed-off-by: Tyler Taormina <taormina.dev@gmail.com>

Staging tree's maintainer (Greg) disagrees with checkpatch.pl on this one
and prefers to keep these parentheses. So I would leave them be.

You can look up the staging mailing list for details.

Best regards,
Nam

