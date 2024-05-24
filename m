Return-Path: <linux-kernel+bounces-188836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC88CE7A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4771C21D36
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A2412C80F;
	Fri, 24 May 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HIop7gvi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30E12C49D;
	Fri, 24 May 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563844; cv=none; b=ovTbZaYpCoSfJgUFM7r9HN34KBRcOc+PMh8Bb/WFW/+UzCo195IqcxdJxYs7LhqSjG4Ho9Wgpr8F9zeqUhDAUmvQXXu2XWjsacPL5Ud3VSgqRgSjJ0jKsV0uGBgZlFAbAJ14CbnNxLqiHw7+fQUWhrMWpUYBYvbDJy5L3Cd3rU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563844; c=relaxed/simple;
	bh=54cN2pcgiCJTw1IxV7vpRaf7KqEcvY8gQcKJg5eH5Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgzZIOL2KiwVz2BIqM8DGUSHNRVLF4S2WCU8PysRgs0CBrvosb/r4Ryt9P6/l/oFkSzViEj6gh3Pu5PnycXS2S3VoDSPA93dofWcVHmUG7gz5WE7EW/Eu/gXqpAPG/Dl6zvek3Kp5XVtFW2GUf6s0rZOyF8jZadzOh0fAuQrbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HIop7gvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A819C2BBFC;
	Fri, 24 May 2024 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716563844;
	bh=54cN2pcgiCJTw1IxV7vpRaf7KqEcvY8gQcKJg5eH5Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIop7gvi9u6mGA2YX9oMWqdC1d2uta++uMhx4BD191nFaHDSBXjlts81gq0jGypwD
	 4/aH75ylsX5ZxKM7+O3GR3sirjJXLEVArraT0IErudUWesaKG0lj/GDp3b/86p6giF
	 +0Jobg3gX2iPZqOMbU10361DHBP8xznPep79msQo=
Date: Fri, 24 May 2024 17:17:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Anthony Iliopoulos <ailiop@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26821: fs: relax mount_setattr() permission checks
Message-ID: <2024052452-undecided-nutlike-ecc1@gregkh>
References: <2024041702-CVE-2024-26821-de6b@gregkh>
 <20240514124939.77984-1-ailiop@suse.com>
 <2024052328-favorably-gesture-7495@gregkh>
 <20240524-denkbar-rechnen-470d602cf601@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-denkbar-rechnen-470d602cf601@brauner>

On Fri, May 24, 2024 at 03:16:07PM +0200, Christian Brauner wrote:
> > I'll defer to Christian if this CVE should be revoked or not.
> 
> As per my other mail, this really isn't a CVE.
> 

Ah, yeah, this was rejected over a week ago.

