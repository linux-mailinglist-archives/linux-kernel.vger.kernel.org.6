Return-Path: <linux-kernel+bounces-180949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC078C7552
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A081B2103F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DB4145A08;
	Thu, 16 May 2024 11:36:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69413145A02
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859383; cv=none; b=n1NpQo/FjFA+FxB1KeXrAYf2QYSns6hOSx+GTV9GEkHUaiUs+bZaOlL10J381WkVCKZonJhCY/NEyE1tbczCnts4PINDanW2zgQMU74O8lHg3YUrSCz15kcKkubXUZgK8Hv4PbBCgfbki2AzGPjIJ+1jSCIjW2oDLWRwdZWCxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859383; c=relaxed/simple;
	bh=xnCHpjWJCxd1ThpugjVih1IsrG1enpQdqddYfJNlRLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ns9gGtea/zFQdoxSW2rfBsUveoTcpDsyUwG/XlUezGGPqNSFQzNP/KMya+V6pso8hoP7SOKyuerM3yy+GFMfNP6hleRlY7PlzEEcnWvI4SciysjMRFu3sUxebZoLRhUyjnXtKIuTQ/vodTCc8iX57qzdc4G1VdIX+wHLfvaeZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1s7ZOz-0007RY-PT; Thu, 16 May 2024 13:36:01 +0200
Message-ID: <b354724f-5235-4519-8361-b8209ab99d36@pengutronix.de>
Date: Thu, 16 May 2024 13:36:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2 and
 PDK3
To: Marek Vasut <marex@denx.de>, Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, kernel@dh-electronics.com,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Fabio Estevam
 <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
References: <20240514010706.245874-1-marex@denx.de>
 <20240516080008.GA9338@francesco-nb>
 <76b3cee8-1fe3-4192-b8c9-7a9c2b7165f0@denx.de>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <76b3cee8-1fe3-4192-b8c9-7a9c2b7165f0@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Marek,

On 16.05.24 13:14, Marek Vasut wrote:
> On 5/16/24 10:00 AM, Francesco Dolcini wrote:
>> Hello Marek,
> 
> Hi,
> 
>> On Tue, May 14, 2024 at 03:06:42AM +0200, Marek Vasut wrote:
>>> Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2 and
>>> I2C mux port 1 on PDK3 respectively are used in regular I2C mode instead
>>> of HDMI DDC mode to permit connection of other I2C devices on those buses.
>>
>> Are you able to read the HDMI EDID with such configuration? I have the
>> patch ready for verdin imx8mp, I just did not have time to figure out
>> this last details.
> 
> Yes with ddc-i2c-bus in hdmi_tx{} node, no with ddc-i2c-bus in connector node. Maybe that's what you're running into ? The DW HDMI core needs the ddc-i2c-bus property in hdmi_tx{} node if you use non-native I2C bus for the DDC channel.

What benefit does the hdmi-connector provide over just omitting it?
Just for documentation purposes?

Thanks,
Ahmad



> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


