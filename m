Return-Path: <linux-kernel+bounces-577513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBBA71E20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37BB3AE625
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC1C24EF9D;
	Wed, 26 Mar 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="XWdheIXY"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC256FB0;
	Wed, 26 Mar 2025 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012858; cv=none; b=qs9S4ReCH7iU9Xho6Q2vz0ptEaWKxyymLdgId2OydGLZ1LDTYRTn3iolaA6v5WjhhvX5n585Fyae2v/gvbVfymdJwrOrwme6ROj2mGAsjkPvHcOG1k5sQiU05GqexZ9OgsdRK8467dgOGMoNv9/4gEH+OxrqROWXO5xvGlwUiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012858; c=relaxed/simple;
	bh=5Rx8o+rsjCY9GlFunVyrcmqBelS0z89PcsLnWD/BdKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIwCgWaKRPME6eVuiilqGLCDsCXcX6t5gzI78P3MTivT8+F9bfjL5KQM5RL5K9A5oDvJcuObLeBoFs7MI7+FRZaBjgH2a9BKMOF4RxKMo3MHzXZLgv9+M2rkrWmmVhuoySYRXtfZhIdN+yIIoMm2iUPHSGcb/uHbJqZvfUFnBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=XWdheIXY; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IwGQlTa50b11s0/QB0TMViZRNAPGc3dv8qv0hUaDBFw=; b=XWdheIXYnr/QruXm3c4EN6hiz0
	RmY829zjrqRP/rERC2OME6bZbau2rh+ICaEniwmsUTscf21co+WGCbPYEXfAF+3/yxxnGO//jhifx
	O+XyHJm8TDTWw3/6Mrhl8OJSUW9dFoZmns/OsCclrgaIrz+t7Ug27KmXq7bttBuni/zq/TbqWeCVB
	C5EwqKbUBGGIAGt1pqdj5Ibwbjgv+3609tuqoxRpuU2MEz3jwjh/ZD3TlMmtUcFFBIOt+oS3zvcL3
	bBr43rsJo3z4g+64lm5Zcu+ryRO1bRFh/idEd9IVFYRscEVn4r8uo8LN11oah3aPyW7U1ljL/qN7a
	1b7NCJnQ==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1txVFh-003lrg-Lc; Wed, 26 Mar 2025 18:13:22 +0000
Message-ID: <f38e690b-2eaa-461c-87e6-72927a02bc9e@codethink.co.uk>
Date: Wed, 26 Mar 2025 18:13:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] riscv: dts: add initial support for EIC7700 SoC
To: Conor Dooley <conor@kernel.org>,
 Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Min Lin <linmin@eswincomputing.com>,
 Pritesh Patel <pritesh.patel@einfochips.com>, Yangyu Chen
 <cyy@cyyself.name>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Kanak Shilledar <kanakshilledar@gmail.com>,
 Darshan Prajapati <darshan.prajapati@einfochips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner
 <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
 "rafal@milecki.pl" <rafal@milecki.pl>, Anup Patel <anup@brainfault.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
 <20250320105449.2094192-10-pinkesh.vaghela@einfochips.com>
 <CAJM55Z-LUoeh0pSDnPKpduub_UBOPeg4g3t20JA0GBosJKuiAQ@mail.gmail.com>
 <CH3PR04MB89282DDB25C289C34581DC0083A62@CH3PR04MB8928.namprd04.prod.outlook.com>
 <20250326-headpiece-muskiness-dc167183018e@spud>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20250326-headpiece-muskiness-dc167183018e@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 26/03/2025 17:55, Conor Dooley wrote:
> On Wed, Mar 26, 2025 at 02:20:55PM +0000, Pinkesh Vaghela wrote:
>> On Tue, Mar 25, 2025 at 7:06 PM, Emil Renner Berthing wrote:
>>> Pinkesh Vaghela wrote:
>>>> +     soc {
>>>> +             compatible = "simple-bus";
>>>> +             ranges;
>>>> +             interrupt-parent = <&plic>;
>>>> +             #address-cells = <2>;
>>>> +             #size-cells = <2>;
>>>
>>> Hi Pinkesh,
>>>
>>> Thank your for the patches!
>>>
>>> Should this not be marked dma-noncoherent to avoid having to mark each
>>> peripheral as such?
>>
>> Thanks for your feedback.
>>
>> We have not added "dma-noncoherent" because there are no DMA-capable
>> peripherals in the devicetree yet.
>> We planned to add this later when we add any DMA capable devices
>> i.e. sdhci, gmac, sata, pcie, spi.
>>
>> Do you recommend to add this property in current version?
> 
> If the bus is not cache coherent, then it should be marked as such now.

If it was like any other P550, then the DMA has to go via the cache 
coherent part of the interconnect which is a different address space
that maps into the same bus the P550 and cache controllers are on.

You just need to add the right node to map the DMA addresses and then
have the pain of what happens when there's no memory in the 32bit
address space.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

