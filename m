Return-Path: <linux-kernel+bounces-304212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D79961BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF081C231B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802CD45945;
	Wed, 28 Aug 2024 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Kh9X6rv1"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AD1EA87
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811044; cv=none; b=cyQoXwkkzePErcW/3aZZiNF/b8cZYgh17E9Wu3vA+MfpcxVRCC/zYWAAxURQ/8r/BUXpbqKq7PhcjLSs7f8YiQQZxqIKeGNE472GKPIMPQGeCJnZL6i+OgKxSjJ6JUqFHRGLp7WLidsypjZIVf7VE/47Bm278qweT8sGpHtQ09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811044; c=relaxed/simple;
	bh=u5D7QebsliSqst+5Nt3KvijBFBYEQtRJqWsQZUCSNRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpmESfP3p3t4Rc5Q1oDTAZ9Ju4E77G3+RkGZ3rtJpjbTAZWXL3jptexC77igUjjEKzzTQWYAjIK6AklPwi4X+jFz6Be7RRS4fbC2O7yWYdKe1sOl2Jr4dJkN4oy0yYY3XPnkTGCLDGfMdobj6OFIjOhhQazPpDnyzQPIdaQs/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Kh9X6rv1; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=D9uHGLvjretUNKP5fR/bSUuJzOdYPlRAGN0AIxMlgxk=;
	b=Kh9X6rv19b92JpLADRDTzAuWR4iE9px3yi9Q84qYFdRBqKBpGshCHExScRcjtI
	EDlSWDClBKDeWEV7wBMMFyCiXjiflC3gGjn/fbEZ3n3VrXEoH4aI0L0Kkpj+GLOK
	s11D/tK29J6Be8PkHjfwoZIhIn79C+yEp+Vs3MIPBD+QE=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDXr+LDf85mhlgNAA--.23888S3;
	Wed, 28 Aug 2024 09:39:17 +0800 (CST)
Date: Wed, 28 Aug 2024 09:39:15 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL driver
Message-ID: <Zs5/w7zxpg5L6AwQ@dragon>
References: <20240715123635.2894222-1-peng.fan@oss.nxp.com>
 <ZrmESMKrhIv/+32l@dragon>
 <PAXPR04MB8459714653491478CF0A6DE888872@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459714653491478CF0A6DE888872@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-CM-TRANSID:M88vCgDXr+LDf85mhlgNAA--.23888S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUr2NtDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAh1JZWbOHAPdGgAAsD

On Wed, Aug 14, 2024 at 02:29:31AM +0000, Peng Fan wrote:
> Hi Shawn,
> 
> > Subject: Re: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL
> > driver
> > 
> > On Mon, Jul 15, 2024 at 08:36:35PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Enable i.MX SCMI Pinctrl driver which is for i.MX95 IOMUXC settings
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > Applied, thanks!
> 
> Thanks for picking this patch, but after more check, this patch
> needs to be dropped for now before we find a better solution
> on how to resolve the arm scmi fw devlink issue.

Ok, dropped.

Shawn


