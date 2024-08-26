Return-Path: <linux-kernel+bounces-300916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADBA95EA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE0C1C20BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A5136671;
	Mon, 26 Aug 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e1LbLJrg"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8B82490;
	Mon, 26 Aug 2024 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657560; cv=none; b=quZILRj/VlwWl/r/1Ev2EdDTTb9kJOukSyG82R/PJAew4Bck6TaiqVmuPJyE1fr9JTEwah04v0nBzB5pfQUd4gD8eZpLWOYq8A4pwhR+UVOiaE8lj3oNa9u6sISdJmZc9XhzGewG3PkucEsBpfbof7AnHDLHd7doRpTToZ+j0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657560; c=relaxed/simple;
	bh=a+CpVZgGiTL8JhtFV1PU7HeO6EwxdOWGSDK5dPwAiDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oja6Igc2FBddTQUFQezW3xiPz5F4p4qxZURV70lUpWeDvhe+zPEBpttcCjIcI0kvrWFwAu14edu/ygkUREahHQhrkumiaAu72adBeXBZ4bbNsfAi1noWWFz6Q9gdw8YWR+htsWNDvHIPqDcZzIJjvaZW9DlnglNUyq/kOIQk4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e1LbLJrg; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73f033cb-d890-426d-8b1a-f9c56456961d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724657555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGdrGxQwgoxsXhspyMbG8l2ZGZETxRuwcMDsFiaAMqE=;
	b=e1LbLJrgwyrIS1FKWYpzuMPFCPJ7RILGWqg5nk65MwWlhLaQ0Sr5uvirxiI+GVuOcceIrs
	nmGUEAuRqnuhqMhEgJTBB3bpBKH4Oducv/Ei5SR86ulY0ylBewDT8BKqM3Z1BF0GjDlEcN
	b6vbYAbXrC1CF9j6kEsP0hcNDKs/2AY=
Date: Mon, 26 Aug 2024 13:02:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/4] dt-bindings: display: ti,am65x-dss: Add OLDI
 properties for AM625 DSS
To: Krzysztof Kozlowski <krzk@kernel.org>,
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
 <20240716084248.1393666-4-a-bhatia1@ti.com>
 <93844c97-46b7-48bd-9397-2bbba9c09510@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <93844c97-46b7-48bd-9397-2bbba9c09510@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Krzysztof,


On 7/21/24 21:09, Krzysztof Kozlowski wrote:
> On 16/07/2024 10:42, Aradhya Bhatia wrote:
>> The DSS in AM625 SoC has 2 OLDI TXes. Refer the OLDI schema to add the
>> support for the OLDI TXes.
>>
>> The AM625 DSS VP1 (port@0) can connect and control 2 OLDI TXes, to use
>> them in dual-link or cloned single-link OLDI modes. Add support for an
>> additional endpoint under the port@0 to accurately depict the data flow
>> path.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>  .../bindings/display/ti/ti,am65x-dss.yaml     | 135 ++++++++++++++++++
>>  1 file changed, 135 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> index 399d68986326..249597455d34 100644
>> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> @@ -91,6 +91,24 @@ properties:
>>            For AM625 DSS, the internal DPI output port node from video
>>            port 1.
>>            For AM62A7 DSS, the port is tied off inside the SoC.
>> +        properties:
>> +          endpoint@0:
>> +            $ref: /schemas/graph.yaml#/properties/endpoint
>> +            description:
>> +              For AM625 DSS, VP Connection to OLDI0.
>> +              For AM65X DSS, OLDI output from the SoC.
>> +
>> +          endpoint@1:
>> +            $ref: /schemas/graph.yaml#/properties/endpoint
>> +            description:
>> +              For AM625 DSS, VP Connection to OLDI1.
> 
> Eh, that's confusing. Why do you have graph to your children? Isn't this
> entirely pointless?

I am not sure I fully understand. The same display source video port can
connect up to 2 OLDI TXes - hence 2 endpoints which connect to the OLDI
that were described in the previous patch. The idea has been to
accurately depict the connections of the hardware.

What am I missing here?


side-note: I do realize, as I write this, that it has been quite a while
since you reviewed, and that you may have, rightfully, lost context.
I apologize for that.

> 
>> +
>> +        anyOf:
>> +          - required:
>> +              - endpoint
>> +          - required:
>> +              - endpoint@0
>> +              - endpoint@1
>>  
>>        port@1:
>>          $ref: /schemas/graph.yaml#/properties/port
>> @@ -112,6 +130,23 @@ properties:
>>        Input memory (from main memory to dispc) bandwidth limit in
>>        bytes per second
>>  
>> +  oldi-txes:
>> +    type: object
>> +    additionalProperties: true
> 
> Why? This looks wrong.

This, I will admit, was a shot in the dark. The binding check asked me
that I was missing either this or unevaluatedProperties. I tried to make
sense of the two, but with little luck. Eventually, I went with this.

I could change it to unevaluatedProperties if that is indeed correct. I
could also use some comprehensive resource to understand this, if you
have something to recommend. =)

> 
>> +    properties:
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 0
>> +
>> +    patternProperties:
>> +      '^oldi_tx@[0-1]$':
> 
> Please follow DTS coding style for naming.

Okay!

> 
>> +        type: object
>> +        $ref: ti,am625-oldi.yaml#
>> +        unevaluatedProperties: false
>> +        description: OLDI transmitters connected to the DSS VPs
>> +
>>  allOf:
>>    - if:
>>        properties:
>> @@ -123,6 +158,19 @@ allOf:
>>          ports:
>>            properties:
>>              port@0: false
>> +            oldi_txes: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: ti,am65x-dss
>> +    then:
>> +      properties:
>> +        oldi_txes: false
>> +        port@0:
>> +          properties:
>> +            endpoint@1: false
>>  
>>  required:
>>    - compatible
>> @@ -171,3 +219,90 @@ examples:
>>              };
>>          };
>>      };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +
>> +    bus {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        dss1: dss@30200000 {
>> +            compatible = "ti,am625-dss";
>> +            reg = <0x00 0x30200000 0x00 0x1000>, /* common */
>> +                  <0x00 0x30202000 0x00 0x1000>, /* vidl1 */
>> +                  <0x00 0x30206000 0x00 0x1000>, /* vid */
>> +                  <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
>> +                  <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
>> +                  <0x00 0x3020a000 0x00 0x1000>, /* vp1 */
>> +                  <0x00 0x3020b000 0x00 0x1000>, /* vp2 */
>> +                  <0x00 0x30201000 0x00 0x1000>; /* common1 */
>> +            reg-names = "common", "vidl1", "vid",
>> +                        "ovr1", "ovr2", "vp1", "vp2", "common1";
>> +            power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
>> +            clocks =        <&k3_clks 186 6>,
>> +                            <&vp1_clock>,
>> +                            <&k3_clks 186 2>;
>> +            clock-names = "fck", "vp1", "vp2";
>> +            interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
>> +            oldi-txes {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                oldi0: oldi@0 {
> 
> You are duplicating the example from previous schema. No need. Keep
> only, one complete example.

Sure!


Regards
Aradhya

