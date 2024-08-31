Return-Path: <linux-kernel+bounces-309900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538099671A3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F121F212C7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0706181310;
	Sat, 31 Aug 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="JP8WMB2p"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0AE2AF05;
	Sat, 31 Aug 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725108871; cv=none; b=r2d8JBbTQW3M73PLn3OjRGcJwgYNCOYW9n6Jb9AY3qy+pr9bCB1SNmn0g+qcnm5ArIV1KKmxEa540GmtYLXhj/z5yH8B2bQg/APfbqsoBmCEwUvEKyGb4JOtOz8i7QWzqggxFDjSW/5avfduVwdL/vhLInuQmPABX45neDK4awk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725108871; c=relaxed/simple;
	bh=2XSVFmj/9f7JSvMOYvkAM8H9FENNi4eZdpDjcsZlUS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYaYmXA3GjDmZSC+37lEYs7hh+HhbRCEaVT+aNthkAOvhbbT2VL85CNY+RHVU/6CKJ75fGkukuDzng4CEHGvIHNI5j9q0K8Evx/Cf/II4RDPsAPReIQLRhQRvumncfe8PqrVKF+t/DPOAQ035DA1YbMzJQ5AJCgcKlOspcIgNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=JP8WMB2p; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=11hKmzHQAJSyR+Fny0gB8RizXyDsH10V73RfyavEu7k=;
	b=JP8WMB2p0lRzfm61Ko6UqrRr3tBdqswahKYPqPmLKWBOSdWAenUmS7D9jem9Y5
	r18itIEMTQCrQRuKMG+0G1+/cGy+Q3Za1aBJ7Rm9wbp9wKZBGf0mp91Xt4t6/HpW
	0GTMinGlvBTivooLudmBxMG6fhkAQKdcNfqF43Gv4p9yo=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDnzwIZEtNmbRI6AA--.20347S3;
	Sat, 31 Aug 2024 20:52:43 +0800 (CST)
Date: Sat, 31 Aug 2024 20:52:41 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Peng Fan <peng.fan@nxp.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>, Fabio Estevam <festevam@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: arm: fsl: add fsl-ls2081a-rdb board
Message-ID: <ZtMSGV7vIVRlIsB/@dragon>
References: <20240812200816.3828649-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812200816.3828649-1-Frank.Li@nxp.com>
X-CM-TRANSID:M88vCgDnzwIZEtNmbRI6AA--.20347S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVTKZDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAghMZWbS-BorEgAAsI

On Mon, Aug 12, 2024 at 04:08:15PM -0400, Frank Li wrote:
> Add compatible string fsl-ls2081a-rdb for ls2081a rdb boards to fix below
> warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /:
> 	failed to match any schema with compatible: ['fsl,ls2081a-rdb', 'fsl,ls2081a']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


