Return-Path: <linux-kernel+bounces-543820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD0A4DA4D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FECB1884B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34661FE46F;
	Tue,  4 Mar 2025 10:24:39 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259991FDE06
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083879; cv=none; b=GhJgu7Y39fkpVz4SDoPA2ajn1REJ5vLlELudL9bq8dgy72ZAGkOVn240hyJGj1qypvvYemUci/3eimMxenEx1KUmFTByDDEbqhySZ1IdJM0Pz8/70KQlnDmATEJlhHMvk5IPDSv4F+0Klfv1vn6124nOQwYCZaxq7VJlAaEQP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083879; c=relaxed/simple;
	bh=pQmn721u+PSnx87iTwVor5lq6R+WaUEBvxnRRr8COsI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7yJFYNqgmLXFYFCbVAyqjgNzrO1xVSw63TYIG7qa4w5s6Km4cmZg3R6RCIJ5OPSp8avKjn/glUXlXHO7d7oLMEoKQjc0z9s8Qbrf1aftm8NSXMkGj62x7ogbHDVwR8T7c6EoKZXem8M7vo85hPeauqOx9iqAwtRd1gX39y2VM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6WsX3n6Wz6L5NK;
	Tue,  4 Mar 2025 18:20:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 34CEF140A08;
	Tue,  4 Mar 2025 18:24:35 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 11:24:32 +0100
Date: Tue, 4 Mar 2025 18:24:27 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH 9/9] drivers/perf: hisi: Add support for HiSilicon MN
 PMU driver
Message-ID: <20250304182427.000076d9@huawei.com>
In-Reply-To: <20250218092000.41641-10-yangyicong@huawei.com>
References: <20250218092000.41641-1-yangyicong@huawei.com>
	<20250218092000.41641-10-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 17:20:00 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> MN (Miscellaneous Node) is a hybrid node in ARM CHI. It broadcasts the
> following two types of requests: DVM operations and PCIe configuration.
> MN PMU devices exist on both SCCL and SICL, so we named the MN pmu
> driver after SCL (Super cluster) ID.
> The MN PMU driver using the HiSilicon uncore PMU framework. And only
> the event parameter is supported.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Short and sweet

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


