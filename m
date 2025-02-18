Return-Path: <linux-kernel+bounces-519990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C0FA3A470
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D365B16C099
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BA426FDB0;
	Tue, 18 Feb 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="MG2Ietzs"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6165246348;
	Tue, 18 Feb 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900244; cv=pass; b=riEb4UxEwIIqqxxUvgBqfYZaHZhkI+wCyx8c/rStokyFoMbHGzaXPt01+MjpBjREfmOLm8mN1LPQFxZZkh95EeuEz+GHtUQJC7hyxeav+/lcvtiCmeP/HW+ejwGNBvDiPBdgDBgNCShe6wmBVdY5/x4HEkDk9atbaowKhdjjVJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900244; c=relaxed/simple;
	bh=UixU1Y8H/6oLRHZaemHuH3J3DlfIiJ+CWy16hrFxz+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xq7d7PFqg7oGKWHsbLYwX2+QdUSIWVcga2B43bMAWFJJUPsaaVRA2Pj9zjrl+izy1UaGbCkzPupNuARe9C7cVN52fPTiDFO7wBsFGcGofneV7QJlZmIUTpJosl9zSEMfGtU56VsfXunevHoynz58N+OoTwdqSGs4aAWHwH+3WC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=MG2Ietzs; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1739900221; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=grr+0lS3/3BYH360gRwkzLM+3E466IAaltXYKBbg79sVz19or3+IQpyGZDcAklYrm+slRNSSCYXNJ99pmPLE9ObA1Jc6dWW+sJQjp2yidnreWBuFFaELBfRPNos4zb9+cDDm3QxSRI3FwqQBxo1E+gTAOV+y7d9wQcTRMXMiK0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739900221; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ltKaZrI9teXpHN3rxYKOD+ITb8+l8u8RqERzWuBNvdA=; 
	b=V3gCXeeN44w4wXMEB0QD46IIGQR+mXNwYx2navETCqdQoO+kYcisMlC0ofEk60S3oZDR1CyciSCEukHn/fzabVUcWsAgP8KO/pQs9Liy3hC+hXO4kXq8flp5jYaS7x8RI6xJizBsW2WpmmXO0IvRzk6E4nMVEoF7Occl5I+5dO4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739900221;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ltKaZrI9teXpHN3rxYKOD+ITb8+l8u8RqERzWuBNvdA=;
	b=MG2IetzsDhA8+Sfnq0OUEnWCZy+ea618WnHYx4ejx49qE25J+rYyojOqnsM5hT/Y
	LD0rGafHN23Hp+vSdMV7OPcOfCqfzvlYCwu9hr6u2Q6ciu4kjTyMRloMIzjSvHgcjEq
	oQE1xMJrvwXhtunOZi1NnO5M/diXh67EhWru+nuY=
Received: by mx.zohomail.com with SMTPS id 1739900216177414.7839071442543;
	Tue, 18 Feb 2025 09:36:56 -0800 (PST)
Message-ID: <56310dfb-62c8-4508-a36f-22f383053024@zohomail.com>
Date: Wed, 19 Feb 2025 01:36:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] riscv: dts: canaan: Add clock initial support for
 K230
To: Conor Dooley <conor@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
 <20250217-b4-k230-clk-v4-3-5a95a3458691@zohomail.com>
 <20250218-status-friend-51fb039ab97e@spud>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <20250218-status-friend-51fb039ab97e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227cd7930601ff6ebc2a10e2da600003679650531eac0101031d31a21ff948c946d9e95b9b798b92f:zu08011227e9cf27d652ab798f48ced574000072302a8a14e3f70cb8059410b94c92a96d722e96a5a4a72a3a:rf0801122b73a3e2e54c7314499e8c1a04000091975e61466cda03089d952cd1635febf3eea1ae3ebb2c624ecb168621:ZohoMail
X-ZohoMailClient: External

On 2025/2/19 01:00, Conor Dooley wrote:
> On Mon, Feb 17, 2025 at 10:45:18PM +0800, Xukai Wang wrote:
>> +		sysclk: clock-controller@91102000 {
>> +			compatible = "canaan,k230-clk";
>> +			reg = <0x0 0x91102000 0x0 0x1000>,
>> +			      <0x0 0x91100000 0x0 0x1000>;
>> +			clocks = <&osc24m>;
>> +			clock-output-names = "CPU0_ACLK", "CPU0_PLIC", "CPU0_NOC_DDRCP4",
>> +					     "CPU0_PCLK", "PMU_PCLK", "HS_HCLK_HIGH_SRC",
>> +					     "HS_HCLK_HIGH_GATE", "HS_HCLK_SRC",
>> +					     "HS_SD0_HS_AHB_GAT", "HS_SD1_HS_AHB_GAT",
>> +					     "HS_SSI1_HS_AHB_GA", "HS_SSI2_HS_AHB_GA",
>> +					     "HS_USB0_HS_AHB_GA", "HS_USB1_HS_AHB_GA",
>> +					     "HS_SSI0_AXI", "HS_SSI1", "HS_SSI2",
>> +					     "HS_QSPI_AXI_SRC", "HS_SSI1_ACLK_GATE",
>> +					     "HS_SSI2_ACLK_GATE", "HS_SD_CARD_SRC",
>> +					     "HS_SD0_CARD_TX", "HS_SD1_CARD_TX",
>> +					     "HS_SD_AXI_SRC", "HS_SD0_AXI_GATE",
>> +					     "HS_SD1_AXI_GATE", "HS_SD0_BASE_GATE",
>> +					     "HS_SD1_BASE_GATE", "HS_OSPI_SRC",
>> +					     "HS_USB_REF_51M", "HS_SD_TIMER_SRC",
>> +					     "HS_SD0_TIMER_GATE", "HS_SD1_TIMER_GATE",
>> +					     "HS_USB0_REFERENCE", "HS_USB1_REFERENCE";
>> +			#clock-cells = <1>;
>> +		};
> Apologies for not commenting on it until now, but this patch seems like
> there's some hunks missing from it. I'd expect you to remove the dummy
> "apb-clk-clock" from the dts and replace it with a real one sourced from
> the newly added clock controller.

Thanks for your time.

I've modified all nodes that previously depended on apb_clk， and they
are now referencing the new clock controller.


