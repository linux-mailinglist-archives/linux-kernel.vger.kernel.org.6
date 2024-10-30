Return-Path: <linux-kernel+bounces-388762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC009B6414
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407FCB20D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6CB1EB9E1;
	Wed, 30 Oct 2024 13:28:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889F1DF754;
	Wed, 30 Oct 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294935; cv=none; b=F3Pu4K8vGUkvqK5/z5q6CHiZYn37AoZ2b6v9o8g0Cqp3vVEUuIQQaKvwWzlqTW30aEY3Zda43FZPaicXsEP3IRqqsDIaW0HiEgKJ3Szy3SZDfx3BJR86ozn7x3HqkJFR1k2dUbbY94uqKU+mE7cwaqhPnhG+4aWT0e7jVpwQwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294935; c=relaxed/simple;
	bh=++NFQYD9pKNnBhUiPl8q19h3ZzuSoCYcNY8ZXM5N+4E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBdkB5FsTkaBDpnJ5wPByC67QaR4Be2fX7hluF7EwOB6PHhHO/0xW9zwTgiKEdVpa9LUzb8eTicWpkf3xng6BwZu8E/vSK+9gso6haTq1YCcxGOa7u1SWHuWC7pijptOuK+mkBQZvLPM7WkQ7bFDTasD+othCCcNUxrmZhUJr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdnvj1hXnz6K5xw;
	Wed, 30 Oct 2024 21:26:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4882F140B38;
	Wed, 30 Oct 2024 21:28:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 14:28:49 +0100
Date: Wed, 30 Oct 2024 13:28:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/27] dax: Document struct dev_dax_range
Message-ID: <20241030132848.00001ac7@Huawei.com>
In-Reply-To: <20241029-dcd-type2-upstream-v5-3-8739cb67c374@intel.com>
References: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
	<20241029-dcd-type2-upstream-v5-3-8739cb67c374@intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Oct 2024 15:34:38 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> The device DAX structure is being enhanced to track additional DCD
> information.  Specifically the range tuple needs additional parameters.
> The current range tuple is not fully documented and is large enough to
> warrant its own definition.
> 
> Separate the struct dax_dev_range definition and document it prior to
> adding information for DC.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

