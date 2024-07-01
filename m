Return-Path: <linux-kernel+bounces-236371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A291E143
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5A52863EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E685D15ECFA;
	Mon,  1 Jul 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TDjtVtGv"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B315ECD6;
	Mon,  1 Jul 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841897; cv=none; b=KEc//LbJEjjrMs9/6MXiplyYozyFvMw7p5hB2Yo3kOaQLK/T1ZSnlX6zkF4dAcGpOCTfiPE9unMnli1iQo/9/fOus6JDZHedpQWQQAzRpOk5AJ8yQcGCopcyIfqGoM9PtQaYIVWxtPOViEkxTSlWh9yzAujlxUO4r0lEvW3QXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841897; c=relaxed/simple;
	bh=WJFcrpAfZ6kI2zxHwjgX/7RRQzrcoaIk1p4RHYDLG6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvRp6IS45LhckqLbcSDbRbstQzX4AKIlBNbyWOfrDOMszGG1IWIcsf5eZJFgWfsum37zPLBknvyNV/IHMhRooR8jNX/esRbYdDIeRfCXGguHjqVP8Ez9sfqnlVD7nTTh9cskyKUUTXIQXRZSfCmhTar+YvgDY1Eqf6AHpw2E5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TDjtVtGv; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=46sR/V9dviRjPP8fczYXYSmC0ZFzyAg7+5eAMPqu8VY=;
	b=TDjtVtGvOiV4G3I4CyMU2yX6yusj8RjKxWWm8PBa/POYrSIvZPMO+LG+5n5i8K
	mOO+GcgfYGyW7Nls1tJNmXAxWnc0tImyXe4vAACJ30YIn3JS57hrBEfEGUpO4uNB
	6GnmyJ6miDhDWy3KSKzO6+lG7ex0MuqvbpEwASxyk07Jg=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3H444tIJmlLU4AA--.1103S3;
	Mon, 01 Jul 2024 21:50:50 +0800 (CST)
Date: Mon, 1 Jul 2024 21:50:48 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mp-evk: Add audio XCVR sound card
Message-ID: <ZoK0OCYzcvLDH7F5@dragon>
References: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
 <1719481981-4069-4-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719481981-4069-4-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:Mc8vCgD3H444tIJmlLU4AA--.1103S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIF1vUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBoPZWZqry+fPwAAsY

On Thu, Jun 27, 2024 at 05:53:01PM +0800, Shengjiu Wang wrote:
> Add audio XCVR sound card, which supports SPDIF TX & RX,
> eARC RX, ARC RX functions.
> 
> HDMI_HPD is shared with the HDMI module so use pinctrl_hog.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks!


