Return-Path: <linux-kernel+bounces-219163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B8790CABD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC492837C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1191A15ECD9;
	Tue, 18 Jun 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yeckDiAE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1D156243
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711278; cv=none; b=qvO6L+NaFw052i7gpOorHNOjHdaxE5/cyezI6pMyPY4Ok9fwWdQyhhAl6oJMwTK/db99yk6o9haSJl11sPaAxEcki30ebenC7n+JLQU21HScww1PoHZloNrPRLvz2Mx0VRfzUU3rbHvoPqql/fuUhYnRpIM9zsn3j/Zu6aDetQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711278; c=relaxed/simple;
	bh=LCU1/wOlqhMINpdJryJw+TiAI7Pm6y9VMDX9zjYoTss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkuiRHLWHCIGGsrthENGa73dJz2EUQwaXdsIuiVZc9b28EBduxaqA9bXsxLmqbTMVUb7DtCOLhIT5wzHSl9uATiBEbII9jLGca05lg4dhNw8XCzjsqh6PvkBesE7zY1H0yY6BBae3WwyUvwDwaA95M11Uv0uo0fQxeNLS5647is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yeckDiAE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718711274;
	bh=LCU1/wOlqhMINpdJryJw+TiAI7Pm6y9VMDX9zjYoTss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yeckDiAEUb+DP1MZqjwJngPW/+GxgOHE5R08Li3TKX+LHvwY8YL8TOL3ULuE25xS5
	 IbXb2Mb5Hpr1X3FYL9rz7GZICtEUlny9Wa+8pUzBl+2HsK+FKjwx3y6EST6ptG7ZVj
	 w/aP5QiMDbbSxblzKIMabPNh3OqaRc0ocDjWAK4lpdrdccRNyfrz0WF6oJvZXkZqc9
	 H8fAzOlRe7S9Pqdli40eEYIYxKJs125DxOcpLlkBuIuf57GZWQS5NVnE3M5cVtCDCf
	 8RmGrdJJhPuf6yIeL91qacqR6wD5kUbCUmc2b+ao+JkUFcRkrIcpePD/QyaC078THN
	 ahoRh6xaB52wA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4D10D378217B;
	Tue, 18 Jun 2024 11:47:54 +0000 (UTC)
Message-ID: <a681e496-4979-4f4a-9f79-9636d9496fa3@collabora.com>
Date: Tue, 18 Jun 2024 13:47:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: mtk-cmdq: Add unregister mailbox controller in
 cmdq_remove()
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20240613150626.25280-1-jason-jh.lin@mediatek.com>
 <8ef254cb-ac65-405d-bcee-d0990536fb32@collabora.com>
 <44f6308379a8b6c834df6ff0604c652bf1f7a4b7.camel@mediatek.com>
 <47f1c2c79ad03094ebf411e13516cca47054c962.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <47f1c2c79ad03094ebf411e13516cca47054c962.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/06/24 05:28, Jason-JH Lin (林睿祥) ha scritto:
> Hi Angelo,
> 
> On Fri, 2024-06-14 at 00:52 +0800, Jason-JH.Lin wrote:
>> Hi Angelo,
>>
>> On Thu, 2024-06-13 at 17:10 +0200, AngeloGioacchino Del Regno wrote:
>>> Il 13/06/24 17:06, Jason-JH.Lin ha scritto:
>>>> Add unregister mailbox controller in cmdq_remove to fix cmdq
>>>> unbind
>>>> WARN_ON message from pm_runtime_get_sync() in
>>>> cmdq_mbox_shutdown().
>>>>
>>>> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ
>>>> driver")
>>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>>
>>> Hello,
>>>
>>> I think you forgot about...
>>>
>>>
>>
>>
> https://lore.kernel.org/all/6fcd48b14e865c25e6db7559fe6b946537bfa0ce.camel@mediatek.com/
>>>
>>
>> I'll send this series next week after testing it.
>>
>>
>>> ...as that would also resolve this one without any hacks.
>>
>> I thought it was another problem, so I sent this patch.
>>
>> After looking to the kerneldoc of devm_mbox_controller_unregister(),
>> I
>> found that it's not necessary to call this anywhere.
>>
>> I'll drop this patch. Thanks for the review.
> 
> I found that the series of "Move pm_runimte_get and put to
> mbox_chan_ops API" can not fix this unbind crash issue.
> 
> It seems they are 2 different issues.
> 
> So I think calling devm_mbox_controller_unregister() in cmdq_remove()
> can ensure the CMDQ device is not removed and be paired to
> cmdq_probe().
> 

Can you please paste the stack trace of that warning that you're seeing when
calling cmdq_remove()?

I'm not convinced that this is the best solution - it might be, but I have
a hunch that there might be a better way to address this issue.

Thanks!
Angelo

> Regards,
> Jason-JH.Lin
> 
>>
>> Regards,
>> Jason-JH.Lin
>>
>>>
>>> Cheers,
>>> Angelo
>>>
>>>> ---
>>>>    drivers/mailbox/mtk-cmdq-mailbox.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
>>>> b/drivers/mailbox/mtk-cmdq-mailbox.c
>>>> index 4aa394e91109..1399e18a39a4 100644
>>>> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
>>>> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>>>> @@ -371,6 +371,8 @@ static void cmdq_remove(struct
>>>> platform_device
>>>> *pdev)
>>>>    {
>>>>    	struct cmdq *cmdq = platform_get_drvdata(pdev);
>>>>    
>>>> +	devm_mbox_controller_unregister(&pdev->dev, &cmdq->mbox);
>>>> +
>>>>    	if (cmdq->pdata->sw_ddr_en)
>>>>    		cmdq_sw_ddr_enable(cmdq, false);
>>>>    
>>>
>>>



