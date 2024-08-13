Return-Path: <linux-kernel+bounces-284373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5129D95004A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0893F1F2227F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3013B797;
	Tue, 13 Aug 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Os8nz6D0"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216E249F5;
	Tue, 13 Aug 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538986; cv=none; b=IBXMU07+vjuFN4ijnaUF7iQz6IRCgSEZOVw2i4kIHH+ZQVBT4EVtJAFy++MJh10yrJjYZeIiw3LyK5M7oBN+P8w/4DA+FSlS7vJwM5Q0+VbitSfyUnf7FT8fAmqbUbnMSnVFXk1VXp8bDh9M6+VapPz/3rIo+rk6aSil5MVtaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538986; c=relaxed/simple;
	bh=fnGUMR8alWJ23yiSC9hwqHhWGxCojupW1eTuANhSJGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ5768fiweLK9xhBV6zJl+Up4YOCRctb9rPy/Vjcd5GGzGzkbkGX6X96ixWReNos0BfKgXRmlzul54n7NHRGLMnZFhjZgwmees7qMeLW4RLlacoe61ipzdRsppZPFNz0OvBiT6wWWUlaJEGDUxoYwNzKx2f1ghGAYFIjPqnPA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Os8nz6D0; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ubP/x6XM1hVrrXEFEEkcuv4aeS2a2HZhT4tQZk/QGN8=;
	b=Os8nz6D06WVF/hzVZq5Y4vI7jyB4pG81Vgvw3c8mAAkM+V3dzsaY82idHq+cbu
	IfqNbTd7x+6t7YhzWugDZEOX6o7d7srN/9PcZlKxBxfBmbBZQnESz6cACW1ULVSa
	Uk2COdTdngPa6Vh+7UHZXQS+Sjs3Dfe6rO4CIrrM9qwZ0=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAHj78AHrtmfYIbAg--.7470S3;
	Tue, 13 Aug 2024 16:49:06 +0800 (CST)
Date: Tue, 13 Aug 2024 16:49:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso node
Message-ID: <ZrseAE8+YJ1PhRL3@dragon>
References: <20240808162157.3323811-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808162157.3323811-1-Frank.Li@nxp.com>
X-CM-TRANSID:M88vCgAHj78AHrtmfYIbAg--.7470S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxsqWUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQI6ZWa7CftCUAAAsp

On Thu, Aug 08, 2024 at 12:21:57PM -0400, Frank Li wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> The i.MX93 11x11 EVK has a ST LSM6DSO connected to I2C, which a is 6-axis
> IMU (inertial measurement unit = accelerometer & gyroscope). So add the
> missing parts to the DTS file.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


