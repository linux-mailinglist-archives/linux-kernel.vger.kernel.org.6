Return-Path: <linux-kernel+bounces-283557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1A94F654
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516AD282653
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801DD189B89;
	Mon, 12 Aug 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgoY75bk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F1188CC0;
	Mon, 12 Aug 2024 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486257; cv=none; b=SrdoIJIvIGrjpd7ZkH1wFadqXh7GMQSsn7fee7qNoThIGfAz632cyT12CYjUcM6nfUYEFLngqk/r4i/HgGZzi0uvm70XtzNoecx+4be5A/UdxUI+/jrKbEsUfQArAhskxS0Lz74iM9KhC3j8W7h2b6KLHr4cubuig9tRo6zXQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486257; c=relaxed/simple;
	bh=zXDpBzwnAWQ9ftmM2XfNlBBaM9d2VKtVYQlnQhipN6E=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=k8SRGwhR1DM+JxMjETAX0qq8EIaBcCv1Va6YEUrDHaJrfkm/Mp4esDkSQv667gEhYd3oVzUv2ORiq/RSVS+9CTB53U4WayEY8QNSKBUKXTVtdTNeKQtqeMiuNToWAfDfrBciBzTowAScBp7jkVS+IvmO+xrfrfJSFHAVXxzceZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgoY75bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228C8C32782;
	Mon, 12 Aug 2024 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723486257;
	bh=zXDpBzwnAWQ9ftmM2XfNlBBaM9d2VKtVYQlnQhipN6E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CgoY75bkFcdbTXTdnHY5lq8cNeRRp0XY8CEYIaMLfjiToXmkjRhVPci0XjbXaANUL
	 qQNzeC9etqlDsXc3mFa1lXsZ3d1p4cVdnYoyoIlvKBpaCYh9p7szOOj6Z7PaTvxKjB
	 suIbReAm1kt4EAivtjyOmQp0TYETnnzL/Qo6XawzjWc7DnbaTfSCb4iayH4dVLJb1t
	 SBoo+7dtDqTBh98rPgWR69bM4ENj87TzYipLqk+vEq21v4sAd3HLXo+Wc90RMOZUhc
	 XOxno2rOlb/kLpdKQ6RFYWNkK/2XO9zcvj85GlynMKwFV1muUCuEmqnpE3SA6O6ags
	 li+zZmcqW97Ug==
Message-ID: <1234a0176de236abb603f96ab9a1d6a1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PH7PR12MB72845D56BF4361441AA9CB9A8A852@PH7PR12MB7284.namprd12.prod.outlook.com>
References: <20240722121910.14647-1-naman.trivedimanojbhai@amd.com> <ac67f76d4b4b5f4bf108c1457f1263c7.sboyd@kernel.org> <PH7PR12MB72845D56BF4361441AA9CB9A8A852@PH7PR12MB7284.namprd12.prod.outlook.com>
Subject: RE: [PATCH V2] drivers: clk: zynqmp: remove clock name dependency
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
To: "Simek, Michal" <michal.simek@amd.com>, "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>, "Trivedi Manojbhai, Naman" <Naman.TrivediManojbhai@amd.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, mturquette@baylibre.com
Date: Mon, 12 Aug 2024 11:10:55 -0700
User-Agent: alot/0.10

Quoting Trivedi Manojbhai, Naman (2024-08-12 05:57:13)
> >> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> >> index a91d98e238c2..b791a459280e 100644
> >> --- a/drivers/clk/zynqmp/clkc.c
> >> +++ b/drivers/clk/zynqmp/clkc.c
> >> @@ -543,7 +554,7 @@ static int zynqmp_clock_get_parents(u32 clk_id,
> >struct clock_parent *parents,
> >>   * Return: 0 on success else error+reason
> >>   */
> >>  static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
> >> -                                 const char **parent_list, u32 *num_p=
arents)
> >> +                                 struct clk_parent_data *parent_list,
> >> + u32 *num_parents)
> >>  {
> >>         int i =3D 0, ret;
> >>         u32 total_parents =3D clock[clk_id].num_parents; @@ -555,18
> >> +566,30 @@ static int zynqmp_get_parent_list(struct device_node *np,
> >> u32 clk_id,
> >>
> >>         for (i =3D 0; i < total_parents; i++) {
> >>                 if (!parents[i].flag) {
> >> -                       parent_list[i] =3D parents[i].name;
> >> +                       ret =3D of_property_match_string(np, "clock-na=
mes",
> >> +
> >> + parents[i].name);
> >
> >You shouldn't need to match 'clock-names'. The order of that property is=
 fixed
> >in the binding, which means you can simply use the index that the name i=
s at
> >in the binding in 'struct parent_data'.
>=20
> This driver is common across multiple device families, and each device ha=
s different set of clock names in device tree/binding.  This implementation=
 seemed to be generic for all devices.=20
> To use index directly, I have to add if..else for matching compatible str=
ings and more if..else inside each of them for matching clock names to find=
 index. Please let me know if this is preferred approach.

It is preferred to not use clock-names and use the index directly. This
avoids a bunch of string comparisons and makes for smaller and faster
code.

