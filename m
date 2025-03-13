Return-Path: <linux-kernel+bounces-558664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75496A5E930
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82B0177D29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D6208A9;
	Thu, 13 Mar 2025 01:05:31 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF71C695
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827931; cv=none; b=s63NYKH8B/XYGcjBSCdetHYRjKTNVUb4NhkqqD0XFKwVMPShgVzTFSjZzPDtA6wN6+/975tHOGdb3pAk0eTVPdZynBJbrNccdGUPOKxT3Wvxtv3ECugHDZJnCYTEml0jqMcG0XQ/u0OkkmvIlV6uh0qg/l00z0VBpc8u1H4f7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827931; c=relaxed/simple;
	bh=WCQsMq0EyD/YZjEzr8cKdGuD6oskaUsOa1tNnxvM2Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDXCn1xzRnMLzYzB6fY6WnSSNayK7rfEs9jeAQbFICnc4tyXB6jzyPhNcfPu1PwV2Khnj4MhPmOQnmtObZGwaTIbRAKFgsWoZMp7ldN5BpX4NeILDO30kcO/GY0rdqeW76u3qKNr8Vv1/zsIcL1TKxpgQayHFvromO5vloYccYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 39e1e5f2ffa711efa216b1d71e6e1362-20250313
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bbd193c5-dadb-49de-b249-730427404302,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ca730cb57221af9a06bb235bb51d9a23,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 39e1e5f2ffa711efa216b1d71e6e1362-20250313
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1052669869; Thu, 13 Mar 2025 09:05:16 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 826CCB804E8F;
	Thu, 13 Mar 2025 09:05:16 +0800 (CST)
X-ns-mid: postfix-67D22F4C-402505127
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id 7840DB80758A;
	Thu, 13 Mar 2025 01:05:15 +0000 (UTC)
Message-ID: <fa38b65e-3271-4989-a95a-64bd8c37441e@kylinos.cn>
Date: Thu, 13 Mar 2025 09:04:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/debug: Fix minor issues in mm
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250312032344.297946-1-liuye@kylinos.cn>
 <Z9F8JYitsY9viNg4@casper.infradead.org>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <Z9F8JYitsY9viNg4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/3/12 20:20, Matthew Wilcox =E5=86=99=E9=81=93:
>> -	if ((head & 1) =3D=3D 0) {
>> +	if (head & 1) {
>> +		foliop =3D (struct folio *)(head - 1);
>> +		idx =3D folio_page_idx(foliop, page);
>> +	} else {
>>  		foliop =3D (struct folio *)&precise;
>>  		idx =3D 0;
>>  		if (!folio_test_large(foliop))
>>  			goto dump;
>>  		foliop =3D (struct folio *)page;
>> -	} else {
>> -		foliop =3D (struct folio *)(head - 1);
>> -		idx =3D folio_page_idx(foliop, page);
>>  	}
>> =20
>>  	if (idx < MAX_FOLIO_NR_PAGES) {
>=20
> How is this "simpler"?  It seems like churn for the sake of churn.
> NACK.

This modification simplifies the condition check by directly testing=20
head & 1 instead of using ((head & 1) =3D=3D 0). The updated logic first =
handles
the case where head & 1 is set, assigning foliop and idx accordingly.=20
This improves code readability and reduces unnecessary branching,=20
making the structure more straightforward and easier to maintain.
I am personally accustomed to this format, but if it is not accepted=20
by the majority, then drop it.

Thanks,
Liu Ye                                              =20



