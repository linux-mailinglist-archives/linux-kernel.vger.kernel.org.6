Return-Path: <linux-kernel+bounces-340253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6925987088
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137DD1C21367
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8F1ABECE;
	Thu, 26 Sep 2024 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OK36qtJM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368881A4E97
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343822; cv=none; b=Jp4w2RZQCQWkzieU7zvUUbyWGXeP9LgGkVbXxAwHkYyz8fY4LTPfpVRPvsuHd8Yz6f207ruzqpKmlHrP37oiijN04+Hv67aaELtwm2QdrqBHNs3W+IR6rjisaos18TXjP79LnYu8jEynkGktWW/hdxqSWtUfO0dc1Mv/VxuxUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343822; c=relaxed/simple;
	bh=vq1GUjXNsP5rX8yDh/hNAiZ3oslcwl01tLDsM6AY3wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXWzS7z+rgwoybM5fw/jdAAoiukNLSrU4ZHgVfAiQOqNhGTnfsfHOYok9csJGjHdGsKPUsT/5kfyMlgZBbiIGvySOho4i+QCnRqBG+Wcd+xdcsy9FYOfA4fpBi/fjTJnBSNJ5efgm97r15flHghoFJEOI1iE/DW8hx3LFXu2oqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OK36qtJM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727343819;
	bh=vq1GUjXNsP5rX8yDh/hNAiZ3oslcwl01tLDsM6AY3wk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OK36qtJMUqVfqjq7kqlAHsrny4+RT5SkCf6eM/LJWJ5TYCJf1XAm1Tb7Bceq/8hOr
	 8RNIoRdduYHMI1R1Vuowx/iMbAXUjEyILwyR6iQodeXlWsgIupc0rd8odiEC09o2Js
	 edKIDL+G5h+ng7AfVIHj05qDDoNNzwsMvwcOvocEhzZkZQHBKTGwWe2F6C6//taULJ
	 fNVQiNSRLq9JDv9I4YkhE/FXwitT2orUDMEhQvE6Ynv3fjSOsLIyyzw5nB58yuSfxm
	 U1lfXIWlWzKnFB9Ul/2f3s9y64YUoDFlfRMeXxWB5f0usjg3P74TPymSzzEbjNfD2X
	 OqGzMyZGKqTww==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4ADEE17E10B5;
	Thu, 26 Sep 2024 11:43:39 +0200 (CEST)
Message-ID: <2ad8c375-84b9-45ea-a27c-076021970d28@collabora.com>
Date: Thu, 26 Sep 2024 11:43:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240925101927.17042-1-jason-jh.lin@mediatek.com>
 <20240925101927.17042-3-jason-jh.lin@mediatek.com>
 <64b96ec0-1264-4a3c-a26d-f8a0c3375d79@collabora.com>
 <2c05e5d9684aac50dea22c2c0dfbf0f679e29434.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2c05e5d9684aac50dea22c2c0dfbf0f679e29434.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 26/09/24 11:42, Jason-JH Lin (林睿祥) ha scritto:
> On Thu, 2024-09-26 at 10:37 +0200, AngeloGioacchino Del Regno wrote:
>> Il 25/09/24 12:19, Jason-JH.Lin ha scritto:
>>> Since some SoCs support premultiplied pixel formats but some do
>>> not,
>>> the blend_modes parameter is added to mtk_plane_init(), which is
>>> obtained from the mtk_ddp_comp_get_blend_modes function implemented
>>> in different OVL components.
>>>
>>> The OVL component can use driver data to set the blend mode
>>> capabilities for different SoCs.
>>>
>>> Fixes: 4225d5d5e779 ("drm/mediatek: Support alpha blending in
>>> display driver")
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>
>> Just perfect.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>>
> 
> Just to confirm. Do you mean reviewed-by? :)
> 

Oh, my brain needs coffee. Sorry about that, yes, I was meaning R-b.

Anyway, gave you the right tag on v6, so ignore that.... :-)

Cheers,
Angelo


