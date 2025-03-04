Return-Path: <linux-kernel+bounces-543640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6537A4D7D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8115B164A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9D1F5853;
	Tue,  4 Mar 2025 09:21:15 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70418FC6B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080075; cv=none; b=S1oOQlabIGc5Yyf8aWZQZFCXuynBA3rv178gKjmlK7mUf2bh2za7UYJD/KRGSYgkBTHeVqRBdM3Of76QgCRFuyd8KUBg63ed5GgyqplE18eu312aRLwkyXlqez7xp9PhRnAoLCrjNDUR7qdYP2od15Acdi3oJE22fOgo9tWwIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080075; c=relaxed/simple;
	bh=dqTF9c+PHa0w+sPxfqURNbcThtMGZJqqUoJDmdYR1Fc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/xm9dlM1jZisA/l/R3rNuA1plLJDhqvENIWBcorEEumOi/yaarBs++RnAfpxl1zX+xQ/caFZ5lfB3eY7jtagp0qxIxi+2thzmF5W7U+nX6u2jEU5MRZXgZ5IyQVVQC2vMO+wj9k4C3SqtpUoB/zWmfpZf5qXjCyn28HXlj+52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6VVV3RPXz6K9BZ;
	Tue,  4 Mar 2025 17:18:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 592D9140A08;
	Tue,  4 Mar 2025 17:21:10 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 10:21:07 +0100
Date: Tue, 4 Mar 2025 17:21:02 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: Will Deacon <will@kernel.org>, <yangyicong@hisilicon.com>,
	<mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH 1/9] drivers/perf: hisi: Extend struct hisi_pmu_dev_info
Message-ID: <20250304172102.00006e54@huawei.com>
In-Reply-To: <e6cfcfd0-5412-20bb-f4b5-cf266884c5d0@huawei.com>
References: <20250218092000.41641-1-yangyicong@huawei.com>
	<20250218092000.41641-2-yangyicong@huawei.com>
	<20250301062343.GA27700@willie-the-truck>
	<e6cfcfd0-5412-20bb-f4b5-cf266884c5d0@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 3 Mar 2025 22:43:35 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> On 2025/3/1 14:23, Will Deacon wrote:
> > On Tue, Feb 18, 2025 at 05:19:52PM +0800, Yicong Yang wrote:  
> >> From: Junhao He <hejunhao3@huawei.com>
> >>
> >> The counter bits and event range may differ from versions of a
> >> certain uncore PMU. Make this device specific information into
> >> struct hisi_pmu_dev_info. This will help to simplify the
> >> initialization process by using a list of struct hisi_pmu_dev_info
> >> rather than checking the version.
> >>
> >> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>  drivers/perf/hisilicon/hisi_uncore_pmu.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> >> index f4fed2544877..777675838b80 100644
> >> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> >> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> >> @@ -72,6 +72,8 @@ struct hisi_uncore_ops {
> >>  struct hisi_pmu_dev_info {
> >>  	const char *name;
> >>  	const struct attribute_group **attr_groups;
> >> +	u32 counter_bits;
> >> +	u32 check_event;
This name is a little confusing.  Maybe nr_events or similar?


> >>  	void *private;
> >>  };  
> > 
> > This doesn't really do anything on its own; please just fold it into the
> > patch where the new fields are used.
> >   
> 
> sure, will make this into the following patch.
> 
> Thanks.
> 


