Return-Path: <linux-kernel+bounces-224163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F26911DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5051F250F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD1F16D9C6;
	Fri, 21 Jun 2024 07:57:39 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE516D9B2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956659; cv=none; b=u3wtomtPCFvGACqf5agi4pPN5PJMYyQRYrshO31nBp1HvrGFKjVVPOyKCvSIplMrclTTyy5Xbdu2GfR7Edseedm5LPmLRNFl6owy1mI4FlBnC9rgmuglGZD2lbeLYqTM5H3e1cFT1TIRM9fB4SN5ajsQDow79wohj2eof6MpUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956659; c=relaxed/simple;
	bh=XwzgDeJWleg5OR247GUJYTPFQ0uyUzPPoq151hb0C8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIv/vMzVm+VpSl2gt9NsRCb5aSku2HiRS5s1OoerLPjp6KlA9VbEILksZsSDPiceeqlglF3FEWGRcRThcWwm0J6nh9uFt/z/BPZyQeHDrMHCT4oXr8hWQ56RFMNLXHTxZlOW1mr4gmAM0Rcl+5BpcZjmokEn97Eb2Cw7HBZzXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e3280df02fa311ef9305a59a3cc225df-20240621
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:dd247ac0-53fc-4c76-8205-049e773f2f19,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:6
X-CID-INFO: VERSION:1.1.38,REQID:dd247ac0-53fc-4c76-8205-049e773f2f19,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:6
X-CID-META: VersionHash:82c5f88,CLOUDID:a4c1103e4110ee529d51a5886313aa4f,BulkI
	D:240620044834U5B7J34Z,BulkQuantity:2,Recheck:0,SF:64|66|24|17|19|43|74|81
	7|102,TC:nil,Content:0|-5,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:40,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-UUID: e3280df02fa311ef9305a59a3cc225df-20240621
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.255)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 171995361; Fri, 21 Jun 2024 15:57:20 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: markus.elfring@web.de
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev,
	lihongfu@kylinos.cn,
	linux-kernel@vger.kernel.org,
	teigland@redhat.com
Subject: Re: [PATCH] dlm: use KMEM_CACHE() in dlm_memory_init()
Date: Fri, 21 Jun 2024 15:55:33 +0800
Message-Id: <20240621075533.86674-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dec3e8d9-0a29-4e9b-afb5-888aaef4780d@web.de>
References: <dec3e8d9-0a29-4e9b-afb5-888aaef4780d@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

>>> Can the three passed name strings matter still for the identification
>>> of the created caches from this function implementation?
>>> https://elixir.bootlin.com/linux/v6.10-rc4/source/fs/dlm/memory.c#L27
>>> https://elixir.bootlin.com/linux/v6.10-rc4/source/mm/slab_common.c#L362
>>
>> probably only for "dlm_cb" that turns into "dlm_callback".
>…
>
>Will the development attention grow for deviations of passed name strings
>from applied data structure identifiers?

My initial purpose is to replace kmem_cache_create() with KMEM_CACHE().
In my view，there is no problem in unifying passed name strings and
structure identifiers.
Maybe that's wrong，I will resubmit a patch that does not change
"dlm_cb" to "dlm_callback".

thanks,
Hongfu Li

