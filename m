Return-Path: <linux-kernel+bounces-555402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FFCA5B6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80E61895717
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997B1E32C3;
	Tue, 11 Mar 2025 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="aUk0JzXj"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E28566A;
	Tue, 11 Mar 2025 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741661283; cv=none; b=nH9tC7HQJX/vcPketAob1UD5QbfZ9snK6qWpyPZlxfWwExHsr8j20EM/dElkfxzFv1C/IHKjdi8LNZe9KZ+cVYBT/SkrZStpiy49QN/LCrWM1zKOIlThQsM5YuypczZhUrtD17zqBrJ72kxI+AsyyT3QethAXEG7WaQXeaRgkTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741661283; c=relaxed/simple;
	bh=Fzqz7dFMDlYf04/3j+5kk7viIEamjr4Tpo1oxYIS7Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZy6w6vI0nVHiV6TEucchLZxVorUd+MEnIqvKNjfpYWETNejVkmQc+RxOCbCypPWmFySZTACW8XAoBHZGQ5OnCYvR57PJDG8HE+YcgmzSh7Sfhjwdn9c4p4urOrnYiQktDjBJzO7jyK9s+Jwy4s0EKwGW2eBfgOaDfVhSL1dFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=aUk0JzXj; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=WsOaeFx84mEMIUh1L0Rg4ey/wr5JNJW+7tpTSLncbys=;
	b=aUk0JzXj24LIHoUlTD1VitEKqbk5WwNNDL1dNpHPSq1kBdHcdBqZLNPR7HRFRJ
	d6xvoCXtdbkyhM2TBH3Mus6x9u3PLGyNPYufcRPWdofRIXPJ0I9svTRsbd0ns5Z3
	xUhHsQxELYQvDN13ohHKEAMZOJb5Wkf9TevnFbZOA/wyU=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCns4o+pM9nw3GvAA--.42893S3;
	Tue, 11 Mar 2025 10:47:28 +0800 (CST)
Date: Tue, 11 Mar 2025 10:47:26 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: imx6ul-tqma6ul1: Change include order to
 disable fec2 node
Message-ID: <Z8+kPrY3BsyniZS2@dragon>
References: <20250225144436.813645-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225144436.813645-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:M88vCgCns4o+pM9nw3GvAA--.42893S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxG-eUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQQNZWfPU+r87wAAs-

On Tue, Feb 25, 2025 at 03:44:35PM +0100, Alexander Stein wrote:
> From: Max Merchel <Max.Merchel@ew.tq-group.com>
> 
> TQMa6UL1 has only one FEC which needs to be disabled as one of the last
> steps.
> imx6ul-tqma6ul2.dtsi can't be included in imx6ul-tqma6ul1.dtsi as the
> defaults from imx6ul.dtsi will be applied again.
> 
> Fixes: 7b8861d8e627 ("ARM: dts: imx6ul: add TQ-Systems MBa6ULx device trees")
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


