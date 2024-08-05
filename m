Return-Path: <linux-kernel+bounces-274335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476C79476E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46491F21B65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC74B14B960;
	Mon,  5 Aug 2024 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YpsABBu6"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797B13E05F;
	Mon,  5 Aug 2024 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845344; cv=none; b=VMFFFetOdac1d9BJmPpe20ihTBfaWP/wLjrOOeEbBUiKD4fx24aNPqJQL2s1fXnFSYzSHgGObl53oVKCEQqXlIot9OEYjN6zYHhudRb9bpN8enu066XEIRqNHVsaxcHQMDj0Ner4VbUbUSBMfIO6UDks5Mk9ribcm9E0H5iG6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845344; c=relaxed/simple;
	bh=KE/Au4YFNV4bz1phxnnuJ5q43HE2mGsEXaLzPA/x8Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBrD1hz2mD8fbSj+TR8p5jwqy2A0ijh6Gyf66eXCcdNM0PMctpHd82iJuVsZ5P6ldES+xueesWOH0l0f4Ai+nDXnKzNaNLJz2DROBMQE0zJFHAOScypu88FCuuADvdwPY10YkZls22m6aFz54KA16zpmWNcmQ3g8qG6/z8Gn1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YpsABBu6; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=zbXZUL041JHyI1fWwrbPiM7cj8TSvBZYJLch7Yc7dlk=;
	b=YpsABBu6Zsjp7rqgHOz5uk5LeICWFp4JgwvqpaKJIfPpSK2z91r+Oqa1xibIrq
	qkNV5v56RUu7vF9epPbfeXzIWGLGDtwmhE1HxeakflDuZ1VzWQ+UwN7v+XBZSPX/
	T91IF/R7WzYolBmJmnLOiM+MwozNdVqCPhslFpN6Cba0w=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBX379riLBmkIORAQ--.48430S3;
	Mon, 05 Aug 2024 16:08:13 +0800 (CST)
Date: Mon, 5 Aug 2024 16:08:11 +0800
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
Subject: Re: [PATCH v2 1/7] arm64: dts: imx95: add edma[1..3] nodes
Message-ID: <ZrCIa/91C6mYpB3E@dragon>
References: <20240701200728.1887467-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701200728.1887467-1-Frank.Li@nxp.com>
X-CM-TRANSID:M88vCgBX379riLBmkIORAQ--.48430S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAkyZWawgQMbcwAAsm

On Mon, Jul 01, 2024 at 04:07:22PM -0400, Frank Li wrote:
> Add eDMA1, eDMA2 and eDMA3 support for iMX95.
> Add dmas and dma-names for each peripheral, which use eDMA.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!


