Return-Path: <linux-kernel+bounces-284236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA3794FEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF602843A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7453F60B96;
	Tue, 13 Aug 2024 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="D7jHVW/f"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C0558B7;
	Tue, 13 Aug 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534079; cv=none; b=lm5RnmjFmjI2P6YXSjnLfsT/rZ1t2VFJCsHX9v0ZE/PViaw+Fk+OesAoZJChBodWFsV0G0UDE6HdaUNsC7L8UiAKj/nrKi5sFO9GEiEaPj0lmKYEegu3uEFsb64/bIUcni6Rdism3zmoEnUZDMfaIvFkhtJy633igJeLTOrBNIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534079; c=relaxed/simple;
	bh=jOyfnNttF+JbOHF1VZDwVIR/LVCxD9x1nxj4aGHIibQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbdAMxPMGYvXlxIoMejaoUJ8ceFPbvSvGszg4n2X/keXZ2oR2ZO88jwJM6iMs/W+E/IW8YsDSD5OYfGApDzbxBjqQYvFXGYDKz/yMdw9lAHlNLCJdDHGxAlyNL81fZh1/nftOXwtlMJ3cPYg32U13wPPDRwusVF+EwNjHgNZyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=D7jHVW/f; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=QwCyesgedQKYteFTZ+O3vBV5d0QLs46WyGTgF5Wdcdg=;
	b=D7jHVW/fyz4l9DKHkQRvCBYWtE0V+ZwIiQmS2FgQ7264CgaloDE47EB4TyAoza
	H/Vfg5sEM8GTEqWrA0jjTf9v1ge8g4/PAjz28Y1kmPSrNvvkl48yRj2qrzGcWAhO
	bOTqWRpKn7Hz09bEB7FEYkmK0wu4uTYZN0i6szhNUgs+s=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgC3vyDYCrtm_RFVAg--.43140S3;
	Tue, 13 Aug 2024 15:27:21 +0800 (CST)
Date: Tue, 13 Aug 2024 15:27:20 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 00/10] arm64: dts: layerscape: collect all fix warning
 patches
Message-ID: <ZrsK2G+sjWLLYTew@dragon>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
X-CM-TRANSID:Mc8vCgC3vyDYCrtm_RFVAg--.43140S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWftrW3Jr13Wr43tw45GFg_yoWxKwc_uw
	43Grn7WrsrXa95ArW3Ca1jqF9Yg3W0yryDJFyfK3Z7Jr1ftF13A3sIv34rWr4Y9anxuryD
	AF15Crs2qwn5ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU03xhJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBI6ZWa6wsf+XQAAsz

On Mon, Jul 29, 2024 at 02:59:22PM -0400, Frank Li wrote:
> Frank Li (10):
>       arm64: dts: layerscape: rename aux-bus to bus
>       arm64: dts: layerscape: rename rcpm as wakeup-control from power-control
>       arm64: dts: layerscape: use common pcs-handle property
>       arm64: dts: fsl-ls1043a: change uqe to uqe-bus and remove #address-cells
>       arm64: dts: fsl-ls1028a: add fsl,ls1028-reset for syscon
>       arm64: dts: layerscape: add msi-cell = <1> for gic its
>       arm64: dts: layerscape: remove big-endian for mmc nodes
>       arm64: dts: fsl-ls1046a: remove big-endian at memory-controller
>       arm64: dts: layerscape: remove undocumented fsl,ls-pcie-ep
>       arm64: dts: fsl,ls2085a: remove fsl,ls2085a-pcie

Applied all, thanks!


