Return-Path: <linux-kernel+bounces-380894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB8C9AF75D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FD91C2192D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40913AD38;
	Fri, 25 Oct 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Deoy5qwP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C242139D1B;
	Fri, 25 Oct 2024 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823053; cv=none; b=Zb30CmMQvf4CeMmazeO7ac8kHm/ZFhKOrz+r/UVYu2GHmE2eAeEAvvkXeHV+W91jCfbqBSwKSbdjMeQ+Opn3RmlM/twF47/fym2FlJkuWSUPS6Ds2z8tO1z236QRDWckeMbgdMTWLjw4udbScUpXUkZRDiBA7MuiaXRTyg6cnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823053; c=relaxed/simple;
	bh=5C5uFSBTr62E2WfrhFfYnrIEMMYUAv9JYb0KMQXuH/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM5qTmj/wq2AsaOXLZV0o5j+N57YqXJrPU8/4YM9HJK0+ZUlU+A9ox6P0zNZwOQhIX3eLDlZ3S+k/4sLltn7xTN9g57G9oKAnAUvxPbZ9UmDfldBJAcbH74QN9NlSsOeGL+fGpKPxHAt8jEo5KDowtyYnuJLdm4p/CwJihR8p2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Deoy5qwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7752C4CEC7;
	Fri, 25 Oct 2024 02:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729823053;
	bh=5C5uFSBTr62E2WfrhFfYnrIEMMYUAv9JYb0KMQXuH/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Deoy5qwPMWxzV+sAcpoC8vH1leyHr1gtikAWy4UFrbCriymkOmwl3fj7zCohoOsfo
	 l+Q1wmC8+g45BCL8k4wVpk1X8T9mufz5N9PH0FaJz9S15CgsEzyuGqCmtMqBEMNiAw
	 Xbk2Zr9XBlyQGwVM/CHCH3h/o8nsbpruo2bwwimZEeeRlunAnmjuMoOwIzaGsUDipw
	 YjEPLY3EOlIsqLAxKrvv2SJqX07MBZ3toQSizhu8tJMJ2DRzx9GvHcXmX7FTWyG6mG
	 eifWO3Qfmdox2rCLetNBq4uccp/1TlBVzOZXSSfizORPFTVzZQymnjE53mjjMNaR9l
	 43pE6c67jdbPA==
Date: Thu, 24 Oct 2024 19:24:11 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 5/5] dt-bindings: riscv: document vector crypto
 requirements
Message-ID: <20241025022411.GB1781@sol.localdomain>
References: <20241024-fanning-enrage-bcc39f8ed47d@spud>
 <20241024-pungent-lasso-42dd3512a3c8@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-pungent-lasso-42dd3512a3c8@spud>

On Thu, Oct 24, 2024 at 01:34:33PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Section 35.2. Extensions Overview of [1] says:
> | The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the composite extensions Zvkn and
> | Zvks-- (sic) require a Zve64x base, or application ("V") base Vector Extension.
> | All of the other Vector Crypto Extensions can be built on any embedded (Zve*) or application ("V") base
> | Vector Extension
> 
> Apply these rules in the binding, so that invalid combinations can be
> avoided.

It looks like that part of the spec is wrong, though.  The Zvknhb and Zvbc are
correct, but the list of the composite extensions that at least one of them is
included in is: Zvkn, Zvknc, Zvkng, Zvksc.

- Eric

