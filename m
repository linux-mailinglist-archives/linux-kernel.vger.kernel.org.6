Return-Path: <linux-kernel+bounces-274264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E39475DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B4EB209DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3701146A6F;
	Mon,  5 Aug 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="jnsBO+ej"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3121494A2;
	Mon,  5 Aug 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842238; cv=none; b=JMf5KRnk7Av0sQ12nV7uHGdTY5Bydjk6V9R7lPpFxaI6J+ICdY23lxZL2z8YSMHlY4DFiJQCgdHj34GTrNjfAB5PT82u5wjMiH7NvT4ynBfCA+SyvNCPskzNDecVUGndNvYk4gDk4vuOoX1IqD7MIkKdH2hQMdHbabKZyQODlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842238; c=relaxed/simple;
	bh=JOMYg8DOG4tLI+5jybSvb28Ohz8S17Lfyr4ACTh6HSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ3r0xGtLMfcwZYI6+HL7VTny9evgJkqlPDHJVQethENZyB4IPlaEbyhOPQJvbH5GZynfoLSl92m3XDZQ2ljCanfjMpFbp9yp4bOYNdFutvaZ+N7J4cjRLKoFd8UErdERNQZ1fSTLWhxPVOWY444On5UOXV9QSGPH3aX1fFPfms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=jnsBO+ej; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/DT/wia1GTJIcjE3GVqGNEeHp3aRJfKhp1ZNlHAsXNs=;
	b=jnsBO+ejPa7FzyvtRqQeJWswmPCJsnE0VSg5vnZalUmcFnuYXWxNLzQa2L2oSS
	T50mCk9s/iypfqGbCzO31LY1QMyipcMjyx7IZcWN3rLVBiMkSyLT5AO/p7intcG3
	KXWkNr+R1ZL1g7fM1tgm6QjJPLUuFuUZ/zX/iJnW1gpN4=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgC3P0umebBmO_TJAQ--.28452S3;
	Mon, 05 Aug 2024 15:05:12 +0800 (CST)
Date: Mon, 5 Aug 2024 15:05:10 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add i.MX93 14x14 EVK board
Message-ID: <ZrB5picooEBIYlRJ@dragon>
References: <20240628121542.2000184-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628121542.2000184-1-peng.fan@oss.nxp.com>
X-CM-TRANSID:Mc8vCgC3P0umebBmO_TJAQ--.28452S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBB8xZWavYGtqTQABsr

On Fri, Jun 28, 2024 at 08:15:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add compatible string for i.MX93 14x14 EVK Board.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied both, thanks!


