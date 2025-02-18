Return-Path: <linux-kernel+bounces-518580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A5A39127
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDE51894A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 03:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D53B161321;
	Tue, 18 Feb 2025 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="qWlCq4FO"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE728373;
	Tue, 18 Feb 2025 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848368; cv=none; b=EoBb02drsLsZ1BnalHYNZuUO3gPKeA9sGS03pLmI7G+ph8Kn25E9hA2Lq5O0UuFiWv4Icpf/arxsYpeqyZpstn+e9S+lH6u675Zjxm0U/OQplthvShCP6ylZnAKV8//B4qWlPN8zzKP9h0oKI0YNhGOPzIpYMSk4CSKJ1oCksDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848368; c=relaxed/simple;
	bh=IaYak8ZAhTWiVDW7+X3d5puGKle3mrD6/+6DIpb8/6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLyRM2Dp+6cBfdzWeoEAI98Yh+6sWNnnhoHEvafLub8Vjz8R6duJAqOUvZoQixuXGPYGBa8BSlsSo64XfTdUT92MVXWKqeAmcimRUsusxu1uxFLRp1Bx156Yh5+NYqMPAa6LPstKVrj7x1E0wKK+kRC1q2HOS5XGKjdvTY3QCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=qWlCq4FO; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=I5sXNENN0HCvQl/q8XCRMfovXIba4uIDzB7gZ/fD00M=;
	b=qWlCq4FOF1aeWHSc1agaVeuZ90eACl8USQx0ppHIlNKGbHQom/nahJfLuArRyx
	VgqWYYAFnE1WsZqydOzVM0XJQREqs7MBkCy4wPXuFrHeHwKJ/vqUMp/zxeP6ooJt
	daAtaVv42FBAtYBNdGA4uka5aUenVyJ2QkWya+rEOaKCI=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDHalpZ+rNnj3Q0CQ--.18186S3;
	Tue, 18 Feb 2025 11:11:23 +0800 (CST)
Date: Tue, 18 Feb 2025 11:11:20 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Conor Dooley <conor@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Bo Liu <liubo03@inspur.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/9] Use correct LDO5 control registers for PCA9450
Message-ID: <Z7P6WBMxes7X5glY@dragon>
References: <20241218152842.97483-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218152842.97483-1-frieder@fris.de>
X-CM-TRANSID:Mc8vCgDHalpZ+rNnj3Q0CQ--.18186S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVf-BDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgz3ZWez6b5ivgAAsD

On Wed, Dec 18, 2024 at 04:27:23PM +0100, Frieder Schrempf wrote:
> Frieder Schrempf (9):
>   arm64: dts: imx8mp-skov-reva: Use hardware signal for SD card VSELECT
...
>   arm64: dts: imx8mm-kontron: Add support for reading SD_VSEL signal
>   arm64: dts: imx93-kontron: Fix SD card IO voltage control
>   arm64: dts: imx8mp-kontron: Add support for reading SD_VSEL signal

Applied all 4 DTS patches, thanks!


