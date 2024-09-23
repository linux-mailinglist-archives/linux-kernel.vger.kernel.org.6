Return-Path: <linux-kernel+bounces-335644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C118197E87B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E6B1C2122E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9390B194A66;
	Mon, 23 Sep 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j092psrs"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5821946A4;
	Mon, 23 Sep 2024 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083274; cv=none; b=J27VpytP3ZchXrUr8v6AcUOIBWE/3HG4XrAdmNSquAR8wM4DT20XfYB4h8HcUy8nYKq63K1hi3Xe6pDt9v0Nzp1ydEuG+qN90mxrUk6Hkvj5tCHKWhkshZBvoZDGrICiCDn19yZlzY9a+BJdVnf/BpifmRs7ut41vu1hc/SJa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083274; c=relaxed/simple;
	bh=XkTMzR+QaaPQ9beNXFFpDntWSUyMlJZakghbnU0IjVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EI7TlBjpkRhI52Kh3tkyZYfpZkkax5uJ5dp8qUGFcs5Z9PABxaRl9aQ6DdmqY0922oAwD3A5HTuKPEqyrQgkpwqPvz9DyDdsZRIRVSnjz3YmqGKmAtNXIdi6j53M7VOdEr3EFNpaqDIivzXBLlUjhdxKk6Fnz+IxHTbVBrBTy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=j092psrs; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 27eabd06798d11ef8b96093e013ec31c-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=gjZj/08QvvsJ8Imgl9uWiUrtWHG3Yj6fTeZovpkIvPE=;
	b=j092psrsPIOVqOfFiiHzAcaVFEJDZfhobjAR/DceUmZ++cq6FBKYvtsn4zYnPQxG2eDQO0P1qwYUPq8+qReH/wuUnrMKAuz0ztDAcrYmeRBzVpbp5L6oKc4PkGkHe+nGwONWYcyPgrnDdl4ukNGOiKj7xYIKI/dYmop+MTGC8gI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2517809b-de0c-43c1-b60b-ccbad6e3382d,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:edb56a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 27eabd06798d11ef8b96093e013ec31c-20240923
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1536765249; Mon, 23 Sep 2024 17:21:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 17:20:59 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 23 Sep 2024 17:20:52 +0800
Message-ID: <2914fee8-c94a-fecb-a69c-0d58a40caded@mediatek.com>
Date: Mon, 23 Sep 2024 17:20:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/5] nvmem: mtk-efuse: Enable postprocess for mt8188 GPU
 speed binning
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
References: <20240920134111.19744-1-pablo.sun@mediatek.com>
 <20240920134111.19744-4-pablo.sun@mediatek.com>
 <866d7cd8-856b-431a-9408-527cdc021922@collabora.com>
From: Pablo Sun <pablo.sun@mediatek.com>
In-Reply-To: <866d7cd8-856b-431a-9408-527cdc021922@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.754000-8.000000
X-TMASE-MatchedRID: u1zqiMeMcroNtKv7cnNXnSa1MaKuob8Pt3aeg7g/usAM74Nf6tTB9rsI
	asnPqvyQfVSuQp/lqthxq+Aq7jUw2GN6tywQmwQMngIgpj8eDcC063Wh9WVqgjuUMbK1NdLP+gt
	Hj7OwNO2OhzOa6g8KrQg299MEvOql1vSXLi9e57Sdpgh/0Y9xmmUJIWO8gdo5djIFhP3krtZiou
	j39kMFs02viMYyOMeglkEG27gbXTQ3u31m+KVydpeZT8XNJIzV
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.754000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8FFCC96B34A170870F29F0F6648320318BC4090AB294D4AB700CD9D0A14064CA2000:8

Hi Angelo,

On 9/23/24 16:37, AngeloGioacchino Del Regno wrote:
[snipped]
> 
> Please reuse mtk_mt8186_efuse_pdata. There's no need to add a duplicate.
> 
> { .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8186_efuse_pdata },

Thanks, will fix in v2.

Best regards,
Pablo




