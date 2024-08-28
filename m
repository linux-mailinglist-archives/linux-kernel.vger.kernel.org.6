Return-Path: <linux-kernel+bounces-304269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD72961D01
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D961F24999
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F713D50A;
	Wed, 28 Aug 2024 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="JfSXU9+e"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B553C64A;
	Wed, 28 Aug 2024 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815627; cv=none; b=KzhbYwNLfTiArYPdLjqZmA9J67rbbZHBBXk46Ne7NM0+Eqk+jD/G/CdAke9gHSb1E9iSlPlzJXjvUkcgQrY/WvK8ButOxwG9hsucCMST9OWwvVE3eXuQiLAjxpkYrIRfXSGu/TPvp0JzsmfWrnvfVf1/tNYBaG5xyteDHltbUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815627; c=relaxed/simple;
	bh=Q39l5fDbckzRksH8EAZrkXrhZJa8vD8qWLMhV8saxUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4CvbZCoVCBRRquloQ1myzP+al6QblUuygG/UfudTw83sAGU5YxaXSGIVG/glEnYeKyKGXrzt6eyOfGbJeKBK69wSY1gz01wYwZNio2uKb3g4bhUJhPgiwALa06C7wJzSfma+nDDtMz1cxZypLb9YRP5zvlB2lr0amkiD5kefcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=JfSXU9+e; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=h3JjGv/N8L2zcJNzHvUr/aEYJjgel2MGlSMr+f/ZFVs=;
	b=JfSXU9+e3yHLS+lZrdekQWxA0EPvUQtPhP2j+VqctrnXBm0g1yAnXyzNRCHh/D
	4mrePmIwxrAnZHkxzmjSVWOkIPHswWpQJlDvFVZ0lxcGLQ97mRGCEVRgSGHZ72eQ
	djoJnulukVryd7kxSIx89IDfNg+4AgFH0IlPEDR+MS5Ts=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3vz7pmM5mSMoOAA--.22932S3;
	Wed, 28 Aug 2024 11:26:35 +0800 (CST)
Date: Wed, 28 Aug 2024 11:26:33 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH 0/5] TQMa6x / MBa6x DT improvements
Message-ID: <Zs6Y6XoqU4DBLvbL@dragon>
References: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com>
X-CM-TRANSID:Ms8vCgD3vz7pmM5mSMoOAA--.22932S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4DGw17WF4DJFy8GF1xZrb_yoWxtwc_Zr
	n8Wr4DAan8GF43W3y3Jrn0gr9rKw1UKay5Cw4rWw1UJa1rX3Z8Wa92k343X3yxArWFya4q
	kr1DZ34j9FWkGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8E38UUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCR5JZWbOhc5TWgAAsR

On Mon, Aug 12, 2024 at 04:34:26PM +0200, Markus Niebel wrote:
> This series brings following improvements:
> * use a more specific compatible for the LM75 temperature sensors
>   on SoM and mainboard
> * move I2C pinmux entries to variants that use them and prevent
>   doubled declaration
> * rename node name for onboard USB hub
> 
> Alexander Stein (1):
>   ARM: dts: imx6qdl: Rename USB hub node name
> 
> Markus Niebel (4):
>   arm: dts: imx6qdl-tqma6: move i2c3 pinmux to imx6qdl-tqma6b
>   arm: dts: imx6qdl-tqma6: improve compatible for LM75 temp sensor
>   arm: dts: imx6qdl-mba6: improve compatible for LM75 temp sensor
>   arm: dts: imx6qdl-mba6b: remove doubled entry for I2C1 pinmux

"ARM: dts: ..." please.

Shawn


