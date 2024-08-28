Return-Path: <linux-kernel+bounces-304998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F19627E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9D71F214E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116717ADEE;
	Wed, 28 Aug 2024 12:56:13 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5301EA65
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849773; cv=none; b=Vp+cxhNuMgcQYYPPdXTlJ6TRct8DmYKkvWIJ74xjhVQ0V4iGPxVcZ44p8BmaiwT+txb5m2lXGXM2LLEOynqjhoRflSt8EDz28SfklpEokzTEk04f3pS7efgEm9vZS203oft3hthmmydsWxDyutsLcV5vXCwukBGZtihCd/F88Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849773; c=relaxed/simple;
	bh=vADGLPvEvMx7QQ3cm7cK7jUl7b2AiQlr/Qg0YeZKdK8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0rQlt1nFaMyVAlLwZ0B4TDwpClm4j0znM9474DMNuk2I020c6fmH+ZNIikARHamxfbcp95ZQuBQJ4sKEx0yky/sTfgahecbhRa+T6OgMIbRH7R5eKpjlE15dDvGPBa8xLF29jIVYanheoWiYmB1ljh5cUSqjZrGiEF0yihgL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv47C3ZvZz6K6Xn;
	Wed, 28 Aug 2024 20:52:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E211714038F;
	Wed, 28 Aug 2024 20:56:08 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 13:56:08 +0100
Date: Wed, 28 Aug 2024 13:56:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huisong Li <lihuisong@huawei.com>
CC: <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH v3 5/6] soc: hisilicon: kunpeng_hccs: Add used HCCS
 types sysfs
Message-ID: <20240828135607.000035bc@Huawei.com>
In-Reply-To: <20240828104956.20214-6-lihuisong@huawei.com>
References: <20240828104956.20214-1-lihuisong@huawei.com>
	<20240828104956.20214-6-lihuisong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Aug 2024 18:49:55 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> Kunpeng_hccs driver supports multiple HCCS types used on one platform at
> the same time. In this case, to find which HCCS types are used on the
> platform the user needs to scan the type attribute of all ports, which is
> unfriendly to the user. In addition, the aggregated information is also
> useful for global control like the low power feature.
> So add the sysfs to show all HCCS types used on the platform.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



