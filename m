Return-Path: <linux-kernel+bounces-569946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D80AA6A9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5F983CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FBB1E7C1C;
	Thu, 20 Mar 2025 15:28:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E98F3C0B;
	Thu, 20 Mar 2025 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484539; cv=none; b=B9izth3LbIb6lp4Wpac42TfzZHuRQhR/Ul8r6mqTAFHtHEd8DA5KCmcI0B0LoEvSJPZbiBdaFlbRmuLrWg1yx1yc/caagAio+FCT+67t32zr5MC2Pno0aLGVbo9ReQqZe3ge4IiERpx3J1bk7MHLjCNeXFiuIG/xSE+bs1+l92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484539; c=relaxed/simple;
	bh=vf4tAcImK/lyeaEP0yTngNOf0Cu595FOvZhjhfidrM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljQ0hHmhxlWp0lRUGy35pmIPeYSy+AqBAF7A58mhsSE+9qZkL4J0IkknoketcAiIZ/+/bR/jol5Jx5iBc2gMNJW+KuUan3uLFSRtMkBMTIlbHiz2XyTnGpqC5hXWTaIQC8If2hyN4mzCXWIAFHjw2MLl0WTPvigqBzHQHgxpIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11CA3113E;
	Thu, 20 Mar 2025 08:29:04 -0700 (PDT)
Received: from gentoo-vm (unknown [10.32.114.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 438423F673;
	Thu, 20 Mar 2025 08:28:54 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:28:49 +0000
From: Kajetan Puchalski <kajetan.puchalski@arm.com>
To: Peter Chen <peter.chen@cixtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com, marcin@juszkiewicz.com.pl, 
	Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add CIX SoC maintainer entry
Message-ID: <zsmeh4ukuspyetowryqi3blcquxlua5wzy5ibgy7lupryr5txx@74ic6drtremv>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
 <20250305053823.2048217-7-peter.chen@cixtech.com>
 <7419360a-abc0-44cf-8d55-8f5fad8e9079@kernel.org>
 <Z9vyy7f5NOPyzUES@nchen-desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9vyy7f5NOPyzUES@nchen-desktop>
User-Agent: NeoMutt/20250109-134-7b7c50

On Thu, Mar 20, 2025 at 06:49:47PM +0800, Peter Chen wrote:

(...)

> > > +ARM/CIX SKY ARM ARCHITECTURE
> > > +M:   Peter Chen <peter.chen@cixtech.com>
> > > +M:   Fugang Duan <fugang.duan@cixtech.com>
> > > +R:   CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
> > > +L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > +S:   Maintained
> > > +F:   Documentation/devicetree/bindings/arm/cix.yaml
> > > +F:   arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> > > +F:   arch/arm64/boot/dts/cix/sky1.dtsi
> >
> > Instead:
> > arch/arm64/boot/dts/cix/
> >
> > or if you think there will be more different architectures coming from
> > cix, which you will not maintain, then useful would be a "sky" subdirectory.
> >
> Hi Krzysztof,
>
> Thanks for your comment, CIX is Arm SoC based silicon design
> company, we may have different SoC style for middle end in future.
> So, for that SoC series, it may not name sky.

I believe the idea is that the file should either say

+F:   arch/arm64/boot/dts/cix/

if the two of you intend to be maintainers for everything under cix/.
You don't need to list every specific file.

Otherwise it should say

+F:   arch/arm64/boot/dts/cix/sky/

with its own subdirectory if you only intend to be maintaining the sky family.

> --
>
> Best regards,
> Peter

