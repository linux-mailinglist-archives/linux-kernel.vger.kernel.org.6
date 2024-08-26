Return-Path: <linux-kernel+bounces-300765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596A395E811
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120E42837AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F26A77119;
	Mon, 26 Aug 2024 05:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RWL7dc9d"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573C320C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651264; cv=none; b=VcxCZwg4suDzJgfq66GaNT3ab1osANxVe6dSTZ3YjUzqQV+kxmfwq/E2LYVip1P/TeLQatCt/bXD0fP3NoTnW3B0OvHKFerHmDTLu9+10aP7nszRs/QcbVv9IN1nBflulk9eCEyxg1KIo0c579GIgZrL0ZRKlYKLxoqvN00S4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651264; c=relaxed/simple;
	bh=sNN7Gi7TFWA5uui4XNiyosEuHHsstx1Zym+EVmgBXKw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bk33t0YWzHs7uKEc+Jq3w6SmTzezrlTkQWZGA3zU+OKgchQS/UUHdQebs1bfyHr8MEeO1xlqtizS/h6jhaEOsG/cnK9Ll047mnIadJKldp//yaKLAc70wfHcGrtGwLowtXaKkDOgdhdgH6L8ZoBaFzpaXCGhNGkAbCNnncSoPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RWL7dc9d; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c1afef7-fed9-4685-bf07-b9f3d44a0077@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724651258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts+B+wwMLY0gXBEyoiteKuMyTQYOutXDb9a3yKvXexU=;
	b=RWL7dc9diM7n5fSd4t/eRCeBapVC8b4VBQygRQ9X5izqRegFhOu1RQ2Luhn+29BND4U4Fh
	6HkZ16e9nYkeB13XMiLhdeRWcZJGUs9IQ52BpDq7nm7Vb92uQs/Tr74igCB55wisYDiVcx
	Ja0YmrnIoV4VxozxCZaf4DAIk29TzEQ=
Date: Mon, 26 Aug 2024 11:17:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Subject: Re: [PATCH v3 2/4] dt-bindings: display: ti: Add schema for AM625
 OLDI Transmitter
To: Krzysztof Kozlowski <krzk@kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: DRI Development List <dri-devel@lists.freedesktop.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Randolph Sapp <rs@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20240716084248.1393666-1-a-bhatia1@ti.com>
 <20240716084248.1393666-3-a-bhatia1@ti.com>
 <0144d9b4-e830-44b0-95cd-4d49d5051155@kernel.org>
Content-Language: en-US
In-Reply-To: <0144d9b4-e830-44b0-95cd-4d49d5051155@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Krzysztof,

Thank you for the reviewing the patches.


On 7/21/24 21:06, Krzysztof Kozlowski wrote:
> On 16/07/2024 10:42, Aradhya Bhatia wrote:
>> The OLDI (transmitters) TXes do not have registers of their own, and are
>> dependent on the source video-ports from the DSS to provide
>> configuration data. This hardware doesn't directly sit on the internal
>> bus of the SoC, but does so via the DSS. Hence, the OLDI TXes are
>> supposed to be child nodes under the DSS, and not independent devices.
>>
>> Two of the OLDI TXes can function in tandem to output dual-link OLDI
>> output, or cloned single-link outputs. In these cases, one OLDI will be
>> the primary OLDI, and the other one, a companion.
>>
>> The OLDI functionality is further supported by a system-control module,
>> which contains a few registers to control OLDI IO power and
>> characteristics.
>>
>> Add devicetree binding schema for AM625 OLDI TXes.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>  .../bindings/display/ti/ti,am625-oldi.yaml    | 153 ++++++++++++++++++
>>  MAINTAINERS                                   |   1 +
>>  2 files changed, 154 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
>> new file mode 100644
>> index 000000000000..0a96e600bc0b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
>> @@ -0,0 +1,153 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/ti/ti,am625-oldi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments AM625 OLDI Transmitter
>> +
>> +maintainers:
>> +  - Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> +  - Aradhya Bhatia <a-bhatia1@ti.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.

Okay!

> 
>> +  The AM625 TI Keystone OpenLDI transmitter (OLDI TX) supports serialized RGB
>> +  pixel data transmission between host and flat panel display over LVDS (Low
>> +  Voltage Differential Sampling) interface. The OLDI TX consists of 7-to-1 data
>> +  serializers, and 4-data and 1-clock LVDS outputs. It supports the LVDS output
>> +  formats "jeida-18", "jeida-24" and "vesa-18", and can accept 24-bit RGB or
>> +  padded and un-padded 18-bit RGB bus formats as input.
>> +
>> +properties:
>> +  reg:
>> +    maxItems: 1
>> +
> 
> How does it even work without compatible? How is this schema selected?
> If by part of your next patch, then this is not a proper split - this
> patch itself is noop. Squash the patches.
> 

Yes, it is supposed to be picked like the next patch does it. I can
squash these both.

>> +  clocks:
>> +    maxItems: 1
>> +    description: serial clock input for the OLDI transmitters
>> +
>> +  clock-names:
>> +    const: s_clk
> 
> Drop _clk or name it correctly.

Alright!

> 
>> +
>> +  ti,companion-oldi:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle to companion OLDI transmitter. This property is mandatory for the
>> +      primarty OLDI TX if the OLDI TXes are expected to work either in dual-lvds
>> +      mode or in clone mode. This property should point to the secondary OLDI
>> +      TX.
>> +
>> +  ti,secondary-oldi:
>> +    type: boolean
>> +    description: Boolean property to mark an OLDI TX as secondary node.
> 
> Why? Lack companion tells it, doesn't it?

A lack of companion doesn't mean secondary-OLDI automatically, actually.

There is also a possible configuration where 2 OLDI TXes could be
individually connected to 2 different sources => 2x single Link
configuration. The OLDI TXes would then work independently.

> 
>> +
>> +  ti,oldi-io-ctrl:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle to syscon device node mapping OLDI IO_CTRL registers found in the
>> +      control MMR region. This property is needed for OLDI interface to work.
> 
> "This property is needed for OLDI interface to work." tells nothing.
> Everything is needed for everything to work. Be specific.
> 

Yes! Will fix this.

>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: Parallel RGB input port
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: LVDS output port
>> +
>> +    required:
>> +      - port@0
>> +      - port@1
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        ti,secondary-oldi: true
> 
> This does not work... Test your schema.
> 

I tested again just now. At least the schema check didn't report any
error. I used the v2024.05 dtschema too.

This github gist[0] captures all details of this test.

Could you instead please elaborate what maybe wrong here, and I will try
to fix that.


>> +    then:
>> +      properties:
>> +        ti,companion-oldi: false
>> +        ti,oldi-io-ctrl: false
>> +        clocks: false
>> +        clock-names: false
>> +
>> +    else:
>> +      required:
>> +        - ti,oldi-io-ctrl
>> +        - clocks
>> +        - clock-names
>> +
>> +required:
>> +  - reg
>> +  - ports
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +
>> +    oldi_txes {
> 
> No underscores in node names.
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Right. Will make the name generic.

> 
> 
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        oldi: oldi@0 {
> What is the "reg" for?

The reg is for indexing purposes so that the driver can distinguish
between which OLDI TX is under question. Since, the syscon controller
has different power control registers and bits for different OLDIs - its
important for the driver to be able to tell one from another.


Regards
Aradhya


[0]: Github Gist of schema testing for patch 2/4.
https://gist.github.com/aradhya07/e3776cb10ee64c33405db5609cbd2e4f

