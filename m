Return-Path: <linux-kernel+bounces-531734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9E2A4443D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD6E3ADF18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC5426BD8E;
	Tue, 25 Feb 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CIanoWiO"
Received: from ci74p00im-qukt09090101.me.com (ci74p00im-qukt09090101.me.com [17.57.156.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1726B098
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497059; cv=none; b=qcGzz9dPqGqNvCvnjdm0J0TwztdlfJN4BdlKDRU7I37jT2STUuUz/Ap0b/vjfu1+cBZ4rjZ5S5woOMRUZRLf4cB4XkWVpH0LLEQbUJ+1atG23HkgILxc8d3enlr8LwlFJk/1y0ZcJHSLC/apm/npsOYphuoiHH9E6pjvNo+rBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497059; c=relaxed/simple;
	bh=KKCgr4XOuwhlA0iWbXJwU/5OQ3sqThFzQ7RQy/OTe44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMqyunXZoF36+1KIrwmlKq/UHKADY5hoFMS0nL5Zuuq4apbZFhoTHGjoF/oyoX2LYkFhN8GiEsBCxYnU4rKYqldti0Yca2VjZbmfqNLyeytudB8NX+1uiffbgMFnWGKF/t12eakjLUWFtgpFimWpBa+V6tSsfX4mqDwf3h+pPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=CIanoWiO; arc=none smtp.client-ip=17.57.156.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=KKCgr4XOuwhlA0iWbXJwU/5OQ3sqThFzQ7RQy/OTe44=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=CIanoWiO8J8PtwZ9J6YcNggtSK4U6hbju7kVkMu7k3fdtwWReomoyWbaJd4EuSCp4
	 XDG+TLp7JEh3BXwLJt6JJJBNHGx58Hf0RprD+XB/G6QPsNsin1NdfNcjxq6yyay0ej
	 CR7oiWzF6Qpb6azWRDUZji88f2o0tOe3xtukChB/Ho7V4KwWoHLsitXxHKzA3LbCCy
	 +ppDDD7w9H03Z27giG3XLMokamkKLKt41XPI4/DhupYuICwmf3ruqV/La04E/bvCz7
	 pZ9oZcQgSAbMN2zVqGfHoMhD3Kled8ppXjXNF2PztJ3Ml6ngkosV0vOcGJb6bvtR55
	 uaVPLu3LkV4cw==
Received: from [192.168.1.26] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090101.me.com (Postfix) with ESMTPSA id 7D7CA35C05F0;
	Tue, 25 Feb 2025 15:24:13 +0000 (UTC)
Message-ID: <cd4ec50b-dadd-490b-ab15-078dcf4bb02a@icloud.com>
Date: Tue, 25 Feb 2025 23:24:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] of: Do not change property state under
 __of_add_property() failure
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
 <20250224-of_bugfix-v1-4-03640ae8c3a6@quicinc.com>
 <20250225144108.GB2279028-robh@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250225144108.GB2279028-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7BBuBFw4b3gV4JIpSCjkpo_q-vHQT-Ln
X-Proofpoint-GUID: 7BBuBFw4b3gV4JIpSCjkpo_q-vHQT-Ln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=706 mlxscore=0 adultscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250102

On 2025/2/25 22:41, Rob Herring wrote:
> On Mon, Feb 24, 2025 at 10:28:00PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Do not remove the property from list @np->deadprops if
>> __of_add_property() encounters -EEXIST failure.
> A property can never be on both np->deadprops and np->props.

i made this patch based on convention that

This change is made base on convention that tasks which have
been done successfully needs to be undid if fails to do the
remaining task.


It is okay to drop this patch based on condition you mentioned.

thank you. (^^)(^^)

