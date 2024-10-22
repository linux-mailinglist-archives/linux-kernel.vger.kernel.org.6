Return-Path: <linux-kernel+bounces-375544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482E9A972A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E31F21D19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877EC13A87C;
	Tue, 22 Oct 2024 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="iyaj3Soq"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A6256D;
	Tue, 22 Oct 2024 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568202; cv=none; b=kjriErWMke45MkDEif5/Bf6Ekc0LoqywhH8UYY/jPryUd02/5KHL5S8ZzrdXJVRrdOAMKciEnAeUSxlP+fOugIo4owjan9tJvn/7Dy3feRZrbYhecJCGfEt7szGnhJHgv+FKtMV/ssmpUXLEgOi5K+BRUAiLF4p3vzhTZkZ9kRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568202; c=relaxed/simple;
	bh=aDWM3Tsm/QnlSB4T1eEAl53wu1sl3BOYUKQW+rM+Dho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT1HfXt7eKS2dQtaKJtYVwyKQ2naK5L373y13Y5IteHXgdmtFMkbENgB2UlSXbAVlSJClgNvkWyvU2i+UB6J7/QTsMBA/sj+lsgyEanbCvJmUlLERR6TTeBLOWDtX+NBuoaa0oi+0phvbtkQuVf1XL18tG8Czc3bSIbnnQ3QqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=iyaj3Soq; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=thn0AY0PIXWYmip1+zVuTvIXO66qKJV0eJxybGA31Cg=;
	b=iyaj3Soqwf93MEBn23OahSPitJyKJkrUWibScwUsGhCEpph17cJ0PmkAMylhuv
	k9ASoVrcwuhXTxceoF0Xv1rPEh5YNsbROyeW8G572iQ6ZlqJCghmpesoLBEKM36s
	jh1+7ewO2ncUZdlHMlRU36cjPjdMkPczHAMwByUAt2Bso=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBnb9erHRdnk9aUAA--.5381S3;
	Tue, 22 Oct 2024 11:36:13 +0800 (CST)
Date: Tue, 22 Oct 2024 11:36:11 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v3 1/4] arm64: dts: imx8-ss-hsio: Add PCIe and SATA
 support
Message-ID: <Zxcdq6HN8n7Ri8xv@dragon>
References: <20241021190602.1056492-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021190602.1056492-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgBnb9erHRdnk9aUAA--.5381S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVOzVUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQqAZWcXARRp3wAAst

On Mon, Oct 21, 2024 at 03:05:59PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add PCIe support for i.MX8QXP, i.MX8QM and i.MX8DXL.
> Add SATA support for i.MX8QM, which is in hsio subsystem and is shared with
> PCIe PHY.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!


