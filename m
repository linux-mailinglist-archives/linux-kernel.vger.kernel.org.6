Return-Path: <linux-kernel+bounces-375400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040729A9578
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5DE28404C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E57684D0D;
	Tue, 22 Oct 2024 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AsTDbaKW"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC58F66;
	Tue, 22 Oct 2024 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560758; cv=none; b=EHsJgNqgJ7s2zvZlN8MeX0N76mNTyO20hC75yim7xclcj0Alg/UUi29U73zccAej/YUP4aqi7+oZ/X51l5+3Qnw3EFccsRvN3RlHE7FbER8hp+hGLpnfNSRJYoMdUzUm7KP+twpcUtNoIYZmdN5uD0tnwwbTyAhkhT5GzHPebC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560758; c=relaxed/simple;
	bh=OMkw5dnxET0m6i1oeX8vKcSmAhjj/0kZ0bp/cpjgfkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh9oy7IMEM1vBwV+I0cN3wKlIe3U6cc+XJepl6vxmZFzSfZntLHj/iBLKOpBfoA+KKVxv2C4tq0420tmbf5nyz5/P73wdw+HG0kJR5NqnaniOAkNZIyMwC0CkDPl8LXdFnleE/N2M0cleR1IysrCr6imCOvoUkrtlnBFVjXik/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AsTDbaKW; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=1X8kVmEbMFJxApTAaGolOIOVn5C/D1ylt7AqE6Lsdlk=;
	b=AsTDbaKWt9TrwbvX6xHRv2hgIP77UgHetYAxOpxHPYXOi1Vnrlh+bnN46ILpGN
	XGttILnw8fWb7UjO8no3O7euz2AbOYLf5FRg6MEzgDJb3vWGs99P18AljhSlJXUU
	+79fsH0clARBfGpPUjbImRRrnT1u+n6a7KQXnjJM9VyyM=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDH5tWNABdncyiVAA--.5247S3;
	Tue, 22 Oct 2024 09:31:59 +0800 (CST)
Date: Tue, 22 Oct 2024 09:31:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v3 0/7] arm64: dts: imx95: add various nodes
Message-ID: <ZxcAjXzQjsmtcwDa@dragon>
References: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
X-CM-TRANSID:Ms8vCgDH5tWNABdncyiVAA--.5247S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4IJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgeAZWcW3kZSbQABs3

On Sat, Oct 12, 2024 at 07:19:07PM +0800, Peng Fan (OSS) wrote:
> Peng Fan (7):
>       arm64: dts: imx95: set max-rx-timeout-ms
>       arm64: dts: imx95: add bbm/misc/syspower scmi nodes
>       arm64: dts: imx95: update a55 thermal trip points
>       arm64: dts: imx95: add anamix temperature thermal zone and cooling node
>       arm64: dts: imx95: enable A55 cpuidle
>       arm64: dts: imx95-19x19-evk: add nxp,ctrl-ids property
>       arm64: dts: imx95-19x19-evk: add lpi2c[5,6] and sub-nodes

Applied all, thanks!


