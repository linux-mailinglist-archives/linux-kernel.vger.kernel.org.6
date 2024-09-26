Return-Path: <linux-kernel+bounces-340433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B074298735A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5339C1F28691
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC41714D9;
	Thu, 26 Sep 2024 12:13:22 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A11714B3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352801; cv=none; b=WV9sO8POQcNXrir37ZFtYifUnZ31+5qzOOjY2I3mZVRjduV5UfMAszv40EiVlXSR/8EQ1rF3G55jexaouVshq9xIAxHKtvWapfwhAT4fYx5ec9rOklP19GmN+qdt5Ps6ErBIFaMFc7n76UTzwMsE5qFybADmIXw+b1saPddY+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352801; c=relaxed/simple;
	bh=GEQZD3LgjwLXHYWqzy2IVXpGgTaJMDyNpjQWKUAObc8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS14LtQPQ3IRkCx+e2V8iWYr2vVmBFJJmlCfidM3PijeplIZEolVkLXtuwULTF5BQPFi5jqCuys++UOExgnZBtf63zXoeRUuY9aY58VG7HXJOM+WxATFaFmGFeB4YzckSSphshv/35FDEgiIl1MInvssut5oWEC6/vmo8xga2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDsnd1NLCz6K8wf;
	Thu, 26 Sep 2024 20:08:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C7A314011D;
	Thu, 26 Sep 2024 20:13:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 14:13:16 +0200
Date: Thu, 26 Sep 2024 13:13:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 15/15] docs: acpi_hest_ghes: fix documentation for CPER
 size
Message-ID: <20240926131315.00000229@Huawei.com>
In-Reply-To: <f6604a9dba8b5dcfe4e21d1f2a8b68ad05b265f4.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<f6604a9dba8b5dcfe4e21d1f2a8b68ad05b265f4.1727236561.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 25 Sep 2024 06:04:20 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> While the spec defines a CPER size of 4KiB for each record,
> currently it is set to 1KiB. Fix the documentation and add
> a pointer to the macro name there, as this may help to keep
> it updated.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

J

