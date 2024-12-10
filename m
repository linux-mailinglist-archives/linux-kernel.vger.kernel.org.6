Return-Path: <linux-kernel+bounces-439564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589A69EB118
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92386287543
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6340B1A4F1F;
	Tue, 10 Dec 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="TsyEOpjz"
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71D1CD15
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834667; cv=none; b=p5KtJ9N5gnCv5S4rOfmCuEOn9V/HgGK8kJX8OFR9BvlP4KhXhgrJ6EhlHTG08L4YlV+rJs0OcsA22f81pTfhrfS9utfEU6kuCPo4/TWGe0KGCTBi2cEnk0Bc7yv2sfh7scFIQ0nNnB1dob0hm0bXd0iZauQmdw9jpTFwBSehYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834667; c=relaxed/simple;
	bh=1Or8ky/gQQDQxZVueVYOIvTn9XadCmtEYG+XPJ56src=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HviwY0b/c2TMxdnCXnb4NKoNYNCkVuJm1g3ZxPg9FrbK1fVqUIPnLG3C3jHxOyBsEuPSY1AlWRCeN/YrpX9s6hWHYvowA4sWZeQGOI+jMZlxNdr0DmgIqGNT0Umwkm3SfwPZiSujOHC603a0vpdklGoLNnBOLJet9rC22LIMcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=TsyEOpjz; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733834666;
	bh=gQGh6Z9zgbZ/t+U8O/w7cP42QXHfGREQL95maqlbm9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=TsyEOpjzGPcIadc/luHREOBryqzXjhEv8qWjLiUNQ2XA7sCujaXrCeQmWp0SF1j3X
	 w9CWBDdYg9FhY9TyZWM/nhsp2/4jhgas83/r6GGpNyW5baDKKGfxj94v4Wxjb9cTiW
	 LfC0S+NDRRt6i0qWvPebQ+LfgJsgAUViQSmY8iFaZpIkBNlK9CFE8qMuMNUu5eiORm
	 XZz4GIiL+/H2wnkfUIyeFJ/4oEl96s7LSG+1MYklFMkajZxAG75AFoXX1ab9fpMeGa
	 gVOCzTTQgJIHxRPijdVEDaF1kVADxOTqOfqlTQb2TW5ase3UXaBG8ORv+r5w0/UDJy
	 8tNyks4MQeeeA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 2AC3B8E05A4;
	Tue, 10 Dec 2024 12:44:21 +0000 (UTC)
Message-ID: <dc989762-d868-44ff-968c-6d7be19e41cf@icloud.com>
Date: Tue, 10 Dec 2024 20:44:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] of: property: Implement
 of_fwnode_property_present() by of_property_present()
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Grant Likely
 <grant.likely@secretlab.ca>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-9-dc28ed56bec3@quicinc.com>
 <CAL_JsqJvh5pddoVEgaKQvGth0ncgtC9AAGxMEiK__NiZKrjmxA@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAL_JsqJvh5pddoVEgaKQvGth0ncgtC9AAGxMEiK__NiZKrjmxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l6rfo6fDJHytzY_G9afP-quudMfb-Lb1
X-Proofpoint-ORIG-GUID: l6rfo6fDJHytzY_G9afP-quudMfb-Lb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=766 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2412100095

On 2024/12/10 00:48, Rob Herring wrote:
> On Thu, Dec 5, 2024 at 6:54 PM Zijun Hu <zijun_hu@icloud.com> wrote:
>>
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> of_property_read_bool() is deprecated for non-boolean property, but
>> of_fwnode_property_present() still uses it.
>>
>> Fix by using of_property_present() instead of of_property_read_bool().
> 
> of_property_present() just calls of_property_read_bool(). For now. I'm
> working on making using of_property_read_bool() on non-boolean a
> warning. No point in this change until that happens.
> 

what about below idea?

replace all of_property_read_bool() usages with of_property_present()
then remove the former.

> Rob


