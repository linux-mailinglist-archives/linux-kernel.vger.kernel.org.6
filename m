Return-Path: <linux-kernel+bounces-232141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D2491A402
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A87EB20A91
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8D13E029;
	Thu, 27 Jun 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="T8f3RMfO"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4031386BF;
	Thu, 27 Jun 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484682; cv=none; b=JMXFuavro87IC24BBmFO9momI2aP4ONacQ1Cgy59rPHjrDkBrbGdH1jDElBYKFbI+Wv9jtzmBzdXn65vUYFnnm0iUvuq0quF3w3PzJTqOAkb2LD3RbwZINBTEb3x774E63RhRDa5etwCWMhwukVvGzqcOVrx4g0zLGMMqV0FQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484682; c=relaxed/simple;
	bh=J7HqGzCFxvM7WV0C+sFHgXvFU5LTNWgPqlRmG8ld9Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn7qeDHK9U4luwr2mTHMq6LOGkMvEgvSlz/A5N5bp5a9sz7tM3YgKaitTYRlxBW9X8deP2Pc0Oe1J11HRVu3gsNqt3o4iciuD8rcdDL9JPMq+GndVHoRHtAz6vkz1cpdcs7MUH9ekCI8gehmlTrvRkddOSY7Sh7HKXXLZ5eAqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=T8f3RMfO; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9sxCIQg8fVr2efTR8sroAQlij2XuJ03C7PxfEvrRihE=;
	b=T8f3RMfOBpTFk3XO4029KZALIhUqtMbPTWZnXxtrB8H7YZbSeIAh7fwXr/kosi
	T+Bq4oC2xcx5bQRO9ER+K+ieawG1cpnf40Hp9M6FA+QMV+qzlc/F78BJdFgAjXsa
	T+Kcl7+oOMyWp7GIJXrLyVRoG6YHVeTlzcUoCNZscCEQA=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3v2riQH1mnIwaAA--.25525S3;
	Thu, 27 Jun 2024 18:37:24 +0800 (CST)
Date: Thu, 27 Jun 2024 18:37:22 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, shawnguo@kernel.org
Subject: Re: [PATCH v2 00/13] arm64: dts: layerscaple: clean up some simple
 CHECK_WARNING
Message-ID: <Zn1A4gcDpOArsSof@dragon>
References: <20240626202533.2182846-2-Frank.Li@nxp.com>
 <20240626202809.2187404-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626202809.2187404-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgD3v2riQH1mnIwaAA--.25525S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryfuryDAFWfCrWxZw1xGrg_yoW8Gr4UpF
	Z7ZrWUKryIyr9Yg3WkZ3ZrJ34fG3y7tF45Jr1agr1qkr1Y9rnrWF9Y9F98WrWkGan2vay5
	tF17XF4ktw1vvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVZXrUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCw0LZWZv-czt0AABss

On Wed, Jun 26, 2024 at 04:28:09PM -0400, Frank Li wrote:
> Change from v1 to v2
> - Combine some similar warning to one patch for difference ls chipes.
> - Remove arm64: dts: layerscape: add '#power-control-cells' for rcpm
> rcpm actually not power-controller, it is wakeup controller, need
> better method to fix warning
> - Add aux-bus fix
> - Add pcie irq order fix
> - Add rename to rtc fix
> - Add thermal-node name fix
> - Add q(b)man-portals node name fix
> 
> Frank Li (13):
>   arm64: dts: layerscape: rename node 'timer' as 'rtc'
>   arm64: dts: layerscape: add platform special compatible string for
>     gpio
>   arm64: dts: fsl-lx2160a: fix #address-cells for pinctrl-single
>   arm64: dts: fsl-ls1012a: remove property 'snps,host-vbus-glitches'
>   arm64: dts: layerscape: replace node name 'nor' with 'flash'
>   arm64: dts: layerscape: remove compatible string 'fsl,fman-xmdio' for
>     fman3
>   arm64: dts: layerscaple: add #dma-cells for qdma
>   arm64: dts: layerscape: rename node name "wdt" to "watchdog"
>   arm64: dts: layerscape: change pcie interrupt order
>   arm64: dts: layerscape: rename aux_bus to aux-bus
>   arm64: dts: fsl-ls1043a: remove unused clk-name at watchdog node
>   arm64: dts: fsl-ls1046a: rename thermal node name
>   arm64: dts: layerscape: rename b(q)man-portals to b(q)man-portals-bus

Applied all, thanks!


