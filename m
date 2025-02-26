Return-Path: <linux-kernel+bounces-533567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B331DA45C21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F961891284
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22C20E020;
	Wed, 26 Feb 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="u8jNnmbp"
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC720CCEB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566982; cv=none; b=PyzYqRP9W8uxPNGppIKfyIoydaS2BBuC9cFDyl+hOxSBVZfxzUv13bIiVX8jzLNleG+XQ7WHAwapeDPFFTzycKT6xeTo8aaw4SecX8FKOGxi3FUns+9PVDmwCm8HZRzTAhNNHwfvJ3DEdfxgajOVuY4NtC/MJVIyJzgUkerc1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566982; c=relaxed/simple;
	bh=/ksErclY+a2HfY+n6eyQP1xvxnb1/u05wmeZJj/ugy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITKbE3IHzyrulVMy0mTozMu0UBIuR3k6l2lrxaCPVlUDKTHR51CZxhlcpHbkjgiLu1QmEu3T7yyPkgbn1asd3YU8XgEhQBzOHDcgBB3EfOSkXzkxuF95wkX5SWklnu9zefC6bYQM9pWJy9t4WyH12vjExnmYtmpry9osBNGx/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=u8jNnmbp; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=rZ/JKLqvgcs6sxz9YBuHcFMLh6kDf+x72Yif1lbgen4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=u8jNnmbpJbeehjrSua28dZ0/xMaBJoS73delakyASdo1yTPjiYiMhTZHl5m6a6D/Y
	 uCkpbNxVjfvP09X8stV6LlLFTwwVJa8Ygzr2SdyFIZT2gzSr2Iq7cScxglsLfz+T8F
	 RQt/ZThY+PMDeI48gg6gWlAOc3iR7Hj/4duOAzfxJz9xfFIhwz5ZUXU5YusMcBvFDV
	 mN2zsXCGGiHn80xrDB6nHQ5JYm0V0D9TPFeL3k9FBsL0gmJhVaFyDERWQUzkfCqSZN
	 kqvITJUr2BS1RYcNJUP9LTZ5/bv0FgMlIsH2a8c77mo9uTSojeII0oo3eNz7vJXkSR
	 Ac0H71kX+3eCA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 2A81168011A;
	Wed, 26 Feb 2025 10:49:34 +0000 (UTC)
Message-ID: <aa24e5cf-3a32-4792-be0f-9b8d190730d2@icloud.com>
Date: Wed, 26 Feb 2025 18:49:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] of: Align macro MAX_PHANDLE_ARGS with
 NR_FWNODE_REFERENCE_ARGS
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250225-fix_arg_count-v4-0-13cdc519eb31@quicinc.com>
 <20250225-fix_arg_count-v4-2-13cdc519eb31@quicinc.com>
 <Z73RssDaLZ1NLpSZ@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z73RssDaLZ1NLpSZ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 05sHnAVq0PQ3X_GllbBMIWh8EHQfvioA
X-Proofpoint-ORIG-GUID: 05sHnAVq0PQ3X_GllbBMIWh8EHQfvioA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 mlxlogscore=760 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2502260086

On 2025/2/25 22:20, Andy Shevchenko wrote:
> I would add here that the of.h includes fwnode.h already, so it doesn't
> add any new compile time dependency.
> 

thank you Andy for comments.

include/linux/of.h:
struct device_node {
...
	struct fwnode_handle fwnode; // this type is defined by fwnode.h
...
}

include/linux/fwnode.h:
struct fwnode_handle {...}

So of.h must include fwnode.h


Perhaps, of.h needs to include fwnode.h *explicitly* even if this is
another topic.

> Both patches LGTM,
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


