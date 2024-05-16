Return-Path: <linux-kernel+bounces-180930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5558C7509
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0347A1C22C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2921459E3;
	Thu, 16 May 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="rFEyfyld"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDFE143C56;
	Thu, 16 May 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858049; cv=none; b=JbrFsKRoY5DWv1pjDg2UZyoNklVwoTp8LeRzbZ6dEVi9Ai2D9j6Q7UeQOtfb54ILuW8TS5eqmazjcG/bN+IyjaSZ1DAQTMME8DYlrT7YOKT+6DYnyzHg3GnVuq+CIZd/KivL0E2qlVrlZ7vTsT+VHOFSxCccfsMG/QrmhFNuUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858049; c=relaxed/simple;
	bh=pjoQPkKUuW21zca92UF9OOT5GIqcTfgNNUm9MphTK0Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jfUus8FoNc5CedoFlrpS7mbbB08TczuVWIO5y2FDieoORb4j1Pi5KoQUfguTEFR1RCixBS8lAwMmO6qt/XLtmOVL/xnxXB3PNLIHx31K2KwVjw557UQUyGEnEw1aTKsPRK8Uub3nT68Zburqgguf0IFDKcaw+IGg3stgk8mbmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=rFEyfyld; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A442C87FED;
	Thu, 16 May 2024 13:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715858046;
	bh=RTRToB4vUTm0ZyMBu/TqK7nD8AS7u9L11XcSxj+30Z4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=rFEyfyldCo0w74IknHphCZVE2NuRS3PrH+/VXlTXDvnrPqYx6Zwcp/NRanIBt8vQY
	 SHNz6SzYvaI84aOU35Ky8tUaqz0KoATol8Qe1yOBoYMhhStBP+lHyP2CQv1OrfNrJG
	 HDFfVd0EgomErL/SUoJTSHxoAyAJd+LH8y4hNTvomsjYLsWortF9QMfDphaqFO1tXg
	 kXLcA4d0tIgbcNFQ8aE1X5IdaneVOWAjh7Cvh2iarybZsdVmkpYCYtFCw2zawUrUn+
	 wxbgeCdiWOWkTTShL3BvVE6AnUQRtd5fkUDxDtfThuDkdL09jFRPgCBpOaJaKcKLgE
	 3Mdua4P3eSeJw==
Message-ID: <76b3cee8-1fe3-4192-b8c9-7a9c2b7165f0@denx.de>
Date: Thu, 16 May 2024 13:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2 and
 PDK3
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20240514010706.245874-1-marex@denx.de>
 <20240516080008.GA9338@francesco-nb>
Content-Language: en-US
In-Reply-To: <20240516080008.GA9338@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/16/24 10:00 AM, Francesco Dolcini wrote:
> Hello Marek,

Hi,

> On Tue, May 14, 2024 at 03:06:42AM +0200, Marek Vasut wrote:
>> Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2 and
>> I2C mux port 1 on PDK3 respectively are used in regular I2C mode instead
>> of HDMI DDC mode to permit connection of other I2C devices on those buses.
> 
> Are you able to read the HDMI EDID with such configuration? I have the
> patch ready for verdin imx8mp, I just did not have time to figure out
> this last details.

Yes with ddc-i2c-bus in hdmi_tx{} node, no with ddc-i2c-bus in connector 
node. Maybe that's what you're running into ? The DW HDMI core needs the 
ddc-i2c-bus property in hdmi_tx{} node if you use non-native I2C bus for 
the DDC channel.

