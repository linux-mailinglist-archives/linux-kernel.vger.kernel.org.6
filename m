Return-Path: <linux-kernel+bounces-392021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F3A9B8ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBF9B210EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826DB15CD52;
	Fri,  1 Nov 2024 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="DoamlOQk"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5DB14D70F;
	Fri,  1 Nov 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456068; cv=none; b=VAH6Me0oGF1HuGslLVVo1aA3NLeqT7teTDEZ12GzGSE2r8EdTQnAlXQs4sHXzpL26XuXgIeMSJcwv1zK5AjGLaAtqWsYKPCOlCj67XM5Lth50di5PgyrwRf14GgRA4zgKGfTXCXndMgGYMUP2OetoTG6apeIcduAMU9yh5uDKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456068; c=relaxed/simple;
	bh=62G3rR/IOqIrkP2hPOwpcGpbP/cEvQLeb2BXmg4kXE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BylloQgR9bT80SEVUIyjGzxs4XnLqvSdRWFhAGglQsz0k2kGkQ1QN/5PTfLDwu6e+c31vBCQA+GALUC4X/hmS+v7uWU/PBZbU8+AGbjI93iciNQo1IYHTknBe/wZQDIm1SaI5Fgn5MCK4wtzQDyKlJK/JKejc5aRUH7mpi7t3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=DoamlOQk; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=QZXkEKg8UMMMm6kMsBNgepDvQgd83Ldg8fmPaQgqqcw=;
	b=DoamlOQkoGTjoHdzVo7tQeH4A2jVJDBmBBFryVUJ8NQDNCBR1wCOyi9t/2KUrR
	Pi76EKmMpc8leqH6J55yIzLd7+30fHS8b9j+Y5+3cJXEOdFzv1Ijt8cezDJcGgUF
	aaz/qZGl+S91NCO2ezdxKp7i7EIZdvecONU3GSM2wTa4A=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAXFgfsqSRnPmpkAQ--.13510S3;
	Fri, 01 Nov 2024 18:14:06 +0800 (CST)
Date: Fri, 1 Nov 2024 18:14:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/1] arm64: dts: layerscape: remove en25s64 and only
 keep jedec,spi-nor compatible string
Message-ID: <ZySp7J4JTrrnT62R@dragon>
References: <20241023201129.1382895-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023201129.1382895-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgAXFgfsqSRnPmpkAQ--.13510S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4kuw48Xw4fAr4UZw1UWrg_yoWxCFcEya
	y7XrnxG3y5CrWIgryxCa1rW34xWrWYvw18Xr93GFs5t3y5Zr15Was8Kry3Jws09r4YkrZx
	Z348Jr48AFy5CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8RHq7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhuKZWckdPudrAAAsb

On Wed, Oct 23, 2024 at 04:11:28PM -0400, Frank Li wrote:
> In jedec,spi-nor.yaml:
>   SPI NOR flashes compatible with the JEDEC SFDP standard or which may be
>   identified with the READ ID opcode (0x9F) do not deserve a specific
>   compatible. They should instead only be matched against the generic
>   "jedec,spi-nor" compatible.
> 
> en25s64 already in drivers/mtd/spi-nor/eon.c. So remove it safely and fix
> below warning:
>   arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: flash@2: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['en25s64', 'jedec,spi-nor'] is too long
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


