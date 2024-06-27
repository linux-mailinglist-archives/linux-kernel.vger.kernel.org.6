Return-Path: <linux-kernel+bounces-231913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADEB91A044
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 972E4B22780
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D94D8A7;
	Thu, 27 Jun 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db7rACDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C351BF3A;
	Thu, 27 Jun 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472726; cv=none; b=q9sQR0DGA8jq4ncMaC3YWntH4+wnEavNobd9rmNZPsxcAwFdhPd/QBoyIkff8FGOcKm5gWU6bTZGxlUFmXcgJ+cCR98lcFrxwyzdKujPKYPBr9UhN/OLe04JkaJZlueZgMKWvvQl7BRAm4xwJOTwmZya/22hZXvu0NSWPE83vKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472726; c=relaxed/simple;
	bh=N77V0dE/apH22+7RK8IW/xhIj81SUdpfM54CWaNtWbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBJkQhzMjM95ToIBpsY9fV3oO/xfaJQHUgHEpOrtk2Hp0dTymAgGWxOqNlT5qCw5MHSZI/tHxtxCZPD7OoLRCKwHJ0oeZtKxfxMnqxbPxtzCwFOr7hDO+pflPW6f+OGDXqUiHF3WRrKq7wgytrKUHoGiPY4KhFlTvpzZn1yVNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db7rACDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D4EC2BBFC;
	Thu, 27 Jun 2024 07:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719472726;
	bh=N77V0dE/apH22+7RK8IW/xhIj81SUdpfM54CWaNtWbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=db7rACDG7c+uVpFm8X+Q2C8rjsq2oVLPGxfrfmVEKxyIdamcn7Lr6N1e/jXeEZuiB
	 u+0EoEZ7zbMfbBW/BVN6OZ37nN+cJ7F9cpmyCypsoceLUsikDh0k1+X913R5sYjfsY
	 hPWy/wpdVQ+Q34Gwpkx4xUUsBN36c/6PTXzXaZpGgY+YXQBxlzVGDdVUpUqWtzohxH
	 5v+u0BLxjL2W7/8Fgejx9uFlKhe08XJPY9V5FnfBSjvsD+SFdmyE+l/YSQwdKjN2sd
	 S6fGjmM9IkKea0DgNqJ7vFsW+HE50oqDudWh9cbyq1p+DLFmnuy1ceO9vZJMzXBf4k
	 0zQydjO+6flAQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sMjPH-000000000Zg-1AXV;
	Thu, 27 Jun 2024 09:18:59 +0200
Date: Thu, 27 Jun 2024 09:18:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Vanillan Wang <vanillanwang@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Rolling RW350-GL variants
Message-ID: <Zn0SY4nQzESrQ4xw@hovoldconsulting.com>
References: <20240531024012.29805-1-vanillanwang@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531024012.29805-1-vanillanwang@163.com>

On Fri, May 31, 2024 at 10:40:12AM +0800, Vanillan Wang wrote:
> Update the USB serial option driver support for the Rolling
> RW350-GL
> - VID:PID 33f8:0802, RW350-GL are laptop M.2 cards (with
> MBIM interfaces for /Linux/Chrome OS)
> 
> Here are the outputs of usb-devices:
> 
> usbmode=63: mbim, pipe
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
> D:  Ver= 3.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> P:  Vendor=33f8 ProdID=0802 Rev=00.01
> S:  Manufacturer=Rolling Wireless S.a.r.l.
> S:  Product=USB DATA CARD
> C:  #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> 
> usbmode=64: mbim, others at (If#= 5 adb)

Can you be more specific about the other interface?

> T:  Bus=02 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  5 Spd=5000 MxCh= 0
> D:  Ver= 3.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> P:  Vendor=33f8 ProdID=0802 Rev=00.01
> S:  Manufacturer=Rolling Wireless S.a.r.l.
> S:  Product=USB DATA CARD
> C:  #Ifs=10 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=07(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=88(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=08(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=09(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=8a(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Johan

