Return-Path: <linux-kernel+bounces-294734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809589591C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A92834B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454B5F4F1;
	Wed, 21 Aug 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LpsTILGS"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B84B5AE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199987; cv=none; b=TzxvoSqeZpynt95maVHOaKyQyg4q05TCaOh1dWbpjTNNX45oKLdyV1bb6D4z/WCGv2/PTdw4AtwqloG/u9pkeQhgv0Wxs6d5R0rApV8E4j6KfzrhO8CwI1KF2r8xINAbF4XYomCK5l6/BBtDG0iVORV5ixh69qOzDRvlGszgVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199987; c=relaxed/simple;
	bh=XWU3cpaXWnFcJWYsOpQ1j5T9Ey2nrSBsqbuHS0RVls0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBkPekKqnVTtmSZQWm4ydW58D+Dj6KUdQTIYQ635kAWNqJ7keLLcMoCkchZiWjIdrgzotIuneOfj1L/No8zXG5RKNanKsGIjc/syAo3TRSMPGNjEl5tsd254hyyl3m9T5LW3hXbRme5iSY5nqXO06B8f3MxLw5q9NaCHx8bkw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LpsTILGS; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Aug 2024 20:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724199984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9wpEZBoIigqU6xdar2WwMwVKxe0cZToqsFjy0lZ84g=;
	b=LpsTILGSTxaPlcsP1dCo0F8UmbmVuduOCElTEOS/AF6HGPmL8A2bO0I5DvId45a1wTqlw5
	duLG4D1RTl6rxcFOSP+mz/ByH7bEhQy/G2V36+PHAn93pU0uG6I33O96Ghzkhz5hm8y7J4
	yF+6t/Mz8+kh34e65Z4NU78t19hnLTs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the bcachefs tree
Message-ID: <ax4p5bbx5bpfggfcyfacfhd4gsmmeu6ryvvbs2fx3nzandwnvp@i6zcjuam5udv>
References: <20240821095226.0e7ad7f6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821095226.0e7ad7f6@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 21, 2024 at 09:52:26AM GMT, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the mm tree as a different commit (but
> the same patch):
> 
>   f01d25bb77d1 ("scripts/decode_stacktrace.sh: nix-ify")
> 
> This is commit
> 
>   2c4f6a68c6dd ("scripts/decode_stacktrace.sh: nix-ify")
> 
> in the mm-nonmm-unstable branch of the mm tree.

dropped

