Return-Path: <linux-kernel+bounces-273902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A1946F63
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4832816C9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AC457CA6;
	Sun,  4 Aug 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="T7pWDpvI"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C3A934;
	Sun,  4 Aug 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722783210; cv=none; b=GQy13OFU0nizqWy9QHQqvmglnr2NIIGX3ytyxW1hOaA5+yhxcsGFdJpuwTK8pMzfDP15+9DgQPd0JiZb8MJBLJGrp3LzUigx4HftK6tVi+88nps+tonQHfhWDzzjy0AE3o1sXxY+oylDLQPevmrEk/0i87Nfujpryg6hUCa3p8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722783210; c=relaxed/simple;
	bh=y5K9mTP8UV8PmFAeBNTKn233/lmqrtPpN3ICIpYlWT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym+kXZOk0CeHVTThhkrzbU1pp3KIw1gO1ox3p682NYF+vmFs5QLwjXPHrlnYF0RuVLO3ttrH+kQsnyT9YsXQDybA7stz/r3Q69doCEq1PejOPzwrUhhrJo9XW7zEoAuSTOuszLDiS72bxXCthIU1djkpn9N76AS0xXcSExTRePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=T7pWDpvI; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=fnQ4h9iQX+Dg94vJyXQLUX6l7PO9keScEuNzhdy3Gq4=;
	b=T7pWDpvI/b2HDfNeSRy1pmkYcz2Wrs5g1BkYHP2+US01LelYPXEKOZaiM84KE7
	HjM2/HjnfUrj/4XvjUcQFOFJNGO8zi8a9srzKeWZDXIJPBvcTTdmp+xNY2zD+HML
	i8tRA0Bg/BuS1650IrFUiLTKkL5NuoO9XFprLObex3zP4=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3Pwe1la9m0fGDAQ--.41982S3;
	Sun, 04 Aug 2024 22:52:39 +0800 (CST)
Date: Sun, 4 Aug 2024 22:52:37 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] arm64: dts: imx95: add p2a reply channel
Message-ID: <Zq+VtTD1cbZE07Sb@dragon>
References: <20240628020921.1108888-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628020921.1108888-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:M88vCgD3Pwe1la9m0fGDAQ--.41982S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCR0xZWavYHlo-wAAsH

On Fri, Jun 28, 2024 at 10:09:21AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> For Platform to Agent(p2a) notification, i.MX95 System Manager(SM)
> firmware requires a reply communication. So add mailbox channel for
> p2a reply communication.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


