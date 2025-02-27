Return-Path: <linux-kernel+bounces-537130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98758A4884F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F76B3B79C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397126BD9C;
	Thu, 27 Feb 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOIzM+7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2326B95D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682338; cv=none; b=Q5YTGor9eLoGZeZPLmmq5cCGc1CUpf5egvZWXrUL51doCRSASzDNGgHf1iPe5IgL4In1WO5uah1YsRPDHIzHbbUdKDAqPCjYRNpacC0JwTbJUZlGE6zxzpdk86ZscMtdFFxHQDOi9l2sxDtMW6RqclRYcsk+mN3/2+JO/AgNdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682338; c=relaxed/simple;
	bh=iZEYr3WPS7WmwFveTUVtD47soCK/VR0eQDCz8IwU/P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRfkyZK2N3DCqXjVTs6InKx7ndQ4jY/mb1N0Zse9n6CBP2XcPtdRkvFHlVqJtSEjulR4NxXvjjGgCJElVhOQ/PpcjGwuF0PNI/JvhWiGXPDNJ/XQD4ZRViPWobFM+3FKIIqoL5vkooYP2KtBlhVyEQli/VQXH6FqKglcpeJO5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOIzM+7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B89C4CEDD;
	Thu, 27 Feb 2025 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740682335;
	bh=iZEYr3WPS7WmwFveTUVtD47soCK/VR0eQDCz8IwU/P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOIzM+7pHGqcS/i2OhQnYq3impNLgJFTK5RwACFBXaZwsPewOTRKdx8sBWEGSCPBH
	 b3dzvUzIUBoXMhy/wOJi80g3gweexvoFXW9OsY7SJ0qaDdflTU+GEhGjNo0gQoqq+t
	 mZzgTIo1glZT7yIuOa8ZxOg8+gyFM0TmqW8v7DqGRRhfsHrl7tNH72LHx21lkeJKjC
	 A1OfOher3ROIX7CmxUuHWZ7r7Zk1pq6UWnBdOvz/9Dd6eOK+CLRMvlBFvOUWktvm3L
	 iDZbV1qKSRYgfHqA6wifXz9qNC+FmJg3pLhAYyWCULQB2g6G3vygugChVTH9h3+y4l
	 4vGKPTod3Ff/w==
Date: Thu, 27 Feb 2025 19:52:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC v1 01/11] x86/fpu/xstate: Simplify
 print_xstate_features()
Message-ID: <Z8C0UYHV9q10bKoF@gmail.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227184502.10288-2-chang.seok.bae@intel.com>


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> print_xstate_features() currently invokes print_xstate_feature() multiple
> times on separate lines, which can be simplified in a loop.
> 
> print_xstate_feature() already checks the feature's enabled status and is
> only called within print_xstate_features(). Inline print_xstate_feature()
> and iterate over features in a loop to streamline the enabling message.
> 
> No functional changes.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> I find it difficult to justify using separate lines for printing when
> they can be efficiently grouped under a simple for-loop. While this
> cleanup isn't directly related to APX, it felt like a necessary
> improvement, especially when new xstates are introduced.

Agreed, and I've picked up this simplification independently in 
tip:x86/fpu.

Thanks,

	Ingo

