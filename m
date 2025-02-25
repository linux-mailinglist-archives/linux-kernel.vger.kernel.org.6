Return-Path: <linux-kernel+bounces-531707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160CCA443FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14C13BA2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA9268692;
	Tue, 25 Feb 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ESMyZAlv"
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455E26A1C1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495906; cv=none; b=Acr4pGduA93zp9e+/qX51F+kE2WZ464DiWT0wT2zOmsPdzK7SpkTuJ3ZFL60UxsehQfF0QkbtAG+YoqEBNCBGBhvjciwzFxJJjG5ZZqJyZvfo4QCXXf7PVfhWA4+L2XghUr15FLbdOpVYmXwbRqe7wraW83duYEi6T8zSnfbUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495906; c=relaxed/simple;
	bh=OqIUwNrI2NRVYapWjZN4ov2VJL8MMbFqYHRE3TL8lps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSEFodt98BGm0dnl0dUvMcgfnOqSYE6oBmWu0Ikq8/JuUMuTXXbfI6o0m77gIjDVuO/LQcP1QRbQHh2bwvxNoGe+GW6meqt3jmnOzJyswnn3Bb5TCOsjk9HsmhZpW6kngRZ+luYTydSrzGCtOp/clkarVTO1QwHdwchv1/h2PZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ESMyZAlv; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=q87VqXrF2/CmhKNXioWRVSBysK57pH279yUQysqPB0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=ESMyZAlvgvWfdOYJZRFBB97U30piSmDiH0/KmQJ0XSHfol0Xb1WzIdOEjTP7eggeX
	 47DDRfGAtpIe97KSZgtbUr/5IziZx3MItS22LCIcbLptFq8PPNKTn9ZS5xrifGhHh7
	 GbN+R4cXAlRItzoPoUjfR/Zf9QVmQN/kY5xLgm38ySpVLWtRaqnRCCJAxutThHOxTv
	 zHyJJ39O3qGxGskuGj3kWCDgXMxlE3znp92g6AWv+gBbZ7zLe5b0FZAnSTfoe0ilKk
	 GXKnqzh6ISHo25oz/1qJI7lsJ3AV6GdOVYeuFeRUqT+q1SRzvAgEJMR6yU4oYPs2be
	 YrybiI1z9Lj5g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id EC8DE1804BF;
	Tue, 25 Feb 2025 15:04:59 +0000 (UTC)
Message-ID: <e6faab90-b4f3-4c73-b486-2e44d15d22a2@icloud.com>
Date: Tue, 25 Feb 2025 23:04:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] of: Correct property name comparison in
 __of_add_property()
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
 <20250224-of_bugfix-v1-3-03640ae8c3a6@quicinc.com>
 <20250225143844.GA2279028-robh@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250225143844.GA2279028-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: --H0-2Ohtd1z-A1QUBh5rO5UZOF2IauI
X-Proofpoint-ORIG-GUID: --H0-2Ohtd1z-A1QUBh5rO5UZOF2IauI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=628 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250101

On 2025/2/25 22:38, Rob Herring wrote:
> On Mon, Feb 24, 2025 at 10:27:59PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> __of_add_property() compares property name by strcmp(), and that is
>> improper for SPARC which wants strcasecmp().
> Except that 'name' is the nodename (usually, with a few rare 
> exceptions). Sparc node names are case sensitive, so strcmp was correct. 

Here, it is property's name and NOT node's name.

arch/sparc/include/asm/prom.h:

#define of_compat_cmp(s1, s2, l) strncmp((s1), (s2), (l))
#define of_prop_cmp(s1, s2)	strcasecmp((s1), (s2)) //SPARC HERE
#define of_node_cmp(s1, s2)	strcmp((s1), (s2))


include/linux/of.h:
/* Default string compare functions, Allow arch asm/prom.h to override */
#if !defined(of_compat_cmp)
#define of_compat_cmp(s1, s2, l) strcasecmp((s1), (s2))
#define of_prop_cmp(s1, s2)	strcmp((s1), (s2))      // others HERE
#define of_node_cmp(s1, s2)	strcasecmp((s1), (s2))
#endif

actually, later __of_update_property() and __of_find_property() use
of_prop_cmp() instead of strcmp() to compare property name.

perhaps, compatible and node name also have similar issues in current
OF codes.


