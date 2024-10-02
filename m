Return-Path: <linux-kernel+bounces-347492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3603598D362
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26F4281B69
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF321CFEDA;
	Wed,  2 Oct 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEdnwvOo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA39194A73;
	Wed,  2 Oct 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872507; cv=none; b=XekUP/K5zFbPrc0rPkf8t8W/AFOv4zoQYkX7v7kkvL6WoshgsrOw6L7BdYnKG6sPQXG2dayBVgwwbqPgM2lHJvBcXXu0clcI+ljCUsGp6qQnqd+Ew3fMkLyQsqGIreyLsPPeq0LT44FReq3T6hG4MvoP6VazSiMBWsTiGKrPN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872507; c=relaxed/simple;
	bh=yf5Ab3qSdCZJZHKSago3avKnYBWupqkk/TCwAIHRrZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmWlBiGDKqVPQ+I86WVKHVUom4hk7vaAYu9ZTISAJEqFmhOFSmZImUOXt7uvntBCtavUATR3mgsmsPi30sXwPb/RQQ3HKG7aClm8LYnl5vd28zLBxOdE3cFQPZ+oLaTlAOPeBbVsWBcW9MzYfxiD4t1U4XKTf6Czha+kWOshyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEdnwvOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F2AC4CEC5;
	Wed,  2 Oct 2024 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727872506;
	bh=yf5Ab3qSdCZJZHKSago3avKnYBWupqkk/TCwAIHRrZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sEdnwvOoEy9rjqxQsgzOqe23y9hNv/cGFFTB6C3oIPx5ByDSNWlN62ArGp35im7Ub
	 X1FGmR/UODWp9Ac24ZLDgonyimEmMU9xU2dgxAP2Wfkuw44NDQxYRjqMM3TS3w3FnJ
	 lnq+yD8kiw7iaUpom+k12X8+U9jOyjiS5CDO9N2x8vrMmWLjWOrAAG7F4KRLdodd/N
	 v/+Evzwk/kAU7BEN8A8pvjfEbpusTCbSJXIUb/A9RetGus9nQzyUDR6/YjzrxoRVDU
	 1dcp6Qx+OgZOp1vCjnEHRcD7Uz6MU604hXsIdQUc+Inwlhd9Df4hAjusw17XK32Z0K
	 aAFMdEa2KzA0Q==
Date: Wed, 2 Oct 2024 05:35:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCHv2 net-next 00/18] ibm: emac: more cleanups
Message-ID: <20241002053505.324c6636@kernel.org>
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 13:58:26 -0700 Rosen Penev wrote:
> Added devm for the submodules and removed custom init/exit functions as
> EPROBE_DEFER is handled now.
> 
> v2: fixed build errors. Also added extra commits to clean the driver up
> further.

Please include info on how this was tested
-- 
pw-bot: cr

