Return-Path: <linux-kernel+bounces-545926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FCA4F3D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F6A3A617B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839CA1459F6;
	Wed,  5 Mar 2025 01:33:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D61426C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138403; cv=none; b=rfsN4VDzrcRzV8BrbivzVPWjZtM5EP/pP986NdTe/UehBUqjQ0Lqj1IELKY2+tZ7sQHlxyhHwdHaZnDqRnCVcSdSP/S2jhPHwOa3z8doJ8Tlb7I2n3CZpuaeYASNqozrdu7IH8HotjCZ4hJW0L6EHTMV7ElEykraG8eHSmAc50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138403; c=relaxed/simple;
	bh=a2YxTZNCtN9SLn5Dl8H2Ghi94RIBMXtd0poWhdlap8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaKNh9ytYQi+SPl1vbUeciSQcYVSe/Vky3ioo8jkfRc2trOrim0a5Y+fVjMDb+MpjPvbfKRBQQnl+74uXVz8CHOFCdAgtbfgPIyVB/6Khbhva/dthWSWXlaE30DgxjdQLiO+ExixYiqlIRqIPPjTZbK4voBlIg9KWsFP7/CC9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cbf05f4cf96111efa216b1d71e6e1362-20250305
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:29ed36d9-0967-429d-b844-b4bf550975e6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:c5fa19545ebb2597eaf527003577d700,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cbf05f4cf96111efa216b1d71e6e1362-20250305
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 131484311; Wed, 05 Mar 2025 09:33:10 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 8D39CB803947;
	Wed,  5 Mar 2025 09:33:09 +0800 (CST)
X-ns-mid: postfix-67C7A9D5-483792230
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id 5BAD0B803CA3;
	Wed,  5 Mar 2025 01:33:07 +0000 (UTC)
Message-ID: <c3c638fb-e61f-47c1-860c-0cc024961fe4@kylinos.cn>
Date: Wed, 5 Mar 2025 09:33:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Optimize __vmalloc_node_range_noprof function.
To: Dev Jain <dev.jain@arm.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, hch@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250303094410.437985-1-liuye@kylinos.cn>
 <Z8XUP10G3cTJlbuw@pc636> <921fb496-ae14-4b6d-86a5-a18c492872f9@arm.com>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <921fb496-ae14-4b6d-86a5-a18c492872f9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/3/4 13:58, Dev Jain =E5=86=99=E9=81=93:
>
>
> On 03/03/25 9:39 pm, Uladzislau Rezki wrote:
>> On Mon, Mar 03, 2025 at 05:44:06PM +0800, Liu Ye wrote:
>>> The use of variables real_size and real_align in function
>>> __vmalloc_node_range_noprof is unreadable. Optimize it in four patche=
s.
>>>
>>> Liu Ye (4):
>>> =C2=A0=C2=A0 mm/vmalloc: Remove unnecessary size ALIGN in
>>> =C2=A0=C2=A0=C2=A0=C2=A0 __vmalloc_node_range_noprof
>>> =C2=A0=C2=A0 mm/vmalloc: Size should be used instead of real_size in
>>> =C2=A0=C2=A0=C2=A0=C2=A0 __vmalloc_node_range_noprof
>>> =C2=A0=C2=A0 mm/vmalloc: Remove the real_size variable to simplify th=
e code in
>>> =C2=A0=C2=A0=C2=A0=C2=A0 __vmalloc_node_range_noprof
>>> =C2=A0=C2=A0 mm/vmalloc: Rename the variable real_align to original_a=
lign to
>>> =C2=A0=C2=A0=C2=A0=C2=A0 prevent misunderstanding
>>>
>>> =C2=A0 mm/vmalloc.c | 20 ++++++++------------
>>> =C2=A0 1 file changed, 8 insertions(+), 12 deletions(-)
>>>
>>> --=C2=A0
>> Let me double check it. Quick question, this series does not
>> introduce any functional change?
>
> Yeah, the cover letter subject is misleading. IMHO it should be more li=
ke "Refactor" instead of "Optimize".

Yes, refactoring is more accurate, regarding real_size and real_align.

>>
>> --=20
>> Uladzislau Rezki
>>
>

