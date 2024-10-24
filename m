Return-Path: <linux-kernel+bounces-379393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2089ADE14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1418F282B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E306E1B0F00;
	Thu, 24 Oct 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hWSXuUVS"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D761AB534;
	Thu, 24 Oct 2024 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755876; cv=none; b=GTyo+mS6L5OpyRQbzuQy6vsruEWPRl0aLuCXkPG1lIfcS/7D0zYeUTDrbkoUfbUdze5MuAUWnFyxjjW671n56CZRLKfCs/ZZJAzoXVvZI8QWEp6IAP3Ld7mKERmfG0PSyaN8zBen5Xw9LxeAM8wcKmvGY5Ko6ZL8OovgnPAXnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755876; c=relaxed/simple;
	bh=kg0iUw0jqqI7Chkdg9+6IfjH1xU4IdZnk+pdgXqmukM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oqVTTmIxQ5TsbdPA9vRN4BJsj3+SNZwhRBCjYGBlAJSrRvTfO9XinSlJP4hbz+RcvJWcgrBQDHVcOGvQxdaWM3Lco3DRGu5iHuhBGQStULT/FjRb0rz0NyvHavmOAIe+84zqF9As4mItUGHzAItNraC0fMHM/K1L3WBIwJgVVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hWSXuUVS; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c8b00f6491db11efb88477ffae1fc7a5-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=TvKw24EE97lM/kTvcvxcr9KfOF+59mbqxyxMxCjR1Go=;
	b=hWSXuUVSwmXfDsFJEZId7lP5ahbHJ+EWfbJ12K7EwxSxup8oTCM+EcQB1rlNcKn8igg+7Awjzj4WgqBYj8QdpB5MaRqkoUdtdKijy4SQyZ5fO4/3aOMHdhY/AhkvL3XQfyVY3oyQEwG6nDfUUJ+vwXkGQB8D1V3oXFwqU/h1VJs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:21d12564-0154-4d71-b8eb-8efeb31bb64a,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:b0fcdc3,CLOUDID:bbb1092e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c8b00f6491db11efb88477ffae1fc7a5-20241024
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1042055863; Thu, 24 Oct 2024 15:44:22 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 15:44:20 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 24 Oct 2024 15:44:18 +0800
Message-ID: <60b490d2-30a1-dbff-36c4-992466991d49@mediatek.com>
Date: Thu, 24 Oct 2024 15:44:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-usb@vger.kernel.org>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	Fabien Parent <fparent@baylibre.com>, Yow-Shin Liou
	<yow-shin.liou@mediatek.com>, Simon Sun <simon.sun@yunjingtech.com>
References: <20241023080912.15349-1-macpaul.lin@mediatek.com>
 <c4b5e78e-5337-464c-9dca-9d4e5353cc46@collabora.com>
 <ba44b369-bcd7-4226-b75a-f3c5000e97ec@collabora.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <ba44b369-bcd7-4226-b75a-f3c5000e97ec@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.159300-8.000000
X-TMASE-MatchedRID: oll/cJ/dUC4NtKv7cnNXnSa1MaKuob8PofZV/2Xa0cLBs8kDsMW7w0Cp
	tC5f+eK3PiZe9Opl14NpkFK+Hcv8l4IUMFCMs+CvElgo9H5DnJy2McZY43zJ43TcYDPnhOj7Vr2
	x2Dan2cBuP3qLppM0WGROSk6C4bqV9QpB8/MBSuPuykw7cfAoIEyQ5fRSh265cPDElbD+F/INir
	voD95MYvgnZCOkc4Rc+SFdp+Cd0PefT/zxNL8LPgs9VkfCh3uAyeUl7aCTy8gNmPMcsvd5FkX+w
	eP9mWX+BSECuGLGA17u5ezEA2FHU1d9anLxZbwb04Rmz/agfdxzd7C7BtJobg2G3vz8l/IEem0L
	3kwJxTdX3sD7vCUiwQDzRES7L9pfm3dhKZgH9Y5IcJTn2HkqsZWr6iSXWtgPYz65TQfoDKtTIBW
	jwoscFLHuwtg/JZZi5LrNEBlqCSgTJYL1KomVHwz4VsCc1YW+B4Ntzrj5dXQVTtVbQNElqhWMB5
	o7Iv3SuyWVW34zvS68nGYNSACIpta/jIZoZyKFMN+B8zdlz9HKG6mjA3qUTFHpIy6wt5Uw2PdmZ
	euCYyDHwxZ5smB8PNO0PJ8nvnJZrxpSystEXJLMrZu+Xb3+2UZAbph9cvetYe1mzp7dkwf3a1M/
	dirxUFTPGzyxkQRkFebgClkGNp4piQbfusdLxYa7OiQBC9buCt59Uh3p/NUGW3hFnC9N1feYA0u
	vygK3ISf7n2qaXhJftuJwrFEhTbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.159300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CEEF0D44068983702D6529708423EBC94BA24C18764B8C54F24D729610596DC82000:8



On 10/23/24 20:00, AngeloGioacchino Del Regno wrote:
> Il 23/10/24 13:07, AngeloGioacchino Del Regno ha scritto:
>> Il 23/10/24 10:09, Macpaul Lin ha scritto:
>>> From: Fabien Parent <fparent@baylibre.com>
>>>
>>> Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
>>> configuration for TCPC Port, USB-C connector, and related settings.
>>>
>>> Configure dual role switch capability, set up PD (Power Delivery) 
>>> profiles,
>>> and establish endpoints for SSUSB (SuperSpeed USB).
>>>
>>> Update pinctrl configurations for U3 P0 VBus default pins and set 
>>> dr_mode
>>> to "otg" for OTG (On-The-Go) mode operation.
>>>
>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>> Signed-off-by: Yow-Shin Liou <yow-shin.liou@mediatek.com>
>>> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> ---
>>>   .../dts/mediatek/mt8395-genio-1200-evk.dts    | 54 +++++++++++++++++++
>>>   1 file changed, 54 insertions(+)
>>>
>>> Changes for v2:
>>>   - Drop the no need '1/2' DT Schema update patch in the 1st version.
>>>   - Fix intent for 'ports' node, it should under the 'connector' node.
>>>   - Correct the index for 'port@0' and 'port@1' node.
>>>
>>> Changes for v3:
>>>   - Correct the order between new added nodes.
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts 
>>> b/arch/arm64/ boot/dts/mediatek/mt8395-genio-1200-evk.dts
>>> index 5f16fb820580..83d520226302 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>>> @@ -335,6 +335,43 @@ mt6360_ldo7: ldo7 {
>>>                   regulator-always-on;
>>>               };
>>>           };
>>> +
>>> +        tcpc {
>>> +            compatible = "mediatek,mt6360-tcpc";
>>> +            interrupts-extended = <&pio 17 IRQ_TYPE_LEVEL_LOW>;
>>> +            interrupt-names = "PD_IRQB";
>>> +
>>> +            connector {
>>> +                compatible = "usb-c-connector";
>>> +                label = "USB-C";
>>> +                data-role = "dual";
>>
>> op-sink-microwatt goes here

Okay, will fix it.

>>> +                power-role = "dual";
>>> +                try-power-role = "sink";
>>> +                source-pdos = <PDO_FIXED(5000, 1000, \
>>> +                           PDO_FIXED_DUAL_ROLE | \
>>> +                           PDO_FIXED_DATA_SWAP)>;
>>
>> Please fix the indentation (and also you don't need the escaping)

Okay, it has been complained by checkpatch about this line is too long.
Will fix it in next version.

>>                  source-pdos = <PDO_FIXED(5000, 1000,
>>                               PDO_FIXED_DUAL_ROLE |
>>                               PDO_FIXED_DATA_SWAP)>;
>>
>>> +                sink-pdos = <PDO_FIXED(5000, 2000, \
>>> +                         PDO_FIXED_DUAL_ROLE | \
>>> +                         PDO_FIXED_DATA_SWAP)>;
>>> +                op-sink-microwatt = <10000000>;
>>> +
>>> +                ports {
>>> +                    #address-cells = <1>;
>>> +                    #size-cells = <0>;
>>> +
>>> +                    port@0 {
>>> +                        reg = <0>;
>>
>> Just to make sure that this is ok: are you sure that this port supports
>> SuperSpeed (physical connector too) and that it's not limited to 
>> HighSpeed?

This port should be able to do both HighSpeed and SuperSpeed.
However our internal reference code set SuperSpeed at port@0 and seems
just work for both high and supoer speeds.
See more detail discussion below.

>>
>> I have seen Rob's comment stating that ssusb_ep goes to port@1, but I 
>> think
>> that his comment came after reading "ss" in "ssusb": while the controller
>> does surely support SS, if the port does not, this should still go to 
>> port@0.
>>
>> P.S.: I didn't check the schematics - just please make sure it's 
>> correct, and
>>        that this actually works.
>>
> Sorry for the double email, but I've done some fast research on this as 
> something
> came to mind right after sending this review.
> 
> usb-connector.yaml says that the `ports` property models a data bus to 
> the USB
> connector, and that a single connector can have multiple data buses, of 
> course.
> 
> The last statement doesn't come as a surprise, and actually makes me 
> think about
> what MTU3 actually provides: a High Speed data bus, and a SuperSpeed 
> data bus.

Ya. That's the question I was wondering, too.
Current DT bindings of MTU3 support only 1 port which is also a required
property. For the SSUSB0 port on MT8195, it indeed provides a High Speed
data bus, and a SuperSpeed data bus.

> Now, I see in MTU3 that only `port` is allowed and that only the HS part is
> is exposed... so to resolve this, you want to add a binding to connect the
> data bus of the MTU3 controller to the usb-c-connector, and obviously 
> only then
> you should use it here.
> 
> That should look like this:
> 
> mediatek,mtu3.yaml:
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> 
>      properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: High Speed (HS) data bus.
> 
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: Super Speed (SS) data bus.
> 
> some_devicetree.dts
> &ssusb0 {
>      ports {
>          port@0 {
>              reg = <0>;
> 
>              /* High Speed data bus */
>              mtu3_hs0_ep: endpoint {
>                  /* connects to port@0 (HS) of usb-c-connector */
>                  remote-endpoint = <&typec_con_hs>;
>              }
>          };
> 
>          port@1 {
>              reg = <1>;
> 
>              /* SuperSpeed data bus */
>              mtu3_ss0_ep: endpoint {
>                  /* connects to port@1 (SS) of usb-c-connector */
>                  remote-endpoint = <&typec_con_sss>;
>              }
>          };
>      };
> };

Sure, but after adding that DT schema before the v3 patch has been send.
The dt_binding_check seems show 'port' is a required property for MTU3.
However I didn't found where it has been defined.
I think to add the 'ports' property in MTU3's DT Schema should be better.

> I don't have time to do any testing in this precise moment, so, if you want
> to go on and test - cool; otherwise, I can check that at a later time, but
> on Genio 700 EVK instead (which is the same thing for this specific 
> topic anyway).
> 
> Cheers,
> Angelo
> 
>>> +                    };
>>> +
>>> +                    port@1 {
>>> +                        reg = <1>;
>>> +                        mt6360_ssusb_ep: endpoint {
>>> +                            remote-endpoint = <&ssusb_ep>;
>>> +                        };
>>> +                    };
>>> +                };
>>> +            };
>>> +        };
>>>       };
>>>   };
>>> @@ -770,6 +807,13 @@ pins-reset {
>>>           };
>>>       };
>>> +    u3_p0_vbus: u3-p0-vbus-default-pins {
>>> +        pins-cmd-dat {
>>
>> That's not a command nor data pin.

Oh! Will fix it.

>> pins-vbus {
>>
>>> +            pinmux = <PINMUX_GPIO63__FUNC_VBUSVALID>;
>>> +            input-enable;
>>> +        };
>>> +    };
>>> +
>>>       uart0_pins: uart0-pins {
>>>           pins {
>>>               pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
>>> @@ -900,8 +944,18 @@ &ufsphy {
>>>   };
>>>   &ssusb0 {
>>> +    dr_mode = "otg";
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&u3_p0_vbus>;
>>
>> Is this port usb host by default? If it is:
>>
>>      role-switch-default-mode = "host";

This port0 is exactly a dual-role port for genio-1200-evk.
It is usually used as gadget device port (like ADB) and
sometimes can do OTG function with xhci0.

>> Cheers,
>> Angelo
>>
>>> +    usb-role-switch;
>>>       vusb33-supply = <&mt6359_vusb_ldo_reg>;
>>>       status = "okay";
>>> +
>>> +    port {
>>> +        ssusb_ep: endpoint {
>>> +            remote-endpoint = <&mt6360_ssusb_ep>;
>>> +        };
>>> +    };
>>>   };
>>>   &ssusb2 {
>>

Thanks
Macpaul Lin

