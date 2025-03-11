Return-Path: <linux-kernel+bounces-555392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3268A5B6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617E418955CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547CF1E5B69;
	Tue, 11 Mar 2025 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lPnlQljQ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429EEEBA;
	Tue, 11 Mar 2025 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660643; cv=none; b=Zcg9fcnnrQkrhO0u6lh0hNYSIqjVa/gYJ6Dl3ltdaOGo9liCiqeiutzERD+V/ZdCM/4YVV+Jrf60Cfijg7Y7jQnN0D6gVl7aXMN14WdKhUJKWPFQvtgPiduQiJ+Pyz+YnmUFef+rxziQHizykRJTYyqM6T2b0R76rAzoSwHddbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660643; c=relaxed/simple;
	bh=FXtPzAGVJb0GdIlkJWer/5cmp+mFmG55OSNf2JR/SK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEtbTggwc7gCgc6Tzxd0f9E/0oBiuYQj2ITNWvOtbL4wfEEFDjpAjsqXp3q6fHcpMKsQYK6nZK+5qjvgGw3doVnN6QSinvywc8Vq85if1mhygsCC3Ie3jOCUz1WwX9d/+wHnT43XTe+402s8fWAz60+8ZEkWo461vKqv6PxASPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lPnlQljQ; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ynTyUmTRCgFTrUshSeCg3vb32qg0W3S4+Fy0XJ4c8bs=;
	b=lPnlQljQAhc8CzTGxTeVOX4ueEc/kN7y2BvyDQp4u5LvrdQPaN8hStqne9EMN2
	FUNpegP2C6hbrt+Xx5h/RZYg7fhsXJlYeumba48vBAHlwKtyylT4vRtopgPar/p4
	dNUQ4HkoEYQ0opeCu4j57BMGcDwLF7vIADn8JTjYMF1Cc=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAXFkPEoc9n2Xe0AA--.48983S3;
	Tue, 11 Mar 2025 10:36:54 +0800 (CST)
Date: Tue, 11 Mar 2025 10:36:52 +0800
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
Subject: Re: [PATCH 1/1] arm64: dts: im8mq: move dwc3 usb port under ports
Message-ID: <Z8+hxCxum9uTLGGC@dragon>
References: <20250224193308.407606-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224193308.407606-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgAXFkPEoc9n2Xe0AA--.48983S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4fGFy3XF1kAw15ZrykGrg_yoW3uFX_Aa
	17Wr1rur4DZFs7KF1jyFn7Aa4UK347J3srXryfXw1kXryIv3Z2kF45tr95ur1UGF40qF93
	Ar15JF10y39akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0rsqJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgANZWfPVKnuuQAAs4

On Mon, Feb 24, 2025 at 02:33:07PM -0500, Frank Li wrote:
> Move port@0 and port@1 under ports to fix below DTB_CHECK warnings.
> 
> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: usb@38100000: port@0:reg:0:0: 0 is less than the minimum of 1
> 	from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#
> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: usb@38100000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dr_mode', 'phy-names', 'phys', 'port@0', 'port@1', 'snps,parkmode-disable-ss-quirk' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied with a change on subject prefix, s/im8mq/im8mq-librem5, thanks!


