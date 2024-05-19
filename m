Return-Path: <linux-kernel+bounces-183070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038FB8C941E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 10:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD4B1C20B16
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09B2576B;
	Sun, 19 May 2024 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IBuq5Yc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354E17C9B;
	Sun, 19 May 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716108794; cv=none; b=cg5PyLxTF0p9yZQH+f6Q51oOB9PHA4DfKiSOdoROGEMGdf9JfrMhgGx5tJ0kxgnLUA3/BHIQnQLIMEcinwpW6FI2SUAjh33BYH9fy2vlhqCxO7yTSXmVT5Gz+EkoOSSMSeF7dAP8PyFObPbQcP6QzdNGJW+AbxYtAoaQzOwEZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716108794; c=relaxed/simple;
	bh=OkqBkdyMVNgKTLHGmM2W2G4Sl6wOqdQaV04McuATOQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCDBsmvJR7ZVdfO/OyxmHTAJnU1D5BkrcStYzeivnzVjzr0tBc8a+TKAYQCR1wbTTEEPQLm4Yk5BMEbs5qsd+K1ROJMnpt2Dd26NmP4V+dQCo3zQCPMl68heQT0/jHiKI3xJ5ILN7uwmrR69MK7BfqxDqPVWKYwM7lXbnd4lqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IBuq5Yc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E542EC32781;
	Sun, 19 May 2024 08:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716108794;
	bh=OkqBkdyMVNgKTLHGmM2W2G4Sl6wOqdQaV04McuATOQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBuq5Yc42M73fknn1ZCdI+W5JoWxgmzF+MSe29OmTLB31MCmztlXZPuw4nAnyJEr2
	 wg0lEynF3Zc0qt3J/TJco3+BsIdAryT8wm6d3S3GTXALpjBbiALO4aGt67cpobtXwU
	 MBSoAqf+grgRdP2YgBIrKuapbqB1ADUK/BBpst5U=
Date: Sun, 19 May 2024 10:53:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-27406: lib/Kconfig.debug: TEST_IOV_ITER depends on MMU
Message-ID: <2024051947-hermit-yeast-3e15@gregkh>
References: <2024051739-CVE-2024-27406-cfc3@gregkh>
 <ot4g5zxesgwpzbgvb7yjazsgdxojktdph42qbw6pik3tvyswhj@kdo44nmnwwcq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ot4g5zxesgwpzbgvb7yjazsgdxojktdph42qbw6pik3tvyswhj@kdo44nmnwwcq>

On Fri, May 17, 2024 at 07:42:14PM +0200, Michal Koutný wrote:
> On Fri, May 17, 2024 at 01:40:41PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > BUG: failure at mm/nommu.c:318/vmap()!
> > Kernel panic - not syncing: BUG!
> > 
> > The test calls vmap() directly, but vmap() is not supported on nommu
> > systems, causing the crash.  TEST_IOV_ITER therefore needs to depend on
> > MMU.
> 
> This is fixing mising assumption of a testing module.
> The BUG is deserved AFAIU. The CVE should be reverted IMO.

Many people/distros run the built-in unit tests at boot time, and having
crashes is not a good idea.  So if you don't enable this option, great,
this CVE isn't relevent, but if you do, it's an in-kernel crash which is
not good, and this is the fix for that.

So I don't think this CVE should be rejected, sorry.

thanks,

greg k-h

