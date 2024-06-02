Return-Path: <linux-kernel+bounces-198346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097548D7703
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA671C219DC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D04AEE0;
	Sun,  2 Jun 2024 15:54:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E109B537FF;
	Sun,  2 Jun 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343669; cv=none; b=XIsxCPwcdeB9NW6GQtMbT2naPLlM+AfatMkCexAPQxvx0oQJt2cfXMRBEV1AiG47YjSSS0tngGMiaeh+d5c5SCbfuXcu2dwaMp8OXgHWH5pVP53l7fuh3uDZ3DQFZkPvo9qAnqXx/97lbXqXqrycSI7r+pTgHR9wXsVVbS1GrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343669; c=relaxed/simple;
	bh=Pial4zPTFNynySNton0QC3/Qd1accVop8Xud9f9QmJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrCVv1NpEzmosbPKAglb2p03BVKuRXGV6M+euOODT6jg3qmW2D1hH8R0jnpE/i9wmjBdb2hD31V6O8bG9HPrCcn1a32qNm1SxOUjOjlSFKBv8GtKgbXw2yi3z+E2EFEnzhKzLLX1ponXU66bAcTk5W0nMfxdvH03YDybPYmTqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC4D8113E;
	Sun,  2 Jun 2024 08:54:45 -0700 (PDT)
Received: from bogus (unknown [10.57.83.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09DE23F792;
	Sun,  2 Jun 2024 08:54:18 -0700 (PDT)
Date: Sun, 2 Jun 2024 16:54:16 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,juno-fpga-apb-regs: document
 FPGA syscon
Message-ID: <20240602155416.5gkm7w3snba57vxa@bogus>
References: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>
 <CACRpkdayDnBw0wCWffSwOX1EfPkq5TbkBH_wBJAwiZKaRbgdWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdayDnBw0wCWffSwOX1EfPkq5TbkBH_wBJAwiZKaRbgdWA@mail.gmail.com>

On Tue, May 28, 2024 at 01:47:33PM +0200, Linus Walleij wrote:
> On Sat, May 18, 2024 at 10:39 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
> > Add dedicated bindings for the FPGA syscon registers on ARM Juno board,
> > to fully document the block and also fix dtbs_check warning:
> >
> >   juno.dtb: apbregs@10000: compatible: ['syscon', 'simple-mfd'] is too short
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> (...)
> > +maintainers:
> > +  - Linus Walleij <linus.walleij@linaro.org>
> 
> This feels more like a Sudeep area of responsibility than
> mine, so please use:
> Sudeep Holla <sudeep.holla@arm.com>
>

Indeed, I queued them a week before -rc1 and was away last week. I plan to
rebase and reply after applying them officially 😄

-- 
Regards,
Sudeep

