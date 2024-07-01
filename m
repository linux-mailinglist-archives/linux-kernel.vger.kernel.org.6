Return-Path: <linux-kernel+bounces-235923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFC91DB50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111CD280A48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A0383CC1;
	Mon,  1 Jul 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fLyOZH92"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890925622;
	Mon,  1 Jul 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825750; cv=none; b=GDLTg5ApSav9kanCfiYQFuIOYK+1Ak8FSnnf568ZSuMJbG7cyxgBq66lWOUFmeRGb1LhK0cRpkO655H0yaMD6TEgANEkJLed6JMB0AY09bOgyHLKtVjpaMvDSCZlzSHlvyZmi2ysp7nVGWuD0VvPGiq4pzleJr788ww5bnV6tk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825750; c=relaxed/simple;
	bh=lbwB+ukJeyHmMbu3g8UaKP2/Vzw0zCI7Wiov4ynS9vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZOztZ1zH/kcE/xBUHFAbhBKhszube/Wj5uFFh/Zkupf7lUhvUr+rRE2QVKao4b3rW89Pm+zYFP2pwi4Fe4G0BTmiafPFO3yGe8OuEVJA/2Q60rNhN3Hl87O8YQgCcCbcfx9ynZ7zafyNKBBpO5fpAGBHCsfTXWW6byzta2kZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fLyOZH92; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Yfcbm0dg4oK82L+0Zuz0mmml1R+3CJh/Clbm7MneKgM=;
	b=fLyOZH92itCBo0QPCaWqrCjQKavm9s1p3dEXP912anMX4Hb7qmJFjYZdDJlfAj
	WDs09iXBKqTM5PHfoazqZ99cQc9P2wHTlDMrXnVoLINY7Av3xqjI672LTxaV9CnP
	Wes/YXUGbbIM/IU6uT7KGpbHCfD5VLmGJABUWDbyDAM54=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3n5cMdYJmxGQ3AA--.827S3;
	Mon, 01 Jul 2024 17:21:18 +0800 (CST)
Date: Mon, 1 Jul 2024 17:21:15 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mp: Update Fast ethernet PHY MDIO
 addresses to match DH i.MX8MP DHCOM rev.200
Message-ID: <ZoJ1C6il1aoHIBXo@dragon>
References: <20240627233045.80551-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627233045.80551-1-marex@denx.de>
X-CM-TRANSID:Mc8vCgD3n5cMdYJmxGQ3AA--.827S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIxpnUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCw4PZWZv-dp2SwAAs8

On Fri, Jun 28, 2024 at 01:30:09AM +0200, Marek Vasut wrote:
> The production DH i.MX8MP DHCOM SoM rev.200 uses updated PHY MDIO addresses
> for the Fast ethernet PHYs. Update the base SoM DT to cater for this change.
> Prototype rev.100 SoM was never publicly available and was manufactured in
> limited series, anything currently available is rev.200 or newer, so it is
> safe to update the DT this way.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks!


