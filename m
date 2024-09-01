Return-Path: <linux-kernel+bounces-310144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACAF96757A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3611C210A6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37748143744;
	Sun,  1 Sep 2024 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="DKWK3Saw"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E553B2AEE0;
	Sun,  1 Sep 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725177141; cv=none; b=cXSVUfaxThmq/ZKBj1miKNoCJrqvZMRTVl9IScb8j8/QIFS185Uj3mnrGs9ePz38PrytBW4Bh8mYeLgEhAOJwJ/7/Xz5YkQk3V+FFTFVkutdxbpdvAxfnHgCq+46mb1MgctQsT/6pjWSHQ7bvdwUqYN31YD1JXAVgGud3auWDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725177141; c=relaxed/simple;
	bh=IMoBy3oqfpuTJd+qdgKqGUsbleakqi9u6DLCiEE5BOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTqtwIoGNVQEkr1UGtQfY0NZPDq3xAZEjCP0LeeXsWF6XlskG/rjfWNo51o6J9LbhXNxeNhXsUZ1UFErWyrKTFPxCg2csp6BtZ9p2QM0UKiSoLLVO3BYsoGzpJd0JgQEZ0kVvuoD9BgwNd2UzlnFyjUFEVPcQmAhHc5XZaIxoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=DKWK3Saw; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8Cuq/gfx/IIgSkmvxnEdXczuBE1tETsjswZ+yzDi/OA=;
	b=DKWK3SawITxTiFDpTk+cUFhxscwf6IHL2jGm7KxowGpVLzrSYOnVVAZ1HiG44q
	/9+fmrq7GkciPOV9XQBQE14RLle0dER7BHFPYrNS7Ji8S1Zy6nud2OCJV/Iyw8sN
	g26cRSwYrilPBwqB8MoqQC7jt7Bf7ZyZWK39IKa/DUwqo=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnXz7wHNRmGV9EAA--.21759S3;
	Sun, 01 Sep 2024 15:51:13 +0800 (CST)
Date: Sun, 1 Sep 2024 15:51:11 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Teresa Remmet <t.remmet@phytec.de>, upstream@lists.phytec.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: imx8mp-phyboard-pollux-rdk: Add support
 for PCIe
Message-ID: <ZtQc76VJuNTWXVTg@dragon>
References: <20240823-wip-bhahn-add_pcie_support-v3-1-8b86af45e73f@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-wip-bhahn-add_pcie_support-v3-1-8b86af45e73f@phytec.de>
X-CM-TRANSID:Ms8vCgDnXz7wHNRmGV9EAA--.21759S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI2Q6DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgpNZWbUDSsimgAAsM

On Fri, Aug 23, 2024 at 10:01:32AM +0200, Benjamin Hahn wrote:
> Add support for the Mini PCIe slot.
> 
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Applied, thanks!


