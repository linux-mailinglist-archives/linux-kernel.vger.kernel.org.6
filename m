Return-Path: <linux-kernel+bounces-209739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F6A903A17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2FC1C2034D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCAE178CF1;
	Tue, 11 Jun 2024 11:30:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24DF1509BC;
	Tue, 11 Jun 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105426; cv=none; b=Vx72NNQtGoKIOLi/t3ktEYh5VeDR7gv/zXTPM8lc3gsWT+HKngkQSt704bFdNZWujeFc7DSz/I+GvbYrE65FroDxxrmB4sEtmcA4HU3XpnuOetp3N0aiZErpQH1hmWSM6fgyfFWxjvd8H2ysPn6yDOe/Fp4/7Lu3flnRnxGREVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105426; c=relaxed/simple;
	bh=fg8NiSElpPdhVE8j6zGK3dzwzl3ZHR6ya77REGJa4BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u1HOj8h9FeXwgDcqjUwB1S0kzZ8B/SKutqHb4cTuCZ8Nd4q7bPnjx0SrYCpNcJKoi5FTurp87Q5wJFMjmmN6kdAGo7y+FDn5oMAKYKHeoIG+TOxQ1DaogSSt7aYi48wF5YRXIUs2I3z/Emq7i15urhLgxRebkcCw5NVozzLiU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Vz5yg1S2xz1HDTq;
	Tue, 11 Jun 2024 19:28:27 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 305A714022E;
	Tue, 11 Jun 2024 19:30:21 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 19:30:20 +0800
Message-ID: <85948141-5eae-bb3d-cb39-62fc6ddfe476@huawei.com>
Date: Tue, 11 Jun 2024 19:30:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: CVE-2023-52666: ksmbd: fix potential circular locking issue in
 smb2_set_ea()
To: <cve@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cve-announce@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2024051727-CVE-2023-52666-802b@gregkh>
From: Wang Zhaolong <wangzhaolong1@huawei.com>
In-Reply-To: <2024051727-CVE-2023-52666-802b@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200001.china.huawei.com (7.185.36.224)


> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/5349fd419e4f685d609c85b781f2b70f0fb14848
> 	https://git.kernel.org/stable/c/e61fc656ceeaec65f19a92f0ffbeb562b7941e8d
> 	https://git.kernel.org/stable/c/e9ec6665de8f706b4f4133b87b2bd02a159ec57b
> 	https://git.kernel.org/stable/c/ecfd93955994ecc2a1308f5ee4bd90c7fca9a8c6
> 	https://git.kernel.org/stable/c/6fc0a265e1b932e5e97a038f99e29400a93baad0

Hello.

Is this a valid CVE patch?

I noticed that the introduced `get_write` is not being used within the
function, and there are no follow-up patches addressing this.

Best regards,

Wang Zhaolong

