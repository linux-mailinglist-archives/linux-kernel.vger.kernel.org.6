Return-Path: <linux-kernel+bounces-252791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7D931829
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833371F225D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1799120DF4;
	Mon, 15 Jul 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnj+TudI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD3F12DDA2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059717; cv=none; b=f4X0shJE8uWdwPfA11iqcA0S22yaegU+e7hUk/9p0jXBreN/CoIv2mSO4Wl10QyR/8Y7FRgTjMB9/f7dS0jNRNe5mO+ndC28tH9lt2g9WsfR3PPlzlpA+s8fZIGLF72o9QsxGyC3tbh+t4/TvozOhlttMbzgXp2rwiid1zxRjzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059717; c=relaxed/simple;
	bh=9GnDBj5Xnp2lVxGxh+31ziCimp0dwbKkpcW29ik9TsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrWCgwE3G9G0omfGSAge0H03tSEDczFfCnMi+E7w22Q1ezRSL+qxAXKWuDZwoGgJ7e+4MRdHtbP3R9d/e6v3DX7cRbyMSM9iCzKxl4i6CfR99hEiy0grSIm02wUlBwoEfYgdobOhvy1I9epZxq3/zPvqOcWEgIRgHMpZ8Hl1N/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnj+TudI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6F8C4AF0D;
	Mon, 15 Jul 2024 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059716;
	bh=9GnDBj5Xnp2lVxGxh+31ziCimp0dwbKkpcW29ik9TsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rnj+TudI4+66hO3pp2Rp4jJDIIugO1l6k4v1YPt4XIakeVrtB+bf4iBEmepvLdn53
	 sxqN+Nf5it0X2g/ESICqUw7i8tMunxRVBBWD/Zq5aHjZFV6UbS5kdFefvYt4GiyIOR
	 lJZoDq1+sxC4N4iIlF/OdI6JXwHbCLmff3/50IL0oU0TdEXFSY+eLHav7mhC/F+gX+
	 G/j7bhfimJeC6NS0n9kqYKHRuxIenR3r8jaTLDNaY5OwWgOolITBgK4gjuNsMVlUBV
	 0yNoikdEPEJbGVrgkjABBR856NfOwUD5PIJQQLA3bu6G+UCXptZXrh9YflafyI/6IV
	 d7Fnb2RCvsHWg==
Message-ID: <d4538952-add4-4210-ae0a-574cd825b18d@kernel.org>
Date: Mon, 15 Jul 2024 19:08:30 +0300
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
 <0dc54057-d7a0-4123-badc-8f7f07f2d930@kernel.org>
 <c60a1e83-c2ad-4a04-9deb-073c69a4a06d@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <c60a1e83-c2ad-4a04-9deb-073c69a4a06d@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Siddhath,

On 12/07/2024 13:38, Siddharth Vadapalli wrote:
> Roger, Swapnil,
> 
> On Thu, Jul 11, 2024 at 11:04:57AM +0300, Roger Quadros wrote:
>> Siddharth,
>>
>> On 11/07/2024 10:53, Siddharth Vadapalli wrote:
> 
> [...]
> 
>>> I suppose that PCIe is the only such protocol since it can have
>>> different speeds despite a single protocol (Gen1, Gen2, Gen3...), unlike
>>> other protocols which have a fixed speed and therefore the PLL
>>> associated with them doesn't have to be reconfigured as the rate will
>>> never change. Please let me know if there are other protocols (maybe DP?)
>>> which also require such special handling.
>>
>> The constraint is PLL frequency and not protocols as such right?
>> e.g. If there are 4 protocols that all use same PLL frequency then we should
>> be able to support it?
>>
>> How about updating the patch to limit on number of PLL frequencies rather than
>> number of protocols? This should deal with PCIe multi-link case as well.
> 
> I suppose that an indirect way of determining whether a configuration
> can be supported or not is by checking if an entry exists in the "tables"
> (link_cmn_vals_tbl). That should be accurate since it reflects what the
> driver supports.
> 
> I will update this patch accordingly so that Swapnil's inputs regarding
> PCIe Multi-link are also addressed.
> 
> I am describing the logic for the updated patch below. Please share your
> feedback.
> 
> 1. All single-link configurations (1 sub-node) can have only one
> protocol and will be handled via the "phy_ops" callbacks namely:
> .init, .power_on, ...
> No change will be made to this existing implementation.
> 
> 2. All multi-link configurations (2 or more sub-nodes) have to be
> configured via cdns_torrent_phy_configure_multilink().
> 
> CASE-1 (2 Links/Sub-nodes):
> Check if there is an entry in "link_cmn_vals_entries" for the requested
> configuration and configure accordingly. This should handle the PCIe
> Multi-link configuration as well as other similar configurations which
> have a single protocol but cannot be treated as two single link
> configurations performed successively for each link.
> 
> CASE-2 (3 or more Links/Sub-nodes):
> 
> The links shall be grouped together by the protocol. Since we eventually
> have to look for an entry in "link_cmn_vals_entries", it is safe to impose
> the constraint that there shouldn't be more than 2 Protocols as the table
> is of the form:
> (phy_type1, phy_type2)
> i.e. Protocol 1, Protocol 2.
> It is guaranteed to be the case that Protocol1 != Protocol2 due to the
> following reason:
> If Protocol 1 == Protocol 2, it could have been represented in the
> device-tree using either:
> a) single link (sub-node)
> b) double link (sub-node) -> Special cases like PCIe Multi-link
> 
> So assuming the above, we can enforce the constraint that there should
> be only 2 Protocols when 3 or more Links are present in the device-tree.
> This also handles the cases of
> PCIe Multi-Link + USB, PCIe Multi-Link + Q/SGMII
> which Swapnil has pointed to at [1], since PCIe Multi-Link is now a new
> protocol in itself (PHY_TYPE_PCIE_ML) and shall be represented in that
> manner in the device-tree when it is expected to be combined with a second
> protocol.
> 
> After grouping the links by protocol, we can check for the entry in
> "link_cmn_vals_entries" and proceed to configure it identical to the
> 2 Link case.
> 
> [1] https://github.com/t-c-collab/linux/commits/ti-linux-6.1.y-torrent-multi-pcie-sgmii-v1

This proposal looks good to me. Thanks!

-- 
cheers,
-roger

