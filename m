Return-Path: <linux-kernel+bounces-561905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F0BA6185C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A813B638D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1629204C10;
	Fri, 14 Mar 2025 17:42:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24B178F2E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974153; cv=none; b=RRjSFQ9Ceo22s4ydRSs2ejpKhUedahNsteV+uG4tVyQ/LmkkeYewMpR01j5F1bjSm3FRq6ji0R2VrG0ERikseGxt+YDFECPViLP/JvGOAurEIBx7hnR5pzGAvAy355ACF0pLJrHfLgpii5PZBZLrFmsHdszPCRcEyx016MBjmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974153; c=relaxed/simple;
	bh=33jttg2peo6dNKyXFbBVQDvp4YmSGRXp0c7u3G+t+6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR8Ud46R3p4PbmXWZe1k8MOVC+T3jrlTOJ0DxVM7BYd8RmKwGU7KT61ySdo7kiR49KMMrEYq6Ut+qHezA8OWHEZkagElPF14C3CWN2G5SVKkH0sXCpzj4MeP+KeVMZ3YxQ7Qb9iOzEJQTb6ORuJsz3Kd3dBSgMU/KB22XEvCtDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95541BD0;
	Fri, 14 Mar 2025 10:42:40 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 660803F673;
	Fri, 14 Mar 2025 10:42:27 -0700 (PDT)
Message-ID: <af1a273a-0db5-491b-9fbf-48100e29169b@arm.com>
Date: Fri, 14 Mar 2025 17:42:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 47/49] fs/resctrl: Remove unnecessary includes
To: Fenghua Yu <fenghuay@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-48-james.morse@arm.com>
 <f6f98abb-0d4c-4e41-8c83-a3ab919a8fbe@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <f6f98abb-0d4c-4e41-8c83-a3ab919a8fbe@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fenghua,

On 07/03/2025 02:37, Fenghua Yu wrote:
> On 2/28/25 11:59, James Morse wrote:
>> When splitting and moving the resctrl code to live in fs/resctrl and
>> arch/x86, some code was duplicated. This was done to keep the parser
>> in the script that does the moving simple. These extra includes are

> As for "parser in the script", my concern is people may forget or don't know the context
> of the python script in the future and get confused when reading this patch.

> Is it possible to merge this patch into patch 45 which introduces the macros? It simplify
> the patch set and avoid future confuse?

The plan would be for these patches to get merged together by the person that applies them.


Thanks,

James

