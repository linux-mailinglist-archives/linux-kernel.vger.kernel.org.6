Return-Path: <linux-kernel+bounces-377528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228A9AC014
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1FB281D16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B223153BD7;
	Wed, 23 Oct 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u82jhDzQ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12A145B0B;
	Wed, 23 Oct 2024 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668002; cv=none; b=aXAPOucWwd6thwXiO9cYoTzhmB2GND3Ql8Mngm3Cttsi9t+Rkj9hrRmn1gw4iEjGTTEbIfQG9VXlJYoFBXGFqFbiPVut+ju+XVXxJ5BiPNWXAaEG7eEAl7xWMHSmi2uZZ7Ytk4gesepD4Ptp3P/JruEdeS4BaQE4SWzC59XzUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668002; c=relaxed/simple;
	bh=W5/8zUzhBSXkmFa+iPt1HdRhskdX6rnozZGjUR2YwoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hlv/tEA7km7hwuwZrTtApIsqP7X2EY882ebnTegaQaIj/MS5aoBAiBEr4RHZo92NAxsCt3XdGU0FAkcgypcZUwATzcCc4vWxKZJiH93zzT9s9HzeYAzQDY1ofWj8OLDsZTXfuWFjCNPUM5RXhTR6LEMyNcBNU7TYQ+VpaW/lu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=u82jhDzQ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2da889a0910f11efb88477ffae1fc7a5-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=jhHEEh0SNtmeYF/HiL8jMitAzbQi3ryoKk6ZYK6HnO8=;
	b=u82jhDzQVKVgdv4PJhwPUT+6y8OxI7wGCcWvmCebdfDeUEKVoD4A3KseoQmwFUYw+p/JVQsxpP/JEuwmubzSSXQNN2oweXGp0w1+zZVBVVGtP+xLD3g7qWZ13BKu6l4UoQ/HIn22ZtH6NAhMmtnaCfNulNeCFfXvMnIwrhjNU34=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:ed820678-f4d6-4416-8f30-ad3ed031b789,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:b0fcdc3,CLOUDID:e535b341-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2da889a0910f11efb88477ffae1fc7a5-20241023
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 222065180; Wed, 23 Oct 2024 15:19:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 15:19:42 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 23 Oct 2024 15:19:41 +0800
Message-ID: <7bed09f4-b792-4587-2c08-df8e6aa9a314@mediatek.com>
Date: Wed, 23 Oct 2024 15:19:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "ChiYuan Huang"
	<cy_huang@richtek.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bear Wang
	<bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin
	<macpaul@gmail.com>, <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>, Fabien Parent
	<fparent@baylibre.com>, Simon Sun <simon.sun@yunjingtech.com>
References: <20241015103337.20479-1-macpaul.lin@mediatek.com>
 <20241015103337.20479-2-macpaul.lin@mediatek.com>
 <20241015205637.GB1934266-robh@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20241015205637.GB1934266-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.862100-8.000000
X-TMASE-MatchedRID: y/2oPz6gbvgOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rfEt9Ay9zO7sc+qKbgAFCSoxWB033D5MLUqhJbkmLVe3PBWZjlMys293R
	/67MIvJx0vTAlSptNlcBI1OxqxxNMFzzGUz0QhoXCDMQhoerulx3fOSCz34UdnQqircTOm4d7nq
	zzG+5SELfpIvb2AFnm3nZ2IBXOo3afT/zxNL8LPgs9VkfCh3uArrEvQogcy/ET7lsB95pa6vz8v
	ajouc6X6P2jQ8ymte8QDZh9tV+I0RgHZ8655DOPOX/V8P8ail1ZDL1gLmoa/PoA9r2LThYYKrau
	Xd3MZDV82cyBsUWY5/1f/6848J/TsxrUDvSmaei2e+KVzCqZbVB9yLVq2hBC
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.862100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C4B433C839EC422FF41D031EF6CA4B98F32CA080A736DEE76F1B765FDBBD3F9C2000:8



On 10/16/24 04:56, Rob Herring wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Tue, Oct 15, 2024 at 06:33:37PM +0800, Macpaul Lin wrote:
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
>> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>  .../dts/mediatek/mt8395-genio-1200-evk.dts    | 51 +++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> index 5f16fb820580..b91a46f4a702 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> @@ -249,6 +249,39 @@ mt6360: pmic@34 {
>>  #interrupt-cells = <1>;
>>  pinctrl-0 = <&mt6360_pins>;
>>  
>> +tcpc {
>> +compatible = "mediatek,mt6360-tcpc";
>> +interrupts-extended = <&pio 17 IRQ_TYPE_LEVEL_LOW>;
>> +interrupt-names = "PD_IRQB";
>> +
>> +connector {
>> +compatible = "usb-c-connector";
>> +label = "USB-C";
>> +data-role = "dual";
>> +power-role = "dual";
>> +try-power-role = "sink";
>> +source-pdos = <PDO_FIXED(5000, 1000, \
>> +       PDO_FIXED_DUAL_ROLE | \
>> +       PDO_FIXED_DATA_SWAP)>;
>> +sink-pdos = <PDO_FIXED(5000, 2000, \
>> +     PDO_FIXED_DUAL_ROLE | \
>> +     PDO_FIXED_DATA_SWAP)>;
>> +op-sink-microwatt = <10000000>;
>> +};
>> +
>> +ports {
>> +#address-cells = <1>;
>> +#size-cells = <0>;
>> +
>> +port@0 {
>> +reg = <0>;
>> +mt6360_ssusb_ep: endpoint {
>> +remote-endpoint = <&ssusb_ep>;
> 
> No, this is wrong. This should go to 'port@1' in the connector node.
> That is the SS connection.
> 
> Rob

This wrong index and wrong intent for the whole 'ports' node will be
fixed in patch v2.

Thanks for the review.
Macpaul Lin

