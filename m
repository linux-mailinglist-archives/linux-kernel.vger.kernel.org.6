Return-Path: <linux-kernel+bounces-338156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64198541A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B5CB24829
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4EE158524;
	Wed, 25 Sep 2024 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S+DTkOq0"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EF15AD8B;
	Wed, 25 Sep 2024 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248963; cv=none; b=iWE2kdPMCLDjAKmLJcK6kxphJC2pnxxFK+kUxVATfmqiKFfpInF4XinHTgxfSPVVXxR54ycQsv7Z23j6phkt2UeyR3J6gNPrBUC7/jsUhNOUNBsfkLY7TITEEaXqz6bEDC1nZqOqvbAntjcTpU4c/9OAJniwA9rzSW6gN5yUZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248963; c=relaxed/simple;
	bh=fWQc86uvk41jzWAKtD5AHKfG+qWsOinTlTLdzMU6ivo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t0dYEE8hyHpCy0AnRmQ9AjSanPv5Gp2HAy4sHt25i5xmRjCKx6utg7Q2PlvT1D2wDI4+gi1EkoZqfQBE4qJhzMN5o2E+LmCmA+oPCYxyi2LciokxCehbLGBl/x5zztjWn2c+o+xkttaWAOn9rRFh+s8TAoyrw+DJheaNGmCeYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=S+DTkOq0; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f015f3cc7b0e11ef8b96093e013ec31c-20240925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=xl0YbQNchGMDcxT/riTMU37tGxjdInutMd+47zW0twk=;
	b=S+DTkOq0tHsWBT2f7xSVhqDnupaPlSY26O1XFuhyxOsZ25lrSOjQDCR8EevL3Ab29VdIYF60lc6LajscoN+9LshhU+J/Vi4FWx1aZAUpO79dl6uU5qKngbNHJapnqBEvDpBeAfqilI9YILmxtQ9l7bTQeihQESs1Zmk84bAuKuk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8e35c7da-81c5-4139-91b0-9d0a3373e917,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:682cbcd0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f015f3cc7b0e11ef8b96093e013ec31c-20240925
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 161981965; Wed, 25 Sep 2024 15:22:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Sep 2024 00:22:35 -0700
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 25 Sep 2024 15:22:35 +0800
Message-ID: <47c4b502-0c8d-126e-699f-b59a55d895c3@mediatek.com>
Date: Wed, 25 Sep 2024 15:22:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add power domain for
 dp_intf0
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, Chris-qj
 chen <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>, Tommy Chen <tommytl.chen@mediatek.com>
References: <20240925071514.17626-1-macpaul.lin@mediatek.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20240925071514.17626-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 9/25/24 15:15, Macpaul Lin wrote:
> During inspecting dtbs_check errors, we found the power domain
> setting of DPI node "dp_intf0" is missing. Add power domain setting
> to "MT8195_POWER_DOMAIN_VDOSYS0" for "dp_intf0"
> 
> Signed-off-by: Tommy Chen <tommytl.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

[snip]

Sorry there is a typo in the Signed-off-by.
I'll send v2 to correct this.

Thanks
Macpaul Lin



