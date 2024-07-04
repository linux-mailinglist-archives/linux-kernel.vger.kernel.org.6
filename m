Return-Path: <linux-kernel+bounces-241007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E09275B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D251C225F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF121AE0AD;
	Thu,  4 Jul 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gRBPlNW0"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846FF1AB503;
	Thu,  4 Jul 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094664; cv=none; b=SX9d5qvCAoQiFYADtvy+wD03UJL/r1Q8GYS5y9qyG/6E1v6UX9IQiZPUFePVuSoBX+01d4Nl8/yNIByvnfqrQogH+w9JCbxhxf+AQeTzUHEZWnwOIFgm9owiY8suLGKL+dLGLYMrxwQFUWPOpIYkagBQKyo6BjDMhu2k3u1PDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094664; c=relaxed/simple;
	bh=IHvig0xNBoArwokNbI6ToWo2CGjEfPQHtuYXlRQ32Bs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FcFz11d+/u5wzzWZ4N2BPlUmAUaIfANeQxt0/rBO2qSNs4uB29td4BsqjNIWelTyXJ4KkDowWAJeOWOCOOBdwIjRs+zcLAq2j5cf2YerxoG/oT0fpN7YcHd0bERngJA1+cj4mCXb6aJCB2f5QuPGDMgRVgnq/dXeZGJ5xdx8d44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gRBPlNW0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720094658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJUq1gL2n6O72FkagfIzF/3l8GxaCoyh+6xXf/fqDcI=;
	b=gRBPlNW08B8tS5OnAMQ9KbKBi1bRqPjxjtrqXgm1ASF6PQDH92VNJkkDhsO00ovfrcdcJI
	0u0t6QUKlKkw/tGLgfI274Ea6vx84+jMCmO7lLxunIOMFqubhCINssRMbG20qRcxUocKSB
	lM0807HOaxgbUafC3UDKSOwxQs5D53ypO5h+iyc/DneuMEkFGSLmAvfP4Jmp8EHsd5SwII
	lVFodHrBKgetcu/1SM0PdWI5FYYDE43K/BR9aBvFceU2htemLGaKirtvHohMpaSbUD2as0
	UxYGWCY10fd0DpH2pdrUsdozBzqtInvALsyReoRSkYXCaI20jYTezqGlSfeeug==
Date: Thu, 04 Jul 2024 14:04:18 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add rock5 itx board
In-Reply-To: <faeb87de-b97e-4f95-bbb0-edd03a411f4c@gmail.com>
References: <20240703210524.776455-1-heiko@sntech.de>
 <20240703210524.776455-3-heiko@sntech.de>
 <faeb87de-b97e-4f95-bbb0-edd03a411f4c@gmail.com>
Message-ID: <06e69b64b25fbbff338aac9e84c68ce9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alex and Heiko,

On 2024-07-04 12:52, Alex Bee wrote:
> Am 03.07.24 um 23:05 schrieb Heiko Stuebner:
>> The Rock 5 ITX as the name suggests is made in the ITX form factor and
>> actually build in a form to be used in a regular case even providing
>> connectors for regular front-panel io.
>> 
>> It can be powered either bei 12V, ATX power-supply or PoE.
>> 
>> Notable peripherals are the 4 SATA ports, M.2 M-Key slot, M.2 E-key 
>> slot,
>> 2*2.5Gb pcie-connected ethernet nics.
>> 
>> As of yet unsupported display options consist of 2*hdmi, DP via 
>> type-c,
>> eDP + 2*DSI via pcb connectors.
>> 
>> USB ports are 4*USB3 + 2*USB2 on the back panel and 2-port front-panel
>> connector.
>> 
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>   arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>>   .../boot/dts/rockchip/rk3588-rock-5itx.dts    | 1188 
>> +++++++++++++++++
>>   2 files changed, 1189 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts

[snip]

>> +&usb_host1_xhci {
>> +	dr_mode = "host";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	status = "okay";
>> +
>> +	/* 2.0 hub on port 1 */
>> +	hub_2_0: hub@1 {
>> +		compatible = "usb5e3,610";
>> +		reg = <1>;
>> +		peer-hub = <&hub_3_0>;
>> +		vdd-supply = <&vcc5v0_usb12>;
> 
> Are you sure about this one? I couldn't find any schematics for this 
> board,
> but both the bindings for usb5e3,610 and the datasheet[0] are saying 
> this
> is the supply for the hub's internal logic which is typically ~3.3V. 
> It's
> definitely not a supply for the vbus.
> 
> [0] http://www.sunnyqi.com/upLoad/product/month_1308/GL852G.pdf

FYI, here's the board schematic:

- https://dl.radxa.com/rock5/5itx/radxa_rock_5_itx_X1100_schematic.pdf
- 
https://dl.radxa.com/rock5/5itx/v1110/radxa_rock_5itx_v1110_schematic.pdf

Perhaps it would be good to include these URLs in the v3 patch 
description.

