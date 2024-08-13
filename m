Return-Path: <linux-kernel+bounces-283982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4832794FB72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044972828EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21A15ACA;
	Tue, 13 Aug 2024 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IHlD5uku"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FEF8485;
	Tue, 13 Aug 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723514065; cv=none; b=qBkxk6NjbTNV5HjK6BXewM8roCjuZ5TXrTJ7SQPg8ZYOtCrShy5DGcBamih8JzTp8qYx2OiDuIdhi8/MTCOyd7qZ+eitCwbqcG9zHE25aQ8K7eTR4D4AuXmZ8mL+rkAzG7u7KozTBIDzkCvsY+WGY8b+MNcmtUrXgLy9mIusNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723514065; c=relaxed/simple;
	bh=akMXU70pK8hT9LhVoCYs6vNxj5TFyaPo9utkufjeggk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubDgwJcG8h3T/k1YtU6MLLFdGyDys/6b+u2+LPuqT28EFogqtF7+tVMyZP1ai1aGK9ekBf5c1rzODe3skwY841bA8wq11leChay48myCmEFrRTMZQrCbWzW7vbhz40FuiKa9gj5jXwLzDOTODhM69mvH8ujh/A4Jclp+j8zX03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IHlD5uku; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=5kPfqD68TfyrjDXHavXG5xz+7qcCkFKuvLVhShQxrxc=;
	b=IHlD5ukuMBCiIAeWlEOImgZxFAGtQv245UzKop6QxrJvXNSL2kqdiFKakDoU+x
	Uzrkzlc/B/Q1PMTZT2fox+uqWGle6gLNBXAovGWSAvbhghcXQbMNau+DpW4mPxFc
	ctNiqL+/soX3T2mKXRmBIginVpOKkbpmNbTqfz20CpLrs=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3X4igvLpmL7ZRAg--.33993S3;
	Tue, 13 Aug 2024 09:53:38 +0800 (CST)
Date: Tue, 13 Aug 2024 09:53:36 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] arm64: dts: freescale: imx93-tqma9352: improve pad
 configuration
Message-ID: <Zrq8oIxUw6C2g8Zc@dragon>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724125901.1391698-3-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgD3X4igvLpmL7ZRAg--.33993S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxCJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwk6ZWa6Xp3TZQABs1

On Wed, Jul 24, 2024 at 02:58:49PM +0200, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> - disable PU/PD if already done with external resistors
> - do not configure Schmitt Trigger for outputs
> - do not configure DSE / FSEL for inputs
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


