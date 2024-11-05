Return-Path: <linux-kernel+bounces-395720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8666B9BC20E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD920B21A04
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16CF9C0;
	Tue,  5 Nov 2024 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AUDsRB1/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9FAD39;
	Tue,  5 Nov 2024 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766819; cv=none; b=erEAPx8YzsB/rF9m408TZIbq+nhlA8CtPmeWNCvF97ejuXqHarRtPSYfEYtnDH5gfNlWT6cMvPWq1We+z8v6IfZRKjkwSKRVo4YvjL3SY/OIIC/lMk9XCwJhVSMzOZgSSPpTimbi9l7eFTPvEL+j5vrNPUmDxSGUD+jUV8lj8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766819; c=relaxed/simple;
	bh=Xmwxg1h2S3GmdUxdYbcV8vAvia134i82J4iyVpWPIMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SYqd2oQaKgU+0y6sxUsK1UtzvEoLx3OgPiAzlLAEIq674n+JQ60aqZ6aDo0lM1azipaaBgHR10LuLiUhBmIXz7SefIMEVbxX1rnWU9h/Vtu6OLTmufF5ZCOdMO9TVUj8sclMUylDdRlr8snA8s+zv8jkzA1NXSNhaUYt/u9PZ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AUDsRB1/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730766815;
	bh=36wSJdCPKTJa+pneI4xqY1eNvL6gR9xuN9Id9gxbFnc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AUDsRB1/SnWNB05Bh7/nXGANt9HOyTC6CQhGs8nEgXGa1rUwo0qEPyvmc8gOAoc0h
	 iulp1MUJmq6WiYAzHE6LsjtkahYFQbdR3vb5D9OrvO8QnC3evjwpobiyBn7bXitSA5
	 8fTeFXStcGYX3vVGCtCBxq/c2dKsIYZIu1uqFN0zsVltNbKoemWYO5ulZSPLwzuubg
	 RQWZSFfCV25ewjc7FSFTJLeTwxcblA6jN019R1UdCDc4EjCIgetPkR8KG24+VM1gMz
	 11JHb8ZQLgXcrXo2SmiXZ59HBUuw01CwxNKMlHQ3qEk22A63hfzrdTMPt97sTWreMJ
	 dWajekN8ALT1g==
Received: from [192.168.68.112] (ppp118-210-162-114.adl-adc-lon-bras34.tpg.internode.on.net [118.210.162.114])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 38B436A3C9;
	Tue,  5 Nov 2024 08:33:34 +0800 (AWST)
Message-ID: <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Naresh Solanki <naresh.solanki@9elements.com>, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 sylv@sylv.io,  linux-hwmon@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Date: Tue, 05 Nov 2024 11:03:33 +1030
In-Reply-To: <20241104092220.2268805-2-naresh.solanki@9elements.com>
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
	 <20241104092220.2268805-2-naresh.solanki@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-04 at 14:52 +0530, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Add a device tree for IBM sbp1 BMC board which is based on AST2600
> SOC.
>=20
> sbp1 baseboard has:
> - support for up to four Sapphire Rapids sockets having 16 DIMMS
> each.
> =C2=A0 - 240 core/480 threads at maximum
> - 32x CPU PCIe slots
> - 2x M.2 PCH PCIe slots
> - Dual 200Gbit/s NIC
> - SPI TPM
>=20
> Added the following:
> - Indication LEDs
> - I2C mux & GPIO controller, pin assignments,
> - Thermister,
> - Voltage regulator
> - EEPROM/VPD
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>=20
> ---
> Changes in V6:
> - Verified all regulators warning resolved.

How did you verify this? Testing the patches locally, I see:

   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu2@58: 'regulators'=
 does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu2@58: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu1@58: 'regulators'=
 does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu1@58: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu3@58: 'regulators'=
 does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu3@58: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not mat=
ch any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not mat=
ch any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not mat=
ch any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not mat=
ch any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu0@58: 'regulators'=
 does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu0@58: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#

From a spot check, the warnings seem legitimate. Did you send the right
patches?

Andrew

