Return-Path: <linux-kernel+bounces-527606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859B7A40D3D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A683BEBE0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B731EEA29;
	Sun, 23 Feb 2025 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="EXuso7zT"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541EF2BAF7
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740295336; cv=none; b=lqLsD2QGKJFDQwtXELPa1Txe+fBx87K8Dr6zOOTwsJeW+Ey1PFq+JlkJQqlhY4muOI2OUCCbAPXbUYBoBcdw6X3MbvOjFqyBbLxbJjkt9erC2APrP5g4y3V7KXsigGSOCTSBOGBhwzZrcEvdz0MeW2bDiLR3Op7Bcl0rX1KXwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740295336; c=relaxed/simple;
	bh=nGyfLB/fx7ZPd0J5Y49mn0isbQeGuFYMvEeVgYfsi40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stt++rdNXaowxh3UUlqhEzqGFSTQLv6JPpPEXRdVOgJXFUhcmol10IMw3cqKzyVby9aiOMSA2lLUpCDU7eWzwZ/jF3ouPNCPe5nfmOadvfoiqMGTlXM9lwqYNFNP9JZ8klJJtDMs1SPZuKERPqya8LLCXX8JYr11EkpzAaOGTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=EXuso7zT; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9y4HplaZVCu1QQjMAnhjKML9wwHJeOFR7OdXRZKJR4s=;
	b=EXuso7zTjRTSduWNS6SUjCikx4WLdlc5rZmclXdlA/4OTl/VNctCXl0HhEX5jI
	DGA06+qWahBDZyhHrB0z5anwOLLSWiKaC7/JjW7VYCj6/YS19TGs7e7oSFwz2f69
	YqtVXwxG/33r2ZtT4iTBFw6vx6Knh6mV0Ng07gholDUCE=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAnC6x2zLpn1yKfCQ--.22908S3;
	Sun, 23 Feb 2025 15:21:27 +0800 (CST)
Date: Sun, 23 Feb 2025 15:21:26 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Brown <broonie@kernel.org>, soc@lists.linux.dev,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] firmware: imx: IMX_SCMI_MISC_DRV should depend on
 ARCH_MXC
Message-ID: <Z7rMdg7+m6qa0Hft@dragon>
References: <9638976432d8dfcb0c4df9d454b661f9022a2d7b.1738766259.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9638976432d8dfcb0c4df9d454b661f9022a2d7b.1738766259.git.geert+renesas@glider.be>
X-CM-TRANSID:Mc8vCgAnC6x2zLpn1yKfCQ--.22908S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1xZr17Jr13JFW3tryrJFb_yoWxAFXEv3
	9Y9wnrC3s5GrZ7KF10gr1ayF1Sg3yqg3y5Jw1IqF4agFySq34xtF4vy3s3WF1S9FZ2grya
	kas09rsI9ryaqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0uMKJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgb8ZWe6xy0Q-QAAsH

On Wed, Feb 05, 2025 at 03:41:43PM +0100, Geert Uytterhoeven wrote:
> The i.MX System Controller Management Interface firmware is only present
> on Freescale i.MX SoCs.  Hence add a dependency on ARCH_MXC, to prevent
> asking the user about this driver when configuring a kernel without
> Freescale i.MX platform support.
> 
> Fixes: 514b2262ade48a05 ("firmware: arm_scmi: Fix i.MX build dependency")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for the patch, Geert!  But I have just picked up the change from
Uwe [1].

Shawn

[1] https://lore.kernel.org/imx/20250204101531.233549-2-u.kleine-koenig@baylibre.com/


