Return-Path: <linux-kernel+bounces-254632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E59335A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC611F2238C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104C6FC5;
	Wed, 17 Jul 2024 03:30:20 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0819A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721187020; cv=none; b=MwwHq5GTV9QdMFUADRkGfLdfCQL0c0UCd4tHIrg+YBOjY+jgi2Ky+rpET1vhsUCSL1CfDX9HoeEWGqxlqN+GDya5xUAl9uQ6tZqqo1srwyy9IY11gfYkCr9AbJ6n5fyWduXddTo/X0HTSslS2D1/qCxtifC8y/b1nUuXzpA/x6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721187020; c=relaxed/simple;
	bh=NqpNoeelliAzym46lQbkLL6BBS42TvYviUXNhhN2eLQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:CC:
	 In-Reply-To:Content-Type; b=U3+fdotL/6N/jqWGsh1cdWZMfmNppPzMUlZzReJH6REc1CL8+fHipGyT7rmqNX/G6fzqpFpkgH3FV+YgaNQuY/JLb3zOety/6TgKb1nbY0jQpfrAnhKIZmeJ5fX9fFNaAZZPgDnVypzQGCq6C0NksOJEc+n3RO7OS+KZLn5n1VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WP1Y93PTQz28fXS;
	Wed, 17 Jul 2024 11:25:49 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id A190F14037B;
	Wed, 17 Jul 2024 11:30:07 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jul 2024 11:30:07 +0800
Message-ID: <3f551249-8a42-9a4a-621d-3fc742280413@huawei.com>
Date: Wed, 17 Jul 2024 11:30:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6.10-rc1 0/4] arm_mpam: Fix several minor issues
Content-Language: en-US
From: Zeng Heng <zengheng4@huawei.com>
To: Xie XiuQi <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>
References: <20240713060944.2725647-1-zengheng4@huawei.com>
CC: <james.morse@arm.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20240713060944.2725647-1-zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Loop Xie Xiuqi, Wang Shaobo


在 2024/7/13 14:09, Zeng Heng 写道:
> After completing the MPAM related test, several bugs are discovered and
> attempt to fix them. Now it's time to send them to the community for
> review.
>
> It's first time to send patch to this repository, if any rules should be
> realized, please let me know. Hope to submit more patches in the future.
>
> Zeng Heng (4):
>    arm_mpam: Correct MBA granularity calculation
>    arm_mpam: Fix the range calculation of the implemented bits
>    arm_mpam: Correct the judgment condition of the CMAX feature
>    arm_mpam: Fix typo about mbw_min controls
>
>   drivers/platform/arm64/mpam/mpam_devices.c  | 8 +++++---
>   drivers/platform/arm64/mpam/mpam_internal.h | 1 +
>   drivers/platform/arm64/mpam/mpam_resctrl.c  | 4 ++--
>   3 files changed, 8 insertions(+), 5 deletions(-)
>
> --
> 2.25.1
>
>

