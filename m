Return-Path: <linux-kernel+bounces-262217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 249BF93C298
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5521B1C21B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E419AD8B;
	Thu, 25 Jul 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RZi9Z04A"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB619ADBE;
	Thu, 25 Jul 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912413; cv=none; b=jhCa7cCvoryBFBzrE5L33RTEQfoQ+TibAF7k1WirSWjlo3ben4iql6EVZhyhzDsRJYjlF4D9bTne1HCtVa43cUEnaho+gK849V1rUFDpBuOUJrqYuDfQBuxT7Q6wmr3cgJIUX2TskJeXTgYxZpxWL/2U4V6WI0gbWlnYt7MXdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912413; c=relaxed/simple;
	bh=pR52xDUurWPyK/7A/DEfCS7HBpLihe1f7oaa6YE+HmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qeTnTn4MA1xOX2wQApMKfaR1Zt0E8tZkHH32NhmaNzr/268xlOo79qqLoLXwUKoz9eSq4AXEWCSaMLKFEkmqIR+eqw34D0NNRZECHyc/Ab2HS+M8j30gEdJSTQDKZpxlqooupjIXye5aF+8pJPIFui6kn2QsCiT+XBGKvqhqbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RZi9Z04A; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ca1209684a8511ef87684b57767b52b1-20240725
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=uD3XGrqNc/LkHS1p+rIDmcZc8WV2188cZAdzBOYaQ10=;
	b=RZi9Z04AA9NbVXJivsE5xOBxXcCGJKwaJN8XDke6OlBypKP/ol4X4DOfq8K5W8HbzObKZ4yY7UW8vst1tR5rSYTR8FpT1e0i832odj2aWdpitItjiSquE3LwWs9WiFdUhlmRBrQkpnn6FXMwA05Vt5biTGZ2+kb7NuG8wgGCqdQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ea2fd3a3-dd34-482f-8e14-5665fd447ceb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:25eee3d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: ca1209684a8511ef87684b57767b52b1-20240725
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 19011528; Thu, 25 Jul 2024 20:59:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 Jul 2024 20:59:56 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 25 Jul 2024 20:59:55 +0800
Message-ID: <7603f704-caf2-a5b9-e84e-bfec210273b8@mediatek.com>
Date: Thu, 25 Jul 2024 20:59:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add missing clock for xhci1
 controller
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, <chris-qj.chen@mediatek.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<kernel@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
References: <20240722-usb-1129-probe-pci-clk-fix-v1-1-99ea804228b6@collabora.com>
 <CAGXv+5H_pxR18sHeqdWPy9_FARrnLwyyOHV4VXCn9p5OExseiQ@mail.gmail.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <CAGXv+5H_pxR18sHeqdWPy9_FARrnLwyyOHV4VXCn9p5OExseiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.987100-8.000000
X-TMASE-MatchedRID: fE0JoqABJp1jbyiFvYNuKLhzZI/dfrdOjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo23tJaKJZJX/V7rr6ndct5SEmVes1pwna5Q74
	mZ61P8ptCXD2S19glPTl4fr3J7Ttwxgua8617TyWzI1v7J4hECvioIsi7Sa0gYdn5x3tXIpdSIS
	RzTzrHdrK/yup2qeEYIMLBH+nQWgW2YiHNOjOnAwPZZctd3P4Bf2g6KJZtxl0NmPMcsvd5FpMfT
	P6axk0NSGz7tVxwx8H2HBjYROMcHPWUZFWpEkltMKPrF7dK57M6XfbB1aMjXnzXuTu6yhVMtGMo
	giL4BSQI0JEpLdHmfJPgDLTDkZJsS2vb/Rh+9IXAJnGRMfFxyb7VXHusOfivClyrX4tOmxSjxYy
	RBa/qJaEwgORH8p/AjaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.987100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6A074A2B9F64AA60FDDFB2D755D15C379843814E42F72FF3BAA9532B519A11902000:8



On 7/25/24 18:34, Chen-Yu Tsai wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> Hi,
> 
> On Mon, Jul 22, 2024 at 11:27 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>> Currently if the xhci1 controller happens to probe before the pcie1
>> controller then it fails with the following errors:
>>
>> xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
>> xhci-mtk 11290000.usb: can't setup: -110
>> xhci-mtk: probe of 11290000.usb failed with error -110
>>
>> The issue has been tracked down to the CLK_INFRA_AO_PCIE_P1_TL_96M
>> clock, although exactly why this pcie clock is needed for the usb
>> controller is still unknown. Add the clock to the xhci1 controller so it
>> always probes successfully and use a placeholder clock name for it.
>>
>> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
>> Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> So I asked MediaTek about this, and it seems the correct thing to do is
> disable USB 3 on this host controller using the following snippet. The
> snippet is copy-pasted from our issue tracker and won't apply directly.
> 
> This is also seen in mt8395-kontron-3-5-sbc-i1200.dts, on which xhci1
> is used only for USB 2.0 on an M.2 slot.
> 
> 
> ChenYu
> 
> index 8b7307cdefc6..2dac9f706a58
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1447,6 +1447,7 @@
>                                        "xhci_ck";
>                          mediatek,syscon-wakeup = <&pericfg 0x400 104>;
>                          wakeup-source;
> +                       mediatek,u3p-dis-msk = <0x1>;
>                          status = "disabled";
>                  };

If this is the other final solution, please help to add it per-board 
basis dts.
mt8395-genio-1200-evk indeed uses USB3 XHCI function for this port.
https://mediatek.gitlab.io/atio/doc/aiot-dev-guide/master_images/hw_evk_g1200-evk_ports.png.
You can see a USB3 port at the left bottom in this picture.
Otherwise, we need to check if it is possible to override
mediatek,u3p-dis-msk = <0x1> with <0x0>;


>> ---
>>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> index 2ee45752583c..cc5169871f1c 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> @@ -1453,9 +1453,15 @@ xhci1: usb@11290000 {
>>                                  <&topckgen CLK_TOP_SSUSB_P1_REF>,
>>                                  <&apmixedsys CLK_APMIXED_USB1PLL>,
>>                                  <&clk26m>,
>> -                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>;
>> +                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
>> +                                /*
>> +                                 * This clock is required due to a hardware
>> +                                 * bug. The 'frmcnt_ck' clock name is used as a
>> +                                 * placeholder.
>> +                                 */
>> +                                <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>;
>>                         clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck",
>> -                                     "xhci_ck";
>> +                                     "xhci_ck", "frmcnt_ck";
>>                         mediatek,syscon-wakeup = <&pericfg 0x400 104>;
>>                         wakeup-source;
>>                         status = "disabled";
>>
>> ---
>> base-commit: dee7f101b64219f512bb2f842227bd04c14efe30
>> change-id: 20240722-usb-1129-probe-pci-clk-fix-ef8646f46aac
>>
>> Best regards,
>> --
>> Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>>
> 

Thanks
Macpaul Lin

