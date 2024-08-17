Return-Path: <linux-kernel+bounces-290625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C9955674
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94EC7B2160C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C66C1448FA;
	Sat, 17 Aug 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqKv1fF/"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A912FB37
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723884407; cv=none; b=TOLdJU3M9kgpeXbpC/9T7cCtU4CVH3ibOZlF83V4vTU6uhTj/j17o74b9mn3mBYtB6+iwnXmqhvgdPYAhSxMRdZ8JIwhrSqmQU/ZNL7LyvjtcOJ2MCIrFNdyPIq5Qol9Di0Mej/uCHPSAle0kHNIGV0z/zC3ZBGzhQu4TUTtBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723884407; c=relaxed/simple;
	bh=HgGLgbu1/qWVx1lyyESDChPt/OUUW1ebFpe2qoF8JxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLAh2ufLsSLD7H6L5cHkMllroRCXhacrxVch748x2KVzOIpY9jNNVqiY9N52YtOjkptZ7pj2ODZIy+jqkT1cMT6oEC3VvamyTuQBOhxNP7Ub/o1L93oHZj4lgJV4bpATkJjIT2ZpINkKVqlrAZlvNDN8lwrvbo/ZdZHwWvJtz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqKv1fF/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5377e3e7-9644-4e71-8d2f-b34b2b5ae676@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723884403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGHIyJLxgTPX0taP7YAbOFdfgE44JycCOF1YZWtuhWI=;
	b=RqKv1fF/88Z+Xul3C305DJxXKKxibkUnzyg61xqo1g6L5Cyra7uxiE8zm755V84DyKBwIa
	Rc4X9Sh23MUqHGjuaWkcsW234Jm6mVP0YWx+dRwllUK98tY0YEHMp1yxGjukzqiaHVHq20
	aGApkRYDo5GijH+AdT++w3A/XNxbwMc=
Date: Sat, 17 Aug 2024 16:46:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linus:master] [RDMA/iwcm] aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Bart Van Assche <bvanassche@acm.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-rdma@vger.kernel.org
References: <202408151633.fc01893c-oliver.sang@intel.com>
 <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
 <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
 <717ccc9e-87e0-49da-a26c-d8a0d3c5d8f8@linux.dev>
 <3411d2cd-1aa5-4648-9c30-3ea5228f111f@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <3411d2cd-1aa5-4648-9c30-3ea5228f111f@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/17 1:10, Bart Van Assche 写道:
> On 8/16/24 5:49 AM, Zhu Yanjun wrote:
>> Hi, kernel test robot
>>
>> Please help to make tests with the following commits.
>>
>> Please let us know the result.
> I don't think that the kernel test robot understands the above request.

Got it. I do not know how to let test robot make tests with this patch.^_^

Follow your advice, I have sent out a patch to rdma maillist. Please review.

Best Regards,

Zhu Yanjun

>
> Thanks,
>
> Bart.

-- 
Best Regards,
Yanjun.Zhu


