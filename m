Return-Path: <linux-kernel+bounces-512622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9AA33BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BF93A5913
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E820F06D;
	Thu, 13 Feb 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BuuNI85o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDD20D4FC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440318; cv=none; b=PzjYeNdD6fuyerfVm4GWTJovJctLFXwNSUUbdYvK538U5/UJ3YQa+Aeu8wYyaJmLOodrZbk0yQpVu+hSWyO6i0CgjSMCB+DD3exNn8I078fS70+xNv6EmbmeMOSRoU9C9GtfmjHhUrOJtNygMberyNkiPI8ODu9LFbb2k5AJ/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440318; c=relaxed/simple;
	bh=6N2+fbfxcDI9Fdms78thpwbZ8Rd9JuIdpkN1DJzK4fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8/duZFjuAp+0cxzMSvbTT1gKvW2Jnh/AXMd/Xpexi5gBK5A+19D1XRTIvnGv1LjWM2C8n3wHemgy/i3rhVKgUCjbwX1bKeY/Thqpz+ME5G0HbXSumKns8Z5pTUykJ4OHAFsw615YXtsEEgImVgNfW5irHHZihGEet7FpVY4mSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BuuNI85o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556F9C4CEE2;
	Thu, 13 Feb 2025 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739440317;
	bh=6N2+fbfxcDI9Fdms78thpwbZ8Rd9JuIdpkN1DJzK4fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuuNI85odlBNVCT77QpNuQsLRqoP0HQMPghKOCDad75bev6YCC9UfmLDLd+pMmSmc
	 FapSAcwSWzrCze13lxLCe6sq9ZMHckCWIx44os8pknOsAhRMqsF/Z+s+t0m8bxCZOG
	 jyOj4Y6C4LnDnNslBgXbeLwzVrqpNAz/10WeG9yw=
Date: Thu, 13 Feb 2025 10:51:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
	alistair@popple.id.au, linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH] MAINTAINERS: change maintainer for FSI
Message-ID: <2025021301-deniable-sequester-5a72@gregkh>
References: <20250212170827.1477102-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212170827.1477102-1-eajames@linux.ibm.com>

On Wed, Feb 12, 2025 at 11:08:27AM -0600, Eddie James wrote:
> Due to job transitions, both Joel and Jeremy can no longer maintain
> the FSI subsystem. I will take over.
> I also removed the link to Joel's FSI tree as he won't be maintaining
> it.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> 
> Since there is no longer a tree associated with this subsystem, can we rely
> on you, Greg, to merge changes to the FSI subsystem? Or will I need to create
> a kernel.org account and an associated tree and send you merge requests?

Just ack patches and I can pick them up from the lists, no need for a
kernel.org account for that at all.  Or you can batch them up and email
them to me when you want as well, which ever is easier fo ryou.

thanks,

greg k-h

