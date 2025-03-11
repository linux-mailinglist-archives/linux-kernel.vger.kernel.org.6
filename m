Return-Path: <linux-kernel+bounces-556334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C4A5C427
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4316189B0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04525C6F6;
	Tue, 11 Mar 2025 14:42:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAEE2580F8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704125; cv=none; b=d/JW6WQkpwO7O3Xk6tScK6YqyhHzszHoUQptC9rDl4s+pjArLEJ99PoE8ji3B0MdNSjqSyRX6cdyw77mIPz2rdLEXs2SAHx0LEngBGNrVL8/61bxmYUK4I3ufSm/h74Tj8/uiM7yVYUrqk4v5UR5k56rkuJdl4PoHOy44N5wpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704125; c=relaxed/simple;
	bh=lSKfYrW3CTQloEtezI4zy1iH9CgFhkAXV7XnHLDoqxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFhN9hhQXJQ2Rzqm4IxUvKJCUI953wizlVRxbh52r5xyJdwDlJ6vZs3d/A3G7SMv0d0vlkx4guh8HHKwNG+O4Q2b4XJw/XtDCP0jXXkDurwVxTXxQMn2bnyKtDykkyl8SC6uP7FEGbP8fXjdYhd5iZP8wdaGN8jRnv8sz+Dz93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E6B271B;
	Tue, 11 Mar 2025 07:42:14 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 479853F694;
	Tue, 11 Mar 2025 07:41:59 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:41:56 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<pierre.gondois@arm.com>, <dietmar.eggemann@arm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>, <sshegde@linux.ibm.com>
Subject: Re: [PATCH v12 4/4] arm64: Kconfig: Enable HOTPLUG_SMT
Message-ID: <Z9BLtGYyQ3CqkX5Z@bogus>
References: <20250311075143.61078-1-yangyicong@huawei.com>
 <20250311075143.61078-5-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311075143.61078-5-yangyicong@huawei.com>

On Tue, Mar 11, 2025 at 03:51:43PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Enable HOTPLUG_SMT for SMT control.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

