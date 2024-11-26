Return-Path: <linux-kernel+bounces-422775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 337E59D9E01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F90B227EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5981DE891;
	Tue, 26 Nov 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ut329A+t"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0883155321;
	Tue, 26 Nov 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649077; cv=none; b=Qf9GeD6B7HjbM1W2Jzv5O02J9COO8Pe/h6hQ2gc9SOC029Wetuvm4r8nuFVVm1GV6zP2TiRsvD3DxVANWqMor4hF/ttvYHUDfnnS3z2z2C8NEbsRmr7y77Da0aJrvzjM5C/fBNN+AKddPGzyzptZR5mCT5ThTi8A09EsO/vD0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649077; c=relaxed/simple;
	bh=xioSiBT8wjXlDRrCPnFB9OcOlvvl5ZoA3gG7NxGfWIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UakoxBtqk1ZjYVacH01wX5zcOS85fhCG9TZvxseG6P/Ry+XwK93bYFcSk9eWmZoYobaEAjBdwMdTc8XTWrXu1SOfyQsOEgJ25ZZxjrXs2rUPXsAmt5AIOqVlNbfOXmphvdyLKgweXFLp0iCdRX5ofxe6RmbUKmC0KrC4wB11t6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ut329A+t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=snKroQwtkypY8SdAmHkbYrAAMz7CQLXGWztiA4anALU=; b=ut329A+tI3avnKTDT9v25tw0Y1
	W4SBgQOyGBdvNGrWiPgUmzHTCs5JL317/ClnLgZrzZsdv3UAUzdYf2LAjTrxzC5Wxh2WB0TbwQxVA
	K/RXS44a8gmeHWiZE983yZfQtj6xkcnR6TdmHqlqI3StK5XZ9MKiE44y+O54/PYlSN2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG1AV-00EYHb-Hf; Tue, 26 Nov 2024 20:24:15 +0100
Date: Tue, 26 Nov 2024 20:24:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Message-ID: <160008e2-f480-49c3-994e-a498e74eee23@lunn.ch>
References: <20241126111817.2331577-1-jason-hsu@quantatw.com>
 <20241126111817.2331577-3-jason-hsu@quantatw.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126111817.2331577-3-jason-hsu@quantatw.com>

> +    // 88E6393X CONFIG FRU
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +	};

I just noticed this and it seems odd. MV88E6393X is a Marvell Ethernet
switch. It can have an eeprom, and if so, the mv88e6xxx driver will
export it via ethtool. It is not normally visible to Linux as an I2C
device, because it hangs off the switches I2C Bus.

Do you have some multi master going on?

I also don't see the switch itself here. I would expect it to be
listed in the MDIO node.

	Andrew

