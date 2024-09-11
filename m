Return-Path: <linux-kernel+bounces-324691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E724974FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15A51C21C86
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F5C183CDC;
	Wed, 11 Sep 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mh77mlR6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE761547CF;
	Wed, 11 Sep 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050961; cv=none; b=dzA2XrgrAkji+eS3DupK09te5zhhak+hfm0won1RAnrlkRjsxBiuOXbcp+nKKj3mP45wRywZKEpgdSgIou1FlIgdcG79BQVrdCFqNFVYSDiP9zXOOcD7DfCR2emCF5AWavWdoNbdTHT2unQtCFWj3foQdz6SABCB+omM+s/NX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050961; c=relaxed/simple;
	bh=Qrz6RTX1PNpBROsSRh/yqWHiZMg93U0DcfQlo+fXndY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PMUXO9Jtk5JPf15MhxoyQdT0eUPHdMJ1Yi53QrleQtnGXN437PZAW4s+5pgiu5STsmW4wTkQpDw2c+pIZ2IOXsHhgBGvKZvy1l9JSd+v8jRuoNyoXzD67aN8OvR+stJ1X7tjzMx8G2fG2Qltak1K4MFYUgQvH3ywpiarSCMbfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Mh77mlR6; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9e957fbc702911ef8b96093e013ec31c-20240911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=i3tHF/N//EGXGgamdyyH/gK3cs5Dqc/2JBLeUZVd4RM=;
	b=Mh77mlR6TAlSV+4bbsyowC5OLbsmjdXzGXXBQV5fBI6RkmBCt8lRt5Hpm0EYzt9UmDOJ8NnNb51U2mc7TyXU6YDuXyrAOcUe6zFe+iBgRyHSAG0HU4CSrG5rdxLofK+zu9mNz54/L4QCW9OgiYTHS48OjJdzuLVA/+U3vleYEVE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7efd543e-21d3-4711-87b6-039266cb423c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:932fccbf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9e957fbc702911ef8b96093e013ec31c-20240911
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1163102840; Wed, 11 Sep 2024 18:35:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Sep 2024 18:35:51 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 11 Sep 2024 18:35:50 +0800
Message-ID: <2fd45240-a341-806b-f336-78d0595a8031@mediatek.com>
Date: Wed, 11 Sep 2024 18:35:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable GPU
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240910143245.5282-1-pablo.sun@mediatek.com>
 <01020191e04d4237-204596e1-6cc1-491c-a60f-de3917af7d42-000000@eu-west-1.amazonses.com>
From: Pablo Sun <pablo.sun@mediatek.com>
In-Reply-To: <01020191e04d4237-204596e1-6cc1-491c-a60f-de3917af7d42-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Angelo,

Thanks for the review,

On 9/11/24 16:57, AngeloGioacchino Del Regno wrote:

[snip]

>> +/* for GPU SRAM */
>> +&mt6359_vsram_others_ldo_reg {
>> +    regulator-always-on;
> 
> No, that's not good. Like that, the GPU VSRAM will be subject to current 
> leakage.
> 
> Remove the regulator-always-on property.
> The right way of doing that is to add the vgpu to the mfg0's domain 
> supply and
> vsram to mfg1; that way all of the GPU regulators will be off at PM 
> suspend time.

Thanks for pointing this out, I'll send v2 to fix this.

>>   &mt6359codec {
>>       mediatek,mic-type-0 = <1>; /* ACC */
>>       mediatek,mic-type-1 = <3>; /* DCC */
>> @@ -839,8 +851,8 @@ regulators {
>>               mt6315_7_vbuck1: vbuck1 {
>>                   regulator-compatible = "vbuck1";
>>                   regulator-name = "Vgpu";
>> -                regulator-min-microvolt = <300000>;
>> -                regulator-max-microvolt = <1193750>;
>> +                regulator-min-microvolt = <546000>;
> 
> I'm okay with this constraint but are you sure that MTK-SVS won't go any 
> lower than 0.546V?

I'll see if I could confirm the maximum voltage drop that may be lowered 
by mtk-svs for MT8395. There are 3 constraints that I am aware of:

- capability of Vgpu buck: 0.3V-1.193V
- sign-off voltage of the EVK board: 0.6V to 1.2V
- recommended operating voltage of MT8395 DVDD_GPU: 0.546V to 0.787V

For the device tree of the board, would you recommend set the regulator 
voltage constraints in narrower range (because it's safer to keep in 
recommended operating conditions), or in a wider range (leaving the 
check to driver software for potential power saving?)

Thanks



