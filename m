Return-Path: <linux-kernel+bounces-284335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E803F950001
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87E1286E94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347B13BC38;
	Tue, 13 Aug 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="S3A2JamD"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714B013A244;
	Tue, 13 Aug 2024 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538344; cv=none; b=k/UGctG0FOgFU5Ke+jpiJnO9iSJ5kNi2cA8czKwDLrwmyeE5SVcG00L4Va+cp9wiAckk05W+/YgHyWVHVjkcLv/wlMQX90u08bUCLfu0CrGOilfg1v9sEzC9KHaWTxcv93C4ZsCOrjymAIwVMWyl1PhXnPcyGf4z++JnAGRJl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538344; c=relaxed/simple;
	bh=KNC1FlKtaFTC7uEe/OzVoy8EeVo9yNK8fvRodY33ENs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8i+LDAUEsDCFVRwPgTb6n1YNQ4BtCx/IoqN3z5ekE+4WBV2OSmaPrrIKX2Uke+tX/qkNiddIrZuzqCnWWQZ5PPurWgqb6R8Nh8DgwJx4agKoELl69Cspzpmtx89CWApe08gWPlpad+AjCoendvnrMGnKhNZeRfRadxlzgjhQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=S3A2JamD; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=g1PQSpwNOrLhtPCyYwrJXqmAm+KykyaUlnObNwe/CE4=;
	b=S3A2JamDLEQZiU4cRVs4goD+wOl2/JtIScb/EKbKxi9omyQ0oq65QmtIQudXgf
	L/yf6BBgm0C9XkWtl2GyO4qnW2V/3dnCjwC1voPd/uMAam8tBP6hdfvA+xBWuAHk
	RwhqMIn/duxdFIoko7hMoIUUS2l6rgN4N1/3WyUF+rQ3M=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnr5mBG7tmLoJiAg--.6804S3;
	Tue, 13 Aug 2024 16:38:27 +0800 (CST)
Date: Tue, 13 Aug 2024 16:38:25 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Teresa Remmet <t.remmet@phytec.de>
Subject: Re: [PATCH v2 0/6] arm64: dts: freescale: 2nrd clean up dtb warning
 under freescale
Message-ID: <ZrsbgQj/XVe6Eqm7@dragon>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
X-CM-TRANSID:Ms8vCgDnr5mBG7tmLoJiAg--.6804S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyDtry8JF43AFWrKw4kWFg_yoWfGrc_u3
	WrW3WkW34UCw4xG34qy3Wq93sFgw4UZr9YgF1Sqws3XwnxZFy3Zr1kJrWfWw4kCFs3urWD
	AFyUXw1qqw1F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn_gA5UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQ86ZWa7DgUtHAAAsm

On Wed, Aug 07, 2024 at 10:52:03AM -0400, Frank Li wrote:
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - added fixed tag for arm64: dts: imx8mm-phygate: fix typo pinctrcl-0 .
> - remove compatible string for dto file
> - drop patches, which already in mainstream
> - Link to v1: https://lore.kernel.org/r/20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com
> 
> ---
> Frank Li (6):
>       arm64: dts: fsl-ls1028a: remove undocumented 'little-endian' for dspi node
>       arm64: dts: fsl-ls208xa: move reboot node under syscon
>       arm64: dts: imx8mm-venice-gw7901: add #address(size)-cells for gsc@20
>       arm64: dts: imx8mp-data-modul-edm-sbc: remove #clock-cells for sai3
>       arm64: dts: imx8mp-venice-gw74xx-imx219: remove compatible in overlay file
>       arm64: dts: imx8mm-phygate: fix typo pinctrcl-0

Applied all, thanks!


