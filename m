Return-Path: <linux-kernel+bounces-555404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF75A5B6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4BC3AC816
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B761E520B;
	Tue, 11 Mar 2025 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="CAvKBMGZ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793E01DE4F0;
	Tue, 11 Mar 2025 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741661463; cv=none; b=GynFSt2crCZD+D5hfxTZKaJ9HAHjCuCNLCO5fgaALknWPLg/B5dza+keGqyjdZM8UUQIHYMQu1+hTk9HOlTJPI8veV+//kUFhSJUTrCNh7Zh0J9lLmBWb8NH8lZXtLo4P6AV5StkQEmIhAK2ikKuyuDWH6AGX1EjsfwNiWqviLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741661463; c=relaxed/simple;
	bh=1fbW+QU0NIiVwq5BQT5D3WXMNirWuD/+Eje0aoYYGe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i15cx8O5NFfUNQyN2KQ1vizEHDVabLDzRAex4CmDKK8qFzRtmeEVloK+7Zo16pjVvQ1H3aD1FPAn9qeIAwVpsI8JhIejkEiXUINL6p6HNyUnJl7ys5ztu9ep8LbMD30tO7Fz6UAVPej8fKH28pJ2QcDpAcxGoXgumEEoxARLBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=CAvKBMGZ; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=yD8oPqx1bJfk/6wLNnCY911Tq4LRHUDIWKPgfRYfY9Y=;
	b=CAvKBMGZE/ItnDvOCYd+rSxGncNxtQSNRWGL6AZRPdjVBtA5OxP1HUlVfl49Wa
	LX7skFDHB4KyrfUj7e5ppoguMy1H2/GIoAY7fbq3uDHK1F6rqarapdz89D5f0tlL
	Q2k0bFbAP7/zF1ECaANX98+b9mQokLMQcjlbwjQk5alUA=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAnZD_2pM9nHKK0AA--.48569S3;
	Tue, 11 Mar 2025 10:50:32 +0800 (CST)
Date: Tue, 11 Mar 2025 10:50:30 +0800
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
Subject: Re: [PATCH v2 1/1] arm64: dts: imx95: add ref clock for pcie nodes
Message-ID: <Z8+k9s/vrLE7N4km@dragon>
References: <20250225170802.2671972-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225170802.2671972-1-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgAnZD_2pM9nHKK0AA--.48569S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVvedUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAh4NZWfPWknv1gAAs2

On Tue, Feb 25, 2025 at 12:08:02PM -0500, Frank Li wrote:
> Add "ref" clock for i.MX95's pcie and fix below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie@4c300000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


