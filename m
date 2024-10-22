Return-Path: <linux-kernel+bounces-376111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B05B9AA033
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A9E1F233B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED947199FDE;
	Tue, 22 Oct 2024 10:39:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913C16DECB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593581; cv=none; b=BUT603tMltopynRcXAM67xM8ga5HsDBq33g6OP+zAdjY8emdObHGiZF7pPLIhVdZ6uIfP+W+ZrMQCloEVFAhK1501oZpyHf8Il41SZqaksItRjPNBYZw+kEE973hqERPYs2GILLG7xu1vZFGUbZOeyNPlS8u/Ea7IA14UQSh8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593581; c=relaxed/simple;
	bh=DWfnen0LhO7KrNDiIVZN91s+P8K+xSM5u06hB6cvFKs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wl4zPhv3V2vskHw6pSbhD5dkGts7QdNnh0KtJ1le8iv6Z5u7codvs+FMq/9QtLLyLT5ivubeTTYmIwIxBAzEsyS8kUC4+DkaXvThLXG/I6s71QiZYjrPQDsgQ3+hfvAXCzXSK7FgXRw1bmB7dbPpMcxguLhx+OvCOiUz+gi+7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20E70DA7;
	Tue, 22 Oct 2024 03:40:04 -0700 (PDT)
Received: from [10.57.65.71] (unknown [10.57.65.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37E003F71E;
	Tue, 22 Oct 2024 03:39:33 -0700 (PDT)
Message-ID: <a3f401dc-cb7a-4b8b-9149-dd733005d54c@arm.com>
Date: Tue, 22 Oct 2024 11:39:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: Add support for Cortex-M85 processor
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241013132435.2825-1-jszhang@kernel.org>
 <9e81d3b6-3567-48f0-994e-9cd60fd71955@arm.com>
Content-Language: en-GB
In-Reply-To: <9e81d3b6-3567-48f0-994e-9cd60fd71955@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 10:42, Vladimir Murzin wrote:
> On 10/13/24 14:24, Jisheng Zhang wrote:
>> Add processor info object for ARM Cortex-M85 CPU which inherits the
>> setup procedure, the processor and cache operation function from
>> Cortex-M7 processor info object.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>


Please, upload the patch in RMK's patch system [1]

[1] https://www.arm.linux.org.uk/developer/patches/

Vladimir

