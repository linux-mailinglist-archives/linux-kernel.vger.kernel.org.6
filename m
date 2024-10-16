Return-Path: <linux-kernel+bounces-367199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1541E99FFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966B8B23302
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D0717D896;
	Wed, 16 Oct 2024 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="nlWN4ORL"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7921304BA;
	Wed, 16 Oct 2024 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050727; cv=none; b=IKfHHJOsw1fq44syxEHnobP/X2WBb54MkB/bRQPVuUOTlIHMj6khKMxRowsMXzCJfAaQ8dd3HEP7qqTNPG8ntfMiUAWCAGNxcm3VCrN42Wf3lXLmF2Uccg5rng1TksHtcZ/AKxvbqFVnbhICFe3LMc7STJDZUo6lv3JlxR66iDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050727; c=relaxed/simple;
	bh=i0oyF3S1jAQPmVHT/yiLKVxqroap7/90JcQ7zu3JOWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAvSMCq0lrjcWQn+SMHy5t0z2f91vdDgNyKhp9ice8FIgn8Vo7Zz9CCpT7gx2/m0QTs5cnLp4dHknOXt6Rm2yBFyMe0VK3u45LX3L7TsFSexSWj4GSRhiLKI/HA2zeRH5Flkh/BtLkwaG7BmqH6kZ42mvo975iYcRXRgh9FL1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=nlWN4ORL; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=jmFozbLWgaQflNtxAhxn4cd9iiQsaZAwFfFa3MgoSxs=;
	b=nlWN4ORLR38AmQbvEj7YsgVRs9qD+jHkac4N/1xLqkv8OJ0C+vk2J8QUGOsc+k
	eoDdCxqZar81ZoDEy8e8G+speyNbLWG8Gt0TdGPixxSIKix1HeBvQR0T8z1SlelA
	t77DAR5AFS7VCNACVqejKaseK8A5CR1CfDERXxnyFesRo=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBHk_1BOA9nTY4VAA--.259S3;
	Wed, 16 Oct 2024 11:51:31 +0800 (CST)
Date: Wed, 16 Oct 2024 11:51:29 +0800
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
Subject: Re: [PATCH v3 1/3] arm64: dts: imx93-11x11-evk: add io-expander
 adi,adp5585-01
Message-ID: <Zw84QZlvEqKa4PKv@dragon>
References: <20240903185450.1486505-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903185450.1486505-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgBHk_1BOA9nTY4VAA--.259S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxCJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCx96ZWcPLTgmEgAAsC

On Tue, Sep 03, 2024 at 02:54:47PM -0400, Frank Li wrote:
> Add io-expander adi,adp5585 under lpi2c3.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!


