Return-Path: <linux-kernel+bounces-233244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A81F91B4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA2D1F22606
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91F314F98;
	Fri, 28 Jun 2024 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Q2YKneEz"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD213FF9;
	Fri, 28 Jun 2024 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539367; cv=none; b=q9wRi0qV7+1QZhwTFFMT+g8kR95RU6qh5fut8op/EFHj1hDzFIl4Hyoc5G3rhVnTP70SLHaEaCDNc++pEuILxB6kjMiQ4rrRGpAJ42OAMTmB8vO7hiSpgai6IVfgCNIoO6htKj4K2I2HdmzpmRv0mEtC8SuTMKA+2jW36YXG7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539367; c=relaxed/simple;
	bh=Rs49+JIKJdY+1UvrtcnqUVMMjX1sUgaLIkYpckoXj0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TU7PTFZkWJzHSmy0Je/1dxo7T9sxX2l3pp67kQ2D1lWRMzwsDsiXkJ4FvN+fhBGpvzgRxPXclK70RFqp2ylJ89SIpqh7MfELK3f1+mqmhMvKKwzQ75vU2sxKy6AEE4R6K4iozqHNYVE+teVD8I9WUd2tE1X4qGle5PhQF+IKvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Q2YKneEz; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 05CB8880DE;
	Fri, 28 Jun 2024 03:49:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719539358;
	bh=3vHgI1S9XSt7yVWwqDPZ3+9FHiRFzokTN877wHoSbXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q2YKneEzXzxyrD+rIMVN9rgQCwBceXlhad/6c3olqRwLXjfLzoIdM6QtUT0aI8N4p
	 gepKQLoJimB4Cxt0eAlLvXR3jnZUsBvj3wHKgL85AoI+jeeyhp78Z4ZsOwZpjBL5fa
	 +T8jQE9Yjru/fPocJnyaU9MEbjlTyo/iUuypiPqrpLhB7JruZMJTb+wfXUyi6PE0rU
	 WOuIFWCpOJCUvJoF9YPLXsDL9lVhO1yb7xMt7/yLns32lHVtIP1K1k5K0cYf27mK13
	 SynCL7UsFgpiEIpQIJ7FIhU4UHh8O42Q5z0xlXos/DSAUE3N6Rf7auZm3KZ+TWhQoW
	 99Pxub0qykLbA==
Message-ID: <1d9202d8-2a01-420a-937e-216cb1cd1748@denx.de>
Date: Fri, 28 Jun 2024 01:32:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mp: Update Fast ethernet PHY MDIO
 addresses to match DH i.MX8MP DHCOM rev.200
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20240627005913.326662-1-marex@denx.de>
 <1ae34d3f-a44d-47ab-8bf1-d87366d24fc8@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <1ae34d3f-a44d-47ab-8bf1-d87366d24fc8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/27/24 9:06 PM, Andrew Lunn wrote:
> On Thu, Jun 27, 2024 at 02:58:33AM +0200, Marek Vasut wrote:
>> The production DH i.MX8MP DHCOM SoM rev.200 uses updated PHY MDIO addresses
>> for the Fast ethernet PHYs. Update the base SoM DT to cater for this change.
> 
> Where did the original values come from?

Preproduction rev.100 SoM .

> Did they never work?

They did work on rev.100 SoM .

> A pre-production device?

Yes

> Do we need to be worried about regressions?

No, it is only rev.200 or newer hardware that is shipping.

> It would be good if the commit message explained why this is safe.

Fixed in V2, thanks.

