Return-Path: <linux-kernel+bounces-308711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B99660B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFF31C251FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D8199FBF;
	Fri, 30 Aug 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kQy1H/0y"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BC199FA9;
	Fri, 30 Aug 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017143; cv=none; b=HxGF/p9jbaPIFPrb7lQxi/HOI3XDuHqCk8/iRfIAYm05JCpiAgebOGamAD1E87Xi9WTtnIu+KDst7LeLs1CBPHRscGXxZao3on3nzBh/ig9P++UfqOwWIOo1ptFgBRpBkuirsp2Jm1yKPTb2Pl3HizRH64LXZPUUjbEM9Yke+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017143; c=relaxed/simple;
	bh=t2wncrwmiNH/c2wgm8EhCgtxeigtwWS9Ar5vjZFimZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lVKvcE9o559DN9htjn6soK7Pz0RRUvwadufVDz+AmWVH+tU9GhRhvcqLto8TzJ7kBpvZxXIhcsSANsabFW1NDxQyz6WGlzsaMdj1AOCImunodG7Io4aj5EPH7DlqQjz8UgWxL1iOCj0kThd/vE22ESD8DHseGJVzQpnmK2PDYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kQy1H/0y; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9273ca3866c211ef8b96093e013ec31c-20240830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=8hFbDqdqARkXESCpWhEKpXy666gO0BZMnAA7bAJp/zY=;
	b=kQy1H/0yHnVwaqCdm2FqJ1a1LSyGue3PSruFY0837fmDETWiFzQezOgrmtkd5t9Xq1v2t8Fw9sU2DKaWFP8uYjcczvD8Se8BsjqTOFkn969Fuim4y68l88uQyyfoEPgS18NrXwO4d9LgPUiazF61wy038o8T0SFnlgQzp1xhQ/0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2f12afbd-22ce-4ef8-a279-ed567767174d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:dbab0d15-737d-40b3-9394-11d4ad6e91a1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9273ca3866c211ef8b96093e013ec31c-20240830
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1355043557; Fri, 30 Aug 2024 19:25:33 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 30 Aug 2024 19:25:34 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 30 Aug 2024 19:25:33 +0800
Message-ID: <2d2626a7-b920-6113-e81c-3b24463c1fe1@mediatek.com>
Date: Fri, 30 Aug 2024 19:25:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: mfd: mediatek,mt6357: Fixup reference to
 pwrap node
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>, Flora
 Fu <flora.fu@mediatek.com>, Bear Wang <bear.wang@mediatek.com>, Pablo Sun
	<pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen Chu
	<sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, MediaTek
 Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>, Chen-Yu
 Tsai <wenst@chromium.org>
References: <20240826065415.19641-1-macpaul.lin@mediatek.com>
 <20240826-slurp-earphone-0d5173923ae8@spud>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20240826-slurp-earphone-0d5173923ae8@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 8/26/24 23:50, Conor Dooley wrote:
> On Mon, Aug 26, 2024 at 02:54:15PM +0800, Macpaul Lin wrote:
>> The mt6357 is a subnode of pwrap node. Previously, the documentation
>> only included a note in the description of mt6357. This change adds the
>> appropriate $ref for pwrap to ensure clarity and correctness.
> 
> I think this change is wrong and the existing binding is fine.
> Adding the ref overcomplicates the binding completely, and stating that
> this is a child node of another device is sufficient.
> 
> Instead, if anything, the pwrap binding should have a ref to /this/
> binding.
> 
> Thanks,
> Conor.

Thanks for the clarification of this parent-child relationship of the 
binding. Will apply to further conversion tasks.

There are many PMIC devices belongs to the pwrap bindings. Hope I'll 
have time to fix this soon.

>>
>>    $ref: /schemas/soc/mediatek/mediatek,pwrap.yaml
>>
>> Additionally, the indentation for the pmic section has been adjusted
>> to match the corresponding structure.

Best regards,
Macpaul Lin

