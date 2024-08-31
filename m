Return-Path: <linux-kernel+bounces-309930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE282967205
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AD01F22307
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8689F1B28A;
	Sat, 31 Aug 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="XapfVc8h"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81018AD31;
	Sat, 31 Aug 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725112770; cv=none; b=UNzKtf9Rp/M5CcWCpr014aMKyCdidSHtFPbyNEODNUC4vsTqSkAJ3kYKR0DExzr5+Bp3Ed754ETxvjXbLkG2412lsRvOOQsNiND8uAaUQ86pHw8AAkx8kgVGJAQWfAKB/2Nd86ClrP4ulzqv3hzD8HcN49byhWoEEBvnI5QL2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725112770; c=relaxed/simple;
	bh=olb2Yj319sDzyouQfaWxhscW/cDafKrdK0bsMwqI+SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0RN8iEzBodtF7owdCsCGi5xW9xBKwDgM/96l0dY62E6ICG3fZwCIwH0PvAYDTm9fGLZliDMBKg+xoyENcThD75Yndz7j+Xt/BrIIzoEVlMBFu+L2fCD2YaN3cDnpj14IE2Z6hJheErcrDyfPuts27G07ffZWP/3qy40L+f9JMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=XapfVc8h; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=rIBs47d/scBVqEy3z5/U1QghjEY+bs2wua1lZgASHyQ=;
	b=XapfVc8hIqZAzD95PT1c5wuygQx5O0/rHMu1pbatGHFcD7Y3tyi/aqTlyplJj3
	mwC6SC/hSoiD+oVUoTwaEK1907hX8upPIphdLXYty3RxhHYmurtiyFF8Pz38dqMx
	ZR+6WfdP025d4wVjlE6gGEhyaKsPDKHZ62cSsAzZuzDmM=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCX_jWRIdNm4fQ6AA--.16889S3;
	Sat, 31 Aug 2024 21:58:43 +0800 (CST)
Date: Sat, 31 Aug 2024 21:58:41 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 00/12] arm64: dts: imx: 3rd dtb warning clearn up
Message-ID: <ZtMhkedCstjfNJca@dragon>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
X-CM-TRANSID:Mc8vCgCX_jWRIdNm4fQ6AA--.16889S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFyUtFy5JFyUZry7Kr4rKrg_yoWftwc_uw
	13Wa1kWw4UJayfAw13A3Wjq348Wr15CryUWFy2g3WkXr4fta45Zas2v34rWr1UAF4a9r1D
	uF1UJw4vq3y3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0HxRDUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQtMZWbS-GE9EQADs1

On Mon, Aug 19, 2024 at 01:01:09PM -0400, Frank Li wrote:
> Frank Li (12):
>       arm64: dts: imx8-ss-img: remove undocument slot for jpeg
>       arm64: dts: fsl-ls1043a: move "fsl,ls1043a-qdma" ahead "fsl,ls1021a-qdma"
>       arm64: dts: imx: rename gpio hog as <gpio name>-hog

Applied all except #3 which doesn't apply to imx/dt64 branch.

Shawn

>       arm64: dts: fsl-ls1012a-frdm: move clock-sc16is7xx under root node
>       arm64: dts: layerscape: rename mdio-mux-emi to mdio-mux@<addr>
>       arm64: dts: fsl-ls1028: add missed supply for wm8904
>       arm64: dts: imx8mm-venice-gw7902(3): add #address-cells for gsc@20
>       arm64: dts: fsl-lx2160a-tqmlx2160a: change "vcc" to "vdd" for hub*
>       arm64: dts: imx8mp-venice: add vddl and vana for sensor@10
>       arm64: dts: fsl-ls1088a-ten64: change to low case hex value
>       arm64: dts: s32v234: remove fallback compatible string arm,cortex-a9-gic
>       arm64: dts: imx8mm-beacon-kit: add DVDD-supply and DOVDD-supply


