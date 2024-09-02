Return-Path: <linux-kernel+bounces-310437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70626967CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8202817D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F975680;
	Mon,  2 Sep 2024 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="n8duNEyS"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A733F6;
	Mon,  2 Sep 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725237082; cv=none; b=hUQbSysKn3bkBZgOA+Tql4yne1kXr4JKKt4e30dYxVWAIq1G/QoNRtTUGDqdkGH4oBWSyOXWxdOrBaCyC7gWV8I+goVU/r0XlJG7E16lDTlU60z/pkujCaB+MUEzk7y7/1HYUTaFBaGBrd4HgXQWyJybS1GWFszb1vdHc5aws4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725237082; c=relaxed/simple;
	bh=5Ni5xmZ5s1jOJyHB1+Euf+oNvve78sG/JGZNDDZsCpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8+1TSDx78MiHQXk+nM1ChLnilBsaNCu0CoS699eweznv9Da/Kh76r+E6B0pnC46LIJ1nTC3PHRHKQAi8OorBVuIP8EQEA9wE+UWqTq2FxhvPDnRloDJSEcM+YU7Khtmnn7W6YNpmkS7vaLfJ3uy1yRGM5MofDaF9raak009K3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=n8duNEyS; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=odYBsQzSId1TEjPBzPPEa7UrY1IArw1yNoSnzcBtmAU=;
	b=n8duNEySSje2OUT0XGHTNBtkR0pUMp6PxkVlAV0h6+dqQQV9laXu8qA7fWdh4H
	YtNxnow/K/OMkG0WtIVaecU/XjEWwyB5FMSBp1Ggbwh2phlSdSULaqkSnWEQOLzI
	vsId0ZKayN35ehm6gEvy6Wl4yV1nB/tpVnx3jQhmZxQ1A=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3v_QUB9VmbYpKAA--.43359S3;
	Mon, 02 Sep 2024 08:30:14 +0800 (CST)
Date: Mon, 2 Sep 2024 08:30:12 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Wei Fang <wei.fang@nxp.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, abelvesa@kernel.org, peng.fan@nxp.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 4/4] arm64: dts: imx95: Add NETCMIX block control
 support
Message-ID: <ZtUHFEeIY/RgISdI@dragon>
References: <20240829011849.364987-1-wei.fang@nxp.com>
 <20240829011849.364987-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829011849.364987-5-wei.fang@nxp.com>
X-CM-TRANSID:M88vCgD3v_QUB9VmbYpKAA--.43359S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4Xo2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgtOZWbU5Xc8DAABsj

On Thu, Aug 29, 2024 at 09:18:49AM +0800, Wei Fang wrote:
> Add NETCMIX block control support.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Applied, thanks!


