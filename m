Return-Path: <linux-kernel+bounces-286748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB3951E89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60CF1C220B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DAF1B4C23;
	Wed, 14 Aug 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qNjn7tNL"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2423D3B8;
	Wed, 14 Aug 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649285; cv=none; b=HGDsXjBDbqJTGxTzsx2wMn4yPJffYU0F5IlI9JAIZ12MLDj0pE8C3LztOHCjT63ib9vvh7Jfpdr+SW+6oNND+U7mZc3a5cfmyLwKCsRDwfEXA70PNfTQ5uADfQlh4K9U8MPIan3fFWASu03rajnhywqTYoCSj/CNUBnaQ6Vns6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649285; c=relaxed/simple;
	bh=AXCtGLE64nt0KQjRPD02ENWHVya56vEl3iAlZUy9Qek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mpqg/aN479NWfL54vHMURYwtYsNHAbWE0ihhNcVYnm0IZ19h2KCl95VxLEU2z7GJ6PqVutufDfjob6jsAzq/90RF0erxRfHxnoaDny6++zYCs4EHPxec7K8d3ntxkjUWwR7naF5+ax6yeAZo4cZShSJntGm6iKsbhMvle+G0Z88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qNjn7tNL; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+Q3KV87gK1VRLxAD2pzYYpy3QuJKu3N0u85aamBDwjM=; b=qNjn7tNL1177aSnVJPjd4RZG13
	gxY/c6lFQRQMY9b9vgk7eDl9g1MsdiApc0NVOoh3KpB1c55ulob78MsotM8erb6LmHwt4wLbn/2A/
	vMf4HBf45epu1zC5NvX7GnSzIDbI6NyXELRsjtsE7uP5QjxCC5j+gqUMITW/Lg1VPb2yUg5YSLXMD
	9jdA8Gmn1/LSuh2P966D8axTCqTBoUqDu8e+xXp+SdGth9zzN+XYPDyr5SIRVuGoNikEc8jDK7Qpx
	P7//z+ebF0Ghdtvm6jPuTD+HtQKlIxSQxUMN4EH7BgZ00efNBHfcpr823JuubKZ9G+zfX4+mBS96k
	4w3QVT9w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1seFun-0006UH-QI; Wed, 14 Aug 2024 17:27:58 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1seFun-000J8C-0e;
	Wed, 14 Aug 2024 17:27:57 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Jessica Zhang
 <quic_jesszhan@quicinc.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  dri-devel@lists.freedesktop.org,
  linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add JMO Tech
In-Reply-To: <97f60cd3-1433-4dc5-9dc4-ad9a53c1b35a@kernel.org> (Krzysztof
	Kozlowski's message of "Wed, 14 Aug 2024 17:26:49 +0200")
References: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-0-22a5e58599be@geanix.com>
	<20240814-drm-panel-ili9881c-lcm-jm800wx-v1-1-22a5e58599be@geanix.com>
	<ec3462d8-e300-4273-9ce5-5380b506821e@kernel.org>
	<871q2r5fnq.fsf@geanix.com>
	<97f60cd3-1433-4dc5-9dc4-ad9a53c1b35a@kernel.org>
Date: Wed, 14 Aug 2024 17:27:56 +0200
Message-ID: <87wmkj3z0j.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27367/Wed Aug 14 10:36:34 2024)

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 14/08/2024 16:43, Esben Haabendal wrote:
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>> 
>>> On 14/08/2024 15:10, Esben Haabendal wrote:
>>>> Add vendor prefix for JMO Tech CO., LTD. (http://www.jmolcd.com/).
>>>>
>>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>>> index a70ce43b3dc0..5d2ada6cfa61 100644
>>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>>> @@ -758,6 +758,8 @@ patternProperties:
>>>>      description: Jiandangjing Technology Co., Ltd.
>>>>    "^jide,.*":
>>>>      description: Jide Tech
>>>> +  "^jmo,.*":
>>>
>>> Wevsite is jmolcd, so prefix should match it - jmolcd.
>> 
>> Ok. Even though the companies name is "JMO Tech CO.,LTD", and does not
>> hint at "jmolcd"?
>
> We use domain names as vendor prefixes, so when another "jmo.com" comes,
> they will get "jmo", not something else.

Ok. I will change it for v2 of the series.

/Esben

