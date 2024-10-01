Return-Path: <linux-kernel+bounces-345282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75B998B415
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96B7B23476
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619B1BBBF1;
	Tue,  1 Oct 2024 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxgM0nZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83841BBBC3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762566; cv=none; b=l+7JlWVBBdLfMkqMXQTjOs4hZZIP0YIdzsY/XDSLaPcgml4YiBbzLwUTTE1JADs5SS4gso+p+t2BPdqda4KP+heXTbJbj8ApRTP8fcAtb7en/u5neAhG1KmvsbTdpiOQ1TAaHQkYvFMnlRnR+Xh+Ha2eHl2QZiEAiHMvWhsAXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762566; c=relaxed/simple;
	bh=rGURyU0q5IpmNAxeZNOxzNUHTX2mHMJxAi0SPIdKbRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uePMSOtTibOiFoS+fvUIySYCtVTJZFZaGK9S3A9C1b4w1oKtqsfcBoVHB0OrzZX4bjn4n9NFUKLGZqWQu1FdgoCFSmxL2bECeP9MPfdeMe/mEvvVrQnHS1AggG6CZvjw8FscorUwGie9WFRsqAREHnx7WtqkpU9d2zow4QEt+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxgM0nZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BF3C4CEC6;
	Tue,  1 Oct 2024 06:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727762565;
	bh=rGURyU0q5IpmNAxeZNOxzNUHTX2mHMJxAi0SPIdKbRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QxgM0nZXvcli+3SxLlTIQ3jQ9d3zwVBWfTXDZqufc3WmF8iXSrAILhZhCHS6+JPGa
	 hIt3nfJfj9TE5vBKSy/F1fSS0pSIXWrlh7aKJQUMEP4iuLJpcgrWzkBrkfrfqLISqK
	 JsYvcjNOIEpbcrDytheCePB9MH0FwPE8DXtkpqqSdSgNQ3o0C/EhdAeCzrz1AjWFmC
	 blBXzIj0a7uykHqmD+HWqXKstPMTqVqJPm2GP/XK6JptLkduy9dbR8OTopiIUZ96J3
	 39CniiBYzPSVa3NpPC/+ZB34Oqw17lN07qAQZcQov+3DSh67cwFxyWAFVzv6nPwn9K
	 JSQDkUrlZySEQ==
Date: Tue, 1 Oct 2024 08:02:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 14/15] better name the offset of the hardware error
 firmware
Message-ID: <20241001080240.56a927d2@foz.lan>
In-Reply-To: <20240926131225.0000337c@Huawei.com>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<94dec32ef07d95940ee63445f151899ae7b430b3.1727236561.git.mchehab+huawei@kernel.org>
	<20240926131225.0000337c@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 26 Sep 2024 13:12:25 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 25 Sep 2024 06:04:19 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The hardware error firmware is where HEST error structures are
> > stored. Those can be GHESv2, but they can also be other types.
> > 
> > Better name the location of the hardware error.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> This feels a little theoretical as for now they are always GHESv2 I think?

It is, but the new code that will be added on the next patch series
will allow future addition of other types as well, as it seeks for
the source ID inside the error block structures.

Yet, if we end adding other types, it will probably make sense to
rename ghes.c to hest.c.

> I guess it does no harm and may make sense after follow up series.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,
Mauro

