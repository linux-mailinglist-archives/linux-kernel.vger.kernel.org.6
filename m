Return-Path: <linux-kernel+bounces-284025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D164694FC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0BCB22345
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4931B947;
	Tue, 13 Aug 2024 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="BxhyfcpT"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9251862A;
	Tue, 13 Aug 2024 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723518612; cv=none; b=VD86ANwK7wrRvG1suQyGPnIwh4nGyIdxKRLwvcwTs4QmwmXL6u/kWdksO2s0D4QWsg5ipzgr+JgMGLgzBMkMrMxFttU1m6HfPb8acFAAmHY81AqiQ87Ec2Rai4odx2N17p3xMpPZ+QzJhV0aK1lgNp024uzn2YuCbOv19IiLNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723518612; c=relaxed/simple;
	bh=3M91t14B3gmhekD1hskxYIbTlw8UDZSkyAnFI+JrdzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeCSUoI1d43qpn2kN46ihQ1W+eQENxZbMWcZ6o6pU+wBxXeb18VcU1TzciF4k+5Tlq/XfesSUm3i6twXUjkEfWSFhg/CVZPN+/TItOZFYy+JevgGJR8ituVef5YIV/535U1aWNZ2xV97QOzW1dltWTbXUAS6u/DsGDj0MGnE7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=BxhyfcpT; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=IPuRpYSKipGaUbv6mIhpbBcqwqxErWZg5BKVBR9kFRs=;
	b=BxhyfcpTzeTvTTs5lO5DusfL8tzvpHSHTiEU38Xthb4JV3ysyiqIJmr0PkAjcu
	on37p24maTIZQbk9N2mG1/ptzd6TGHY3rorhv7gDgK7TJGNy4QS9U6yJfNTBxQXC
	YXoF3Es7oA7ID3gs7GfW5/06mLiMhboI9s/iWIGTX7iok=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDH7ydszrpmqXxSAg--.41459S3;
	Tue, 13 Aug 2024 11:09:34 +0800 (CST)
Date: Tue, 13 Aug 2024 11:09:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8-ss-dma: enable dma support for
 lpspi
Message-ID: <ZrrObJSIaY6u/g6f@dragon>
References: <20240731060959.897105-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731060959.897105-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgDH7ydszrpmqXxSAg--.41459S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaeHqUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgo6ZWa6xHErEgAAsH

On Wed, Jul 31, 2024 at 08:09:58AM +0200, Alexander Stein wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> Add DMA configurations for LPSPI nodes on i.MX8QX/QM/DXL.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


