Return-Path: <linux-kernel+bounces-280832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF52894CFC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B043282D72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF32192B82;
	Fri,  9 Aug 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zPLhWBZs"
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998801553A2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205107; cv=none; b=QPsEd/EkM3NXLYReUf0xZvsCU0cgQffs6haR5IsXGpf7Y8Y+YHTeYAic8p7+6aGZ+mhpaRUHmEuv8j7reFMxKr8PgDQnejVMLL7QXuRbGQzV/t9bna2W5k0C66c1KGMQmZiyqdoyPRnBvAnHNdYO91G9JKU3istoXdWGQQ4gB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205107; c=relaxed/simple;
	bh=aQmufaufbrUJgVw0unwrNxyrz6qqTbQCxhkQayxDZ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LO5ZNurIPJvLDotlBXyBftSltDeozCUScTOJ9yPtujdtTMaJTnpC4gSu5vpgg6RU0XQ6a9StPyENoQ2Gv20Q++Nagt3SHY0gNcNle4xQpBYA8ofu0By+ynKX3AZuLTYA8Tb+iQ2R/I3AG+XOh5UPafzmi7b+00BluTANwkmUgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zPLhWBZs; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723205106;
	bh=91ku7gZIyYNJbyF7z6zrP3dy9raxhhiSk8CHiD8KfgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=zPLhWBZswlJ1MEKK3ZH7NHY78XHo0vkZRWmYC4DhPWyls+rj7aN0T3/1J5t3YG+no
	 znCbjIJb/p7f4vZXN+g2aM981rDLaAxU/hCIMzRXQcjYckKrOz03sc4QtWkA7TN8lc
	 U0tmVGvsbatprdF4KTOuWCSktHR8lPOi8lB75yvMVgFYquZEai1FaK7rseS3/4wQgt
	 VGLL9ktlfIlYiZfK0jKTPqz448NywiTxjXQgSjbqvZ6riE5QDdWXSlr2R8BqbM2UOd
	 xk77hgxrm5nFsCp9lOZFgRmWh3gitMW0eme0z4Pc51/1/8CvcQbgMwOnqv8y2y/y/z
	 0OIJh0pZ7T+Zg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 09877500145;
	Fri,  9 Aug 2024 12:05:01 +0000 (UTC)
Message-ID: <ff11cab0-6dfd-407c-8039-3dfd873e7280@icloud.com>
Date: Fri, 9 Aug 2024 20:04:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux/container_of.h: Remove redundant type cast in
 container_of_const()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240802-container_of_const_fix-v1-1-90e7a5b624f9@quicinc.com>
 <ZrX9G2Ol2jt4o-s7@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZrX9G2Ol2jt4o-s7@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GjZA7YvFAi6EvkXUvYot7wfn9wY58hTX
X-Proofpoint-ORIG-GUID: GjZA7YvFAi6EvkXUvYot7wfn9wY58hTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_08,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 clxscore=1015 spamscore=0 mlxlogscore=879 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408090088

On 2024/8/9 19:27, Andy Shevchenko wrote:
> On Fri, Aug 02, 2024 at 11:15:15PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Remove redundant (type *) cast for default branch in container_of_const()
>> since the cast has been done by container_of().
> 
> While it might have same effect, the below is explicitly clear about both
> cases. With your patch it will become inconsistent.
> 

my change is more obvious to say that container_of_const() is same as
container_of() for none const pointer parameter @ptr. it is simpler and
easier to understand.

> ...
> 
>>  #define container_of_const(ptr, type, member)				\
>>  	_Generic(ptr,							\
>>  		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> 
> (see, in the above line the cast is still present / required)
> 

yes, for above case, (const type *) is suitable and required.

>> -		default: ((type *)container_of(ptr, type, member))	\
>> +		default: container_of(ptr, type, member)	\
>>  	)
> 


