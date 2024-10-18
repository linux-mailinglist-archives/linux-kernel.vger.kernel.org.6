Return-Path: <linux-kernel+bounces-372554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9579A4A40
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E29628243D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C200A1917E6;
	Fri, 18 Oct 2024 23:46:29 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132D152E12;
	Fri, 18 Oct 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295189; cv=none; b=jphWa9c7MS45ywWR3DMPG6v97bdAUrz7zy4nt0PwrKv5wWd0Bfqew6uD0+A6QHvfU+fY0OP9b9ltHOD53oayKiQOIh96vkPf2gbnRFDQTh7557NzFYQgqpw5GMszHLU9mTGjlsss8ygPckUeUAIBEFaxJWZyrZlJrBOeISAE7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295189; c=relaxed/simple;
	bh=oH3mmL8w1VzBwkoIErlqAXURXZliwRqlPIyCItbDdjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnHPuRDfqTcswURRWrFKZAxdabo97hX78zSQTKq9IWB6WfQ6MnU9IoVmxtRTvO5gFYx9SXIdlKjw2gz3zCjUTM3coHFuk9kGfXpV8TFyftbqVgwyFChtPxNb9MZW+5TTHi5tZ2AU7L/fwTRTcXOqfJrr4gANcPNQtXV+MaL2W2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sat, 19 Oct 2024 07:46:15 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>, cyy@cyyself.name,
	samuel.holland@sifive.com, anup@brainfault.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, inochiama@outlook.com,
	uwu@icenowy.me, zhangmeng.kevin@spacemit.com, kevin.z.m@hotmail.com,
	matthias.bgg@kernel.org, Haylen Chu <heylenay@4d2.org>,
	Troy Mitchell <troymitchell988@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse T <mr.bossman075@gmail.com>
Subject: Re: [PATCH v5 00/10] riscv: add initial support for SpacemiT K1
Message-ID: <20241018234615-GYA2124001@gentoo>
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
 <mhng-5bc45db9-5deb-4db6-8733-561768b2968c@palmer-ri-x1c9>
 <20240917-spoilage-nimble-a8303fd04482@squawk>
 <20241018-drapery-stable-cc31a97cda90@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018-drapery-stable-cc31a97cda90@spud>

Hi Conor:

On 18:24 Fri 18 Oct     , Conor Dooley wrote:
> On Tue, Sep 17, 2024 at 10:08:03PM +0100, Conor Dooley wrote:
> > In other news, nobody has really made an "official" statement about who
> > is going to maintain this particular platform. People have expressed
> > interest (including the submitter of the series, IIRC) but there's no
> > MAINTAINERS entry added here AFAICT. I used to have an entry that
> > covered arch/riscv/boot/dts/*, with exclusions for sunxi and renesas,
> > but with Drew taking on thead and sophgo being the resぽonsibility of
> > Chen Wang and Inochi, I no longer have that wildcard.
> > 
> > I'm happy to apply patches for the platform if noone else is interested
> > in that side of things, provided there are willing reviewers, but I
> > would much rather that someone else took up the responsibility of
> > applying patches and sending PRs - and of course I am happy to help
> > whoever that is with the process.
> 
> On second thoughts (and on a second opinion) I am not actually willing
> to apply patches for this platform, since it isn't sustainable to take
> on each and every platform that there's no maintainer for.
> 
Ok, I fully understand your concern..

> +CC a few more people that have been involved in the platform.
> 
> Yixun Lan, you're kinda the "prime" person to maintain the platform
> since you're the one who took up the core support work etc. Is
> maintaining the platform, maybe with the help of one of the other folks
> working on it something you can do?
> 
That would be sweet, yes, I can take the maintainer responsibitly for now
but, I'm open if someone else willing to help and co-maintain..

> Mostly the responsibilities are just applying patches for fixes/new
> content and sending PRs to the soc maintainers - but knowing what's
> right or not obviously requires familiarity with the platform which
> people that work on it are best placed to do. Myself and the soc
> maintainers will help if whoever does this runs into any trouble.
> There is some documentation here https://docs.kernel.org/process/maintainer-soc.html
> that will assist somewhat with getting up to speed with the process
> also.
> 
Great, thanks for the info
> Cheers,
> Conor.

last, one question I'd raise:

for this particular patch series, do you want me to send another version v6
which can update the MAINTAINERS file (nothing changed with the code)

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

