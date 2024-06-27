Return-Path: <linux-kernel+bounces-231963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15D491A0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB55E283C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A90757FC;
	Thu, 27 Jun 2024 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="iyHkCtSl"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49A82D98;
	Thu, 27 Jun 2024 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474753; cv=none; b=GtxrqOXh/JxzhNFTxMtJmhd2sxeVL/bXt1W5AA72x3UDmnEvh2ncdsqQEu67xOkQKS/qdkA4rikWekMRc6zV/ukqVvNBQIRnfPe5/fTWs/pfN04sGwmjdcpc4svKBBWzIzOgeRHhrx+zbDHCx+wSw3IgkSxTc0BoCBR1pvhwneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474753; c=relaxed/simple;
	bh=CP61DuAhOiaPLVj/P5oJkJD6WfLnU38En/Bptcpi9xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqLTcplCbgE0Y2qWaHOzf4TAQP5TvZlohxh5Yh+FBcgC2KqCkwe1Oow3WL3Mx/JWz25lDl1ZHnr+RbKqamVdM+25mpahv6JL6afffRGng0Cj9nP2fgWP/7bSerfNBytcrKs8nMsyDMhBF7Oc5UyW8WetxKDKLsf9O8DdM8tOH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=iyHkCtSl; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Ch/0kjw+ijLB7Q66Qm2SnEbwqYydHBlsULmBzoeBAX4=;
	b=iyHkCtSlB8SCvD0M1Bx0CMk8Llrgkc6+Yh4HxVdcHgTHs8PU4o2jSyi8KW7XJe
	lS+KsHkHNEOq0MrC2EiLOUuTfCSsf2hZUFkyUXl/U6rxe+j43+vA2QfGh2jIqlUx
	QTZSoFNeFqnuqu1je4QrWS2f7hKJ7yDwgFQwiy9j7zZoc=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3H47lGX1mYN0ZAA--.53086S3;
	Thu, 27 Jun 2024 15:51:03 +0800 (CST)
Date: Thu, 27 Jun 2024 15:51:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: add DP83867
 configuration
Message-ID: <Zn0Z5em1knqGLO2w@dragon>
References: <20240618200900.1741251-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618200900.1741251-1-tharvey@gateworks.com>
X-CM-TRANSID:Mc8vCgD3H47lGX1mYN0ZAA--.53086S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVLvKUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgcLZWZv-czVVAAAsS

On Tue, Jun 18, 2024 at 01:09:01PM -0700, Tim Harvey wrote:
> The GW7400 has an onboard DP83867 RGMII GbE PHY:
>  - add RGMII delay and FIFO configuration
>  - add LED configuration required to use them via netdev trigger:
>    two LED's (LED1 and LED2, skipping LED0).
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!


