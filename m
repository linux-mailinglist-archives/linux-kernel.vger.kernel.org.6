Return-Path: <linux-kernel+bounces-215762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91799096C3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295D3285763
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4561C280;
	Sat, 15 Jun 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="cSpa9X0I"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D332F182B3;
	Sat, 15 Jun 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438892; cv=none; b=dXwQb90p/M7QKsNanAMGdnhPOCJbU4sv5zjitFDJTGnr4fdAen4CvAnbtQ258EHLDk7iZtRWJw7EjhWCr0+ZO6XNzGdoH4tiM7devostRF8bKpYqzNn2GyU+/V6ScdxsS6/Y89rR0VOcVYRy9KrW9KKGYQU2Uwi7oZ8SMjlQUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438892; c=relaxed/simple;
	bh=rPgCc9oeqCVfNZ8wHQbb4DAAw3Bq7+5vbSGwXTvp2p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCDeLVDiUjPHgVcwLnToC+NRufherqkmk9lUt6qxOoVPAUOlUQtnWb/beYZVeQy1X65jvMBS/NjCKAEd9rp2Om2g4IM4NwODbldV317DNFw+2wvyUaKL4P6PZ8RDzL6zlrHwmLwUn8xmJj4aR5cTdV5tSbAMsDxrUv31arRcaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=cSpa9X0I; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/iKjibvMsxezGFlPSNPKpOBNVsf+6rthH3pcb2WX1No=;
	b=cSpa9X0IMbQKAzcN/yz/8EXPeA/EMwh8Ujy3dqSwaVMna++cJGjIHFOptHf+pT
	4OwVYNQvrDW4ylikwSuEoMdEBaja2yNLBdrQeet2c8KZV3ppNxuzEidY6I1ew8Dq
	NjL6q5HtOm1NOl+gl86hUdbqGZ/2nmmKXNjvlyMGhOS/Q=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrACHjxDRS21mwOK0CA--.43334S3;
	Sat, 15 Jun 2024 16:07:46 +0800 (CST)
Date: Sat, 15 Jun 2024 16:07:45 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Liu Ying <victor.liu@nxp.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH] arm: dts: imx53-qsb-hdmi: Disable panel instead of
 deleting node
Message-ID: <Zm1L0fyKupDFDOUX@dragon>
References: <20240514030718.533169-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514030718.533169-1-victor.liu@nxp.com>
X-CM-TRANSID:C1UQrACHjxDRS21mwOK0CA--.43334S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUswZ2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBRL+ZVsVCphcKQAAsl

On Tue, May 14, 2024 at 11:07:18AM +0800, Liu Ying wrote:
> We cannot use /delete-node/ directive to delete a node in a DT
> overlay.  The node won't be deleted effectively.  Instead, set
> the node's status property to "disabled" to achieve something
> similar.
> 
> Fixes: eeb403df953f ("ARM: dts: imx53-qsb: add support for the HDMI expander")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Applied, thanks!


