Return-Path: <linux-kernel+bounces-369454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C929A1D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E05280CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E21D54F2;
	Thu, 17 Oct 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="O2IeVqA6"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0281C2447;
	Thu, 17 Oct 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154706; cv=none; b=Bq5RVAXBx5y3DG9FVGjrqt8pmgX/muccr/pUqa3BtQx+QXPBRXZ6iF10YjEPVPgqGxnKLJA2mvzWqehqdmcwbbfOt8cFb+v5TAHZa+zsodljb9XiJhq6pTQK3Kx1UUUTcRG1btwLehHbiD7sc8SSso40jyzaMEvHc5qoC2MC+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154706; c=relaxed/simple;
	bh=PBz7kQKc3l9H1T0Y9A9p7V37KYmmj65awrZeqNTRkpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZQ2+VlyKpt331G37h+R1LaSbPKO1Yh+qbYvGZkjDzk0U+bXqVEKqhnHjY4qh1ZfvDsNEZnL17mNFB2Z19Gv2f2IvyDtLLQYFSIHuwL0HrBGznQiXEoIhXNbpAMAdl5cnYupA/l51O7EZRfdQ0eV89ULpYugyzJLURsCzFUEb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=O2IeVqA6; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=f/CE3M9tZlrKOkYsnQZ8XeAHkJLrZZohMbO9naRhDKE=;
	b=O2IeVqA67qKl3mB3QSLg2pCgGT3gaZz9+PcaMgvEqLbh0hsqjhzKoO1ySeiJV0
	WJzVLVAHiB0DQXNS3gWePARkUOc9yR/++TvxB7nJ9np/ofRgPvRpCfwXAn9FXbNC
	bF0h3cyEP7oJ+JqRRTPy3jqKA5U3yGqvI7yhQNKtGRO74=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXPh5HzhBnoC0wAA--.1292S3;
	Thu, 17 Oct 2024 16:43:53 +0800 (CST)
Date: Thu, 17 Oct 2024 16:43:51 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com
Subject: Re: [PATCH] arm64: dts: imx8mp-skov-revb-mi1010ait-1cp1: Assign
 "media_isp" clock rate
Message-ID: <ZxDOR9VL0u6OB+jX@dragon>
References: <20240924071218.3578402-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924071218.3578402-1-victor.liu@nxp.com>
X-CM-TRANSID:Ms8vCgDXPh5HzhBnoC0wAA--.1292S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFykAr1rXF1UGFW8Ar1kKrg_yoWfCFg_ur
	y2y3WkGws8XFn5KrnxGryjya4xtrWUAFyUXr9Fgws5trykZ345ZF1Sv34Fgr1UtF9av3s8
	Was3Wayj9asxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8qYLPUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERB7ZWcQs3RUPwAAsE

On Tue, Sep 24, 2024 at 03:12:18PM +0800, Liu Ying wrote:
> Commit 2d39b78e5716 ("arm64: dts: imx8mp: Add DT nodes for the two ISPs")
> added a new phandle to the "assigned-clocks" property of media_blk_ctrl
> node just before the phandle for "video_pll1" clock in i.MX8MP SoC device
> tree so that "media_isp" clock rate is assigned to 500MHz by default.
> However, it missed updating this relevant board device tree where the
> relevant "assigned-clock-rates" property is changed to set a new rate
> for "video_pll1" clock.  This causes the "media_isp" clock rate being
> wrongly set to the "video_pll1" clock rate and the "video_pll1" clock
> rate being untouched.  Fix this by assigning "media_isp" clock rate
> explicitly to 500MHz in this board device tree.
> 
> Fixes: 2d39b78e5716 ("arm64: dts: imx8mp: Add DT nodes for the two ISPs")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Applied, thanks!


