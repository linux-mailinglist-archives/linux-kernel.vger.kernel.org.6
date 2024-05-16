Return-Path: <linux-kernel+bounces-180955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D088C756A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF808B24EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F01145A14;
	Thu, 16 May 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="aYtdPFKO"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0C145A05;
	Thu, 16 May 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859852; cv=none; b=QXIBFMBchg1fa9nBKudLie83juaCb6EwTA365SGIg7TipsgGBtJUHjRTZz0UJ4N/NyXIPHLvEors4DyimR1s8qPse6Cv8gR1A37zNGscifKgHSsqmy3xbOwPKb2e4WvmbZreuvaHhC4H8Nl0uahenAPSI39n3lV3WjZ8z6ayfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859852; c=relaxed/simple;
	bh=DCHEshO2dOAr8AXh2VzK+u10t7pES4WOhFrmP1fzzjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjqD09i1QTVDp6gZaRH6KR5d70T5gFyBw8HQZfW5PL7GYBjWZyX7gjU5hlNUETQfp83hHidltYpI4orRX4iqvsHVG0B89JDZ6/SmEEXRXyIqh4Yt32Iq3rLGFWZ+yISXoLX9cDG9ZBJCmF6ceer2sApVN/zuMHtGHnhV4V+VqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=aYtdPFKO; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 85AC28826D;
	Thu, 16 May 2024 13:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715859849;
	bh=dsErKX1n5UIXfT2HJBwpSPSizlx6kcbp1S8mWV1k6jc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aYtdPFKObsuhuPDNHyy31uE1czOpvlT6fhn76brMy9vTHtdA+vcbMrvDGEzOjZO0P
	 Flve58qCXKl6wunoocKKstFLRVu9BVwgO1HZI686ne/bsIKtfuawXV24456/GIlRFk
	 +apXaWnUOOLhLmPPaYv4gKDUU3buu79+BAMK+OgPCdQbI5wjemd4P8HidnAoZQx0MO
	 dXNRYa5rYoaShgH+lF1Cf0AUUUz7K34A7B7MwZZEkBwbMSc9Y8xfGH2LbBv9p5TPsL
	 Ocz+rYClGK+wpVWkDqmdwphLaFUaeGDWsUWhEOeuz4/DOFwN2Cn051gvA6QmeSoqWz
	 Y4+3Z1lPVitXQ==
Message-ID: <fa01ef26-d4d4-4c62-9c12-1f8bed1cfdab@denx.de>
Date: Thu, 16 May 2024 13:44:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2 and
 PDK3
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Francesco Dolcini <francesco@dolcini.it>
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
 <b354724f-5235-4519-8361-b8209ab99d36@pengutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <b354724f-5235-4519-8361-b8209ab99d36@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/16/24 1:36 PM, Ahmad Fatoum wrote:
> Hello Marek,

Hi,

> On 16.05.24 13:14, Marek Vasut wrote:
>> On 5/16/24 10:00 AM, Francesco Dolcini wrote:
>>> Hello Marek,
>>
>> Hi,
>>
>>> On Tue, May 14, 2024 at 03:06:42AM +0200, Marek Vasut wrote:
>>>> Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2 and
>>>> I2C mux port 1 on PDK3 respectively are used in regular I2C mode instead
>>>> of HDMI DDC mode to permit connection of other I2C devices on those buses.
>>>
>>> Are you able to read the HDMI EDID with such configuration? I have the
>>> patch ready for verdin imx8mp, I just did not have time to figure out
>>> this last details.
>>
>> Yes with ddc-i2c-bus in hdmi_tx{} node, no with ddc-i2c-bus in connector node. Maybe that's what you're running into ? The DW HDMI core needs the ddc-i2c-bus property in hdmi_tx{} node if you use non-native I2C bus for the DDC channel.
> 
> What benefit does the hdmi-connector provide over just omitting it?
> Just for documentation purposes?

I was under the impression describing the hardware in DT in full was the 
best practice (TM), hence it is in full here.

