Return-Path: <linux-kernel+bounces-236370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1896A91E141
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C69285788
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0D015ECFF;
	Mon,  1 Jul 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="h8H927CS"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544315ECFA;
	Mon,  1 Jul 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841885; cv=none; b=Y+8pUdD/dgmLlqdzfJA0nnSeXlifBSCblJHXqHlMsZ7HBiOmWda2ni4IoimmnBTr/wMNVncBBV4cEhpPzf9gmEwuovQnBWfjBdXicG970NJznmhZDzYTpbCOu1YFYTC9VrIlCGJGuQBPpA+j5y8d8tyXi7rHa55smZguSx95Kqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841885; c=relaxed/simple;
	bh=XevS6dafRcblIePf7yCmfBcE6d8CNAo8N6tWO6UP+OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH8PeJ5VbHyBj0W7QRxqcH7KS7fSqUheIF3xWXGg0hJ/K/9HrObcSfJsnXm2o5/aYFNEuAXcaTw++9GXd6PT4kB7fwCxTOZ6Bjw1GpssbNNUE/iIFo9eknoZ8SZbJI4Q+dvlrmKf8/v16MOQ+aBAQamR45her/sfUP0+jYfIcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=h8H927CS; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=OoMfDQ+2vpm2pUt9NA6K+haGB4CecvBmtCCyIx8I+wQ=;
	b=h8H927CSl/yRCOQwrJRa+KobppNogTk+OX6sbvulR8sPkNeM6L96LRIelpA4sz
	mIN0NTDxQ7zg1gA2ELnIK1r7iuQBAcZiSM+xM4XAJ7hwMBj8lCi1Kxs2Kc0N1Uim
	51jvlt+smXNPoGVOqG0+EZCoxlUJcNRf1T0M+wVwltBQI=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBHDpAotIJmm2I6AA--.6518S3;
	Mon, 01 Jul 2024 21:50:34 +0800 (CST)
Date: Mon, 1 Jul 2024 21:50:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8mp: Add audio XCVR device node
Message-ID: <ZoK0KOGYbF89XmCm@dragon>
References: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
 <1719481981-4069-3-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719481981-4069-3-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:Ms8vCgBHDpAotIJmm2I6AA--.6518S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIzB-DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCw4PZWZv-dp2SwABs9

On Thu, Jun 27, 2024 at 05:53:00PM +0800, Shengjiu Wang wrote:
> XCVR (Audio Transceiver) is a on-chip functional module found
> on i.MX8MP. It supports HDMI2.1 eARC, HDMI1.4 ARC and SPDIF.
> 
> The reset controller is provided by the audio block control driver.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks!


