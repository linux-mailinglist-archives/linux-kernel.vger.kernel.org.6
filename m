Return-Path: <linux-kernel+bounces-391329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480299B853E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CCE1F21AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADA1193402;
	Thu, 31 Oct 2024 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LgLtC02I"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0266175D35
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409924; cv=none; b=Az7kYjMx97x43nxCDu8WoF9hx1aZCYO23fmZrArHwkDASe8jcIVlXOqkep/97IHxQXcJDRKoHrCWvy73ZSVms8hk4nrMCowBpJKU+bJu7zAxl8uVRLkgb37xiztNJM5J6vB3Y+xjNBp9o62WFUZeGUrjSNLSmUDBK2kSEbpVnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409924; c=relaxed/simple;
	bh=Y0HRg+Ah0ZrJ8O+NoB0/ML/YfYSZOijTLEaTUdCFHSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMg3lBhXFryTWUTQGK9RzPujBOTlldAblRH/k8gG9J66G8YF3I8FQp1L7gyuGL4GiGugJNN4gZ1RoKmvS5xvzP/TVxlPkf56exQHk2cH8MEQz0rTpNmYksjhOKNPGRd3ogAIy7ONJ9cbIVEIenOBCw+CFiyS3ifA5YMgNcDsgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LgLtC02I; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 31 Oct 2024 21:25:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730409916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rpwPAur6OOG903dB0I7FmHeas5Pcigjofj0YCcYcEOw=;
	b=LgLtC02IqhaAsW2k4Z/2N3nwAVVQ6XKY98n+2cSW+qCihnS8UbrPr3xK+O3mnsqejPeNnR
	YobFv7ffSlKOHgxQCngn0xTqugn/ziEIrW08jiH061uEA4TXAyo28dlJ3fEnE1B0Mt/oNW
	kjOJXhxHOhvit3DoMFNXvxO4iOJENbs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoffer Dall <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the kvm-arm tree
Message-ID: <ZyP1uPx0sqbSyxMu@linux.dev>
References: <20241101081245.4f49baa9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101081245.4f49baa9@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 01, 2024 at 08:12:45AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   e571ebcff926 ("KVM: arm64: Get rid of userspace_irqchip_in_use")
> 
> is missing a Signed-off-by from its committer.

Fixed, stupid mistake by ${COMMITTER}. Thanks for the report.

-- 
Thanks,
Oliver

