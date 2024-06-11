Return-Path: <linux-kernel+bounces-209348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD4903316
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B691F28C75F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82760172790;
	Tue, 11 Jun 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iiLcw0kA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89877171E66;
	Tue, 11 Jun 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088860; cv=none; b=P0KF9Gi1UD/54Z80RTg2jx6NoVqhzftRUMnv312y9b98dHGaXZGzOzOgiA+g4wvbh9+WkFqZi0NIUnvwuCvd9nHrhUYsWpluGOZQd0EwWShz2hUt8JV3c/W1DYDPIpJrIb0DLpINxtkJs4YyhFO+3Un7mTHBwe5Wj7uMAzmCm58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088860; c=relaxed/simple;
	bh=L2glcEBJPqTLQO8Gdi0zVPEY8C63eL0dUxrZNc/ueBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taDeY1YKH9XKlCxGD52QfuAgYEGQbvbd3Ub6JYNBljnCa2iMV4H6P/Fj/dMzm9Lmc0D+DGrfKaM1EZBqshS7jBK110nUxGj8CSsOcJ/m0b2E32riF682MegYXyiqeR8z5u84TNsyhk71KrnUjUWRwOU8RLWRpPUUzHid6m0xiWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iiLcw0kA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718088850;
	bh=L2glcEBJPqTLQO8Gdi0zVPEY8C63eL0dUxrZNc/ueBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iiLcw0kA6mk7hFiX5Y1591cgeb/Ga9Ubf84v4VB0213cIV28cEdq4NBAvhLWFK73B
	 aYC9owce1ydMJEuVlGqL0CObz/YJrGP3bO5N9r2c9SnNSJ9dQ/SITzarkyyslqv0BM
	 mqv0JIN6AF7+7hwmh3Tn5ekQ5ZzRwiyAcnyMLXr3DiINpryoOz3/JpW8YN5SONFoPe
	 YvibWtk5xpnjTCLamTVnnSEFfxiyZWqGa/bDNLP/XUPYcWECSNvKO9BkPblf8e8NdG
	 oIJoGQNPcWTCuYU4Md5FoWCDXktCwmdliD7TCiRQFV9Xh5y1WmpXVyBODcJRIkxgPP
	 NgnFa+18pgHHA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9070A3780EC6;
	Tue, 11 Jun 2024 06:54:09 +0000 (UTC)
Message-ID: <aa991aa4-7e9e-4cc6-b6ae-69539700691f@collabora.com>
Date: Tue, 11 Jun 2024 08:54:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "amergnat@baylibre.com" <amergnat@baylibre.com>
References: <20240521075717.50330-1-angelogioacchino.delregno@collabora.com>
 <20240521075717.50330-3-angelogioacchino.delregno@collabora.com>
 <e7845300fa822413f6308cb6297222cde89c39e0.camel@mediatek.com>
 <0e0fe86c-92da-43f5-89d7-8084274a908a@collabora.com>
 <0f20214ab3a86f68669ad1392398b16228e699ee.camel@mediatek.com>
 <47f05439-815e-4ca1-b20d-8e427fef0a2a@collabora.com>
 <ee0209dac731b36ffe2ee20a2ff537ce7758b01f.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ee0209dac731b36ffe2ee20a2ff537ce7758b01f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 11/06/24 08:48, CK Hu (胡俊光) ha scritto:
> On Mon, 2024-06-10 at 10:28 +0200, AngeloGioacchino Del Regno wrote:
>> Il 06/06/24 07:29, CK Hu (胡俊光) ha scritto:
>>> Hi, Angelo:
>>>
>>> On Wed, 2024-06-05 at 13:15 +0200, AngeloGioacchino Del Regno wrote:
>>>> Il 05/06/24 03:38, CK Hu (胡俊光) ha scritto:
>>>>> Hi, Angelo:
>>>>>
>>>>> On Tue, 2024-05-21 at 09:57 +0200, AngeloGioacchino Del Regno wrote:
>>>>>> Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
>>>>>> per HW instance (so potentially up to six displays for multi-vdo SoCs).
>>>>>>
>>>>>> The MMSYS or VDOSYS is always the first component in the DDP pipeline,
>>>>>> so it only supports an output port with multiple endpoints - where each
>>>>>> endpoint defines the starting point for one of the (currently three)
>>>>>> possible hardware paths.
>>>>>>
>>>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>>>>> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>>>>>> Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
>>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>>> ---
>>>>>>     .../bindings/arm/mediatek/mediatek,mmsys.yaml | 28 +++++++++++++++++++
>>>>>>     1 file changed, 28 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>>>>>> index b3c6888c1457..0ef67ca4122b 100644
>>>>>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>>>>>> @@ -93,6 +93,34 @@ properties:
>>>>>>       '#reset-cells':
>>>>>>         const: 1
>>>>>>     
>>>>>> +  port:
>>>>>> +    $ref: /schemas/graph.yaml#/properties/port
>>>>>> +    description:
>>>>>> +      Output port node. This port connects the MMSYS/VDOSYS output to
>>>>>> +      the first component of one display pipeline, for example one of
>>>>>> +      the available OVL or RDMA blocks.
>>>>>> +      Some MediaTek SoCs support multiple display outputs per MMSYS.
>>>>>
>>>>> This patch looks good to me. Just want to share another information for you.
>>>>> Here is an example that mmsys/vdosys could point to the display interface node.
>>>>>
>>>>> vdosys0: syscon@1c01a000 {
>>>>>              mmsys-display-interface = <&dsi0>, <&dsi1>, <&dp_intf0>;
>>>>> };
>>>>>     
>>>>> vdosys1: syscon@1c100000 {
>>>>>              mmsys-display-interface = <&dp_intf1>;
>>>>> };
>>>>>
>>>>> There is no conflict that mmsys/vdosys point to first component of one display pipeline or point to display interface.
>>>>> Both could co-exist.
>>>>>
>>>>
>>>> Hey CK,
>>>>
>>>> yes, this could be an alternative to the OF graphs, and I'm sure that it'd work,
>>>> even though this kind of solution would still require partial hardcoding of the
>>>> display paths up until mmsys-display-interface (so, up until DSI0, or DSI1, etc).
>>>>
>>>> The problem with a solution like this is that, well, even though it would work,
>>>> even if we ignore the suboptimal partial hardcoding, OF graphs are something
>>>> generic, while the mmsys-display-interface would be a MediaTek specific/custom
>>>> property.
>>>>
>>>> In the end, reusing generic kernel apis/interfaces/etc is always preferred
>>>> compared to custom solutions, especially in this case, in which the generic
>>>> stuff is on-par (or actually, depending purely on personal opinions, superior).
>>>>
>>>> As for the two to co-exist, I'm not sure that this is actually needed, as the
>>>> OF graphs are already (at the end of the graph) pointing to the display interface.
>>>>
>>>> In any case, just as a reminder: if there will be any need to add any custom
>>>> MediaTek specific properties later, it's ok and we can do that at any time.
>>>
>>> The alternative solution is using OF graphs to point display interface and use MediaTek specific property to first component:
>>>
>>> vdosys0: syscon@1c01a000 {
>>>             ports {
>>>                      port@0 {
>>>                                endpoint {
>>>                                         remote-endpoint = <&dsi0_endpoint>;
>>>                                };
>>>                      };
>>>    
>>>                      port@1 {
>>>                                endpoint {
>>>                                         remote-endpoint = <&dsi1_endpoint>;
>>>                                };
>>>                      };
>>>    
>>>                      port@2 {
>>>                                endpoint {
>>>                                         remote-endpoint = <&dp_intf0_endpoint>;
>>>                                };
>>>                      };
>>>             };
>>>    
>>>             display-first-component = <&ovl0>;
>>> };
>>>
>>> And I agree to it's better to keep only OF graphs property, so it would be
>>>
>>> vdosys0: syscon@1c01a000 {
>>>             ports {
>>>                      port@0 {
>>>                                endpoint {
>>>                                         remote-endpoint = <&dsi0_endpoint>;
>>>                     
>>>              };
>>>                      };
>>>    
>>>                      port@1 {
>>>                                endpoint {
>>>                                         remote-endpoint = <&dsi1_endpoint>;
>>>                             
>>>      };
>>>                      };
>>>    
>>>                      port@2 {
>>>                                endpoint {
>>>                                         remote-endpoint = <&dp_intf0_endpoint>;
>>>                                }
>>> ;
>>>                      };
>>>             };
>>> };
>>>
>>> Maybe we could use OF graphs for both first component and display interface and drop using MediaTek specific property.
>>>
>>
>> We could, or we can simply walk through the OF Graph in the driver and get the
>> display interface like that, as it's board-specific ;-)
>>
>> ...but anyway, let's see that later: after getting this series upstreamed, I will
>> convert all MediaTek boards (including Chromebooks) to use the graphs instead, and
>> you'll see that, at least for the currently supported boards, there's no need for
>> any custom property.
>>
>> Also, setting the DSI0/1/dpintf endpoint to VDO0 is technically wrong, as that is
>> supposed to be the last one, and a graph is conceptually supposed to go from the
>> first to the last in sequence.
>>
>> *if* we will ever need (probably not) to get the VDO0 node to point directly to
>> the last node for whatever reason, the right way would be the first one you said,
>> so, mediatek,mmsys-display-interface = <&dsi0>, <&dsi1>, etc etc
>>
>> ...or mediatek,mmsys-possible-displays = < ... phandles >
>>
>> ...or anyway, many other solutions are possible - but again, I think this is not
>> the right time to think about that. Knowing that there are eventual solutions for
>> any need that might arise in the future is enough, IMO :-)
> 
> This is one routing of display pipeline and the relation of VDOSYS0 with display pipeline.
> 
>                 +-- VDOSYS0 ---------------------------------------------+
>                 |                                                        |
>                 |                                                        |
> DRAM -> IOMMU ---> OVL0 -> RDMA0 -> ... -> DSC0 -> MERGE0 -> DP_INTF0 ---->
>                 |                                                        |
>                 |                                                        |
>                 +--------------------------------------------------------+
> 
> Video data is read by IOMMU from DRAM and send to display pipeline. Then video data travel through first component to display interface.
> VDOSYS0 manage each component in the pipeline include first component and display interface.
> The management include clock gating, reset, video data input/output routing.
> The relationship of VDOSYTS0 with first component is the same as the relationship of VDOSYS0 with display interface.
> If VDOSYS0 is not suitable using OF graph point to display interface, VDOSYS0 is also not suitable using OF graph point to first component.

In the cases in which VDO goes directly to the display, it *is* possible to make it
point directly to the display.

In the cases in which the pipeline is larger, VDO still points to the display, but
only later in the pipeline.

> The job of the component in display pipeline is to process the video data,
> but the job of VDOSYS0 is to manage (clock gating, reset, routing) the pipeline.
> If the OF graph is to show the video data travel path, VDOSYS0 should not exist in the OF graph.
> 
> Regards,
> CK
> 
>>
>> Cheers,
>> Angelo
>>
>>> Regards,
>>> CK
>>>
>>>>
>>>> Cheers!
>>>> Angelo
>>>>
>>>>> Regards,
>>>>> CK
>>>>>
>>>>>> +    properties:
>>>>>> +      endpoint@0:
>>>>>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>>>>>> +        description: Output to the primary display pipeline
>>>>>> +
>>>>>> +      endpoint@1:
>>>>>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>>>>>> +        description: Output to the secondary display pipeline
>>>>>> +
>>>>>> +      endpoint@2:
>>>>>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>>>>>> +        description: Output to the tertiary display pipeline
>>>>>> +
>>>>>> +    anyOf:
>>>>>> +      - required:
>>>>>> +          - endpoint@0
>>>>>> +      - required:
>>>>>> +          - endpoint@1
>>>>>> +      - required:
>>>>>> +          - endpoint@2
>>>>>> +
>>>>>>     required:
>>>>>>       - compatible
>>>>>>       - reg
>>>>
>>>>
>>
>>




