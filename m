Return-Path: <linux-kernel+bounces-441233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1109ECB83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E795188A855
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FD6211A2A;
	Wed, 11 Dec 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="kuRM/eZ/"
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2128211A26
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917458; cv=none; b=DWfRh2bxjJybXccIRIokxNB6fi63wB3h56S/+Gg2cXDZLjb5eh4tfl+oSlmA/0iD0hANhj8bkqtBi+JP0rTAf63vttz60JsdHdXwdH9+9MKllXa7WTrana5MPUCNYyIejzzfFLK3HkHVJxmXmHA9Rg0Lwuua3etS4BqY4H8C0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917458; c=relaxed/simple;
	bh=RYufHWxSlkzSmjLTGP6SJrhGZCpAoM0Qu5uSmhrjUgk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=srja1ObPWkaWPPwMG9h4/qBXz7fgse1yoZIALzPAZUzaJGAGSHzI1zym6XkHVd2cMiQN9BsoT9Xmdswpo3Qo6jhGN8+B9c8fBtcEDsbyCv6AxLUwFaveX/mjHXm9KZGLhT59bEH18yBHQv8GcC7bnng/D4pHbalZXwEZHdTKtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=kuRM/eZ/; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733917456;
	bh=olsUnbbcCu4bwm3gBuWccI/504DZmXXYNoZZOMNxRa4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:
	 x-icloud-hme;
	b=kuRM/eZ/ATjHo1O4i0Ug8Tvies0uy9YI9hphNsvITSWbkJNF+SmfMg7o4kuHBjG6v
	 y//ey3faQrpbRDaHJODNHv1Sdiaf8b7A4Wgu0GfiG6xbRl3vaY6SVwyTWXxVMOcfjT
	 i27oEVLtFbbckO56N04hRrU4rlbeqyZGImng4gXpGKSE7zBCJFYwroEJZAb+SMZTP1
	 a/G7W0P3sfcs+lQVecYxySIrD0ufrnHeka0pbf1RCJH+bSvha6veL2wmnfLly7Hdqx
	 D0pFq8oCJnRYXvwjTWlR1Mj/dqZLr79AMLuCakK+jTAR/x4wUoBQk8vbZ/NPJMd32X
	 7o4wlkF+rfTbw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id EC3CF2010252;
	Wed, 11 Dec 2024 11:44:12 +0000 (UTC)
Message-ID: <696f754e-605e-4564-9d17-b197b72ec055@icloud.com>
Date: Wed, 11 Dec 2024 19:44:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zijun Hu <zijun_hu@icloud.com>
Subject: Re: [PATCH 05/10] of: Fix available buffer size calculating error in
 API of_device_uevent_modalias()
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Maxime Ripard
 <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Grant Likely <grant.likely@secretlab.ca>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-5-dc28ed56bec3@quicinc.com>
 <CAL_JsqL+CRmCQMzcF4-A-PRBrCsfK8nduJtOO=RrsDtCUUR7og@mail.gmail.com>
 <14fe473e-5f56-4a61-899c-bbb79e2aed3b@icloud.com>
 <CAL_Jsq+Aap9Kjzcd5H5m9ArcXMWRogoT0CdPnz4-d8OeRgadUA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAL_Jsq+Aap9Kjzcd5H5m9ArcXMWRogoT0CdPnz4-d8OeRgadUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Gwo7sHspSDEBi0l84sogjbAdEQ_lpRxJ
X-Proofpoint-GUID: Gwo7sHspSDEBi0l84sogjbAdEQ_lpRxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412110086

On 2024/12/10 22:10, Rob Herring wrote:
> Ah, right. However, we still end up with a truncated value though it
> is nul terminated.
> 
>> 2) both env->buflen and env->envp_idx are not updated once @env->buf
>> does not enough spaces then failed.
>>
>> current logic has no difference with normal add_uevent_var() usage.
> There is one major difference. add_uevent_var() will not output
> anything if the whole string doesn't fit. Whereas we might output a
> truncated value because the add_uevent_var() call updated env->buflen
> and env->envp_idx. We could unwind that I suppose, but that involves
> even more mucking with the internals of the env struct.

you are right.
i would like to try to solve involved issue in next revision. (^^)


