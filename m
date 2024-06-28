Return-Path: <linux-kernel+bounces-234598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84DB91C86B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786B1B23C34
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE780624;
	Fri, 28 Jun 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AORxbsxP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4F80020;
	Fri, 28 Jun 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611270; cv=none; b=clgs4KBMVvFYqUeH86NMgQUzepU6hiI5yPT2uppQ8KAAVA6tilZ8YWLkNCABBBTYp1OzSwV2fhToxbfbcg0VGyc7DCSHDXZRFpqEPuTqyVMSzV2R+neQj+1hTvoaia0aYlzum8qpRipnr2EAyONEIX8oZs+9pBKY2hhOJOp9pZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611270; c=relaxed/simple;
	bh=IBc0CYPamY7pDeJJ43X8GTYDFhvoT6MaIAE1S29b2d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjhpuBvXcrtwObBxVFMdpRMp+1dhLTmY/tK3ja4WykylIuiLB52z9LTzMQ/OHVJG/2hY/DbG+56gQ6cehPdpDH4lJHoOVpFL+HUOHEwQnk9UPMM6g6Ywbr/rVF1Afgyz1y3fMZzNAyDgHDb7KBYvx1uZVJQen2W7woVDs+a9Mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AORxbsxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03868C116B1;
	Fri, 28 Jun 2024 21:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719611270;
	bh=IBc0CYPamY7pDeJJ43X8GTYDFhvoT6MaIAE1S29b2d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AORxbsxPRWbzJug5vWfZZCe/qUA0/8exXctT+IVd9tbVaBss0yDcTFeLyO0Fv5jYV
	 RDuvgRHHtd+j5ETzBseezP80GYrHGtYivvyfS3XISCd8krIMQA9djIA/MTvYWbWCnP
	 zYu5/EOf60wwQL9y1KKLTFC3xNH1tuEeHnNeXcDVSyPa6J2UxoH4KUQGNNTbu4UkBK
	 a8xE5Y8gx5uqaCAK2gr7xeE+XJxfWvUM/xQGprmKn3uu9McHNzBRg/zR06SUJv8lHU
	 1M0sGMcGjEVxrKYQAHXNYHOjSwlfi99Qszj0KZYnzO9v5pGQq5CkgcUJqaQ4HgsDDK
	 nTUjlvGs6vDnw==
Date: Fri, 28 Jun 2024 15:47:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
	broonie@kernel.org, shengjiu.wang@gmail.com, festevam@gmail.com,
	tiwai@suse.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_rpmsg: Add compatible string
 for i.MX95
Message-ID: <171961126622.265750.10175458936157332851.robh@kernel.org>
References: <20240626071202.7149-1-chancel.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626071202.7149-1-chancel.liu@nxp.com>


On Wed, 26 Jun 2024 16:12:01 +0900, Chancel Liu wrote:
> Add compatible string for i.MX95 platform which supports audio
> function through rpmsg channel between Cortex-A and Cortex-M core.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


