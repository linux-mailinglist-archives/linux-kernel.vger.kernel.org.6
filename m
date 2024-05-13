Return-Path: <linux-kernel+bounces-177687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7588C430E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BF41C2165F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926A153BC5;
	Mon, 13 May 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W91De+dP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4E153BC1;
	Mon, 13 May 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609860; cv=none; b=M2IHpd06NqFujy7Cs9GtNPxRBKN8XbhwcWl/sHCLt3U8xhyRIbct5aBSb64GRPTfpQYK4NQbTl8JzQisCdp9BSXrg9WKr1bcRCU+NofWr1gvnibK5FhFEITiKj9kUNiZ72HTOCY3X/AETHMfqh9z9u3kFsXJ2s1M/w5NOH1EMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609860; c=relaxed/simple;
	bh=/vPJpE4pp5NAuUGy0qriY6DZV2OLGz/Fs1yxdax2XUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJ54NF4wAOtNZqw+JuQ5GVpNW+LyeXUv4v3575gSQZXWY2oj7NkWqnIPPVZ4mGWCzVc723fHPTGuqe2l/AMjxiRzKw/XlQ6hmxwOYOqaNY/yYgg2ZcCy4DpyeHK1n/S+pBhvJCgosZxd2JBWkw/pBZqhfMzjXiHFWnJr9RJK+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W91De+dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C7BC4AF0C;
	Mon, 13 May 2024 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609860;
	bh=/vPJpE4pp5NAuUGy0qriY6DZV2OLGz/Fs1yxdax2XUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W91De+dPXNkp8Cg8/fH0pR2jb23Nd2ZlKNyCC0Q2DVKlM/fcqagl4F28UsxaE0aIx
	 P87FJ6agLNCUKoK7MBVUlkf3HEOnJVCL0Dahrlow/rA3meYeUYvQ5pFbFiHhIaa8EL
	 IXT42kj9JrnedzcnLNscgQzAv+r4wZs9aX2G5Csd+K5geeotS6TaIGGJUKbWp+GWbM
	 PNc1SVMqL7JPSclnPVVNqVAKOLEfDMXEDHdPtW4joJUNZSU7XYMG+TgzT+EAVV/1If
	 xc2Tv4VxQDNsWveO5PvjxV3pEb/181d+2fXde243vqvMSjBUWGNE69QxeLhKbEbLgg
	 +9lMhOPl5Yq2g==
Message-ID: <f4f85f0b-49eb-4fba-ac76-2df845571b12@kernel.org>
Date: Mon, 13 May 2024 16:17:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Add dp PHY dt-bindings
To: =?UTF-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 =?UTF-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "mripard@kernel.org" <mripard@kernel.org>,
 =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "kishon@kernel.org" <kishon@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
 <20240510110523.12524-3-liankun.yang@mediatek.com>
 <e02c2f42-b5e4-4200-8131-3881b7034625@kernel.org>
 <3f387c9e8ac34ca25ec7b6bfb02536cd4ebbc508.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <3f387c9e8ac34ca25ec7b6bfb02536cd4ebbc508.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/05/2024 16:15, LIANKUN YANG (杨连坤) wrote:
> On Mon, 2024-05-13 at 08:37 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 10/05/2024 13:04, Liankun Yang wrote:
>>> Add dp PHY dt-bindings.
>>
>> This tells me nothing. Read submitting patches.
>>
>>>
>>> Changeds in v2:
>>
>> This does goes to changelog, not commit log.
>>
>>> - Add dp PHY dt-bindings.
>>> https://patchwork.kernel.org/project/linux-mediatek/patch/
>>> 20240403040517.3279-1-liankun.yang@mediatek.com/
>>>
>>> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
>>
>> This patch looks terrible... there's so many wrong things I don't
>> even
>> know where to start.
>>
>> Please use subject prefixes matching the subsystem. You can get them
>> for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the
>> directory
>> your patch is touching. For bindings, the preferred subjects are
>> explained here:
>>
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Then
>> please
>> run `scripts/checkpatch.pl --strict` and (probably) fix more
>> warnings.
>> Some warnings can be ignored, especially from --strict run, but the
>> code
>> here looks like it needs a fix. Feel free to get in touch if the
>> warning
>> is not clear.
>>
>>
>>> ---
>>>  .../display/mediatek/mediatek.phy-dp.yaml     | 45
>> +++++++++++++++++++
>>>  1 file changed, 45 insertions(+)
>>>  create mode 100644
>> Documentation/devicetree/bindings/display/mediatek/mediatek.phy-
>> dp.yaml
>>
>> Wrong filename
>>
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/display/mediatek/mediatek.phy-
>> dp.yaml
>> b/Documentation/devicetree/bindings/display/mediatek/mediatek.phy-
>> dp.yaml
>>> index 000000000000..476bc329363f
>>> --- /dev/null
>>> +++
>> b/Documentation/devicetree/bindings/display/mediatek/mediatek.phy-
>> dp.yaml
>>> @@ -0,0 +1,45 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>> http://devicetree.org/schemas/display/mediatek/mediatek,phy-dp.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek Display Port Controller
>>> +
>>> +maintainers:
>>> +  - Mac shen <mac.shen@mediatek.com>
>>> +  - Liankun yang <Liankun.yang@mediatek.com>
>>> +
>>> +description: |
>>> +  Special settings need to be configured by MediaTek DP based on
>> the actual
>>> +  hardware situation. For example, when using a certain brand's
>> docking
>>> +  station for display projection, garbage may appear. Adjusting
>> the specific
>>> +  ssc value can resolve this issue.
>>> +
>>> +properties:
>>> +  status: disabled
>>
>> I think you nicely shocked Rob already.
>>
>> Please reach internally to Mediatek or collaborating companies to get
>> basic training and instructions how to write patches and bindings.
>>
>> Otherwise it is waste of our time. Mediatek is not a small company so
>> there is no excuse in sending such poor quality patches, which would
>> be
>> EASILY spotted by the MOST BASIC review.
>>
>> Best regards,
>> Krzysztof
>>
> 
> I used scripts/checkpatch.pl and fix reported error and warnings.
> I am resumbmitting bindings by the MOST BASIC review.

No, please wait. Who did the basic review of your patch? Who from
Mediatek? Upstream is not a workhorse to use instead of your resources
for the absolute basic stuff... This feels such exploiting.

Best regards,
Krzysztof


