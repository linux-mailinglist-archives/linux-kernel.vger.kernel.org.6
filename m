Return-Path: <linux-kernel+bounces-263975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAC593DD68
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B3BB21A49
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9301B974;
	Sat, 27 Jul 2024 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="mE6x7Aem"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757917997;
	Sat, 27 Jul 2024 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722057736; cv=pass; b=LkMZ94qXsinZZqogOhlW6yjq3p7miPA3Y58BzFoDjqqxb4y1FjjpTCHZOn/Fo6vZ1bcYw5HUvh5kV9uQ/SUjpM/kU+vtLWUB0W9wHi5YsNaky0W1N9HlsyoaRQPltiBf5CxRMiaONp3Ily7RCt3HTop/gQ593PgYU3qrm5NaHv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722057736; c=relaxed/simple;
	bh=Mih095U9iXueDDnfQMixcmVN6Xd/74AO9SVU2wiAifk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oAywkc4s43j+4Nit7Uyqq2d/Q6j0RquGwKwibnjJq2o70Q5PWe1fPY1r4PGKQppCXY0b5MKhnJoFPVEO7fVqyi7+hjnUuF+rgQ/jlcmhicgT4dRZgOdkhnfu6RBW89eAM8gI6RlHVqzQzzFqxoEdUG5CcP7+GF0lV320wKxMY7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=mE6x7Aem; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1722057708; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aXi1zLnnjn1YLCOIyHDHWq+wPNACX16kzdArfXr6fGs71QPrbvINIpgRoIGoYuGcf5ElOvk27nyPb02iiL6VAjfCOHSO9jNyi1RHhGdIpPJxJl3sCLVoJcSieNm0CUJuexXknk1TwwjEyWN58LoP1EhBkwcjnupiXunky2+3usM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722057708; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mih095U9iXueDDnfQMixcmVN6Xd/74AO9SVU2wiAifk=; 
	b=Q3WtiC2NUZR9yuI4zJTd9srWjqBAsHMh46WTLkSn9nn7xbBy0PBPyYYVJOkRC/6Iqb1LNcgDDwTQhrr5lG/VhraboN/98G2emClS9hujnkNH0tz52WdkllzY/MNwWZoevFxXmqHbhk28A55kcvv4ZBOuaqEhXTiJcgXizB+RkQo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722057708;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=Mih095U9iXueDDnfQMixcmVN6Xd/74AO9SVU2wiAifk=;
	b=mE6x7AemEjphe0KxvGJGqSkAsC2aNPV6Dw8UVJc9uiwKXtzO3VDNzHKGrXhYp56K
	KWDZ9uAbTn/pkxD5rjVuXR/s6kW4uAIlDk/K4CJKBpBkn1ql4YlMiFEluXdhXEioLNF
	RCZOk29odxLzT6AGNplXtSMCTnHt07PELEEGcTOVyvclz3NfIoM7E82u9zEFEZ7qm/I
	lQnVsLo3op+anS1sQoDTSZT1FAmK9LzqScMQbW6xkUOpkftdU5ho3edjlsCD47KjWRg
	tVJTlUr3WZXUjsH41AmOywlT/tyhCNlpCkWVAB/LMKNtkrRSQwYi9ij6dWHIGJmawev
	N/u+GM0q+w==
Received: by mx.zohomail.com with SMTPS id 1722057705832303.64384928637764;
	Fri, 26 Jul 2024 22:21:45 -0700 (PDT)
Message-ID: <2375ff5fb664d8de9627e76788bd40b5d8eabf35.camel@icenowy.me>
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: Document T-Head TH1520
 AP_SUBSYS controller
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <drew@pdp7.com>, Emil Renner Berthing
	 <emil.renner.berthing@canonical.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini
 <dfustini@tenstorrent.com>, Fu Wei <wefu@redhat.com>, Guo Ren
 <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Thomas
 Bonnefille <thomas.bonnefille@bootlin.com>,  Yangtao Li
 <frank.li@vivo.com>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Date: Sat, 27 Jul 2024 13:21:39 +0800
In-Reply-To: <ZqPQ8X51S6PrzQxI@x1>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
	 <20240623-th1520-clk-v2-1-ad8d6432d9fb@tenstorrent.com>
	 <57ef2eef45f2de15e6607da266b37b2a.sboyd@kernel.org>
	 <CAJM55Z8iF8yV5JK5v6ZtQqS5AaWwCZ7uwhSYb7hdxh0juDFdqg@mail.gmail.com>
	 <ZqPQ8X51S6PrzQxI@x1>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-07-26=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 09:38 -0700=EF=BC=
=8CDrew Fustini=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Jul 26, 2024 at 03:45:36AM -0500, Emil Renner Berthing wrote:
> > Stephen Boyd wrote:
> > > Quoting Drew Fustini (2024-06-23 19:12:31)
> > > > Document bindings for the T-Head TH1520 AP sub-system clock
> > > > controller.
> > > >=20
> > > > Link:
> > > > https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs=
/TH1520%20System%20User%20Manual.pdf
> > > > Co-developed-by: Yangtao Li <frank.li@vivo.com>
> > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > > > ---
> > >=20
> > > Applied to clk-next
> >=20
> > Thanks, but this driver seems a bit incomplete. With this applied
> > the Lichee Pi
> > 4A no longer boots without the clk_ignore_unused kernel parameter.
> >=20
> > /Emil
>=20
> Is this the case when you apply the dts patches from this series?
>=20
> The dts patches won't go in until 6.12 so I don't think the presence
> of
> the clk-th1520-ap.c itself in 6.11 would break existing systems.
>=20
> That said, I have been using clk_ignore_unused. I had been thinking
> that
> made sense because the full set of clock controller drivers like
> AON_SUBSYS (always on), AUDIO_SUBSYS, DSP_SUBSYS, etc, are not
> present
> yet in mainline. However, the T-Head vendor kernel does have drivers
> for
> all those clock controllers and I was suprised to see that the vendor
> kernel fails to boot when I just tested removing clk_ignore_unused.
>=20
> As for clk-th1520-ap.c in mainline, I'll investigate further which
> clk
> disables seem to causing the boot failure when using the dts from
> this
> series. I suspect I may need to add nodes that will cause the
> necessary
> clks to be enabled by their respective drivers.

If disabling the clock just leads to system hang, setting
CLK_IS_CRITICAL should be useful (and needed) here.

>=20
> Thanks,
> Drew
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


