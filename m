Return-Path: <linux-kernel+bounces-527610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4EA40D47
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C0178A0D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23050273FD;
	Sun, 23 Feb 2025 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NJ25arv6"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5875F1FC11F;
	Sun, 23 Feb 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740296328; cv=none; b=KbraAm7tDQ6Dd6m6uuuABV4j8Fgu8bEQp0GSjFu+KLkp/cgcp5ASRj6smflWtx2oRJTGgetX6cPvSESB8fAsGLZQnIOUfyK4PM8by3MkqQZlwpuieKy5hyyc3uWpJQmPmRVEWyqbi57iRM+IOHQ2vXxAII98E70Gx2FhODrLYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740296328; c=relaxed/simple;
	bh=i2dYoaxI8qTqb4j86RQOLybkjeou1XdI0LVEdkYI/yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuUj5cXdz+cJ4uzJ80MyqboUM/8q6TB4tw0nJR/PpWS3GcSc2m90JvUGG1oX6/sz4+BCQAsJDW742VPGuKQxxeUEDQG6p9aoruQpldrHlxByCwcAgbjNaVRz6E3PUBTR9VwxNJVyt3a2RiuzNibMeKj9zJd7EjFKtRUiVmBIsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NJ25arv6; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=oPXVRdAdTKk+04iwLdlaaflbSGUMVrgPOHzRGIn45yQ=;
	b=NJ25arv6TSaeOvQf8IygctFsn3BzU1ead0BXGkM/ZNb2emKqNBj2QZ7MiKFSRM
	4TEWq7VmJE/7hetNDF693lfCMLIuERGkIzwypO8oW2Rlc58WMkFT6o0lpeWJO+a1
	NUEmVZ4McAIcgXGFYsi5D0N4hL+63Yaza4qw92VJku7I8=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCXS3Zg0Lpnl1efCQ--.23292S3;
	Sun, 23 Feb 2025 15:38:10 +0800 (CST)
Date: Sun, 23 Feb 2025 15:38:08 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: rafael@beims.me
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rafael Beims <rafael.beims@toradex.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: colibri-imx8x: Add missing gpio-line-names
Message-ID: <Z7rQYN06RUFR2Xqy@dragon>
References: <20250210123134.1659719-1-rafael@beims.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210123134.1659719-1-rafael@beims.me>
X-CM-TRANSID:Mc8vCgCXS3Zg0Lpnl1efCQ--.23292S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxuWlDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgb8ZWe6xy0Q-QABsG

On Mon, Feb 10, 2025 at 09:30:50AM -0300, rafael@beims.me wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
> 
> Add missing gpio-line-names for SODIMM_79 and SODIMM_97
> 
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>

Applied, thanks!


