Return-Path: <linux-kernel+bounces-332268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19F97B795
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F641F239D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB114A0B8;
	Wed, 18 Sep 2024 06:05:06 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725E136327
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726639506; cv=none; b=mn11zx8oqmBCfcKS4NpqSeKz+qNQF1fWi/yXZ0/5/ekB8JhspoAgXouNh36Q25ZszXicuxXjesSlV5/X9Q9DCLjytH5nF9v7w3NU6To9MkgWJ+obqMfZouE4U5/WdB6FwEISFcH2K30Kdt6pC9jko6smmgZiBDvCXXy//klRFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726639506; c=relaxed/simple;
	bh=OqgcunAyMboiPdbi67+Aq5z8Rl/h0S84OYkEC0r4YTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCkfqFrq88iJQ+JNrY2VwO73tKsGMGqvfhT+9j2jVPOkLSutUhqXOGlFyLzYZ0ugwzqjbXuegV0yRhd0Q/CtVdnnJWGdV4FzBXBn3QTWOEnsdyp7DpmkWIVh+CQW8O3Hu2utxuIoWk6Cb4r4O1fZeEUxwVRdshpMGki5kvQfpYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ec40523c758311efa216b1d71e6e1362-20240918
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:0f166acb-9a92-4197-92f2-9b0a98694fed,IP:15,
	URL:0,TC:0,Content:1,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:13
X-CID-INFO: VERSION:1.1.38,REQID:0f166acb-9a92-4197-92f2-9b0a98694fed,IP:15,UR
	L:0,TC:0,Content:1,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:13
X-CID-META: VersionHash:82c5f88,CLOUDID:dcecfe3cf5121096a31c13c67478d6f1,BulkI
	D:240917202609BZ64102R,BulkQuantity:2,Recheck:0,SF:42|66|17|19|101|74|64|2
	5|100|102,TC:nil,Content:4|-5,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI
X-UUID: ec40523c758311efa216b1d71e6e1362-20240918
X-User: yaolu@kylinos.cn
Received: from [10.42.20.76] [(111.48.58.10)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1928682378; Wed, 18 Sep 2024 14:04:53 +0800
Message-ID: <ac7350bd-d29b-7f3f-1de5-e95b0d968e18@kylinos.cn>
Date: Wed, 18 Sep 2024 14:04:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Alex Deucher <alexdeucher@gmail.com>
Cc: ckoenig.leichtzumerken@gmail.com, daniel@ffwll.ch, jfalempe@redhat.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 srinivasan.shanmugam@amd.com, sunil.khatri@amd.com
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <20240812060914.102614-1-yaolu@kylinos.cn>
 <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
Content-Language: en-US
From: Lu Yao <yaolu@kylinos.cn>
In-Reply-To: <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/9/17 21:21, Alex Deucher wrote:
> On Mon, Aug 12, 2024 at 2:10 AM Lu Yao <yaolu@kylinos.cn> wrote:
>> Add support for the drm_panic module, which displays a pretty user
>> friendly message on the screen when a Linux kernel panic occurs.
>>
>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> Patch looks good to me.  Any chance you want to convert the other
> non-DC dce files (dce_v8_0.c, dce_v10_0.c, dce_v11_0.c) while you are
> at it?
>
> Alex
>
I don't have any hardware with those dc ip blocks.
Although the code logic looks consistent, but it still needs to be 
tested, right?  ; )

Lu Yao
> ---
> Changes in v2:
> 1. Drop include "drm_internal.h"
> 2. Add disabling DC tiling ops.
> Per suggestion from previous thread:
> https://patchwork.freedesktop.org/patch/606879/?series=136832&rev=1
> ---
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 48 +++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> --
> 2.25.1
>

