Return-Path: <linux-kernel+bounces-393153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E09B9C71
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483AC2828A9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F61913CA97;
	Sat,  2 Nov 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="cEGfSccs"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E0D13A250;
	Sat,  2 Nov 2024 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730516675; cv=none; b=m8RD59zvPQ72t0xk2hn2At5yf76jgr6BSnVV/h4Yu/WUcU7Sf8rodkXt3/pD/3GKSTaKNuAobK9+oH2Tr7CKyjm7BMZlYo19hd6T2gvMoBjvNuNpCLrNTlCiXj9yFCymJmE9xtys0O0uemNAOBwqzYhQP3NOkVysaKmh6lDSDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730516675; c=relaxed/simple;
	bh=EEt0MEjE4FFmpHsXng0O/SiotnzKihY6I6Ua5Ya3cRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMl54ack88zmeSqfASSYACQ4LKx3GEJnhweYBSMwYdXQS7S2w749FMN0adA/lq4AG0h66uz6NdkMO1JKxixEqlGA+ZwJa/cMU0A3GugfJukf0Ai8W0Nv3l+VOclrT0wspqS1GxxmTBCV6vkvWu2CdbMdnsnJrClu+qfWRbi4Omk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=cEGfSccs; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ANBeQg3BIZC2MxnhvEH4gAK8e61+0m9Yr8bFK4R/WhA=;
	b=cEGfSccsODcmEk9CfsTGs+7qzKJsdowUgKk3yHE6TbswYJQK+LWTLl2bjaUEWC
	HRuvDiNhmmhNcN8H7Jdt5eiOPS+lPw59MapV+SMuxuJj/0+X4tDG3voUt48AvXFU
	xh3iGWkf6Rptzsbsm8Z2tlsU8xHQ/EBS7ApOYWbqIublk=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBHk_2VliVn_Lh1AQ--.14550S3;
	Sat, 02 Nov 2024 11:03:51 +0800 (CST)
Date: Sat, 2 Nov 2024 11:03:48 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] arm64: dts: freescale: imx8m[mp]-verdin: Fix SD
 regulator startup delay
Message-ID: <ZyWWlA7sGuhg0rJw@dragon>
References: <20241024130651.49718-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024130651.49718-1-francesco@dolcini.it>
X-CM-TRANSID:Mc8vCgBHk_2VliVn_Lh1AQ--.14550S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAh2KZWck2JnQywABso

On Thu, Oct 24, 2024 at 03:06:49PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The power switch used to power the SD card interface might have
> more than 2ms turn-on time, increase the startup delay to 20ms to
> prevent failures.
> 
> Francesco Dolcini (2):
>   arm64: dts: freescale: imx8mm-verdin: Fix SD regulator startup delay
>   arm64: dts: freescale: imx8mp-verdin: Fix SD regulator startup delay

Applied both, thanks!


