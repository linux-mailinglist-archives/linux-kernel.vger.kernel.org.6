Return-Path: <linux-kernel+bounces-282543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C843A94E594
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631ABB210F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A7F146D69;
	Mon, 12 Aug 2024 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PwOtRoJv"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B702C9D;
	Mon, 12 Aug 2024 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723433837; cv=none; b=DXDi/qfxtYrmt43bYOm+f8r93ZWRPgIePtirPI+wqBw6Qa0JoGbM9JZCXThjQZ1QhD5/jVy4UvorTRo9cAuHPUQQyEJCabDlGf/OJjmd8XhkU7R3icdfO1Ih5BDiKTqAQa9U03RzDHYUwMIxYh6zHnrA30lLQC4DHoxVPVhrowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723433837; c=relaxed/simple;
	bh=uXuyobOjTnWyOJ8C5OkVOf6A7H0lhKaylh2nIX33f6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUm2ha8tJj61o+Za3LQc1Ed5Z/jjR2P8ui0qxXiGIuhYKKilxMfm5CoYglzu44PPCfkrJPrZplc4vG9/ZYwJtRjF3ue+U1f379PK1Gh2SwAqZYpA8Ac2fl0ZCxTFOqzTAqwRTWnrB2x0jUPZtKSSbWZ3yfpcMFYaLJuoqsL7jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PwOtRoJv; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9+5V5XfOCCt35FGY5jqK51yX030o8KZnQmkWpmCbG8E=;
	b=PwOtRoJvrAsqpqvTW/akyrNUhxam7EFnZ0wcC/LHC+RMfdqN8sndUgT0VtQMHx
	YubP5roAcFqBNZt1sLHSSIslqe93N4iDHcr/sJR4DrzNGgGbv6qoyZk56gS8i5pj
	N/r35UYVbSEX3mfVTVKYR+hhLtrJ4yN5A13NTKHhY/dRM=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBHTbdCg7lmvdsLAg--.59373S3;
	Mon, 12 Aug 2024 11:36:36 +0800 (CST)
Date: Mon, 12 Aug 2024 11:36:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-beacon-kit: Fix Stereo Audio on WM8962
Message-ID: <ZrmDQgU03tf8n91p@dragon>
References: <20240714172017.422811-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714172017.422811-1-aford173@gmail.com>
X-CM-TRANSID:M88vCgBHTbdCg7lmvdsLAg--.59373S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcb18DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxI5ZWa5gcwF+QAAsr

On Sun, Jul 14, 2024 at 12:20:17PM -0500, Adam Ford wrote:
> The L/R clock needs to be controlled by the SAI3 instead of the
> CODEC to properly achieve stereo sound. Doing this allows removes
> the need for unnecessary clock manipulation to try to get the
> CODEC's clock in sync with the SAI3 clock, since the CODEC can cope
> with a wide variety of clock inputs.
> 
> Fixes: 161af16c18f3 ("arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock")
> Fixes: 69e2f37a6ddc ("arm64: dts: imx8mp-beacon-kit: Enable WM8962 Audio CODEC")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!


