Return-Path: <linux-kernel+bounces-248441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19C092DD35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979CE1F2373E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302A158861;
	Wed, 10 Jul 2024 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAM7wnhe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0563A5;
	Wed, 10 Jul 2024 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655809; cv=none; b=ZaPM2IZN4C5F6SGInis3JUjyMieYX1N+jJMCi63lODBLHTuRWoba4bAcahCfxoSCadD4gYYQ5T2ziXZeoHqYBAKhiPFnEK9V7Un1m90V2P5ixN3rFIK+kWjAFYDrVrYHry/aGT5oTuVW+NxZXb5TlpU9bCt/71X9698fzQIUkkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655809; c=relaxed/simple;
	bh=2tc8RIIyfHOiaSxzCTfQKeyqP8HdT8b53uA/ghjOZWg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VubvFZvZCBMd9tju/DKp8BIyTnS9BRxTkJlYugCagmV+w2BlYantRcjyWmClud/cvZRchnkiHATeSbnZLWp7euxe/0+qncdgBY/euM+2QIDdlaRNM2sV7A2/6Zc8PAmTppvIiDvZMyrrZheXASLO/UPDNth9PTV/02n9AflwC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAM7wnhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FD9C32781;
	Wed, 10 Jul 2024 23:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720655808;
	bh=2tc8RIIyfHOiaSxzCTfQKeyqP8HdT8b53uA/ghjOZWg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fAM7wnhekV4nm0zqMszEdt5ToIwVrIMloMD303uJBTeDCflfCUZkQmRHxSUd+8Vda
	 tS8rIyA3sIc6/9uLhyZVsMlO295+nC9Mr0a1ZHOT2kRua0kmkZvVf2x9cE/JJnQuDO
	 sR/+bjAIBXl4ALv+wBUETS8lnrtgij+RjLLlnNsoIZO68tc6rKl3EeNPS4JOsB0Lwt
	 6VPrXmMMZ0pO6Fw4nKzQbUXcotOuf3CUkT1HkR5rNI3M6fvYsQAyYD+o8bfykkY7Qu
	 GKO5yEXfoTNlCGr16m/9thGN+UThWRgOX8yf2c4Tir6myf71DaCsxmbGIsZTG/hrGC
	 pDAyn21p2eI/g==
Message-ID: <b3c450a94bcb4ad0bc5b3c7ee8712cb8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1903511.1xdlsreqCQ@diego>
References: <20240709123121.1452394-1-heiko@sntech.de> <20240709123121.1452394-2-heiko@sntech.de> <2e5852b9e94b9a8d0261ce7ad79f4329.sboyd@kernel.org> <1903511.1xdlsreqCQ@diego>
Subject: Re:  Re: [PATCH 1/6] dt-bindings: clocks: add binding for generic clock-generators
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>, mturquette@baylibre.com
Date: Wed, 10 Jul 2024 16:56:46 -0700
User-Agent: alot/0.10

Quoting Heiko St=C3=BCbner (2024-07-10 01:02:57)
> Am Dienstag, 9. Juli 2024, 23:45:20 CEST schrieb Stephen Boyd:
> > Quoting Heiko Stuebner (2024-07-09 05:31:16)
> > > diff --git a/Documentation/devicetree/bindings/clock/clock-generator.=
yaml b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> > > new file mode 100644
> > > index 0000000000000..f44e61e414e89
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> > > @@ -0,0 +1,62 @@
[...]
>=20
>=20
> > Maybe instead of creating a generic binding just make a binding for
> > these diodes parts? It certainly looks like a generic binding could come
> > later when another vendor supports the same binding.
>=20
> I was actually primarily aiming at solving the Rock 5 ITX clock generator
> issue described in patch 5, where the 100 MHz clock generator is just
> described as "100MHz,3.3V,3225" in the schematics, but definitly needs
> the supply regulator to be enabled [1].

That looks like a VCO (voltage controlled oscillator). Maybe the
compatible string can be "voltage-oscillator" or "clock-vco" and it can
require the vdd-supply.

Those diodes parts look different. They look like PLLs that have a
reference clock, hence the 'clocks' property I was expecting to see.
That would use the VCO you have to make the PCIE reference clk
frequencies. A generic compatible for those diodes parts is likely
"phase-locked-loop", or "clock-pll", but I'd avoid that given that PLLs
are almost always complicated and can have multiple output frequencies
if they have post and pre-dividers, etc. It's easier to be specific
here and make a binding for the part you have.

