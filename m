Return-Path: <linux-kernel+bounces-375397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D92D9A9570
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B5E1F24637
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8DE12C478;
	Tue, 22 Oct 2024 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Buz1x96t"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B185C47;
	Tue, 22 Oct 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560468; cv=none; b=gCy7SHUa4BItm8NTNLMrxw0n3NMdaWmbgBCon/hxBI4iZgF6DllL4fe+xdZW3vq/VuoMO7ctkAIfhgJAkxeFKP9OiRVJIWftQIkFmyk0HjcHLtILNbfixrIBZ1ILU0Em9wa8hgecM9XLTZCP33w684c/9xL5kt0tMJ7grCA0Qis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560468; c=relaxed/simple;
	bh=dqszEP1v019qGNcL5CesOrLFKyvxXNh+xc6yd+cMh8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0L0S1R4NzUBosoJbEKiLUM2blDo15IRfwj6GuaNL1rwKrc6pvISowQq7E+uFRg6vKJ348fNdNFLhskah8X/zBT1G0EwCfAP8SZ3mYjs6lEHj9rer7l7coUy/hIbON6TaU3AELffrQKr/w+y3cQ/U9Z5lk0f768ap/v9Ud8dGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Buz1x96t; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=dVrd/2fUWFhAJT7e0aGI6esgbMA0fu+dfMpHANARuy0=;
	b=Buz1x96twcRHAJQfuAdZK/M4fx4p9OBUmc4NXC2cbkl5yuQP4j9ElGIkQMTqW5
	1ygfysgG5+sx3Wi/N/lKe1kDaQlC9klhfnhxTGGdOdVzCB4Mj6u6ivOdcL4YOAZg
	WOfNnjqCeIiWX/tSGXhN+Z79WGYIaulLQW4C+H18Cfd+A=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAHLrlt_xZnTOeSAA--.5164S3;
	Tue, 22 Oct 2024 09:27:11 +0800 (CST)
Date: Tue, 22 Oct 2024 09:27:09 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: correct sdhc ipg clk
Message-ID: <Zxb/bU7Z7KxLF9Mu@dragon>
References: <20241012025221.1728438-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012025221.1728438-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:Mc8vCgAHLrlt_xZnTOeSAA--.5164S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIXTmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhSAZWcWdwf6DgAAsW

On Sat, Oct 12, 2024 at 10:52:21AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The ipg clk for sdhc sources from IPG_CLK_ROOT per i.MX 8M Plus
> Applications Processor Reference Manual, Table 5-2. System Clocks.
> 
> Fixes: 6d9b8d20431f ("arm64: dts: freescale: Add i.MX8MP dtsi support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


