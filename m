Return-Path: <linux-kernel+bounces-377984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6569AC988
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734A61F223B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9051AB6FF;
	Wed, 23 Oct 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gBRLw9kT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B61A00FA;
	Wed, 23 Oct 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684810; cv=none; b=LwdWciCR6I84KwXjRI1eKbQZgYxMs974nxj/ybh4Hpd+HRsiASut4Bt5BcDqsEK481/AoRukhwbaH+jHu/ZWXMltq9OrQRRPC3BYg6xFD8WyBsZRmzaPn1kmWgUeXtfEFmE1pN6xRvxtyP+bt6c8snNNbbncvTwC5pAX1V32pPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684810; c=relaxed/simple;
	bh=YsnnC89A5gG5taNxdFfwRDiDUBabJ4GU+8bvLB1ZD5w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I9cKnLmh7OwY7jdJJhfT/ZqlX1sW0Z671mzohTVwde4sUo5KPAyA/hmNsa2ZiimQMXL/yhba8hmTgz7ckEptM+X45hzT/8sPnTCtNVkFGuJSv7Pzs+NVKaaDEzg0vz1Edm1PxeMYd2FNVQWF1g1M31cZSOE/UF/JRA5CvYyvpmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gBRLw9kT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729684806;
	bh=YsnnC89A5gG5taNxdFfwRDiDUBabJ4GU+8bvLB1ZD5w=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=gBRLw9kTv3fziHc4h4k7qEYeu32mlEZA3U2um/eMRnzaPDOpJphDgjsxQJAm1YnP7
	 +qUt67lE490Sf+5TnsmmXnhqXBr+5IAAgAD00FKkt3s9ql15JkAwB+c10Hds08IDpB
	 GckUsF1kjzDi90yhjBd0VhQ36+gegDAKWwghmKltkQ+KwApmruRYM6ku2PGYZRAE1Q
	 LniEC8VL+oQYdBL4xRCNZqrn/NfHazBGWS6D2mUHYYLyoq4hchC4YZ0jOYJx7m2kB8
	 ZrHGDjV8B+vCmSOXcnLZYSZxbOKJK4buIafzPNN9Gtlw6RH89PLYELEGW181S5jANi
	 bVecgYavEdT6Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5669517E35E9;
	Wed, 23 Oct 2024 14:00:05 +0200 (CEST)
Message-ID: <ba44b369-bcd7-4226-b75a-f3c5000e97ec@collabora.com>
Date: Wed, 23 Oct 2024 14:00:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-usb@vger.kernel.org, Chris-qj chen <chris-qj.chen@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>,
 Yow-Shin Liou <yow-shin.liou@mediatek.com>,
 Simon Sun <simon.sun@yunjingtech.com>
References: <20241023080912.15349-1-macpaul.lin@mediatek.com>
 <c4b5e78e-5337-464c-9dca-9d4e5353cc46@collabora.com>
Content-Language: en-US
In-Reply-To: <c4b5e78e-5337-464c-9dca-9d4e5353cc46@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/10/24 13:07, AngeloGioacchino Del Regno ha scritto:
> Il 23/10/24 10:09, Macpaul Lin ha scritto:
>> From: Fabien Parent <fparent@baylibre.com>
>>
>> Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
>> configuration for TCPC Port, USB-C connector, and related settings.
>>
>> Configure dual role switch capability, set up PD (Power Delivery) profiles,
>> and establish endpoints for SSUSB (SuperSpeed USB).
>>
>> Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
>> to "otg" for OTG (On-The-Go) mode operation.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Yow-Shin Liou <yow-shin.liou@mediatek.com>
>> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   .../dts/mediatek/mt8395-genio-1200-evk.dts    | 54 +++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> Changes for v2:
>>   - Drop the no need '1/2' DT Schema update patch in the 1st version.
>>   - Fix intent for 'ports' node, it should under the 'connector' node.
>>   - Correct the index for 'port@0' and 'port@1' node.
>>
>> Changes for v3:
>>   - Correct the order between new added nodes.
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/ 
>> boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> index 5f16fb820580..83d520226302 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> @@ -335,6 +335,43 @@ mt6360_ldo7: ldo7 {
>>                   regulator-always-on;
>>               };
>>           };
>> +
>> +        tcpc {
>> +            compatible = "mediatek,mt6360-tcpc";
>> +            interrupts-extended = <&pio 17 IRQ_TYPE_LEVEL_LOW>;
>> +            interrupt-names = "PD_IRQB";
>> +
>> +            connector {
>> +                compatible = "usb-c-connector";
>> +                label = "USB-C";
>> +                data-role = "dual";
> 
> op-sink-microwatt goes here
> 
>> +                power-role = "dual";
>> +                try-power-role = "sink";
>> +                source-pdos = <PDO_FIXED(5000, 1000, \
>> +                           PDO_FIXED_DUAL_ROLE | \
>> +                           PDO_FIXED_DATA_SWAP)>;
> 
> Please fix the indentation (and also you don't need the escaping)
> 
>                  source-pdos = <PDO_FIXED(5000, 1000,
>                               PDO_FIXED_DUAL_ROLE |
>                               PDO_FIXED_DATA_SWAP)>;
> 
>> +                sink-pdos = <PDO_FIXED(5000, 2000, \
>> +                         PDO_FIXED_DUAL_ROLE | \
>> +                         PDO_FIXED_DATA_SWAP)>;
>> +                op-sink-microwatt = <10000000>;
>> +
>> +                ports {
>> +                    #address-cells = <1>;
>> +                    #size-cells = <0>;
>> +
>> +                    port@0 {
>> +                        reg = <0>;
> 
> Just to make sure that this is ok: are you sure that this port supports
> SuperSpeed (physical connector too) and that it's not limited to HighSpeed?
> 
> I have seen Rob's comment stating that ssusb_ep goes to port@1, but I think
> that his comment came after reading "ss" in "ssusb": while the controller
> does surely support SS, if the port does not, this should still go to port@0.
> 
> P.S.: I didn't check the schematics - just please make sure it's correct, and
>        that this actually works.
> 

Sorry for the double email, but I've done some fast research on this as something
came to mind right after sending this review.

usb-connector.yaml says that the `ports` property models a data bus to the USB
connector, and that a single connector can have multiple data buses, of course.

The last statement doesn't come as a surprise, and actually makes me think about
what MTU3 actually provides: a High Speed data bus, and a SuperSpeed data bus.

Now, I see in MTU3 that only `port` is allowed and that only the HS part is
is exposed... so to resolve this, you want to add a binding to connect the
data bus of the MTU3 controller to the usb-c-connector, and obviously only then
you should use it here.

That should look like this:

mediatek,mtu3.yaml:
   ports:
     $ref: /schemas/graph.yaml#/properties/ports

     properties:
       port@0:
         $ref: /schemas/graph.yaml#/properties/port
         description: High Speed (HS) data bus.

       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description: Super Speed (SS) data bus.

some_devicetree.dts
&ssusb0 {
	ports {
		port@0 {
			reg = <0>;

			/* High Speed data bus */
			mtu3_hs0_ep: endpoint {
				/* connects to port@0 (HS) of usb-c-connector */
				remote-endpoint = <&typec_con_hs>;
			}
		};

		port@1 {
			reg = <1>;

			/* SuperSpeed data bus */
			mtu3_ss0_ep: endpoint {
				/* connects to port@1 (SS) of usb-c-connector */
				remote-endpoint = <&typec_con_sss>;
			}
		};
	};
};

I don't have time to do any testing in this precise moment, so, if you want
to go on and test - cool; otherwise, I can check that at a later time, but
on Genio 700 EVK instead (which is the same thing for this specific topic anyway).

Cheers,
Angelo

>> +                    };
>> +
>> +                    port@1 {
>> +                        reg = <1>;
>> +                        mt6360_ssusb_ep: endpoint {
>> +                            remote-endpoint = <&ssusb_ep>;
>> +                        };
>> +                    };
>> +                };
>> +            };
>> +        };
>>       };
>>   };
>> @@ -770,6 +807,13 @@ pins-reset {
>>           };
>>       };
>> +    u3_p0_vbus: u3-p0-vbus-default-pins {
>> +        pins-cmd-dat {
> 
> That's not a command nor data pin.
> 
> pins-vbus {
> 
>> +            pinmux = <PINMUX_GPIO63__FUNC_VBUSVALID>;
>> +            input-enable;
>> +        };
>> +    };
>> +
>>       uart0_pins: uart0-pins {
>>           pins {
>>               pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
>> @@ -900,8 +944,18 @@ &ufsphy {
>>   };
>>   &ssusb0 {
>> +    dr_mode = "otg";
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&u3_p0_vbus>;
> 
> Is this port usb host by default? If it is:
> 
>      role-switch-default-mode = "host";
> 
> Cheers,
> Angelo
> 
>> +    usb-role-switch;
>>       vusb33-supply = <&mt6359_vusb_ldo_reg>;
>>       status = "okay";
>> +
>> +    port {
>> +        ssusb_ep: endpoint {
>> +            remote-endpoint = <&mt6360_ssusb_ep>;
>> +        };
>> +    };
>>   };
>>   &ssusb2 {
> 



