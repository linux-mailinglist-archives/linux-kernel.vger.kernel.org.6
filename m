Return-Path: <linux-kernel+bounces-188860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F5C8CE7E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507691C21DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246512E1C5;
	Fri, 24 May 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GkfVqmOe"
Received: from mail-m12776.qiye.163.com (mail-m12776.qiye.163.com [115.236.127.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EA12DDA2;
	Fri, 24 May 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564545; cv=none; b=SQWYhNGVLhOcGN4qEhQj+NF3ELG/Wps96OPq2W1w+ny0xqFDZMSpNygGPC1Tq60HLow7Lyz5zWOrBHuQElGIQwiTx0VHLVu6wDvSXWyLgeDdvUPSui9RIUeiS0BcGLs9FLSHgDMbsXERkrVtUHlqb6i80F22fcQ8VKE6jUWj+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564545; c=relaxed/simple;
	bh=tQkcd34q1QaxaTpHWMI8oxRvSlHE+4YCiXIDNlF99hI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rnkBDmLf3KIyUS9fhZt2eR7AyivTD0GRhRpwInCiDjfu5lxtRgDm+sfoqTs4rr2jhiSIbOin4bTWqNlck6pjdhXfc2X+ZL/MmVLN+iwGA+QevoXVVL+T4ma9FlQm4Od0j4d/kz6x0L7Sq5tjNshZcnw4CubwF7x2++R15rSUB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GkfVqmOe; arc=none smtp.client-ip=115.236.127.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=GkfVqmOeodjSsHUIq7QZo9oKtwtbKwTt1qnHgCTG7/yWGhv2yHi+u/CK66SOf+nx56G2fHNn+AAnB5zgRSEuWjsTBo7MLRQ4oNxI3lq9VLlgWAJc6ywdMRjS2vUfXHuxgqyIoQ9fOYEhpFMhZiu+gSqQmlvfR259P0J6HSLXrSY=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=vlYy6kfDRcuOHsQw1Qcrcg0CgVRI1V2ODtI9AvFKsJ4=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id ADE8E840B0B;
	Fri, 24 May 2024 18:41:51 +0800 (CST)
Message-ID: <5dec9bd2-88ed-46e6-bb8d-fa899b563fd3@rock-chips.com>
Date: Fri, 24 May 2024 18:41:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v5 00/16] Add VOP2 support on rk3588
From: Andy Yan <andy.yan@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>
Cc: sebastian.reichel@collabora.com, krzysztof.kozlowski+dt@linaro.org,
 chris.obbard@collabora.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
 kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20231211115547.1784587-1-andyshrk@163.com>
 <170247871959.753029.11166929824242336708.b4-ty@sntech.de>
 <7a20761b-4cec-4b65-b9fa-efce73ac4c83@rock-chips.com>
Content-Language: en-US
In-Reply-To: <7a20761b-4cec-4b65-b9fa-efce73ac4c83@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJOS1YdTExOHUoeTRlOTkhVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
	kG
X-HM-Tid: 0a8faa315ab403a4kunmade8e840b0b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Kxw6QzNDMRcDFi5ISUMR
	Gj8KCi5VSlVKTEpNTk9MSEpJTU5OVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSEhCTTcG

Hi Heiko,

On 12/14/23 14:46, Andy Yan wrote:
> Hi Heiko:
> 
> On 12/13/23 22:46, Heiko Stuebner wrote:
>> On Mon, 11 Dec 2023 19:55:47 +0800, Andy Yan wrote:
>>> From: Andy Yan <andy.yan@rock-chips.com>
>>>
>>> This patch sets aims at enable the VOP2 support on rk3588.
>>>
>>> Main feature of VOP2 on rk3588:
>>> Four video ports:
>>> VP0 Max 4096x2160
>>> VP1 Max 4096x2160
>>> VP2 Max 4096x2160
>>> VP3 Max 2048x1080
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [10/16] dt-bindings: display: vop2: Add rk3588 support
>>          commit: 4ccdc92c1fea732fac8f3438d6288719055fa141
>> [11/16] dt-bindings: rockchip,vop2: Add more endpoint definition
>>          commit: dc7226acacc6502291446f9e33cf96246ec49a30
>> [12/16] drm/rockchip: vop2: Add support for rk3588
>>          commit: 5a028e8f062fc862f051f8e62a0d5a1abac91955
>> [13/16] drm/rockchip: vop2: rename VOP_FEATURE_OUTPUT_10BIT to VOP2_VP_FEATURE_OUTPUT_10BIT
>>          commit: 9d7fe7704d534c2d043aff2987f10671a8b4373d
>> [16/16] MAINTAINERS: Add myself as a reviewer for rockchip drm
>>          commit: 6c3ab21f37a97a868193ccbeb8a492e51210ff31
>>
>>
>> I skipped the debugfs patch for now, as I need to look at that separately
>> and of course the dts patch as that needs to wait for iommu maintainers
>> to pick up the binding addition.
> 
> That's fine. Thanks for picking these series.

Would you please take a look at the debugfs patch when it's convenient for you?
It's really useful for development and bug hunting.

> 
>>
>>
>> Best regards,

