Return-Path: <linux-kernel+bounces-356721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BAA9965AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37F51F22B63
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5031D18B465;
	Wed,  9 Oct 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pCgKX5iQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE1032C85;
	Wed,  9 Oct 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466845; cv=none; b=plAdSou4DO6Bl/Gj3BEd4Tb6adUYpRBefpLcoxlkRDJwYUCJ4cP8qDo+Lgzir1Z8V7u8SQhf7yLfnIY2RoBBn2pFutwe5EQWIcb3SK0UMuSQ7o0Y7SY3WmQ657/c7AbWYJUEYMCSknYttxoGFS7B2/cvuKdOPGh44rPvIosnL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466845; c=relaxed/simple;
	bh=E2Yu2Q/yXRle25rPYQMsPtebi0Qs8XsAc7K7IOn2byM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5xdvR21v4hbEYp1wlI2+iLXNZAyMDfm3kqbJqnMKosiO0dAevpT3ARnVP6jlQdn1BkofPY6IkGwP6uz5rSLT43Lcv6CZVWgL4FMjnGMw7sTBnieJFKIpdzKVi461vqZVz1WR344KBTUR1OR/C7u99r+5RuVmX0ywpXja37s9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pCgKX5iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA342C4CEC5;
	Wed,  9 Oct 2024 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728466844;
	bh=E2Yu2Q/yXRle25rPYQMsPtebi0Qs8XsAc7K7IOn2byM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCgKX5iQmosIxLMSC5rH5IbCcokCBjd22hnyqib9Opc7/ArS6Bjkg3wMsVIlcioCR
	 N7kGs5xyLWGD4sm9NWak1eP5Unjyy9616kjfH4omFNEBcEk30NDfZVJLeTCKWI53Vz
	 WvjGCpySYM0u7iHsLx3k9MCoWgVZNTarVkVGn/4c=
Date: Wed, 9 Oct 2024 11:40:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Richard Meek <osl2008@googlemail.com>,
	Larry Finger <Larry.Finger@lwfinger.net>, Xingquan Liu <b1n@b1n.io>,
	Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pavan Bobba <opensource206@gmail.com>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Joe Perches <joe@perches.com>
Subject: Re: [RFC] staging: vt6655: Proposal to delete driver vt6655_stage
Message-ID: <2024100923-player-directive-ffa8@gregkh>
References: <718c0476-c4bc-4a72-a1e4-483697c7eff2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <718c0476-c4bc-4a72-a1e4-483697c7eff2@gmail.com>

On Sun, Sep 29, 2024 at 10:09:02AM +0200, Philipp Hortmann wrote:
> Dear Sirs,
> 
> Forest Bond contributed this driver in 2009.
> 
> The following points let me propose to delete the driver:
> - This driver generates maintenance workload
> - This driver has a maximum 54MBit/s as it supports only 802.11 b/g. Peak
> throughput is 3MBytes/s but this lasts only for a second. Typically
> throughput is 1.7MBytes/s.
> - Depending on the number of devices on the channel the device looses
> connection and cannot reconnect for 5-60 seconds. Watching a youtube video
> is OK because of the buffer. But surfing can then be really a pain.
> - Its form factor is mini PCI (not miniPCIe) that is really old and large.
> - Hardly not to buy. (https://www.ebay.com/sch/i.html?_from=R40&_trksid=p4432023.m570.l1313&_nkw=vnt6655&_sacat=0)
> only 70$ ;-) including shipment.
> 
> Former Maintainer Forest Bond <forest@alittletooquiet.net> is unreachable.
> 
> The staging subsystem needs to focus on drivers that support usable hardware
> that is available. Newbies can then get the hardware for some dollars and
> play around which is fun.
> 
> Please consider that support will remain for years in the longterm kernels.

No objection from me, please send a patch deleting it and I will be glad
to take it.

thanks,

greg k-h

