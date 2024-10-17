Return-Path: <linux-kernel+bounces-369782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C699A229B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AA11C247D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145761DDA09;
	Thu, 17 Oct 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPYY28+f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741961DD55F;
	Thu, 17 Oct 2024 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168867; cv=none; b=Mn4MmL4KJYHWaQKaK7EgqmQpDEm+5DFIFGk94acg3ZU4K4SHT6FiRhvUDmIwdsGwMambLTyE+fepyg1pg1s1NqHHWXz3jb8OrXHzjRB3kcqatATFlLLdfkecwsRao38C2sFh8YZIfrbvHluIgAdgMzaS44EQ0mx8f8QLr5MJaHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168867; c=relaxed/simple;
	bh=LtW4cH6RJ/U6LGh2Snc/2Z+gjm0u80RPvBaReDRovUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiAGz8z2FfY9Ybn87gp4GubiYYw86RsKNM/9DmbKqIrdj0M/OYkK8hKfmdh51AVkSchnSKOeEdU2mWiqPsFnRSyxIpkbpTxczlPJNtI6Koto7ePLy7xaTzAdk7NucQrcEFwKb1hGDnbpzxxdhUCIbTb26GY5ahTrnRR5WwQT7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPYY28+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519F3C4CEC3;
	Thu, 17 Oct 2024 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729168867;
	bh=LtW4cH6RJ/U6LGh2Snc/2Z+gjm0u80RPvBaReDRovUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPYY28+fhwc4pmigbR28drVzI/W2FB1fpX/kXNd5YYdkzH+v6cnTj3FF0nUgcoOU7
	 YgItldM3bwxpQM/fxlGdL6B04oP9RmJmpg8nqQLWvpD46CFYVBgn++N8sY3fQctpg3
	 W4V7w4VyRuhPH4/uR+tbLdFCxTWTo6hg/f4dg9f9SlIbpyJiL/dpC5Z/8C/+3jdqLJ
	 au9dsxX5a3gbMxeA4aMT5k2Fwew6MCCfjcHr3IU5HDHoQSUFTv0jhzqlct3DvAIpoS
	 eyyT893E4zX5SFzeEAlBlBEWxHc4hCvPuLq+POsjbeEzhedqd6/T28rtN4l3FIkDIW
	 9GycGACvP8NJQ==
Date: Thu, 17 Oct 2024 13:41:02 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 4/5] net: stmmac: xgmac: Rename XGMAC_RQ to
 XGMAC_FPRQ
Message-ID: <20241017124102.GK1697@kernel.org>
References: <cover.1728980110.git.0x1207@gmail.com>
 <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:25PM +0800, Furong Xu wrote:
> Synopsys XGMAC Databook defines MAC_RxQ_Ctrl1 register:
> RQ: Frame Preemption Residue Queue
> 
> XGMAC_FPRQ is more readable and more consistent with GMAC4.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


