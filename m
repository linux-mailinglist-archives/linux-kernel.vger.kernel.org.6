Return-Path: <linux-kernel+bounces-282544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF8494E595
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8061F1C214E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9619313DDD0;
	Mon, 12 Aug 2024 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fgxiUJm7"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396B52C9D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723434086; cv=none; b=GyNA69YsSFw5e2rF0MSt4PmyKXd9YfUi985Hx2VbbSAVaKiShNy/7sEt5SAxtkQuT47z6v+RFxIOroAWrU2FRK/K8+5MJPKQtff8drbLp97RAp1H9mwx7Yj6DolLpPVnh1U2b4ZXSSgekFukPkdHTZYACCtTsIdHsw59BX9loOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723434086; c=relaxed/simple;
	bh=WPPo+c8L6JEw/7zdzIytCLTOibLk3e2BhSzBEunZfZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpneCZjD+DWlLAqPKh1GoGxd272hkRSw/moSLwwYg2H9M9kWaea/1W6Zw8tFIh5zB3iPE+0Q47gR6r2crNU03O8CTLfk8yMeH+MsDco3QgUMOb+xkweriPI7qggrudhu1Q2Om/jQKtIUnQRn63yPaXPIfdEx+ouPsf5e1RBBdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fgxiUJm7; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=CiYD68+jwxzfBs2LVkopYRwEFBZhk0PMOB939s68MjQ=;
	b=fgxiUJm7RKtAzaMUH0dFP5e5Lx+itleIMzAcQuBDlUq6F0KbXruxkEisCsLC5T
	/yTORZ6HCe47C0Ty7L7LlzqicCNfHTkMEjR8AUtUUKaHQo0MDmW8Zz3RwLWoAeWr
	T5F70TfzXuYsgbl5GfatMO/ojOiOOs4t4bPsygtq/U/8Q=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAXPydIhLlmejJGAg--.38372S3;
	Mon, 12 Aug 2024 11:40:57 +0800 (CST)
Date: Mon, 12 Aug 2024 11:40:56 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL driver
Message-ID: <ZrmESMKrhIv/+32l@dragon>
References: <20240715123635.2894222-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715123635.2894222-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:Mc8vCgAXPydIhLlmejJGAg--.38372S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7Vc_DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgc5ZWa5gbYKNAAAsf

On Mon, Jul 15, 2024 at 08:36:35PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable i.MX SCMI Pinctrl driver which is for i.MX95 IOMUXC settings
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


