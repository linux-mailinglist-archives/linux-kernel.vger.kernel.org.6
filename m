Return-Path: <linux-kernel+bounces-437710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E189E9760
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB141644DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3718E1494BF;
	Mon,  9 Dec 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NryVIMsm"
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF18233153
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751697; cv=none; b=kBXxJ/So1oQhkqLpQTY/H3eztGhh5H8XjZ3uguS3laO5WrC7jvueZTsN+k4bzFMivQVuJX/8kU6BIXihu5P4HyEaURl3oXolaMk8Wa0oRinBnaxPDBQG0p+45acrDgBt36Oi0qJ/50d09nYtRiZeLUDyuWGcw9drhea3ossU7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751697; c=relaxed/simple;
	bh=AmIxAwkqlVYeUPkw5/lUuMmgHFOjGjRmRw5ewsvfR1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1NSeCU+4QMga5ImZTmKcjjMkJaXTmO8v6mUZmJ3lAuLD7oWscDEMwH4wENZLC4AWyf1mpybaoW6fZ8kDVPJGiBKW0pUZw+8oHY8mAuLCe200tHYm6XUruNc2JoJlEeI/+hif9qLp/mcD8tqZc8sNnmHFGRgUavY4Dk3wq8JavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NryVIMsm; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733751696;
	bh=48ORRjnxh1RphtbhEPkmlQ3TPP2pu7GTYRawebDEkPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=NryVIMsmBEvPvzowLphkIYq6Yyd1g+eVxLfZvSQASrd5jjmVp2jjdeFw1lKYSh90Q
	 IugfLHil7iVdLtT+o0i/Vbm4G0QQBv2j3rsOCNxAPDAj/jucfsezHSRMspELIb9w/4
	 7yvGFDDnoDvgKX0iGTktfH/fwX4MhRbMp1R9eVKBEZIaRlwTTmAmL/HkV2XHOlJR60
	 I9oN8VMH8+0GgF+jYIv0OHJ2S/5hqEhvAukQrEEDm5tHhRWZI4PwBQJRla+eu+AIoA
	 20HpPJBHPd4cyhQPBlFm8d5gmd+2LHl/LX5PE+lVnWWnOhWticciRCWP1inzsPcSOm
	 GTO3WbRwgyBUA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 4D3B0800252;
	Mon,  9 Dec 2024 13:41:30 +0000 (UTC)
Message-ID: <05251181-9b8a-496d-8439-d03460b2fe42@icloud.com>
Date: Mon, 9 Dec 2024 21:41:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] of: Correct comments for of_alias_scan()
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Grant Likely
 <grant.likely@secretlab.ca>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-7-dc28ed56bec3@quicinc.com>
 <CAL_Jsq+140YAXAtxmb4FPdk2C2EZSJ-9AjOz5ik6jK4oHLOdDg@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAL_Jsq+140YAXAtxmb4FPdk2C2EZSJ-9AjOz5ik6jK4oHLOdDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aPkUQO5db_9S1pR6bskGijzRBdsT45Mh
X-Proofpoint-ORIG-GUID: aPkUQO5db_9S1pR6bskGijzRBdsT45Mh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_10,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=881
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412090107

On 2024/12/9 21:20, Rob Herring wrote:
>> - Replace /* with /** to start comments since it is not a API.
> But it is because it's in of.h. However, you are correct in that it
> has no external callers. So please move the declaration to
> of_private.h.
> 

thank you Rob for code review.
let me do it in next revision.

>> - Delete return value descriptions since it is a void function.


