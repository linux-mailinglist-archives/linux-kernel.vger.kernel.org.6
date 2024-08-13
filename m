Return-Path: <linux-kernel+bounces-284243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF1694FED2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8207D2848D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A56F099;
	Tue, 13 Aug 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ocyy+UZ/"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA4A29;
	Tue, 13 Aug 2024 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534332; cv=none; b=L39/prMFGCH/fTBAITJgjSp35nsUwfrLw5omvNFlae0ZogLXa0fEzRIgHL5vUm5ToOslyNKDehvRGMn65/TPR19Y/IOeRIAxmB5xyV+f2gxIrSzD64xOl7GrZv2v8nOVNDULstBrnvc0IoSFEHvzwOFcNjuv5LtuVKFWdtZ+8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534332; c=relaxed/simple;
	bh=LNbX/eGj7S6s2oQOxIXOz4b2aAignCwMHqgSXjse6/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCtMU4vFhG7bFX8RLLYCFEA2qdEPgUoSLjiUYOXRtIMAkBdoBesXFv5hsZQpTc0+yjbJdyCeTOWZcdXNNRnMZp6VeV6ENfoekWJBfETZ8tQwy/d3QLdKy5JGf4NPlR/50FGa6mouF1e089O9icj4TbVE5JBzRoUoCX0hlJXG1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ocyy+UZ/; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ukwzqntnKiYBe01W6Rd4Je4ETHW/Jrrdv/yN98FKgbs=;
	b=ocyy+UZ/pXoblY3mHzRyFuJ/zgFWPUtsXrLra0hexmbZlOK+Bxal2J/g31csls
	MES9SqkXGacB76coMRN1z2WbrcG3PPye7PAbqRhO634hLru6p/e/SVY5tmH1D1qG
	ls58Qhy9uNVEDbEKoZ9ynrZF2+3Ddk+W5nwhUJlqYdKO0=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgA3_Y7MC7tmbM5hAg--.39332S3;
	Tue, 13 Aug 2024 15:31:25 +0800 (CST)
Date: Tue, 13 Aug 2024 15:31:23 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: imx95: add DDR Perf Monitor node
Message-ID: <ZrsLy7hu3gBMedCc@dragon>
References: <20240805201416.2974996-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805201416.2974996-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgA3_Y7MC7tmbM5hAg--.39332S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsPfHUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRE6ZWa7CfsF3QAAsw

On Mon, Aug 05, 2024 at 04:14:15PM -0400, Frank Li wrote:
> From: Xu Yang <xu.yang_2@nxp.com>
> 
> Add DDR Perf Monitor for i.MX95.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied both, thanks!


