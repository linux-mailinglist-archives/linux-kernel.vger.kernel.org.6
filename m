Return-Path: <linux-kernel+bounces-519694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EFDA3A0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D87D16463C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67AA26A1CE;
	Tue, 18 Feb 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozcwuBjT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A59238D3B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891199; cv=none; b=mZ+8bXrkSixj0nmAW+dQtiLkFa9pOcUrhx5Sd81AnStVOhfb9gkvRTl1ESDZJ+Lb76tn7qlfqDZ0zbn2G5U1KxwRHw42ghMofwzNLVDNY/Y5EmN9m9gBC8WKSP8YwMHTqW9EhKLJSUCoAAEPe6M4gOeziQ8oLhqMCpBQurk59Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891199; c=relaxed/simple;
	bh=sz4N5tO/fJWbp+cAUSYMXY5DgjhAHXhhf+KTPoEqg/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGaBIXfIONu+22O7xo6uFNZpUf40lAhrNVl60zZaUCnP7VwFVFz50DEMoes5M50VOX7jN2vdSwz6EGZ6b27P2n6atDtz6Vwrj3EXWHTOTjq39g9vMz7/gb9Ud0+CxTANibOL1OkMyTEn3Fubpc0v5Oo/0AGIghbphCoR3kOgW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozcwuBjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAFAC4CEE2;
	Tue, 18 Feb 2025 15:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891198;
	bh=sz4N5tO/fJWbp+cAUSYMXY5DgjhAHXhhf+KTPoEqg/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozcwuBjTtj9GQB+fl2ugEZFQ4GdbUlFOYHkxo8Ruj77txZxs3SulLsMKwQPhXM7Iq
	 Ml8zSjJdz9xxbleVNQusrNKA/jxbIydBWYon/TkMWqXFJnNZDore2CEPA/7alCvYPB
	 J35hKoKR82lMC1riG/J2vOLANvRsgArb/jA/Ht+UvG4Whgxuq3hpwOSMqklNVtYs3X
	 f7T9D6NBpr4+KgNnLpBugEHzSHS55MKjFkrp/Y91vj3o+JjPaEVuEmciIr7mSuP41i
	 uVVJFKMZCKgxt4eLWxJyucFly/AV8yU0h3NHwLywebMASEKePphqcDO53xGy7aw487
	 FHrdEqXDi3nIQ==
Date: Tue, 18 Feb 2025 08:06:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>

On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
> Keith, Christoph and Sagi,
> 
> This patch has been fully tested and analyzed by Red Hat's QA group and no
> unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
> have been tested. Our QE engineer has asked me to report this upstream.

What's the harm in leaving the parameter? *I* use it so I can test both
ways without needing to compile multiple kernels.

