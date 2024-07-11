Return-Path: <linux-kernel+bounces-248750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47592E174
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBF281230
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194014B96C;
	Thu, 11 Jul 2024 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otP59T3f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340D3D548
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685104; cv=none; b=k/PzT0vONEwt5PXj3oMbWIDt5iazPtoEUMWBS3L11kjyYwCc4yl7mVYowHaQxXgkimOMl+ZnJsYkUruVYGrUgm9dtQgnGVludDo3OnM20JJBlL6c5e00262p5WZnkeQwWX1/ivZ28n+znyLyTCfjzy9PBQ94R65zsyBT78QjJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685104; c=relaxed/simple;
	bh=/WtGV37+R0Eqy7uIY18tPfa3HmfbcUR7p0WOjPP2zpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFyo0SqVxc5vTl5UD+BKyvw4hYuMOBORICoaHNuChjtEVafFktv12sF72PgIdjrje3vnxUVtlfzsHov/TivJRX7YWWLTOECV46cteJAaQg07RiO1z8ShUvPsLDHenWzrekXCp7BPVks2rzjhvdZEi8LbHqpJESR3d0hi5aFGjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otP59T3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E43C116B1;
	Thu, 11 Jul 2024 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720685103;
	bh=/WtGV37+R0Eqy7uIY18tPfa3HmfbcUR7p0WOjPP2zpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=otP59T3fdeQEw2BHe/NSYCGdI42MZ+EshclSslanDlZYkphwhtXGanfpqSpkoxUeg
	 fTNA8rvSKxzU3mu9EEMMoaE/sdH3zDLo0wzJB4FBPC0BT6j6mJGQTj0S6XikukBSkZ
	 y3ZPtcL20E1bi0T3zus8BWMkBxHWdENgg/0jDySx4zhnJ2Y8bIJZiA7nTCkG7Dl5OZ
	 dm/y5iMSN4+J1/0ifQP2l6nrKFuMizW6HlHUKfQJo0kLGL6tLrx7/+As1fyeZBpSE9
	 2G4l3y/y5+Zp3rs0W8A/8gjtJW4Whsozu+SnZ63q+8HLEi3EyuBPTJVedWtYXokM0J
	 hkktGchGjo6hA==
Message-ID: <0dc54057-d7a0-4123-badc-8f7f07f2d930@kernel.org>
Date: Thu, 11 Jul 2024 11:04:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: cadence-torrent: add support for three or more
 links using 2 protocols
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc: "vkoul@kernel.org" <vkoul@kernel.org>,
 "kishon@kernel.org" <kishon@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "thomas.richard@bootlin.com" <thomas.richard@bootlin.com>,
 "theo.lebrun@bootlin.com" <theo.lebrun@bootlin.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "srk@ti.com" <srk@ti.com>,
 Milind Parab <mparab@cadence.com>
References: <20240710115624.3232925-1-s-vadapalli@ti.com>
 <LV3PR07MB1036463AB8AB5D38D003175E6C5A52@LV3PR07MB10364.namprd07.prod.outlook.com>
 <7504ea5a-335b-4152-a0f4-5be68f048903@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <7504ea5a-335b-4152-a0f4-5be68f048903@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Siddharth,

On 11/07/2024 10:53, Siddharth Vadapalli wrote:
> On Thu, Jul 11, 2024 at 06:43:01AM +0000, Swapnil Kashinath Jakhade wrote:
>> Hi Siddharth,
> 
> Hello Swapnil,
> 
> Thank you for reviewing this patch.
> 
> [...]
> 
>>> - A multilink configuration doesn't necessarily imply two protocols
>>>   since a single protocol may be split across links as follows:
>>>   Lane 0 => Protocol 1
>>>   Lane 1 => Unused
>>>   Lane 2 => Protocol 1
>>>   Lane 3 => Unused
>>>   which corresponds to two links and therefore two sub-nodes. In such a
>>>   case, treat it as two single-link configurations performed sequentially
>>>   which happens to be the case prior to this patch. To address this,
>>>   handle the case where cdns_torrent_phy_configure_multilink() can be
>>>   invoked for a single protocol with multiple sub-nodes (links) by
>>>   erroring out only when the number of protocols is strictly greater
>>>   than two, followed by handling the configuration similar to how it was
>>>   done prior to this patch.
>>
>> The assumption here that "a single protocol when split across links is to be
>> considered as single-link configurations performed sequentially" is not always
>> correct.
>> e.g. If there are 2 PCIe links, then this is a case of 'Multilink PCIe' and not 2 separate
>> 'single link PCIe'. Multilink PCIe has different PLL configurations than for single link
>> PCIe resulting in different register configurations.
>> Also, for multi-protocol case, in cdns_torrent_phy_configure_multilink() function,
>> the existing implementation considers this as multilink case of combination of 2
>> protocols which has different register config than single link of each protocol.
> 
> I suppose that PCIe is the only such protocol since it can have
> different speeds despite a single protocol (Gen1, Gen2, Gen3...), unlike
> other protocols which have a fixed speed and therefore the PLL
> associated with them doesn't have to be reconfigured as the rate will
> never change. Please let me know if there are other protocols (maybe DP?)
> which also require such special handling.

The constraint is PLL frequency and not protocols as such right?
e.g. If there are 4 protocols that all use same PLL frequency then we should
be able to support it?

How about updating the patch to limit on number of PLL frequencies rather than
number of protocols? This should deal with PCIe multi-link case as well.

> 
> [...]
> 
>>> +		phy_t1 = fns(cdns_phy->protocol_bitmask, 0);
>>> +		/**
>>> +		 * For a single protocol split across multiple links,
>>> +		 * assign TYPE_NONE to phy_t2 for configuring each link
>>> +		 * identical to a single-link configuration with a single
>>> +		 * protocol.
>>> +		 */
>>> +		phy_t2 = TYPE_NONE;
>>
>> As mentioned above, assuming phy_t2 = TYPE_NONE is not correct here.
> 
> I can update this patch to handle it differently for PCIe multi-link, but
> as of now I don't see any PCIe multi-link support in the current Torrent
> SERDES driver in Mainline Linux.
> 
>>
>> FYI. I have shared few patches to TI earlier removing the constraint of Maximum 2 links (subnodes)
>> in the driver specifically for Multilink PCIe cases.
>> Please check first 4 patches in link below.
>> https://github.com/t-c-collab/linux/commits/ti-linux-6.1.y-torrent-multi-pcie-sgmii-v1
> 
> The patches you are referring to above seem to remove the constraint of
> a maximum of 2 links, __only__ when one of the protocols is PCIe [1].
> However, that is not necessarily the only use-case for multiple links.
> 
> Please consider the following valid use-case:
> SERDES Lane 0 -> SGMII
> SERDES Lane 1 -> SGMII
> SERDES Lane 2 -> QSGMII
> SERDES Lane 3 -> SGMII
> Representing the above in the device-tree will require 3 sub-nodes
> (links):
> &serdes {
> 	serdes_sgmii_link1: phy@0 {
> 		reg = <0>;
> 		cdns,num-lanes = <2>;
> 		#phy-cells = <0>;
> 		cdns,phy-type = <PHY_TYPE_SGMII>;
> 		resets = <&serdes_wiz 1>, <&serdes_wiz 2>;
> 	};
> 	serdes_qsgmii_link2: phy@2 {
> 		reg = <2>;
> 		cdns,num-lanes = <1>;
> 		#phy-cells = <0>;
> 		cdns,phy-type = <PHY_TYPE_QSGMII>;
> 		resets = <&serdes_wiz 3>;
> 	};
> 	serdes_sgmii_link3: phy@3 {
> 		reg = <3>;
> 		cdns,num-lanes = <1>;
> 		#phy-cells = <0>;
> 		cdns,phy-type = <PHY_TYPE_SGMII>;
> 		resets = <&serdes_wiz 4>;
> 	};
> };
> 
> Such a configuration is valid since it is still using only 2 different
> protocols. But the existing driver doesn't allow splitting/alternating
> protocols. So any use-case is forced to conform to a consecutive allocation
> of protocols. This patch enables the aforementioned use-case and this has
> been validated for functionality on the J784S4 SoC with a custom board [2].
> 
> I believe that this patch can be extended further to support the PCIe
> Multi-link configuration as well. Please let me know your thoughts on
> this.
> 
> [1] https://github.com/t-c-collab/linux/commit/fd87922da100b1ed30015333e037c506c510e932#diff-814f5e3b47c89595aa30310ec07ab7aa8ac96f2921f524c4f5cd536a2c3c5adbR2488
> [2] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1383684/tda4ap-q1-limitations-for-configuration-for-serdes-lanes-when-using-qsgmii-sgmii-and-sgmii-usb3-mixed/

-- 
cheers,
-roger

