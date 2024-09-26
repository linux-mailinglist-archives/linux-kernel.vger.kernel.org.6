Return-Path: <linux-kernel+bounces-340431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363D7987355
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E010B1F27FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE741714C6;
	Thu, 26 Sep 2024 12:12:31 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428D78C90
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352750; cv=none; b=gYZbOCrUKvVqFQNN7yX7ojMepi2iDOFMaJqzLi/ShxYBzD4DNjOA6OaBPFbwr+rFwCt/wMu3htnMININd1p5KQ+eesaVN5aQWWhCK1M7B2HXGizyhiUC5hF3RVkMesAwBIcM3vAmtlmhaBqr74QalWkPWg9pc2MLJbKpGeRk0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352750; c=relaxed/simple;
	bh=XXPh8E81Mj0rvCJemIu7vofxSxprvhFm+sTWb2cSF6I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfVpzSUa/H+7JSo+IZT72BQvuTVccWygCe6XUX4GxMfNa7mPYrdFHh8jnIkMRVzNbIQiLcO5lxPt4zxIsVPM+Q7BD7TEMK+2T2H4+82x2YMeZlqs6W0QiPUXYFQK79l8wgXXshTxkKBTxx7G2KoESGLJDz8bK6Xgj1tTMLZzOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDsmg1Wlwz6K8L9;
	Thu, 26 Sep 2024 20:07:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 12FF7140AE5;
	Thu, 26 Sep 2024 20:12:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 14:12:26 +0200
Date: Thu, 26 Sep 2024 13:12:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 14/15] better name the offset of the hardware error
 firmware
Message-ID: <20240926131225.0000337c@Huawei.com>
In-Reply-To: <94dec32ef07d95940ee63445f151899ae7b430b3.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<94dec32ef07d95940ee63445f151899ae7b430b3.1727236561.git.mchehab+huawei@kernel.org>
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

On Wed, 25 Sep 2024 06:04:19 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The hardware error firmware is where HEST error structures are
> stored. Those can be GHESv2, but they can also be other types.
> 
> Better name the location of the hardware error.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
This feels a little theoretical as for now they are always GHESv2 I think?
I guess it does no harm and may make sense after follow up series.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

