Return-Path: <linux-kernel+bounces-317666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D2296E1CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652B92890EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8E17BEB7;
	Thu,  5 Sep 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rw1yGOFT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1B14F125;
	Thu,  5 Sep 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560430; cv=none; b=pZLYu4q0qrYHF8iIpeULASD/K00NUXxMxb1Ra+qWfV4p2o/jjBlIxjg7z+oxj/9D7Ib1Y3j0iA+ra/5JpvWrV5HS+z2lt/pqWoA4/y/+CpUQjbpOrlFTBCtL2nAJ5EP6sbwez//Kdt7PUSSXdApRKHdMcSoBRqH6bW7KUrFO7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560430; c=relaxed/simple;
	bh=eYDL/kpipnRxEEdIRfMrtMtgh+v5Hdg5X2Ofbi4YqDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD4OmqrP5Ktss4Vj7r6frfMWmGMlx68Xz8qgQFTQ8cGhT+9BmAJ6dozMChTrqHH7uQZDj3a3moZgtBc0UqwKBsQWHhLRmtVfQr0MLg8XxwELGgbyK6I20WXNM8nfQ/PurcFhMRBia51zQrN1P62AyrYPU6eq9QTcpUlBoAKDrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rw1yGOFT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WYk12iEsbdnlW331g4DNApKiQCHyaZpFj0H6XOnYFho=; b=Rw1yGOFTRlHggJlQrMRp8CtgMF
	kDHVEeMezbUMAT11yNSIyaVD1FdupgVQ31ZQxBJQ+uX1Br5NtwbsTrfgNvHpgaLSU0MZ7d/7t8+Sq
	fRxQeJVdJf4mzFs7qIGI8viq0bQpnJNPJxaGLdwyK3zuKiw4lWNUIGca9HN4jCylIN0E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smH5T-006i0Z-B1; Thu, 05 Sep 2024 20:20:07 +0200
Date: Thu, 5 Sep 2024 20:20:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
Message-ID: <668ac08e-5bba-43cc-82ec-12af1848d528@lunn.ch>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
 <20240904111456.87089-4-bigfoot@classfun.cn>
 <6030542f-070d-4d76-9a5a-fbfc6bd433e6@lunn.ch>
 <1e189c70-e677-453d-9e31-6637196c2b5c@classfun.cn>
 <3f5bcc6c-5ee0-4fef-bb58-f7acf9551fc1@lunn.ch>
 <fd4fc7a0-7def-4f91-a64c-71689ff71d1c@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd4fc7a0-7def-4f91-a64c-71689ff71d1c@classfun.cn>

> arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts also
> uses YT8521. I added rx-internal-delay-ps and tx-internal-delay-ps
> to rgmii_phy1 of mdio1 according to the prompts, and it now works
> well using rgmii-id!
> 
> &mdio1 {
> 	rgmii_phy1: ethernet-phy@0 {
> 		compatible = "ethernet-phy-ieee802.3-c22";
> 		reg = <0x0>;
> 		rx-internal-delay-ps = <1500>;
> 		tx-internal-delay-ps = <1500>;
> 	};
> };
> 
> &gmac1 {
> 	[...]
> 	phy-mode = "rgmii-id";
> 	[...]
> 	tx_delay = <0x0>;
> 	rx_delay = <0x0>;
> 	status = "okay";
> 	/* Motorcomm YT8521SC WAN port */
> };

That looks O.K.

The YT8521SC seems to have issues with delays.
jh7100-starfive-visionfive-v1.dts says

/*
 * The board uses a Motorcomm YT8521 PHY supporting RGMII-ID, but requires
 * manual adjustment of the RX internal delay to work properly.  The default
 * RX delay provided by the driver (1.95ns) is too high, but applying a 50%
 * reduction seems to mitigate the issue.
 *
 * It is worth noting the adjustment is not necessary on BeagleV Starlight SBC,
 * which uses a Microchip PHY.  Hence, most likely the Motorcomm PHY is the one
 * responsible for the misbehaviour, not the GMAC.
 */

	Andrew

