Return-Path: <linux-kernel+bounces-281367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D534C94D618
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904EE282BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77163146A9B;
	Fri,  9 Aug 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKdcU81L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C413D523;
	Fri,  9 Aug 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227054; cv=none; b=ek+wsAAvbDVjTyRPF5azKiLAs9436/jgBdgqq5FxkZo9B7+McyTdDhd0lRDL5NXn5cDqCWs0UicfiB+XAZayPodIIZNNZLaRw1/un1u8CWPDP+jptgq11BUyI11zuYlT6ll48/5xFGnSf84G7V5CC2fH+8MdD7Uq7tSerc+vTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227054; c=relaxed/simple;
	bh=iY3i8Mtu9KEPb5gUpxjOkhym1OOV0gevOhjmlSQ9cho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp3q5UvXd2pwCL/OtysRjadSpDctt/T4v5bY8sFmYvpHXqs2/C4uEciftFbRqx361jlPk7Ydio8lAeSV+QgBoTbWIoIP+qp8rZ9Zb0yyIcpPJmzMOy7iqiz5QFrPfXVTPoL1xAkyNlGoqgcdsSZG7+ZW5H0xtdvFO1Gj4VTOxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKdcU81L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14D8C32782;
	Fri,  9 Aug 2024 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723227054;
	bh=iY3i8Mtu9KEPb5gUpxjOkhym1OOV0gevOhjmlSQ9cho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKdcU81LE/O0mLWiNzBXgmSnZ+ZjGthgKpRdlIqlyi8r1AKnktLA+FA3HquvSoELf
	 1Wfi0cCgFslA9HRT2Dss3oXylQhR1tzSi+Da5aZj+bAiUY1uwtJ5fEx50NRPVlgmP3
	 KLHIaCTDAozJwfIot0emxcixK2G8/4soKwKThLGKUQvGVkgM8Hq62mwb4VRLIAacog
	 WCcGHcEXcmKcXPrZ9vNw/M11l2a1j9gpgcBdV5iEWINwBXfCiKPEREF+b8jzad/dKT
	 Mc8o0X334iw3djr9vQL8/qFf9Hir2D2ojIW0bMML8IDNts73G7zxucdSc9m8mi25Y7
	 e52b1ohaBF5Lw==
Date: Fri, 9 Aug 2024 12:10:52 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: Noah Wang <noahwang.wang@outlook.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Lukas Wunner <lukas@wunner.de>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: add isil,isl69260
Message-ID: <172322705040.971537.272379828759897694.robh@kernel.org>
References: <20240809070056.3588694-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809070056.3588694-1-peteryin.openbmc@gmail.com>


On Fri, 09 Aug 2024 15:00:54 +0800, Peter Yin wrote:
> Document the "isl,isl69260" compatible, which is already used in the
> DTS files but was not previously documented in the bindings.
> The ISL69260 is a digital dual output multiphase controller
> that supports Intel VR13, VR13.HC, and VR14 specifications.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
> 
> Change log:
> 
> v1 -> v2:
>  - Fixed the binding format.
> 
> v1:
>  - Created the isl69260 binding.
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


