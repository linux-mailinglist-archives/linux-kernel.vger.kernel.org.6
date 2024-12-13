Return-Path: <linux-kernel+bounces-444507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737519F07FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAF8188B677
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380E1B21A6;
	Fri, 13 Dec 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+zTUY2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52C1AD403;
	Fri, 13 Dec 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082601; cv=none; b=sNhPCmoRm4Vx1qHXbH6eSqafuPodiWkSnZz6XT1yQc6QXL9Hw0wbfpqAZ5hBoPLwCYp3KLT3Mfg01GmXet4QZF8QPDkFjkXCrai7WIspDy7QVtqbDFnovymw0k+zaPLRH2Ytm9vMNbzS+ZG5y3C/BPIQFBPkgvQGtCZMYbs5Q9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082601; c=relaxed/simple;
	bh=2398Dink1XI0qXX1lmBE/iLuxkdh/Ul2IAUIGRgTvqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3YHtcoGYFag8ZzFGHJcZ8/fkvAlHnzLWru2mbhYBua3+QCSb6z5gqnUXbv8UnBGBjm9O5vKuHpq1FyvQUu2WjJVsPW/803wdEvKAdSXUlAnM4PxtDkhlHRZlBAbFtUb/5UT0GcSaQIoADG2wO2ynZ4Tso/cMlPIQCbv2eHsq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+zTUY2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1295C4CED0;
	Fri, 13 Dec 2024 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734082600;
	bh=2398Dink1XI0qXX1lmBE/iLuxkdh/Ul2IAUIGRgTvqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+zTUY2zEx1rezaCPp4xGqN3x28llyz6ivL6Fe6I9JGNIaG3hreL27Ic9wnjlm2hJ
	 wX16cQILlbJZXV+A3zcotEdaArsKhgp+FM/rco/QgeXzfKY6MrlhgKP1nA/NkDoqYX
	 hTMCU9LAbUjXfvtm95IPUuVfftMDQuHo6Ck+q0Z3UsUiBCnk9Is8Mt0a07nSeltRyc
	 mKZELaFR/CPAfs+7ofURRuVTg/aX6ckJXYN5mdD3AkEZz4R3EwJUfhyWCnMLk/7GY/
	 kolvtBYl739jAJ7E9lP9R6y7BcDLB/bAxYswMIQRe987sF+8HcctUChZdwObh7hoZ9
	 W6DtVPlsoEJww==
Date: Fri, 13 Dec 2024 10:36:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Hal Feng <hal.feng@starfivetech.com>, Jianlong Huang <jianlong.huang@starfivetech.com>, 
	Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-pinfunc.h
Message-ID: <rqqh56dyxblzsigse6drluhoeuapsxlr3qbzkzvy2lnpzotma5@ltydfatcrtpx>
References: <20241210014903.154551-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210014903.154551-1-e@freeshell.de>

On Mon, Dec 09, 2024 at 05:48:57PM -0800, E Shattow wrote:
> Fix a typo in StarFive JH7110 pin function definitions

That's not a "typo", but entire wrong value with actual impact.

Best regards,
Krzysztof


