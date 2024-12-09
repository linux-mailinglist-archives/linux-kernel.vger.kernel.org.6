Return-Path: <linux-kernel+bounces-437078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269BD9E8ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3020B1884454
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C27215702;
	Mon,  9 Dec 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TW88fyEW"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B259BA4B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736890; cv=none; b=DYuGvYpkgUvaiYppfEcfRg1bOJ3T02NVp0vzdrGU6tV+pch0BALfwZQhRW8FD1e46M2HmW4gBSnISFBPhjjBfWKpbM2WNdHsGAd0snVelZnDZgwjC+RxraRFeNgCvO3TUjZGIoC++aO38ubiYl05UEwGtnOk6Vtff/+nC1QN+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736890; c=relaxed/simple;
	bh=fZudXsA6TDgjSpAHmX4TDRaEd1/rte2MAt9Tki0tGHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUeLSDbFnIAKdLJeWDZjcbG+HX+wlwUxpTaczh4loGaUNZVpbu8WolmEkd3xSGGTOrl5tAZVsqWAb8xPfXcefHYtII+xV2+CYSVQzafJ0Wi41rUSZlIfhvqPPUgwWAjTPeIOf3f7B4nCzkvpQNZ+MSivux1K+KDRQoJ3m2br2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TW88fyEW; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=J7f3mLAKs5aTYmrqkxyLkc8lw0Zm19/PnV18nFW9dUY=;
	b=TW88fyEWWHpX4hPCESuPi0c1Ax5rCJkDSnFRDbMiTbK+UldlzYLHydGvoeDXsx
	usfdP5EulXo+sM5+frUA/6P5xRUP+D2wPok8UGyBzH5QVyqZcTFHQyf5lIdW30b/
	HgXezipCCOUPAKNeXzDnaZTcOXRnQ9hOiUoIdo8U7l7To=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3f3KAuVZnxPyNBA--.47131S3;
	Mon, 09 Dec 2024 17:33:54 +0800 (CST)
Date: Mon, 9 Dec 2024 17:33:52 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, wahrenst@gmx.net,
	elinor.montmasson@savoirfairelinux.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
Message-ID: <Z1a5gBgVIl0BAJ4y@dragon>
References: <20241108153546.268695-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108153546.268695-1-eichest@gmail.com>
X-CM-TRANSID:Ms8vCgD3f3KAuVZnxPyNBA--.47131S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryrGw47JrW3XrWxWrWDXFb_yoWDKrX_Cr
	n7Ww4kGwsYgrZruw18uwsa9Fs8uay8ursxWrnIqFyag3s0vrs8Z3Zxta4rZrn7Xa9aqayU
	JrykuwsIy343KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU08Oz7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBOwZWdWr8gxLAAAsJ

On Fri, Nov 08, 2024 at 04:34:34PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio.
> 
> With commit d469b771afe1 ("ARM: dts: imx6: update spdif sound card node
> properties"), the more generic audio-codec property is used instead of
> the old spdif-controller property. Since most i.MX6 boards now use the
> audio-codec property together with the linux,spdif-dit and
> linux,spdif-dir compatible driver, it makes sense to enable
> SND_SOC_SPDIF in the imx_v6_v7_defconfig. This will ensure compatibility
> with the updated device tree.
> 
> Without this change, boards that use the audio-codec property will show
> the following error message during boot when using the
> imx_v6_v7_defconfig and spdif audio is not working:
> [   24.165534] platform sound-spdif: deferred probe pending: fsl-asoc-card: snd_soc_register_card failed
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Applied, thanks!


