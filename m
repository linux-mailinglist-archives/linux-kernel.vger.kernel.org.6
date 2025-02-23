Return-Path: <linux-kernel+bounces-527616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E40BA40D53
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E99317AF0A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2D1FCCE8;
	Sun, 23 Feb 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VeBopwtz"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA871FC7C8;
	Sun, 23 Feb 2025 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740297542; cv=none; b=po2YPVSzR6mZy739adjxkcCUC3HkhZGXjds3q7Z+feWwUM0+LZNp6CI3EM7ocDl9XPQShcThrc/GK23Yw4AgoCJXN5TE/kEZRR9pRqhD5WVVM8T+/tIU+m7bRH7Ef7krdvls3mA68M9s3IB676PR+5/quI4MIRX6uXZBSqpFlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740297542; c=relaxed/simple;
	bh=Oz3P9N3xl5usKcUKWWwm/yarUuwrPLqlOqj5lKlurM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRA9duUGDo9k2Z/YVjCupnmMMVAlKs4EraeCI29nzygQaazkB+cYo/Ch0dn6RTSgQBd3/Wy52SbmX2SXLbjNC2Nsj1iYy+4BAInseId8F5bQqUMkdXqCUDUn3Ybz69BPY6pucEN4HsrBCTlgFoNNgSfbiMaBmulBuUEUfH96K0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VeBopwtz; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=zf7C3JIfy4ywsPNZ0w+h08cIa2jemMKNKRi45EogFjg=;
	b=VeBopwtzBAgZy9FqVI+FAMxjeG5ieI31VYLCgb2v/zrFjuYWIIvqlauDw9+YCF
	yZEp9wPhsQtTJPHloc2sWQGyxf7AnGbYJiDwMk/v9z45cU5QyDQNM8oRE/sgj5pb
	FEA7LhpSk+mWbYxEbpiEOpzynHr7sJEepifNpCHXX9/Xo=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBXXvcK1bpnD5KfCQ--.23112S3;
	Sun, 23 Feb 2025 15:58:04 +0800 (CST)
Date: Sun, 23 Feb 2025 15:58:02 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: imx8mm-verdin: Remove LVDS
 panel and backlight
Message-ID: <Z7rVCnypQW1wpyAW@dragon>
References: <20250214092634.12414-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214092634.12414-1-francesco@dolcini.it>
X-CM-TRANSID:Mc8vCgBXXvcK1bpnD5KfCQ--.23112S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsku4UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhD8ZWe6kuHc6AAAsB

On Fri, Feb 14, 2025 at 10:26:34AM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Remove LVDS panel and backlight nodes from the Verdin iMX8M Mini SoM
> dtsi file, those two hardware components are not part of the SoM,
> therefore they should not be present in this file.
> 
> This is solving a dtb checker warning about panel-lvds compatible.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks!


