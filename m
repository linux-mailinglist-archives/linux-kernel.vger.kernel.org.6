Return-Path: <linux-kernel+bounces-533085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C448A45586
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102E41886CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB449266F07;
	Wed, 26 Feb 2025 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UDfvlGaR"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24FC29D0E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550981; cv=none; b=JiyBx+Q6gfirXEfWtbUd9kUymIWO+M9Kj4ZGGFKI+aaLCia1WfET3S8XgWsvkXuMkWtD3XmXSGS5hB9jDlfhbxiPeNj1XrNap8rinWpUxCKSPkHN07oqF3J2A869Ia24z66O1rmeqNMxxacRopW70FyUUBWsJvBtSFJ9Gt/abHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550981; c=relaxed/simple;
	bh=gaGT5q2hJkeCFwVBIUxi+ItVgLmJ9uiRm2cydxHO080=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJsq2O1CA2cwEXCtLFZYidnJ9unmXgBEqtpfkShgkBJ0Za3Mak+ipRIjzx2Jx74m7kpzi2XEu5zF35BtqdPw9RVUWKP8YBNsDMrDSFgnIhr7eETfaOAUtI71uVgbI+qnVeIrj+cu2XLl1uBH/Je/JlONrwe5hElOAGcpLjootuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UDfvlGaR; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a060cc7e-3d99-4483-937b-3a20476eb6b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740550965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p84KZbYiIU6m9SlSsr+aRK2OA82hVN0ETZwtDueX4s8=;
	b=UDfvlGaRHhHPkYtzzkJJsBohOAOqzj/RWd0TDW9TX9i4bnBDcW5cnu0No6nP1PvOQwuMIc
	2Vf693IH3A7zq2ZyYSpRH7I37QZB9lSTvtu4u4JWAcG5yh/KMKWfBQiIEcqvVuG4yjl1DI
	+T6Uvxd4PGrc3rUzSDZhrlN2lm0a8sE=
Date: Wed, 26 Feb 2025 14:22:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH linux next] Docs/zh_CN: Translate msg_zerocopy.rst to
 Simplified Chinese
To: yaxin_wang <yaxin_wang_uestc@163.com>, corbet@lwn.net
Cc: alexs@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
 wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, he.peilin@zte.com.cn,
 tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn, zhang.yunkai@zte.com.cn,
 ye.xingchen@zte.com.cn, jiang.kun2@zte.com.cn
References: <20250226014942.2586561-1-yaxin_wang_uestc@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250226014942.2586561-1-yaxin_wang_uestc@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/26/25 9:49 AM, yaxin_wang 写道:
>> <jiang.kun2@zte.com.cn> writes:
>>
>>> From: Wang Yaxin <wang.yaxin@zte.com.cn>
>>>
>>> translate the "msg_zerocopy.rst" into Simplified Chinese
>>>
>>> Update to commit bac2cac12c26("docs: net: description of
>>> MSG_ZEROCOPY for AF_VSOCK")
>>>
>>> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
>>> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
>>> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
>>> Reviewed-by: He Peilin <he.peilin@zte.com.cn>
>> So how did these reviews happen?  I have certainly not seen them on the
>> public lists...
>>
>> Thanks,
>>
>> jon
> xu xin and he peilin are my colleagues. They helped me with the internal
> review of the document and did not participate in the public lists review.

Unfortunately, this cannot be archived in the lore, so it is not suitable

as a basis for community review. how about:

:翻译:

    王亚鑫 Wang Yaxin <wang.yaxin@zte.com.cn>

:校译:

    - xxx <xxx@xxx.x>

    - xxx <xxx@xxx.x


This can better highlight their contributions.


BTW, If your colleagues want to appear in the signature

section of the patch, subsequent patches can be reviewed

on the mailing list. Everyone on the mailing list has the

right to observe the review process.


Thanks,

Yanteng



