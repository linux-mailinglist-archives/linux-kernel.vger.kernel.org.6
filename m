Return-Path: <linux-kernel+bounces-306322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10503963D49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71153283972
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066E188CDE;
	Thu, 29 Aug 2024 07:40:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBD05588E;
	Thu, 29 Aug 2024 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917207; cv=none; b=V5mwBgAX51lXfOaOmueetsoh4yk3Uwf/qFXnyzb+iN0cID4Q7RYzya58hvC8qe7UPZZDYvOxQQ5o6IXjeL7Q5KmMxnaB9cPCFCAz47w2n/EwXromnM3Yosty03mrb5PpbFeFqOwH9gbiFmhioSWvqOyCHn1IBztVAOmRXZXb7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917207; c=relaxed/simple;
	bh=986i0+xBNupS/1yuTZLZEAjb9nmb581G5gYz4J0pnGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb/wX4pXuWLTRMDBU1GvXI1BjJT5+dsw+mF06VayKapkRSTFJe+LQsuKPyKukPf0ZioVapVVScC5pK4JUKvPTi/eZvQcm3DCa98Osl1i8zVIeHv6IY0FsAIWaZZqWiAtyQi7/FZE5JPV1lf0c4fDUNwSSEHGAPexCoZFCG3hFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C34DA7;
	Thu, 29 Aug 2024 00:40:30 -0700 (PDT)
Received: from [10.162.41.23] (e116581.arm.com [10.162.41.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C7FF3F73B;
	Thu, 29 Aug 2024 00:40:01 -0700 (PDT)
Message-ID: <37577635-89c9-4afe-a30d-add02c0eb896@arm.com>
Date: Thu, 29 Aug 2024 13:09:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/mm: Use calloc and check the potential memory
 allocation failure
To: Markus Elfring <Markus.Elfring@web.de>,
 Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240829055621.3890-1-zhujun2@cmss.chinamobile.com>
 <716f7466-562d-4bbe-a8ec-851a0b289db5@web.de>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <716f7466-562d-4bbe-a8ec-851a0b289db5@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/29/24 11:55, Markus Elfring wrote:
>> Replace malloc with calloc and add memory allocating check
>                        memset(…, 0, …) call by calloc()?

Calloc returns zeroed-out memory.

>
>
>> of comm_str before used.
> * Add also a null pointer check for the detection of a memory allocation failure.

Which is exactly what Zhu has done?

>
> * Would you like to improve such a change description another bit
>    (with tags like “Fixes” and “Cc”)?
>
> * How do you think about to omit the statement “fprintf(stderr, "Out of memory\n");”?

Why?

>
> * I suggest to omit the word “potential” from the summary phrase.
>
>
> Regards,
> Markus
>

