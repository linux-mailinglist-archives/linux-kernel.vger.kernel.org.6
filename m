Return-Path: <linux-kernel+bounces-180962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B335F8C7580
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8261C20F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184C145A1B;
	Thu, 16 May 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="FBeHeafd"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00426AD0;
	Thu, 16 May 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715860673; cv=none; b=YuG8ypid//2rilgiegIJnaIrVCR+ydx0feaV60mGIQadUoY6n0dCQpsuKBIpHdxmEL+GItKifVXA2X1p23dEKYEK1xXptv3xxy+v/WM3We7KJKuGOQnzdmnWxa3VN6h4r5I2c98QPP7OWNBU8/aKqNOlZxHzVjX1lmJG12g2p5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715860673; c=relaxed/simple;
	bh=zb3thMvUhgoGD+gDyV0KsfAFSV/xaogkAu6yb5KZ9No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfsi3XAVSvEceUaxFGsjw21YTYZ9jYZOKAQEw249IDz5Z90rR4FGQCX/YzZd+dS/eG66Hw3YM9lJyv2OoSX2TUCPPKjgoRDMUt8qJAG5fI6UVzVSlRrZXs/rrD63vh8kTDcfgnT5Sg4kF/GBTaTyuvEV8h7TiE6gedyBEiqhAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=FBeHeafd; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 221DA1F938;
	Thu, 16 May 2024 13:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1715860668;
	bh=qMf3X2Q4oRj/C7hAFJyFwgIdc7153KsOrkW8sYZ0UHQ=; h=From:To:Subject;
	b=FBeHeafdXEDBYor8B4j+QLg8SJaTMZrCHWYDfvM801Ild6jZBnK+f4YgEfzdV3vu1
	 x1af9xBDvgbLpeHwSsz2ClhZrWHzxgrGatUaJtaAClPi99qVT+2BZV+uFK699a11Pp
	 1cqI/SVUWLB5HIXKiebTyxUXIKLBdy/+76GXxNv1IUrk7BVv3IeSbwk521iDUw2Ima
	 ALnCOd13SMvhewS7IXNONU66iyzGKFOvMI0JIugmyJR4oHxCHmvmQ1QgbYlVdkWqUW
	 KNdqzSjwNNaVBXUKRpiwvvxXmRSeIIVX9us9lfv/2yi6FjSn/s03px5vFu3jKZ+aMp
	 6ubj+BU1UNmcw==
Date: Thu, 16 May 2024 13:57:43 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2
 and PDK3
Message-ID: <20240516115743.GA6663@francesco-nb>
References: <20240514010706.245874-1-marex@denx.de>
 <20240516080008.GA9338@francesco-nb>
 <76b3cee8-1fe3-4192-b8c9-7a9c2b7165f0@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b3cee8-1fe3-4192-b8c9-7a9c2b7165f0@denx.de>

Hello,

On Thu, May 16, 2024 at 01:14:04PM +0200, Marek Vasut wrote:
> On 5/16/24 10:00 AM, Francesco Dolcini wrote:
> > On Tue, May 14, 2024 at 03:06:42AM +0200, Marek Vasut wrote:
> > > Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2 and
> > > I2C mux port 1 on PDK3 respectively are used in regular I2C mode instead
> > > of HDMI DDC mode to permit connection of other I2C devices on those buses.
> > 
> > Are you able to read the HDMI EDID with such configuration? I have the
> > patch ready for verdin imx8mp, I just did not have time to figure out
> > this last details.
> 
> Yes with ddc-i2c-bus in hdmi_tx{} node, no with ddc-i2c-bus in connector
> node. Maybe that's what you're running into ? The DW HDMI core needs the
> ddc-i2c-bus property in hdmi_tx{} node if you use non-native I2C bus for the
> DDC channel.

Yes, that's it. Thanks!

Francesco


