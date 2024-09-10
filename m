Return-Path: <linux-kernel+bounces-323389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AAA973CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C191F26149
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BBE19EEA6;
	Tue, 10 Sep 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AC1umU01"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7918EFE2;
	Tue, 10 Sep 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983183; cv=none; b=gcpx6mKnXdtnjffFv0NbVdJpqxRx5iNEAQF/Af7frPJ4pF5jStZfvBTTzKYw3/tXF+Sjy2s+HgM90XDn/g6I0VGvL+Y+60q4v1gg/yol/g+65z5cNaOo8REvovuY9K5oIv227Z42VkI5NJRdIQyXIpvtEzcj+1nhESRFJbJuWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983183; c=relaxed/simple;
	bh=GrMFIlDH+h32IGt5CGGo+R3M4GXaCobATkGNy8GeYuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWMZp1/3uYSMRFjcVrIDaxDW0faKR+3W3TVMggyQRrYNzvEudm2X68kQrv1Bv/2kQVge1JjBMSJCR5KKJQBKZpoRziaLY9ONi2buL1vxQBKWW3JY/40ePVpUDRMw9Gopr5L4uEcZxYRdyNSetJkXzu4gB0Zie4Nf1BUOn1RkJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AC1umU01; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725983179;
	bh=GrMFIlDH+h32IGt5CGGo+R3M4GXaCobATkGNy8GeYuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AC1umU01a5qKWx+Z24H0jczKmKir9dgqzTCuqU43f6kdvj3E3sUP215CTlYaeDZIk
	 YCD+5O7U+VCILpMm4HTZRZJ1hm3agHZ1Ffv6TJC2L+bp6+ouyEx7U+96Ryvn3kbZ+r
	 Zz9ssUpotEk0pzkly3Trsiilx0KucdIB8aeulNWIiBAvCfREyPc6m9vi6rS24j/Rcr
	 fn77zFHHeQIR4ijW4Eh86YnTtZl8HZBLuEbTVJ4dBqX322J/k5JNxhu9ehzdtLCbnd
	 wenhij+luHI+CwjTp+QHt7b51QEItCahDP6K8/VPOBjgiTaEFYZsynrI+snAfXe6GT
	 MKRBw4t1Wg3SQ==
Received: from [192.168.1.90] (unknown [188.27.55.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD53917E35CC;
	Tue, 10 Sep 2024 17:46:18 +0200 (CEST)
Message-ID: <5803a5ba-2684-44f2-8086-61ef198dac88@collabora.com>
Date: Tue, 10 Sep 2024 18:46:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>
References: <20240906-b4-rk3588-bridge-upstream-v6-0-a3128fb103eb@collabora.com>
 <20240906-b4-rk3588-bridge-upstream-v6-2-a3128fb103eb@collabora.com>
 <3wy2aoowmh7asdymtjccuzprwfah5xornelawg5ulnzj7gyfes@www2cgfnpdsx>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <3wy2aoowmh7asdymtjccuzprwfah5xornelawg5ulnzj7gyfes@www2cgfnpdsx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 10:40 AM, Krzysztof Kozlowski wrote:
> On Fri, Sep 06, 2024 at 04:17:41AM +0300, Cristian Ciocaltea wrote:
>> Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1
>> Quad-Pixel (QP) TX controller IP.
>>
>> Since this is a new IP block, quite different from those used in the
>> previous generations of Rockchip SoCs, add a dedicated binding file.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml       | 189 +++++++++++++++++++++
>>  1 file changed, 189 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
>> new file mode 100644
>> index 000000000000..37467685621d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
> 
> ...
> 
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    minItems: 2
> 
> You can drop minItems.

Dropped in upcoming v7.

>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    items:
>> +      - const: ref
>> +      - const: hdp
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for the review,
Cristian

