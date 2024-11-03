Return-Path: <linux-kernel+bounces-393758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F49BA4E3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C691C20FE9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C8158546;
	Sun,  3 Nov 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="cpgCf1s6"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C829EA926
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730625671; cv=none; b=GZap7HVD9Wv5+KgE5mZS2WdIGaty25WGFBwIniswWvN3hwW+fCyKJGPmgU0R6av1fGMuAgFTWJbS/RVLKeUPePaZ6Zi+k75WViZI31Olv23YMgnfSZO7y6bNRBw3YkXV7l0+u04ZEkbL+tzw9+9Lb/Ep4Mtp2V3qic+RMuKfjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730625671; c=relaxed/simple;
	bh=VEiFMNaHkGx5MrLRTGpbFJIk4D+Cn75e0zVDY8az264=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5+wUxS37Tr5OueYz3Q/WtdAgKIcdQJg3lZHP6SoD+PXFXOfw9av/Sa0W6wsQp0/f13M8k5qfy2hvsGRD4/iX3h8ZmeX/2mo7xY8LyZjxswTep8ltKAUYUMJzlHY1IYssAhaz4us51HMHvW7Q7ELk7RUoVQk8xEj+0yGwzsHn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=cpgCf1s6; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Hd3hoqAxo+sIaJnbd/+l3S6rvstB+d4XTwMycmbNR9U=;
	b=cpgCf1s6Pj+4pHo2nrO4q+eqjlO9emrkG8q+ttAhEjr9Lzp2Pd5B+yH7Je+RG1
	sPoz1GlDpCzUO2bPhpCaBNyPvCh88VCTCOAZejWAfldLoSKwXyIUU+xFxwWgLw/T
	Te1lHSyGtprDDXjncDec2YMFx/L+l0oBc3i/W1KYdIx2M=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCXX7ZWQCdnm9KRAQ--.15895S3;
	Sun, 03 Nov 2024 17:20:24 +0800 (CST)
Date: Sun, 3 Nov 2024 17:20:22 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: alice.guo@oss.nxp.com
Cc: alexander.stein@ew.tq-group.com, wahrenst@gmx.net, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, "alice.guo" <alice.guo@nxp.com>
Subject: Re: [PATCH v4] soc: imx: Add SoC device register for i.MX9
Message-ID: <ZydAVhFvHWCk6oNH@dragon>
References: <20241031065438.3912960-1-alice.guo@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031065438.3912960-1-alice.guo@oss.nxp.com>
X-CM-TRANSID:Mc8vCgCXX7ZWQCdnm9KRAQ--.15895S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxhFxUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQyMZWcmsdbyxgAAs+

On Thu, Oct 31, 2024 at 02:54:38PM +0800, alice.guo@oss.nxp.com wrote:
> From: "alice.guo" <alice.guo@nxp.com>
> 
> i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
> which are provided by the corresponding ARM trusted firmware API. This
> patch intends to use SMC call to obtain these information and then
> register i.MX9 SoC as a device.
> 
> Signed-off-by: alice.guo <alice.guo@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Applied, thanks!


