Return-Path: <linux-kernel+bounces-183630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71BC8C9BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE27280C40
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F850524DC;
	Mon, 20 May 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I/oDXq0u"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B7182DF;
	Mon, 20 May 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202413; cv=none; b=MrzsPeCnCye/Hs6Wnyj9Nedh1lriIK5toLSBaFmWvzChJM3oIh3UBAlof69YjS2SXWiaSBbCIirnZhkj+vwbWKizCbWxwDFpzTRduP1eEJ3uBC1m/4T84Q0jM+AKoa3+VaCv+WdxGHtZ9P5Bn2ihJEMdp7AnaP90NX4se1kiixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202413; c=relaxed/simple;
	bh=WQTGyraacCkp953Pb1xBtyAnVlrhrQtJheAU+E27X1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAoE/n9CwWg8sMFymhwg9pyDxMfioerKE2EQ7lbzpneTzAG9cJbnVQU5csVkBwsKuTNyMr1+lIz2sYJ/xrL7oy/PwCMg3JDmRP4fLkHNQ5nkcX/zmWMqW1LoO5z6hI1+0S6fPMjy1uY6I5/Ai+y0vh1DQoQc5bv/rvDs0adVWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I/oDXq0u; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716202409;
	bh=WQTGyraacCkp953Pb1xBtyAnVlrhrQtJheAU+E27X1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I/oDXq0uYxlX0E45oaELAZ8sisGTPoVZ3frcYvoOquOWHQAETecxFN6l6jY4sXCAy
	 z3HoFWVsDY55Je+68wcfuHbs5kbUGDm5rwngyQHkFaCTDvQBD0sAVWg7Jjv+PuWH3O
	 8PnoA4MUreTvXn5K3DFvZguFmCjNQZbRxj/A54XQcboL2eNm3UCSPgZUqbB64J98rH
	 kD/NmLNPr1/k1tHPTkOfWKE+sjMzO83jq0HeKUdZ9jOIgwoV+YnqgdCo6MeKMmeYTA
	 BMlLNvwp5paeRUbn3H6qcNxoUPYt0CT9BsO7VpAgjck0DA8S7nPmpu15tE6aTa+EZI
	 8eqQ5BnV4mBdg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7A90C37821B2;
	Mon, 20 May 2024 10:53:28 +0000 (UTC)
Message-ID: <7dbe08cf-47a1-4da6-9035-6b0932cf8426@collabora.com>
Date: Mon, 20 May 2024 12:53:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
To: Alexandre Mergnat <amergnat@baylibre.com>, chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240516081104.83458-1-angelogioacchino.delregno@collabora.com>
 <20240516081104.83458-3-angelogioacchino.delregno@collabora.com>
 <ce1de395-3f60-4f7f-9424-bf036134de94@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ce1de395-3f60-4f7f-9424-bf036134de94@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 19/05/24 19:18, Alexandre Mergnat ha scritto:
> Hi Angelo,
> 
> On 16/05/2024 10:11, AngeloGioacchino Del Regno wrote:
>> +    oneOf:
>> +      - required:
>> +          - endpoint@0
>> +      - required:
>> +          - endpoint@1
>> +      - required:
>> +          - endpoint@2
> 
> I'm not sure this is what you expect because I must remove this part to pass the 
> dt-validate.
> 
> I have 2 possible display at the same time (DSI and DPI), then I add this in my DTSI:
> 
>          mmsys: syscon@14000000 {
>              compatible = "mediatek,mt8365-mmsys", "syscon";
>              reg = <0 0x14000000 0 0x1000>;
>              #clock-cells = <1>;
>              port {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
> 
>                  mmsys_main: endpoint@0 {
>                      reg = <0>;
>                      remote-endpoint = <&ovl0_in>;
>                  };
>                  mmsys_ext: endpoint@1 {
>                      reg = <1>;
>                      remote-endpoint = <&rdma1_in>;
>                  };
>              };
>          };
> 
> But the DTS check returns me an error:
> 
> dt-validate -s Documentation/devicetree/bindings 
> arch/arm64/boot/dts/mediatek/mt8365-evk.dtb
> /home/*******/linux-upstream/arch/arm64/boot/dts/mediatek/mt8365-evk.dtb: 
> syscon@14000000: port: More than one condition true in oneOf schema:
>          {'$ref': '/schemas/graph.yaml#/properties/port',
>           'oneOf': [{'required': ['endpoint@0']},
>                     {'required': ['endpoint@1']},
>                     {'required': ['endpoint@2']}],
>           'properties': {'endpoint@0': {'$ref': 
> '/schemas/graph.yaml#/properties/endpoint'},
>                          'endpoint@1': {'$ref': 
> '/schemas/graph.yaml#/properties/endpoint'},
>                          'endpoint@2': {'$ref': 
> '/schemas/graph.yaml#/properties/endpoint'}}}
>          from schema $id: 
> http://devicetree.org/schemas/arm/mediatek/mediatek,mmsys.yaml#
> 
> 
> In other hand, if I use "ports" to keep only one endpoint for each port:
> 
>          mmsys: syscon@14000000 {
>              compatible = "mediatek,mt8365-mmsys", "syscon";
>              reg = <0 0x14000000 0 0x1000>;
>              #clock-cells = <1>;
>              ports {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
> 
>                  port@0 {
>                      #address-cells = <1>;
>                      #size-cells = <0>;
>                      reg = <0>;
>                      mmsys_main: endpoint@0 {
>                          reg = <0>;
>                          remote-endpoint = <&ovl0_in>;
>                      };
>                  };
> 
>                  port@1 {
>                      #address-cells = <1>;
>                      #size-cells = <0>;
>                      reg = <1>;
>                      mmsys_ext: endpoint@1 {
>                          reg = <1>;
>                          remote-endpoint = <&rdma1_in>;
>                      };
>                  };
>              };
>          };
> 
> The DTS check returns another error:
> 
> dt-validate -s Documentation/devicetree/bindings 
> arch/arm64/boot/dts/mediatek/mt8365-evk.dtb
> /home/*******/linux-upstream/arch/arm64/boot/dts/mediatek/mt8365-evk.dtb: 
> syscon@14000000: 'ports' does not match any of the regexes: 'pinctrl-[0-9]+'
>          from schema $id: 
> http://devicetree.org/schemas/arm/mediatek/mediatek,mmsys.yaml#
> 
> Additionally, with the last DTS example, displays aren't working, probably because 
> "ports" isn't well parsed.
> 
> So, I don't know how you want to manage multiple display, but IMHO there are 2 ways:
> - removing the current "oneOf".

..eh I think this should be anyOf instead :-)

I'll check later and send a v5.

Cheers,
Angelo

> - adding the "ports" support in the documentation and driver (to be parsed).
> 
> Still possible I missed something and I doing shit :)
> 



