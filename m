Return-Path: <linux-kernel+bounces-527253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B8A408DC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A514D19C4ABF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF23145A03;
	Sat, 22 Feb 2025 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RdvSu35k"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2702CCDB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740233230; cv=none; b=pxkuGvki0a7Nw6N9vOdhPoPAXq7lmyZITgLAd7Ph2Car1dl2fD4Q12Bolzy/OQUkNhNHBAofQFdOP1hfNEiIX4BiTA1iW2phSk7qv34DZe+vebRpMmGsmCYbdtv3eTijbfYGw+Dm5t6AJjHdotX1Xe+YqMDWiypnOB8ZnRBm7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740233230; c=relaxed/simple;
	bh=JoDL0HgW0R2+LYqjjV7VB0fAIsetibawAPp+OSXTa2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFAlNg0z19KlaJgB5gp+yDR1yQuUdY5GbRfcZszcn2p5Z+gl4EbhqFp6h4D/hcCix9vYPHla01he7/nfqUfKGcrCpS0sDo/4UGv68KLbqUL2796nDVAv4vCDpHbmXfLPj5sZ8eH4/I22Q2l4O5rUJ5NGz2luXcLWg9c8v5KGhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RdvSu35k; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 09:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740233224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12hDZFuuET8/IWzJSq6NgQOafKWg9FuiRIQhyCJLoy8=;
	b=RdvSu35kQh00+UMWrkD/XqwY0XX4VWxvG54op/SwI+fHY19hwjrTtimZk7lJCvnSuFIXBW
	2mPNNzj1sZJ5UCGSRkgWcBFwD2/ifJTTrcLAaNBpfN6DgUlUtLHfAPGrjtBLXsUJoBKfu0
	1YB/Aq1wCdPZz9nTdILrAcs4D/SZBh4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux bcachefs <linux-bcachefs@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joshua Ashton <joshua@froggi.es>
Subject: Re: [PATCH 0/4] bcachefs: casefolding.rst fixes
Message-ID: <rgtsg2xs422yj6mm5lykq24fj5hpqtr3aqe4cq2uj6fyi3okcg@dncvcfnx56yn>
References: <20250222091853.16487-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222091853.16487-1-bagasdotme@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 22, 2025 at 04:18:49PM +0700, Bagas Sanjaya wrote:
> Hi Kent, hi Joshua,
> 
> Here are fixes for casefolding docs. Patches [1/4], [2/4], and [4/4]
> fixes htmldocs warnings reported in linux-next.
> 
> Enjoy!

Thanks, applied

> 
> Bagas Sanjaya (4):
>   Documentation: bcachefs: casefolding: Do not italicize NUL
>   Documentation: bcachefs: casefolding: Fix dentry/dcache considerations
>     section
>   Documentation: bcachefs: casefolding: Use bullet list for dirent
>     structure
>   Documentation: bcachefs: Add casefolding toctree entry
> 
>  Documentation/filesystems/bcachefs/casefolding.rst | 13 ++++++++-----
>  Documentation/filesystems/bcachefs/index.rst       |  1 +
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 77308424ba26e1b41a7db5d4eae121841a707c05
> -- 
> An old man doll... just what I always wanted! - Clara
> 

