Return-Path: <linux-kernel+bounces-198517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE108D7986
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E8A2814B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92061FB5;
	Mon,  3 Jun 2024 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VaheeM0i"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8610FA;
	Mon,  3 Jun 2024 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717377393; cv=none; b=FaIIM6E8udHqPeM/ClMyiKupqE/B97xJ/uYIs6rZEiO/F3bRjl0kEHIbHyeK/CAMgss8Gfs5f7PPQ8fccoZX+gUGgQsOSJ1UoMD7YUIh+8spYkaTn+8+JWyhj6RPaKN3cMqEVRHMQ1dETxuTqkrQJN7FjyWasho2eUrp+6VXDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717377393; c=relaxed/simple;
	bh=blOXyHMP9eToWR4G3lL6JjYMHa7QJ1WsjA1jVi8WQaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hsgb3XwnY/Orxc/Kd20UA5Mzbi0SRQ0NVfI1+CWJhDLsR5BKD6vw0+qm+lU+mcylvU2/HPr8opxk2uaprFAtyCi0Q1zbBU6kiW+se3UsMVLUJN3Pl66VP9sFXMJffEdHC+UK1CtcHY8HvDUTrCnHDqu6dsJHNYNcJUXVAInF7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VaheeM0i; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=RovHC8mcGRzNAGtETqxBmyf7owyCpzoZbO6+2XD5ezc=;
	b=VaheeM0ibtG6P1Jz9+49ODQW5pd4qMIxXBcefx7cSs3z/m+A/IDic3MoFD67Kj
	P+IDVA2/PFw6TWrXy53Sg00uObSnOvyZ7IALYwOuhHIH0yZ1hYDA259qyOBNxGl6
	jZ3cC6rwwAdVXD/vwQ2CyydiyQWCDxFPifk35tMWYVSbg=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrADnr0QvGV1mfIUwBw--.36226S3;
	Mon, 03 Jun 2024 09:15:28 +0800 (CST)
Date: Mon, 3 Jun 2024 09:15:27 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] arm64: dts: imx8dxl: add audio support for imx8dxl
Message-ID: <Zl0ZLxda/a6FvoYO@dragon>
References: <20240425-b4-dts_dxl_audio-v5-0-46397f23ce35@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-b4-dts_dxl_audio-v5-0-46397f23ce35@nxp.com>
X-CM-TRANSID:ClUQrADnr0QvGV1mfIUwBw--.36226S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUswZ2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBRDyZVsVCm8GUgAAs9

On Thu, Apr 25, 2024 at 11:34:40AM -0400, Frank Li wrote:
> Frank Li (3):
>       arm64: dts: imx8dxl-ss-adma: delete unused node
>       arm64: dts: imx8dxl-ss-adma: update audio node power domains and IRQ number
>       arm64: dts: imx8dxl-evk: add audio nodes

Applied, thanks!


