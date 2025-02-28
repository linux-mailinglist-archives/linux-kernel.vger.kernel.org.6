Return-Path: <linux-kernel+bounces-538159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50748A49535
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188393BAABE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C24256C6F;
	Fri, 28 Feb 2025 09:33:29 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC1257434
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735209; cv=none; b=EPCCTMc7GQlX0XkiC6p6Oj1+6KcQvE9XxBfOT2xn1SodMBJGQQFGy4HZkiDgE/948V49zeGWos0WR2NZIBsF59v6Mv1DbmkyR1hg+nS/9Zce/0u6OQRh6beT4MguD2TklQ/VnMH3W3gFG1cmdfUHQmLGeY+hPAiHYL3mvAHDE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735209; c=relaxed/simple;
	bh=TMX49n56xtLsEf2eVO2nQxZ9UvOb1JUvO0arTHreRFw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ky71aSF+Av5hSDRY0UYPVKPOYzZmjxe7suwj9nJrxWTAS8wgAgHQ7JlW/u5HaQhfsyjGpNjDzXrHEUsAozHP1So9T3wfk2NeUuW+JPfLiqUpAyEPCo2Uo4jl7OOHHHNU8jkgnkAD6R/DTjkvzlkdRM56BNrTbbTe0KIWmmgEcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z42wZ6cRXz6L5Nw;
	Fri, 28 Feb 2025 17:29:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E659140B55;
	Fri, 28 Feb 2025 17:33:25 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 28 Feb
 2025 10:33:22 +0100
Date: Fri, 28 Feb 2025 17:33:18 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>, Ani Sinha <anisinha@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 17/19] tests/acpi: virt: update HEST and DSDT tables
Message-ID: <20250228173318.00000f9d@huawei.com>
In-Reply-To: <7a6a1a1ba78f7dac2be6b7335280c1d0b380a175.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
	<7a6a1a1ba78f7dac2be6b7335280c1d0b380a175.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 27 Feb 2025 17:00:55 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> - The HEST table now accept two sources;
> - The DSDT tables now have a GED error device.
> 
> @@ -1,39 +1,39 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20240322 (64-bit version)
>   * Copyright (c) 2000 - 2023 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/aarch64/virt/HEST
> + * Disassembly of /tmp/aml-DMPE22
This is an artifact of where you happened to get file
from so if we are being really fussy drop the change 
diff in the patch description for it.  I don't really care though.
>   *

