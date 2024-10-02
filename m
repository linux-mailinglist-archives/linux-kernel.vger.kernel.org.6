Return-Path: <linux-kernel+bounces-348296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0352698E56B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970601F21C07
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AB221732A;
	Wed,  2 Oct 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvFdxoa2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EE1D131B;
	Wed,  2 Oct 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905292; cv=none; b=NhpFBc8pv/J1bsO7WziR271WF2rWQWIrVnkQTDiHKDYHQvJ5hlmL7+t9JsbaV0JyuBt0QMio1EA5MAz1THNs7yAl3cYOAx/qoI3aXhPHU7krdhdaZekVIELSFeVz6gQ5XQKGUjGCRJmCwGQWtqJnb4Lmwg6tvS0PyUdjh/bhLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905292; c=relaxed/simple;
	bh=MhCybmHtvHC9lNdIeEmiXoehkqXFqlzKTsDQ0Q7WLRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrJzfgh7QJzq5NW3QJIRDwtRk64PCda/OiXAJTyUoiAXX8Q4fOry0HMXwX261nRFYKGySaMolKAgLS2/lKcfxgDalGJpN1gY/A7k417UepNxd2WWRan5IWqo+5/vj+99kZVjy5aPo8SiSvFt68hdSlaaMmfoQMV+DtbwzimV250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvFdxoa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E25EC4CEC2;
	Wed,  2 Oct 2024 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727905290;
	bh=MhCybmHtvHC9lNdIeEmiXoehkqXFqlzKTsDQ0Q7WLRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvFdxoa2dpgVrMZnOltYN8stAk4+Ke6MW6IomUDz5jEwpj3L5VJDEqKCATIpOsC7H
	 hYd/YH2cP2eIEzddFsR/HpjJ8A5hYzlDkMC85CxcimtwHAzRqwZnsu5YaCH2hG5W+I
	 okdyeL1bfrJnlASIUxNeooNbYjeFvGjPHphRtz6gt8kegKihJG6jXKoz4FJg6rO5hu
	 J6+jX9LhdU5fUJQFcupBOd+nPQ2PMQCqSFoLIsBQIvX7LAV4pkN3EqK2xOAHOcCFCi
	 SAjVSnsPPK93OJkYgpfnhX4mqZs8H2LXgl80Ynygp9KCeQJ/1b43+77YH9sc51Lg1J
	 dFSKORiF7JTiw==
Date: Wed, 2 Oct 2024 16:41:29 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
	monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: si5351: Make compatible string
 required property
Message-ID: <20241002214129.GA1347474-robh@kernel.org>
References: <b4b626c85ef3f75a0de936c818b2fff389e92c6d.1727855465.git.michal.simek@amd.com>
 <fa249ec7-409f-4dee-b853-736c5de464be@kernel.org>
 <74e07428-2ed4-47e2-a8ef-360df0252e17@amd.com>
 <7695cae2-33a3-4879-b8e5-d296d81ffece@amd.com>
 <938253b4-91d3-4217-a2c5-d8bd707f0e47@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <938253b4-91d3-4217-a2c5-d8bd707f0e47@kernel.org>

On Wed, Oct 02, 2024 at 02:17:22PM +0200, Krzysztof Kozlowski wrote:
> On 02/10/2024 12:31, Michal Simek wrote:
> > 
> > 
> > On 10/2/24 10:24, Michal Simek wrote:
> >>
> >>
> >> On 10/2/24 10:19, Krzysztof Kozlowski wrote:
> >>> On 02/10/2024 09:51, Michal Simek wrote:
> >>>> Compatible property is likely also required property.
> >>>>
> >>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>>> ---
> >>>
> >>> That's a convention but not necessary, a no-op.
> >>
> >> But how do you identify device then?
> >> Or are you saying that device description is valid even if there is no 
> >> compatible string?
> > 
> > One more thing
> > commit 524dfbc4e9fc ("dt-bindings: clock: si5351: convert to yaml") is showing
> > that compatible property was required in txt file.
> > 
> > -Required properties:
> > -- compatible: shall be one of the following:
> > -       "silabs,si5351a" - Si5351a, QFN20 package
> > -       "silabs,si5351a-msop" - Si5351a, MSOP10 package
> > 
> > I can update commit message to describe it too.
> 
> Devices do not work without compatible, so this is obvious... and like
> said - it is already required, so the change is redundant. Does not
> harm, though.

To put it another way, by the time the schema is applied, we already 
know that compatible is present because that is *how* the schema gets 
applied in the first place.

Rob

