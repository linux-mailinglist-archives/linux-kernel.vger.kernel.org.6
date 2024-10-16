Return-Path: <linux-kernel+bounces-367392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6941D9A01AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F131C23634
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18918FDAC;
	Wed, 16 Oct 2024 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Cq8Ooz/u"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2441C69;
	Wed, 16 Oct 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061053; cv=none; b=tRT48KmMa9Nv2RIbnOQbAWKojoYyEKLgx8JGudNYSf88GQmWP6J7yKbGHVgkGxPRnKe2YfpQ69CdEKZlpb1W6jSj4w+F+VMGXhtABzx+1XLI5Xs3wYoUIRXOiVE7+spyTlYupvJczVl/m+wT+sMZkoNQY9SDyUYGAz/GiYv3D4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061053; c=relaxed/simple;
	bh=FVSU2WBNfgz9zSK+jKgIZGH55UJ7KG8hdJ30EJWrr7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmGosmRG52mAUuKj3/TPx4ppiApYgYZGZIN5XPhwacy9mgsng0FT8TLtuTgmh0u8UAPccyVSQW7N4MPAZj4vAWugJS0rHgUIQVp4OfwgsvP3tRnMh42Px4wrQJZUUlpuR11ERFAepkWHxjQhF1alb8UzcjKdjiAglrZ8gvi33jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Cq8Ooz/u; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=6M75V2q+Tktv1OJM9mVkAGxnLytVuUPATxTb88TgW5A=;
	b=Cq8Ooz/uoD8SQSMQmF+dtrlGvK1vgCkUlO128CgyHR5UhctrSnz1DQw/MhQdAM
	j1TwOnOQxpcFw7HiRRSQRkjwGWmLF/f90vttqdI7BlgA/AGFuMjos1805CbYrRu4
	TQBCLMOGS2GlssqCWv+sAJPH1wSeXFf34mOhlVimpY8nM=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCHlQWUYA9nc0kYAA--.375S3;
	Wed, 16 Oct 2024 14:43:33 +0800 (CST)
Date: Wed, 16 Oct 2024 14:43:31 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: peng.fan@nxp.com, shawnguo@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH v2 1/1] arm64: dts: imx93-9x9-qsb: add I3C overlay file
Message-ID: <Zw9gk2jGnq4fu/+G@dragon>
References: <20240906201501.2249242-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906201501.2249242-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgCHlQWUYA9nc0kYAA--.375S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVpVbDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBB6ZWcPKkWcfwAAsv

On Fri, Sep 06, 2024 at 04:15:01PM -0400, Frank Li wrote:
> Add an overlay file to enable I3C support on the i.MX93, replacing I2C1
> with I3C. I3C is compatible with I2C, but it has not yet been enabled in
> arm64's defconfig. This overlay allows users to conveniently utilize I3C
> on the imx93-9x9-qsb platform until I3C and its driver become more mature
> and ready for full switch to I3C.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


