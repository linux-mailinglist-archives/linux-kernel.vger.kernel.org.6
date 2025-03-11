Return-Path: <linux-kernel+bounces-555522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22826A5B901
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB9F1892676
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB51EDA06;
	Tue, 11 Mar 2025 06:03:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09901E1A05
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672991; cv=none; b=Bljp9fHpswJwnO9Rh1wr17+Y77x8PKExtd382XXP2JEoy02cT+ubkyDNR/frVw4attyPmFJjT32QoKa5UIPApbVscOsSrws/ifvm3kBF30zeSS6L6aizpNEu7SSGmkAd6z44FrGJjLLvAQHk1Vaf8hcKDp2oDWQB5+cN8MK4foY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672991; c=relaxed/simple;
	bh=cVHhPeecRKU2IPVs5w6EiBIF8zy13dfk2z1mFixzALg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxTWhxbOehUxFYrmIEHityMKDuKGfSLd/IKZtmj3+bOEJm03c+nar1psdisbuWcXshCRBGjaru/Ti+zZLqXxf7Go5NCkOwur2XyvCDQP0otHCuC5NUGf/oo6Q7iFzpPJ+5Eaz53w4FZq2NwMTq+fDOMCsDyyAp/HWpLKG86KIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14EEC1516;
	Mon, 10 Mar 2025 23:03:19 -0700 (PDT)
Received: from [10.174.36.193] (unknown [10.174.36.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20D003F5A1;
	Mon, 10 Mar 2025 23:03:05 -0700 (PDT)
Message-ID: <cdc19ae8-4b02-44cf-8cfc-4487eea89bca@arm.com>
Date: Tue, 11 Mar 2025 11:33:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: use ptep_get() instead of directly dereferencing
 pte_t*
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250310140418.1737409-1-ryan.roberts@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250310140418.1737409-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/03/25 7:34 pm, Ryan Roberts wrote:
> It is best practice for all pte accesses to go via the arch helpers, to
> ensure non-torn values and to allow the arch to intervene where needed
> (contpte for arm64 for example). While in this case it was probably safe
> to directly dereference, let's tidy it up for consistency.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Dev Jain <dev.jain@arm.com>


