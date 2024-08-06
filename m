Return-Path: <linux-kernel+bounces-276100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB8948E57
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A792816D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481771C3F08;
	Tue,  6 Aug 2024 12:06:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399122A1CF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946006; cv=none; b=Owd/HrmjPPXnLlybBCkW4DN2K2YfQC4DxVOOblDjNCPHb0stZKxQmgNKFBhDRp3WNLxhLCk5y+acApEvCFvPBknAplxY3xRnDEvs8w2IRRM+bYNxreB9gTU8bY3o59ZKrSmALjeIuFFJ/FQCpOK83o/ktucLn1uNMlPGxRXKOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946006; c=relaxed/simple;
	bh=GfhlcP60k44vfj6NXoBT+7p/J37Ju1rc5WGZaRjwZ3w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G64XtQV07U38MuSGiZVbrltn7SUO+ltDvu2KpO7M98F7Wfvmg/vJDmX5IR33R0l7m40s7kkMytLOaHkAIt151lp9KWYlOPwFONTJh01OzpPz1lZIRy8A8J6R4VFW9oNM7IjH3QRO+c8pPUHm5poSmSvYzVbdBVKPRQl1e/LABh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WdX7d0TvQzpSvD;
	Tue,  6 Aug 2024 20:05:33 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id B450618006C;
	Tue,  6 Aug 2024 20:06:41 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 6 Aug 2024 20:06:41 +0800
Subject: Re: [PATCH -next] spmi: pmic-arb: Add check for return value of
 platform_get_resource_byname
To: Stephen Boyd <sboyd@kernel.org>
CC: <linux-kernel@vger.kernel.org>
References: <20240803065625.347933-1-cuigaosheng1@huawei.com>
 <17286822755c4420d3ec2e405ccab41a.sboyd@kernel.org>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <921e3180-231d-ff14-32a4-4bd5dbed2f32@huawei.com>
Date: Tue, 6 Aug 2024 20:06:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <17286822755c4420d3ec2e405ccab41a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Thanks for your time.

I've made and submitted a patch v2, and I think the right fixes tag is 
as follows:

Fixes: 39ae93e3a31d ("spmi: Add MSM PMIC Arbiter SPMI controller")


On 2024/8/6 5:55, Stephen Boyd wrote:
> Quoting Gaosheng Cui (2024-08-02 23:56:25)
>> Add check for the return value of platform_get_resource_byname() and
>> return the error if it fails to catch the error.
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> Is this the right fixes tag?
>
> Fixes: b319b5922db2 ("spmi: pmic-arb: remove the read/write access checks")
> .

