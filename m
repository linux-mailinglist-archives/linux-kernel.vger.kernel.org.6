Return-Path: <linux-kernel+bounces-338202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5B9854AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF091C20FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADD15853E;
	Wed, 25 Sep 2024 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eolPzsRX"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA7157472;
	Wed, 25 Sep 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251014; cv=none; b=enPZgEpgWGytJn2zTPcXraZ1htQkbCBQEbS7JtPODppApFG9Wl33508ZJK9yiyTSv9w9Xe+Qd5QbwkLslw07V2VrTphP4FwImYwNPakL+BeIi1GlJPNkM+v57O5rnX1nDZso3jXCSLzJWzqwkk14V3z79reU7H6Uycbvo7SlIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251014; c=relaxed/simple;
	bh=l3Gd5No/I+b5yuDaAgG0i6dBjXGvlDsb5BXq3T0WeTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cGggh1xCsx5QoLNJH8EQCydbscSl3AAg0YgT/uPGwtKziTtQb1bXUnTge7T6KbBDWYQJeaJAzh9GJf0OGrGspTIwP6NbSam4QA2neKcnrt1yRD2jtWvam4GhIwPnrzeaxVo9rVXZb3mA+o4JLK9LyQal0XuqygBLLYiUhbJ6rXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eolPzsRX; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b5d1e19e7b1311ef8b96093e013ec31c-20240925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Do3ooaQZNXtQMdr7rWT9aLKM/O1qU46ww0/Lu6tZOpU=;
	b=eolPzsRX6ymMk2kChZd9SCjYjnvogbJzAwU0QHzz+CsFsgdJtdaONWq+t+wqIow6DG2kSWGV6jVdbjZt31EMtbpx3gKeVb9C7YVJXeBmW9mfmqbjmoChUIvsWoz6RjL5Af4aea+vYqlytJayKt1OeIeVKOV2hj6yUNeBI4OFnqs=;
X-CID-CACHE: Type:Local,Time:202409251522+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:210a4649-46fa-475a-a6f0-0a96c23418cd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:682cbcd0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b5d1e19e7b1311ef8b96093e013ec31c-20240925
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 524817971; Wed, 25 Sep 2024 15:56:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Sep 2024 15:56:44 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 25 Sep 2024 15:56:43 +0800
Message-ID: <9e51fdad-382c-5889-7986-7e0373eb0918@mediatek.com>
Date: Wed, 25 Sep 2024 15:56:42 +0800
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
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, Chris-qj
 chen <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>, Tommy Chen <tommytl.chen@mediatek.com>
References: <20240925071514.17626-1-macpaul.lin@mediatek.com>
 <7e57ea01-f881-4c6a-95e7-96ab56dbc455@collabora.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <7e57ea01-f881-4c6a-95e7-96ab56dbc455@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/24 15:54, AngeloGioacchino Del Regno wrote:
> Il 25/09/24 09:15, Macpaul Lin ha scritto:
>> During inspecting dtbs_check errors, we found the power domain
>> setting of DPI node "dp_intf0" is missing. Add power domain setting
>> to "MT8195_POWER_DOMAIN_VDOSYS0" for "dp_intf0"
>>
>> Signed-off-by: Tommy Chen <tommytl.chen@mediatek.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> 
> You missed a Suggested-by tag here :-)
> 
> after which,
> 
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>
> 

Got it! I'll send v3 update later.

Thanks
Macpaul Lin

