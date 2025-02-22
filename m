Return-Path: <linux-kernel+bounces-527036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED073A40681
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE3B17F969
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4A2066E4;
	Sat, 22 Feb 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="EB/CgnJh"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C11FF7BE;
	Sat, 22 Feb 2025 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740214824; cv=none; b=BsY5pshPrQJxKGOcUYZQaAR/OaDSX5iC953Z09yXthfHP7LO/gvrfpZoLnP+1RCvjdntZltEsHrikif5gTmN+0W2H4VGx2qZlmZGj1mIk+YvaR0/V/4RokEo7RviTtXz73rVyFnSxbW4XiVKkbVe1hP+iYOehh/VnuHvmLzsnIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740214824; c=relaxed/simple;
	bh=1RsyIBrd/lKJdHWdJV0umjIe4T8GMvgP+vJ45Pl8ico=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5s2nsRD9IXzY00duBuAfgTheuEe+jqciVJFsiBWuMitoXMpCv71W13GIAj/NJq98CiGifzWXDapvqIKnS9tQ67PTGkXV39VjPCFDXItC6xMjBw5BYHjcvhqHvPv0cXzwZwNGoBYwMNbbPz8AfCgNJprM6TfcxPTgEnHaVwqt34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=EB/CgnJh; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Q6FAWBhfs60pu6OhdgDHuN8n9DU58L3ZOK6V1wpeXKQ=;
	b=EB/CgnJhBXtcC8VlgGWwqzGqGa8DAFbvLirRbGq24hVt5WpMLml7rdum8r6uY6
	iggN4S6DH6TtqioKjznyXtv6Lctwkz7xLkjFmhYjg9uDTMfrL7G8GCKpiW/UcIGM
	Cnp9cn/vcPpfqy89gC5Uj+ibqO7gPVcF/0OTVTdHIlDiM=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHKVLlkblnMNy2CQ--.23671S3;
	Sat, 22 Feb 2025 16:59:19 +0800 (CST)
Date: Sat, 22 Feb 2025 16:59:17 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	shengjiu.wang@gmail.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: imx8-apalis: add clock configuration for
 44.1 kHz hdmi audio
Message-ID: <Z7mR5cXC3p0IA67x@dragon>
References: <20250120094632.13894-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120094632.13894-1-eichest@gmail.com>
X-CM-TRANSID:Ms8vCgDHKVLlkblnMNy2CQ--.23671S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUc8nYDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQL7ZWe5dcBkgwAAsZ

On Mon, Jan 20, 2025 at 10:45:22AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Currently, HDMI audio cannot play sound at a 44.1 kHz sample rate due to
> a clock frequency mismatch. This update resolves the issue by allowing
> the sai driver to change the clock parent to AUDIO_PLL_1 when the sample
> rate is 44.1 kHz. It also ensures that AUDIO_PLL_1 operates at the
> correct frequency for this configuration.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Applied, thanks!


