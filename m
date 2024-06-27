Return-Path: <linux-kernel+bounces-231966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B1891A0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D061F2212E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B836D73440;
	Thu, 27 Jun 2024 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="o1Dmlyfc"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C636BFC0;
	Thu, 27 Jun 2024 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474843; cv=none; b=PMFH3FWfZkcxIxCmHvzoDZv77rtQq15TvcQARdaAKXreirLTMKIJWUQgpUVCCZR2/4d1y7a840KYxN7gUXPpVuvrrtewmQhTWtUkeQNZHZzsFxBOfeQCBnRMcgmuqDqbSjno+XRMm/RX2W2vaeqJGQergUOj1C4RpbI7TVkmIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474843; c=relaxed/simple;
	bh=niWifPxthY5pGSj0MPq+gFtzhUAaPd89u2s14QYBBds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALs3mlCc8zqQCQelS7a1CW8RQL6R/+JmGaK+nlxJfm4oQl0m14i+mTRHVWlrohZQTijIgG39YLIxGeJPsMlpTg/HiVywS4bL8IPC7TM4KoL+Lnsk2AvPcbYy2m4JiVVkL0llnxvoQWfuC0tlq41TvzAu3m7vVJ3JOlOysdRmwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=o1Dmlyfc; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=K/1iSBKlF5A20UDlARtUeGLpv4GEubEh9JBHFml2Ows=;
	b=o1DmlyfcjqqUdXfNYnY3nFYhnI/mw80C/oiJGotW+iWgIDKQZwwSjl1avS2h55
	ModLw6PrC/dH9m2+j1h0MKFTzjO7Jgv9BXO3vne3hFt5sisZE92ohsIIIPv8WmkM
	KBWECYLMNSLiGeS+UkMiaKcyWqTcazvbvmVM0UTsrZpBg=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXD8rZF31mmaMaAA--.52532S3;
	Thu, 27 Jun 2024 15:42:19 +0800 (CST)
Date: Thu, 27 Jun 2024 15:42:17 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio
 mu5, related memory region
Message-ID: <Zn0X2dMZaQ93vwHC@dragon>
References: <20240617184707.1058995-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617184707.1058995-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgDXD8rZF31mmaMaAA--.52532S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3oGQUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRsLZWZv-cxqVAAAs6

On Mon, Jun 17, 2024 at 02:47:07PM -0400, Frank Li wrote:
> Add imx8dxl_cm4, lsio mu5 and related memory region.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


