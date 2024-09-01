Return-Path: <linux-kernel+bounces-310171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D365C9675D0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD8C1C20D98
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B3D14B972;
	Sun,  1 Sep 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="RkBG5WUd"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F89142904;
	Sun,  1 Sep 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725183990; cv=none; b=PpTAc8I7P75te3JiXMdKkov2k3ME4FnHg9S3aAEbAIHbrLvTY79LJKeE0YsYZCVyILg+izYEvEotsIKHx9HgVsaFB38c/278iC0XQD8X43iXlZTAxu4l7uQ7pD1cuQPJSIXypK3QzDiXKPu7+bj8ZUNHOT5I61kKjjO+ea33Nkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725183990; c=relaxed/simple;
	bh=P2pnO1BrbY1wEyH8aTS6WNyRjXR/lbY2nnn9GSwtraQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2v5BwevESP/5D9KHROdZb0JHEnW/t4xc+QSgzLdVCLrOTgLSK1kgP1M4JS4jLnKVv6Zgr0h/KRjGPaPVxB2Xmzbcu0XXwNQVdIkdsSrI98u7vyQFqjdBDoKB38UKQNr2uV6laontCvWUmttkzkwJWW721D1lLALuoAi4Q7De5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=RkBG5WUd; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=RfsGjbmHv8ZEt+kPwgGgTifDmBQIRDYNPTcUivaQ62E=;
	b=RkBG5WUdblZMtXfWh0aKe7wW6lH3JZ4twlLiNPqX8MAZMj3kX9PY/XqOIW/yjo
	ngkYdFfwsBE/ror6KDf3HFxfzHAj+raUJBlqTpAlfF7/+GGUrNSV5Ve4d3kOZWRK
	Ye9VPSGkeJO8HrIYIrwkdDLzcj7rK7qvk+zyG9YC0rbQU=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDXfjrQN9RmxBxEAA--.32322S3;
	Sun, 01 Sep 2024 17:45:53 +0800 (CST)
Date: Sun, 1 Sep 2024 17:45:51 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: imx7: minor cleanups
Message-ID: <ZtQ3z+lWiUZMaGj5@dragon>
References: <20240828095638.231569-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828095638.231569-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:Mc8vCgDXfjrQN9RmxBxEAA--.32322S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVnN3UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAh5NZWbUDStdlAAAsp

On Wed, Aug 28, 2024 at 11:56:35AM +0200, Krzysztof Kozlowski wrote:
> Krzysztof Kozlowski (3):
>   ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property
>   ARM: dts: imx7: align pin config nodes with bindings
>   ARM: dts: imx7d-sdb: align pin config nodes with bindings

Applied all, thanks!


