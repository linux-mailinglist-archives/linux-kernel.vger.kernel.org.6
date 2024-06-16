Return-Path: <linux-kernel+bounces-216090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44A909B3D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 04:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527C8282554
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 02:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B916C696;
	Sun, 16 Jun 2024 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HlSt0jGS"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF73D6B;
	Sun, 16 Jun 2024 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718504926; cv=none; b=O18RvOmLbO4o8jZHcGsy9T+04/RVwiyn02VxucikR+I6KfZ0ED7RuGzn+vQvyitDQFkOQj6g8Tmm7ByOUZTba+uWGCbbSsyplVHH1EwbblPx25/gtj8mgToQPtx1d7ln18LoFIFpN7BGTA/HtKA42vGN1cnVu2BYp5vB/7zfzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718504926; c=relaxed/simple;
	bh=1r14RNKX6lIR0dzW2WDHULEq9VmnThN3nSSYnADO748=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6fRbELSOrndqosWNhK6hOnMvp9ioMw+drLliW7X2JC23G+XWVhu1QFAebzzP7fJnCGFurqt2tyMGPheXwYbzLcvWnwvRP0TyH2oJrLXJ50W9Qnn/O6HwGgZe3Tq4xq3z6byMnWw4vd66uoTzwnYy5PgvJP41W9NQRSTqQXGaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HlSt0jGS; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=tgM+933VJXc6N/HR2wHbnAQi4LrA+IyU4Qmg8g8VZFE=;
	b=HlSt0jGSDyU0Lc9m1Ig0h+KdZgSVPxIbrFubnol386klkkt6lEKMU7UeTbbCjV
	1G6/al/qLc3PSsK9IyBcFzzk+FsQYOmo2GnJiIpWdd1+b6eNBkuxRORYQ78tnmE8
	bkJtXSJpQf2TZWkLauaM2PVzno7dEYn5vWAm+bbOpzacE=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrACX_heyTW5mR4S+CA--.63768S3;
	Sun, 16 Jun 2024 10:28:04 +0800 (CST)
Date: Sun, 16 Jun 2024 10:28:02 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Parthiban Nallathambi <parthiban@linumiz.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: phygate-tauri-l enable pcie phy
Message-ID: <Zm5NskGQrjQk5SSZ@dragon>
References: <20240525171854.2165241-1-parthiban@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525171854.2165241-1-parthiban@linumiz.com>
X-CM-TRANSID:C1UQrACX_heyTW5mR4S+CA--.63768S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVJKIDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRQAZV6NnP0RWQAAse

On Sat, May 25, 2024 at 10:48:53PM +0530, Parthiban Nallathambi wrote:
> I210 intel ethernet controller is connected to PCIe. Enable the PHY
> to use the ethernet controller.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>

Subject prefix should be 'arm64: dts: phygate-tauri-l: ...'

Fixed it up and applied both, thanks!


