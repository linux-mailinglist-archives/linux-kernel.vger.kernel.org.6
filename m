Return-Path: <linux-kernel+bounces-268553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A0942620
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFBDB221AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC912E1C2;
	Wed, 31 Jul 2024 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4afLWhJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD982D94
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722405950; cv=none; b=TjrMLRvEXdy+NBf+ZxbJV4XbWdWHKaGYOtdOE6oNh+vLXmD6WJrmHf/LeeEsayNB0LR83gjz33OgJr3F3vPSrGg+EO/G+xhT5yk7mnRMUyHynH7bng/DBeQgHpSVB7IUU+Lwogo6gqkJiqudQlDqJ+r8jmrK8BoVhOqWXASfZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722405950; c=relaxed/simple;
	bh=K4cH+7VCD6e3VyLaYkP+2c/JqPrRcmLYWXVHy/HV82U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdBu3OougOLS1KYeuTwJG+zYbBuK6A1L6IakcL6r2TWHBo+u5fwOuH1HmJjCgyuEbz33mtpx/eKeWXqzfyqKlfpV0tBQIgTZauzw+Jd3VftqyNNpgrZz+wkAqedJVKqcQ8jmRVTy+n1n/znAvThaASWBhpDWK/EwuZWaLjyEZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4afLWhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BF0C116B1;
	Wed, 31 Jul 2024 06:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722405950;
	bh=K4cH+7VCD6e3VyLaYkP+2c/JqPrRcmLYWXVHy/HV82U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4afLWhJS8R/dW6CabjXEeTVbKhhnxODQ7ygwxzyJzgnactWW7rkADN5YaX+/wtmY
	 OoPJA8wapzWBgt7Oy3e/9yYxCaWhfwsgGOH2/WYR0pib6wrl2TIMMpuMij0ABMos7I
	 r2ObwHJBQuSLTgA6MV+IuNyGY0j3frV2rYkmfIYMLKx2sR1ulIf/05b3Wiye1zZodO
	 BE8eLipiHYRiJZxlHhqQpiOkTKukTs84ucYBmKmmgwQeHKyQIQ7UwMVO5ARg4g6lfr
	 MYeytj/eRqToLRc0ikHlQR05k1KLYK6v5vRdHXmHZcizsIDKm+DOMQzyAuKzBKL10E
	 VQXDVNUktaQjw==
Date: Wed, 31 Jul 2024 08:05:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 6/7] acpi/ghes: update comments to point to newer
 ACPI specs
Message-ID: <20240731080545.7c0dbed7@foz.lan>
In-Reply-To: <20240730073447-mutt-send-email-mst@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<66c1ab4988589be99ae925c6361548f55fea58b0.1721630625.git.mchehab+huawei@kernel.org>
	<20240730132430.44d9e4ae@imammedo.users.ipa.redhat.com>
	<20240730073447-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 30 Jul 2024 07:36:32 -0400
"Michael S. Tsirkin" <mst@redhat.com> escreveu:

> On Tue, Jul 30, 2024 at 01:24:30PM +0200, Igor Mammedov wrote:
> > On Mon, 22 Jul 2024 08:45:58 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > There is one reference to ACPI 4.0 and several references
> > > to ACPI 6.x versions.
> > > 
> > > Update them to point to ACPI 6.5 whenever possible.  
> > 
> > when it comes to APCI doc comments, they should point to
> > the 1st (earliest) revision that provides given feature/value/field/table.  
> 
> Yes. And the motivation is twofold.
> First, guests are built against
> old acpi versions. knowing in which version things appeared
> helps us know which guests support a feature.

Good point, but IMO, a comment like "since: ACPI 4.0" would
be better, as the comment may not reflect the first version
supporting such features, but, instead, when someone added
support to a particular feature set.

> Second, acpi guys keep churning out new versions.
> It makes no sense to try and update to latest one,
> it will soon get out of date again.

True, but having it updated helps people adding new code to
get things right.

Anyway, I got your point, I'll drop this patch.

> > >  void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
> > >                       const char *oem_id, const char *oem_table_id)
> > >  {
> > > -    AcpiTable table = { .sig = "HEST", .rev = 1,
> > > +    AcpiTable table = { .sig = "HEST",
> > > +                        .rev = 1,                   /* ACPI 4.0 to 6.4 */
> > >                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> > >  
> > >      acpi_table_begin(&table, table_data);  

This hunk might still make sense, though. When double-checking the links
against ACPI 6.5, I noticed that HEST now requires .rev = 2.

There are some future incompatibilities, but the current
implementation of acpi/ghes satisfies both rev 1 and ref 2 of HEST.

Also, this is not relevant on Linux, as the revision is not checked 
there.

So, currently this is not a problem.

Thanks,
Mauro

