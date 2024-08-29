Return-Path: <linux-kernel+bounces-307306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0D964B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1121C21A75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B91B4C38;
	Thu, 29 Aug 2024 16:21:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C721B4C37
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948486; cv=none; b=rc+h0Em8+feyAAZ7Q3mTOQw8gTLcEGhx2AX3rB8zgjZ/YNWF7XumaYqX9aPsdVbpzbfxSLilaTHTZmO4szGvEoZ8+n6yx6v//tXMXWpRWNOuA9U1Wnf/NYGTf26Ry4HytTRtoBR3gDuxLwOi2Q/el2iQ2319Eej++/XW96KRYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948486; c=relaxed/simple;
	bh=tOGtrJ7vQ/qhWKPWgynhRqVFVyhbxa9K0svqZXh8FGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX7cnIXm94XNmpUw5801Bkl1OADyFa3745G5RvpuDfARKgKnQYlQxOVybetiZTt6haTy4nVz1of3GZ7I8jZMhtk2hV5uKGS0lUbo4Mz1rhVyD3kV5+xDHbQZQgjljG6gaD6f+O9PEVQm38MJsBO3qLxcu6gQOJulb5PBJOnuwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 979A7106F;
	Thu, 29 Aug 2024 09:21:50 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91D693F762;
	Thu, 29 Aug 2024 09:21:23 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:21:21 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] mailbox: ARM_MHU_V3 should depend on ARM64
Message-ID: <ZtCgATsAkDCdbWC_@bogus>
References: <a391c86658d6c2e6d1aee583caa7a030731596d1.1724939823.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a391c86658d6c2e6d1aee583caa7a030731596d1.1724939823.git.geert+renesas@glider.be>

On Thu, Aug 29, 2024 at 03:58:53PM +0200, Geert Uytterhoeven wrote:
> The ARM MHUv3 controller is only present on ARM64 SoCs.  Hence add a
> dependency on ARM64, to prevent asking the user about this driver when
> configuring a kernel for a different architecture than ARM64.
> 
> Fixes: ca1a8680b134b5e6 ("mailbox: arm_mhuv3: Add driver")

Extremely sorry that I just noticed I didn't explicitly ack this change
though I agreed with it in the previous post.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

