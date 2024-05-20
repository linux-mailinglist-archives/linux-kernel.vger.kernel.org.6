Return-Path: <linux-kernel+bounces-184107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC68CA2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6FB2828CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A421386AB;
	Mon, 20 May 2024 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt2ig/R9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6CF137916;
	Mon, 20 May 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232845; cv=none; b=IBDiy0Zy95JHm2DfC0l5Ip+RCvzk8T4d93cTVOXptKuBFxxuc2LJqfzRapv5GezTXofOzBz+kAA/gAJ6O0eKW5v4S7jL6DNWM+zSrtWwwM6D1M577+Ee144Hr/w7VVlLY/n5ddK804uX777RHLQZsVRFapE5m+v0PVzgdA7AIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232845; c=relaxed/simple;
	bh=oFOkhPb/obahsAYRZ9KsMVQHApqTJjpvtfnG0CAlpL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeJayvSoACwloymUYO+mK6QAyn5/CQ1PD2Rf/7uITHdV+yarDFFMvUBKTb4rk+untUteksKm1E1lXq1DrM9AkJXjxcig5iWRewruTD6BxQohRUv3HZnT8K+zRrHxaqGRqdim1pSbEdaAIw0ej+Q5fJqLRcNwwCH1oGOXV5KwplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt2ig/R9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCBDC32789;
	Mon, 20 May 2024 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716232844;
	bh=oFOkhPb/obahsAYRZ9KsMVQHApqTJjpvtfnG0CAlpL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lt2ig/R9v5B6a1wGEekuUUBqXgEerDXXUrGoa8lJHvufZ51MMeCMHexhklXZbZhg8
	 vfNC1H1ooY4LcBXOl3+rHwdPa4vjnV9xCqa2TkR3RP6wjE6nt0I0Ev/wu0/8NAFLXW
	 aGL6iOT8jKAHauOPvxlSlOtXiGY0T/NLOwSzs/+qFOspLziNcER+wgLZON3rinocWg
	 08JOYx58n3YhEH85EAUmuiPG690CaBLY2hSnUp+galvrh+aE048NmxbI7kny6CdqPy
	 kUADJod8DxBjFyaWszuhydhgWVTl/SgXtZm6OlOAERCm0mHb+EPlvAQ9JCIovH/sgi
	 uXOAdIKwl1o/Q==
Date: Mon, 20 May 2024 14:20:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: julia.lawall@inria.fr, javier.carrasco.cruz@gmail.com,
	devicetree@vger.kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH][next] of: property: Remove calls to of_node_put
Message-ID: <171623283323.1344625.8429412262018055075.robh@kernel.org>
References: <20240515202915.16214-3-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515202915.16214-3-shresthprasad7@gmail.com>


On Thu, 16 May 2024 01:59:17 +0530, Shresth Prasad wrote:
> Add __free cleanup handler to some variable initialisations, which
> ensures that the resource is freed as soon as the variable goes out of
> scope. Thus removing the need to manually free up the resource using
> of_node_put.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> I had submitted a similar patch a couple weeks ago addressing the same
> issue, but as it turns out I wasn't thorough enough and had left a couple
> instances.
> 
> I hope this isn't too big an issue.
> ---
>  drivers/of/property.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 

Applied, thanks!


