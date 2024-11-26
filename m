Return-Path: <linux-kernel+bounces-421839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8479D90C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B232287F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D126BB5B;
	Tue, 26 Nov 2024 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="oUmp80/1"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677263FB31
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732592780; cv=none; b=iIrbSNwLNNWYsqWbXLP1WtqQJvrRWCYGKhDDwvkd3N5hGosa9CkRBT6WfskAgMiRMdc33+ZBRJT5vgQMR+LH2+PxU8FLqP7RZKTVfNPjiEj7M/yt4TPdpOn9DwSjOL2SQ94HmLwH56rs0CHnzNqKDzgkrzhn3bxkjPu1Ogyv+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732592780; c=relaxed/simple;
	bh=YSkrqxKh9N5elFAjOCiYXy17rR2p3vfhcaMtMubZGys=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jE/KfJTXCei32SWsyIRzTEWTjgDgpfdPJcGfavw968Kdp3RizV3CqarEuUKPBio5uZo3ylEe2toKKpPrP6O9v3p0228fQfgKq0Er+JpNN8wsQ9otm0cD/TZkpAiuK1bFJYpm4j6RQRemglUsWKU53ScYph1ZsP6WkfODzJAbYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=oUmp80/1; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id FizvtPnUPg2lzFmWntnEse; Tue, 26 Nov 2024 03:46:17 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id FmWktKiK5XDcgFmWmt1ryD; Tue, 26 Nov 2024 03:46:16 +0000
X-Authority-Analysis: v=2.4 cv=MedquY/f c=1 sm=1 tr=0 ts=67454488
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=-pn6D5nKLtMA:10 a=vU9dKmh3AAAA:8
 a=Uhfq17CCtucz6BUgXkYA:9 a=QEXdDO2ut3YA:10 a=rsP06fVo5MYu2ilr0aT5:22
 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EpVOpGc4bJDTukR4641wyoZUQ4tkmW15trkijARXKjE=; b=oUmp80/1hLyTPIV/hVQpxZ79Y/
	gJSI0jk/GnzimzQi+FvvxMT8ObK3qQFjXdUblR6oWeKbqu0LRORQceJJ6atxp9+WaIqHs/Ivw/LRV
	9H9teytC78wPq2Y8+YE6PEjUPRYq0kPl6/BxIU3z46s51nBUXZ8MDBSVuYg/sc5BbG+qj5zpKDHR8
	28DgJW4lWsTjsqvefcup0KcP4lTx8J07KKB3OXrFFjC+KPQRjEE0a5hqtrKQ241TO9FgtX7ZrzM14
	phf7hHHDnHpgynzGbGChboT/YjRTjzBqAv9ysTY3lxB0pPfH9/VZoiyB6fNWDO81leXjCgnf101fi
	bHblG8sA==;
Received: from [122.165.245.213] (port=40090 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tFmWe-003Oct-33;
	Tue, 26 Nov 2024 09:16:08 +0530
Message-ID: <ec0c0a4f-9555-42bb-adac-3ba574fe82cc@linumiz.com>
Date: Tue, 26 Nov 2024 09:16:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: gpu: add reset control property
To: Conor Dooley <conor@kernel.org>
References: <20241125-pvr-reset-v1-0-b437b8052948@linumiz.com>
 <20241125-pvr-reset-v1-1-b437b8052948@linumiz.com>
 <20241125-dress-disliking-2bf22dd4450e@spud>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20241125-dress-disliking-2bf22dd4450e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1tFmWe-003Oct-33
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:40090
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFzmQz6jtcOph3QZm/q0wwkvEOyShcQPjQm+2Mnlvdc6zVhtVxHzcv/ZpCV0fy4l3kyGWTNJT1WKTZr1IC4rQV145BBCwvy9o9QXoDCo/OYm19EdRfwC
 Mnqy58ucCNdfkDu9giHZV2bKEKyQK1NgUkr8SRCgxtZnpGq2+ONWK8KsNoFRFzj28isfiUXlb/+hSjPW7orohqIxqEH/KIlkdsw=

On 11/25/24 11:37 PM, Conor Dooley wrote:
> On Mon, Nov 25, 2024 at 10:07:03PM +0530, Parthiban Nallathambi wrote:
>> GE8300 in Allwinner A133 have reset control from the ccu.
>> Add the resets property as optional one to control it.
> 
> There's no specific compatible here for an a133, but the binding
> requires one. Where is your dts patch?
A133 GPU is still work in progress in both Kernel and Mesa3D. Also power
domain support needs an additional driver.

But reset control is independent of those changes. Should reset control
needs to be clubbed GPU dts changes?

Thanks,
Parthiban
> 
>>
>> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
>> ---
>>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
>> index 256e252f8087..bb607d4b1e07 100644
>> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
>> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
>> @@ -37,6 +37,9 @@ properties:
>>    power-domains:
>>      maxItems: 1
>>  
>> +  resets:
>> +    maxItems: 1
>> +
>>  required:
>>    - compatible
>>    - reg
>>
>> -- 
>> 2.39.2
>>


