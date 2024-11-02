Return-Path: <linux-kernel+bounces-393197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E741E9B9D8E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 08:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB5E282411
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9BE15539A;
	Sat,  2 Nov 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NVy63dFm"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F61F94A;
	Sat,  2 Nov 2024 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730531305; cv=none; b=P1HQLjXQkFkwy55isDUNjyd+13aLTLoSlAAJcj/e/ZU6XN1NFk8Cf6rPGfXEHFNoaZSAhVnFxrgrK9ckMjzCutu3bIvY/pZzTDYUjj5eumKwwRdvo4t3HGsrh/jvLSMaJE6Hd8qmnbd1b3YoKVBhDhh1OYIWSIebi4+2QDAYQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730531305; c=relaxed/simple;
	bh=HyMk/j65phlFliQ4KdfkM5Tx49kM9Fw3F3jacl8vCEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3VAcAot06Cmr0b7XXX3+ZStry8W74y8jHW84PWSeuWJ2MbMS2oYudgg98Bc6/hpbgJLmazqqgAzMhLquCh2KNet5LA9Xx8rnrzGaMUfc8p1UrlrrxIl977BIeErOlvR7RsZAfovllOFn2NxJyIMk9KG8DRQndSX3KtHajDyFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NVy63dFm; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=SSPQBPU9VpGhI17i4emlrIw4t8MerKFEhaezHfQMv1o=;
	b=NVy63dFm47y4WN43OQDZk59kI1f5y4gxJX5UFAvTD5wB2zbAD5gIqHIveGd6uv
	sSpVWkI3GYQxOH2iNQiWRF+3rRR5dtrO45Cdbkmmg9qixIvrKYG98kDe/7rAgaeR
	eei8OZnLyqk2Bkta8J0lX34Cw/D3LrDml3quSXo0RDAs8=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCXl526zyVnPL1+AQ--.14928S3;
	Sat, 02 Nov 2024 15:07:40 +0800 (CST)
Date: Sat, 2 Nov 2024 15:07:38 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 resend] arm64: dts: imx95: Add missing vendor string
 to SCMI property
Message-ID: <ZyXPugjIFe9FOpKO@dragon>
References: <20241030095555.222143-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030095555.222143-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Ms8vCgCXl526zyVnPL1+AQ--.14928S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVg10UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCw2LZWclsr877QAAsx

On Wed, Oct 30, 2024 at 10:55:51AM +0100, Alexander Stein wrote:
> With commit 7bf46ec090b9e ("dt-bindings: firmware: arm,scmi: Add missing
> vendor string") this property has 'arm' vendor prefix. Fix the property
> name accordingly.
> 
> Fixes: 61ed94cd54e3 ("arm64: dts: imx95: set max-rx-timeout-ms")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


