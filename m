Return-Path: <linux-kernel+bounces-282539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F04294E588
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A563CB21206
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324BE13DDD0;
	Mon, 12 Aug 2024 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bM3szqdf"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8431C3E;
	Mon, 12 Aug 2024 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723433038; cv=none; b=Wb8jGp3UtFY1iGKf3mbLWl05gllMVGP0A+NALU1KJZ85ujoVzWlDVlJSLXu+8HIDQ6M23d5POPFA95zYY171dHGzSece+X0DW5vDKIdY2xM4S9t9ZsVjlrXu6EbBn8Md3/TptQFvaN0qT3wFCLPRNOgUDLj4D+hbDyprm8ULDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723433038; c=relaxed/simple;
	bh=xfpCQhn3U0gxPZTtAwQMWr9rme+W8I7i7rnG4+guxgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xuqt8Yj+nip/EbncxLbc5Y+wovjUj//pZKuSO/VqSh2oldOQFeMtdkELZ0HZMQIdR/LaVjy5THoro6IDICkGgILs7zUtGLZe8LdMxHDCaochq/JPPYuS9jM5M8SKC3XyQaYMXaAkMWM6pnYIRhGJ53DAGv7mG8wwSyaQBD9IxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bM3szqdf; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=r2fqcbW4eowzfLw53eCIKo5ZYNSqw+1v/v/btK3jwZk=;
	b=bM3szqdf2M3h71w5VEPCDhNxx1MAv+ULK0aCATLldDxvMKi7WagJoaGtfJ1zG9
	dytQNVKcNv3VN00z9x1nWRgTBmCc6M0PgLa5e3cG/N/CtPL65ASmjw/mwcsg+lFx
	KHyOpdOOsFKuKgU/2IPRB8wXndWV+2P/V4JpqPAA9c98M=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgC3X4QQgLlmaW9SAg--.33944S3;
	Mon, 12 Aug 2024 11:22:58 +0800 (CST)
Date: Mon, 12 Aug 2024 11:22:56 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v3] arm64: dts: freescale: imx8mp-phycore: Add no-eth
 overlay
Message-ID: <ZrmAECbFwAVSUg5M@dragon>
References: <20240710-bspimx8m-3180-v3-1-8ef55381172c@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-bspimx8m-3180-v3-1-8ef55381172c@phytec.de>
X-CM-TRANSID:Ms8vCgC3X4QQgLlmaW9SAg--.33944S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgM4ZWa4nhcbtAABsl

On Wed, Jul 10, 2024 at 11:48:54AM +0200, Benjamin Hahn wrote:
> Add a devicetree overlay to disable ethernet for boards where it is not
> populated.
> 
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks!


