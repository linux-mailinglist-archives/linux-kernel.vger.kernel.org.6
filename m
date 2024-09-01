Return-Path: <linux-kernel+bounces-310139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A54967570
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B361C212F6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA94A1B;
	Sun,  1 Sep 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gnvR+cAG"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578972C6BD;
	Sun,  1 Sep 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725175857; cv=none; b=O0tCbUtjqPibDQspQWuHj34eao4eKk6kmxnmZnGC7m2XhxBGkD4/tIBPbFBIsLGRAMwCbxYpZxtJn3J9QF9zXmkytq24f3IovXjmzlc/ltcl3/ZbMagHAnu5+qjWCRa4q77UU3nxOQuKp0GkwTMMTcIYTFwV00OSW1uiSILM7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725175857; c=relaxed/simple;
	bh=dfGeXFMOq6f00IZpOQZm8N5Bvm7vAxBrOwA5Vq8b3xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFYR9/HbphpoXNE93LkAqpRUqnWcXZiA+JiaNIcOzWkS7oaA2obAMIy+TW/dIGwfHJFlZnYb3indeT9XNKjaaL6O0QtjH42SvY2EQfZh4ipEGVJh9FYAK0ml3Bfy2MY1ysGUY5HX+JX9uIxH6n9bp8x4fEG+mCXy14PROT9EEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gnvR+cAG; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=pMInww7cugqnnQuFre6/o9W0dpqCLo2tn4lGGIQUctU=;
	b=gnvR+cAGDxeHajIsy6dlFtqNBj4IbIo78MXAltpJMcHmI1z72OVOh5kTjrqCcI
	/yXS+282eUEifveONnd5G2nPlGCE+btKdUfdDzzUiR7VgVpgHM4sFAy4ZB85XjXF
	JUL/SYHjuy3JTErHP2K5lmGDilF31iTSumQDkeqSVq++Y=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3P10DGNRmrAJDAA--.30458S3;
	Sun, 01 Sep 2024 15:30:13 +0800 (CST)
Date: Sun, 1 Sep 2024 15:30:11 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Yashwanth Varakala <y.varakala@phytec.de>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v2 3/3] arm64: dts: Add phyBOARD-Pollux dtso for rpmsg
Message-ID: <ZtQYA1GA9CH3noBw@dragon>
References: <20240820171848.177926-1-y.varakala@phytec.de>
 <20240820171848.177926-4-y.varakala@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820171848.177926-4-y.varakala@phytec.de>
X-CM-TRANSID:Mc8vCgD3P10DGNRmrAJDAA--.30458S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1kZF1DAFyUAw4xKF4kJFb_yoWfKwb_GF
	4Iqr17JFZ5Aa17Wa45Ww4fWrZFka4UKryfXry7t395CF97Za4SkF4DJw4fJr13CF1rKrs0
	ka90vasIkw1YkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0zc_DUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAtNZWbUC2IbOAAAsf

On Tue, Aug 20, 2024 at 07:18:48PM +0200, Yashwanth Varakala wrote:
> Adds a devicetree containing reserved memory regions used for intercore
> communication between A53 and M7 cores.
> 
> Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>

I'm getting these warnings.

arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso:25.3-10: Warning (ranges_format): /fragment@0/__overlay__/reserved-memory:ranges: empty "ranges" property but its #size-cells (2) differs from /fragment@0/__overlay__ (1)
arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso:24.18-54.4: Warning (avoid_default_addr_size): /fragment@0/__overlay__/reserved-memory: Relying on default #address-cells value
arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso:24.18-54.4: Warning (avoid_default_addr_size): /fragment@0/__overlay__/reserved-memory: Relying on default #size-cells value

Shawn


