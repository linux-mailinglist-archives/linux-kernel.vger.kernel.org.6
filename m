Return-Path: <linux-kernel+bounces-371372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A129A3A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9813EB211B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A431F4FDF;
	Fri, 18 Oct 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="sIOmjlZt"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF2190482;
	Fri, 18 Oct 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244328; cv=none; b=pnNT+ZK7ETe47+R+uXpu2OWH6585RO7b55e0Dz1dIhh0DIZhKSdVunIqMKJvm1rjvzdYceAsPvfo+ikUI4qGufXGnEaIPHh2tdqf+BXo4ieW0nTLc6oGNbznEDyvPBWLbNmxI3r6hVLtdqphUhyZFRva1Q3ixhF+pPBoglGjiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244328; c=relaxed/simple;
	bh=gjPnHePZa6vCve49TO7jtw+srcnYDIhom0HnzZqb/TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OImmlRXarDuNhLq1er0ZqZK4IsOqgrmN+2LthY+mRXyEuu0G/f+LRXEmuEeU7el0yUWjkChpzdwg8MiEA1gxhi5cTw+gtiZKvDGWyrAW6jP02SRN143gLfB3JVOLiOqJN7ymu0dGsDA3CbVWs6FgFtxnw2PxEenbIP/iuEXMFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=sIOmjlZt; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D501888FE4;
	Fri, 18 Oct 2024 11:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729244324;
	bh=+VS7STIkwsPw7S3kW+v2YTd1lj/k2vEqYHwS1JqUrwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sIOmjlZt9HnILFO9pk9w+ssaX716q+cyXB0gkq/Ob20Gvh0kLoiO5RSJnE/aJe+dF
	 OhWLXwT4BlGAc2bYOo8nw0Htymc3P+zq1B69v1ndNV5ashmnIWRCTv0dkn1nEhLQ3l
	 0V8YdcC46RUlu/lPALqb2T+JCAlHLbzfDCMw+Gs/dPdypzrUpD6wMVpaGm6e+r4RAs
	 Jej5kERU9YTvZLxZtWgz5RX1eOBVuCkdtRpuyQKFEFakhp0/m7teHXggxNKCD0aY68
	 VLQ6CHdaaSh54yPs96/c1QluH3ETdcLUhCXj0lh8yIYhF9l0LR6wqIpmtcAIQTqlHV
	 FRbO/1XpuIIEA==
Message-ID: <06bb1733-1742-4847-8436-8f9d8d4b7c46@denx.de>
Date: Fri, 18 Oct 2024 11:35:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp-msc-sm2s-ep1: Add HDMI connector
To: Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 stefan@agner.ch, dmitry.baryshkov@linaro.org
References: <20241018064813.2750016-1-victor.liu@nxp.com>
 <20241018064813.2750016-4-victor.liu@nxp.com>
 <69cc9c59-99c0-479d-8143-63698cc56111@denx.de>
 <4d1c434e-e7bd-4e53-b110-1f26eb06c59c@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4d1c434e-e7bd-4e53-b110-1f26eb06c59c@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/18/24 11:00 AM, Liu Ying wrote:
> On 10/18/2024, Marek Vasut wrote:
>> On 10/18/24 8:48 AM, Liu Ying wrote:
>>> Add a HDMI connector to connect with i.MX8MP HDMI TX output.
>>> This is a preparation for making the i.MX8MP LCDIF driver use
>>> drm_bridge_connector which requires the DRM_BRIDGE_ATTACH_NO_CONNECTOR
>>> flag.  With that flag, the DW HDMI bridge core driver would
>>> try to attach the next bridge which is the HDMI connector.
>>>
>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>> ---
>>>    .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
>>> index 83194ea7cb81..b776646a258a 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
>>> @@ -15,6 +15,17 @@ / {
>>>                 "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
>>>                 "fsl,imx8mp";
>>>    +    hdmi-connector {
>>> +        compatible = "hdmi-connector";
>>> +        type = "a";
>> Shouldn't this also have a 'label' property ?
> 
> 'label' property is not required by hdmi-connector.yaml and there
> are in-tree hdmi-connector nodes that haven't got it.
> I tried to find schematics for the board online, but failed.
> I don't have the board to see the label printed in silk layer, either.
> 
> If anyone can provide a valid label name, I may add it.
For the Kontron board, Frieder might be able to look it up for you ?

For the MSC one, hmmm, I am not sure. Anyone ?

